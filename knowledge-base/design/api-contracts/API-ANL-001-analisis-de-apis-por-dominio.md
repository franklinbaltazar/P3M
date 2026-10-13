---
type: API Requirements Analysis
title: "API-ANL-001 — Análisis de las API requeridas por dominio DDD"
description: "Inventario de las API que cada contexto acotado del P3M debe ofrecer (comandos y consultas para el BFF, consultas internas, evento y capas anticorrupción), con historia, actor, permiso y fuente. Insumo del contrato OpenAPI; no es el contrato."
tags: [api, ddd, bounded-context, design]
status: draft
gate_status: REQUIRES_REVIEW
generated:
  by: "api-designer"
  at: "2026-10-12T18:00:00-05:00"
sources:
  - id: ddm-001
    resource: /data/DDM-001-modelo-ddd.md
  - id: icp-001
    resource: /data/ICP-001-contratos-de-integracion.md
  - id: dsp-001
    resource: /requirements/scope-packs/DSP-001-p3m-alcance-candidato.md
  - id: us-001-035
    resource: /requirements/user-stories/
  - id: adr-p2-p5-p9-13-14-p10
    resource: /architecture/adr/
  - id: adr-p5-anexo
    resource: /architecture/adr/ADR-P5-anexo-mapa-rol-permiso-propuesta.md
---

# API-ANL-001 — Análisis de las API requeridas por dominio DDD

> **Alcance.** Qué API necesita cada contexto de DDM-001 para cubrir las historias US-001 a US-035 y los contratos de ICP-001. **No** define esquemas ni campos (eso es el contrato OpenAPI, siguiente paso). Cada fila cita historia, actor y fuente. Lo **inferido** (sin texto que lo diga) se marca **(I)**.
>
> **Estado:** `draft`, `REQUIRES_REVIEW`. Sin revisión humana.

## 1. Supuestos y clasificación

| ID | Supuesto | Procedencia |
|---|---|---|
| A-01 | ~~Un microservicio FastAPI por contexto (CTX-01 a CTX-07).~~ **Sustituido el 2026-10-12** por 5 servicios agrupados (ver API-PRP-000). ADR-P2 dice que los límites salen de DDD pero «falta enumerarlos» | (I) ADR-P2 §5, ADR-07 |
| A-02 | Hay cuatro familias de API, con audiencias distintas (tabla siguiente) | ICP-001, ADR-13, ADR-14 |
| A-03 | Ninguna API se expone a terceros: el API Gateway queda fuera hasta decidir ADR-P10 | DSP-001 «Excluded Work» |
| A-04 | Nada se borra (BR-079, P-3 de ICP-001): no hay `DELETE` de negocio; el fin de vigencia es una acción (`/finalizar`, `/baja`) | DDM-001 INV-07 |
| A-05 | Los endpoints de BFF → servicio usan `/v1/…`; los de servicio → servicio usan `/internal/v1/…` (ICP-001 §2.1) | ICP-001, (I) para `/v1` |

| Familia | Audiencia | Contrato | Seguridad | Cantidad |
|---|---|---|---|---|
| **F1** Comandos y consultas de negocio | BFF → microservicio | REST `/v1/…` | JWT de máquina **más** token del usuario (ADR-P9, ADR-P5 P5-D1) | §3 |
| **F2** Consultas internas entre contextos | microservicio → microservicio | REST `/internal/v1/…`, solo lectura, idempotente | JWT de máquina, un *scope* por contrato | 13 (CON-01 a CON-13) |
| **F3** Evento asíncrono | CTX-05 → CTX-01 | RabbitMQ con *outbox* | Cola duradera | 1 (EVT-01) |
| **F4** ACL externas | Keycloak, GitLab → contexto | Entrada de otro sistema | Credenciales en Vault (ADR-12) | 2 (ACL-01, ACL-02) |

Las historias US-027 (ingreso seguro) y US-028 (cierre de sesión) **no generan API de dominio**: son del BFF con Keycloak (ADR-01 a ADR-03). Ver §5.

## 2. Convenciones transversales propuestas

Ninguna ADR fija estas convenciones; **son propuestas (I)** para el contrato.

| Tema | Propuesta | Origen |
|---|---|---|
| Autorización | Rol del token **más** condición del recurso. Cada servicio es la fuente de verdad; el BFF solo oculta | ADR-P5 §3.1–3.3, anexo G-2, G-6 |
| Actor | `sub` del token del usuario; se guarda como `*_por_ref` | ICP-001 DEC-I03 |
| Escritura con fin de vigencia | `POST …/finalizar`; sin `DELETE` | A-04 |
| Idempotencia | Cabecera `Idempotency-Key` en comandos que crean; los comandos de estado **no se reintentan** sin ella | ICP-001 §6 |
| Concurrencia | `If-Match`/ETag en `PATCH`. `409` si hay choque (por ejemplo, dedicación > 100 %, INV-21) | (I), ADR-P6 |
| Errores | `application/problem+json` (RFC 9457) con código de negocio (por ejemplo, `NIVEL_MINIMO_NO_CUMPLIDO`) | (I) |
| Rechazo del inicio de sesión | Mismo mensaje en cualquier causa, sin revelar si el correo existe | ICP-001 CON-13 |
| Paginación | Listas con `limit`/`cursor`; filtros por vigencia (`vigente=true`, `fecha=`) | (I) |
| Versionado | Ruta mayor `/v1`; compatibilidad por ICP-001 §7 (D-H21) | ICP-001 |
| Dependencia caída | El comando de escritura se rechaza con `503 dependencia no disponible`, sin escritura parcial | ICP-001 §6 |
| Especificación | OpenAPI 3.1 por servicio (con Spring, p. ej. springdoc, por decidir); AsyncAPI para EVT-01 | ADR-16 (sustituye ADR-07) |

## 3. API de negocio (F1) por contexto

Leyenda de actor: **JI** Jefe de Ingeniería · **ADM** ADMIN (suple al JI, BR-134) · **COL** colaborador · **EVA** evaluador de la edición · **JP** jefe vigente del proyecto · **AUT** cualquier usuario autenticado. **R** = solo rol; **R+D** = rol más condición del recurso.

### 3.1 CTX-01 Partes y organización (AGG-01 a AGG-05)

| Recurso | Operaciones | Historia | Actor | Tipo | Notas |
|---|---|---|---|---|---|
| `/v1/personas` | `POST`, `GET` (lista), `GET /{id}`, `PATCH /{id}` | US-004, US-005 | Escribir: JI, ADM. Leer: AUT | R | BR-003 expone datos personales a AUT (ver H-06) |
| `/v1/organizaciones` | `POST`, `GET`, `GET /{id}`, `PATCH /{id}` | US-035 | JI, ADM | R | BR-135 |
| `/v1/partes/{id}/contactos` | `POST`, `GET`, `PATCH /{cid}`, `POST /{cid}/baja` | US-029 | JI, ADM | R | Correo y teléfono obligatorios; correo vigente único entre todas las partes (BR-133). Alta de la baja libera la dirección (K-44) |
| `/v1/personas/{id}/roles` | `POST`, `GET`, `POST /{rid}/finalizar` | US-032 | JI, ADM | R | Roles colaborador y evaluador, con vigencia |
| `/v1/relaciones` | `POST`, `GET`, `POST /{id}/finalizar` | US-034 | JI, ADM | R | Un «reporta a» y una membresía vigentes (INV-03, INV-04) |
| `/v1/plazas` | `POST`, `GET`, `GET /{id}` | US-030 | JI, ADM | R | |
| `/v1/plazas/{id}/rol-nivel` | `GET` (historial) | US-030 | JI, ADM, AUT (I) | R | El cambio **no** es un `POST` público: lo aplica EVT-01 (INV-27) |
| `/v1/plazas/{id}/ocupaciones` | `POST`, `GET`, `POST /{oid}/finalizar` | US-031 | JI, ADM | R | Una vigente por persona y por plaza (INV-05, INV-06) |

Comandos DDM-001 sin endpoint propio: `CambiarNivelDePlaza` entra por EVT-01 (F3).

### 3.2 CTX-02 Identidad de acceso (AGG-06)

| Recurso | Operaciones | Historia | Actor | Tipo | Notas |
|---|---|---|---|---|---|
| `/internal/v1/usuarios/registro-al-iniciar-sesion` | `POST` | US-025 | BFF (máquina) con token del usuario | — | Idempotente por `keycloak_guid`. Si no hay persona, solo pasan JI, ADM, INSTRUCTOR (D-H5, INV-08). Llama a CON-13 solo la primera vez |
| `/v1/usuarios/{id}/vinculo` | `PUT` (corrección) | US-033 | JI, ADM | R | Registra quién y cuándo (`correccion_de_vinculo`, K-45). Fuera de la corrección, el vínculo es inmutable |
| `/v1/usuarios/{id}` | `GET` | US-033 (I) | JI, ADM | R | Para localizar el vínculo a corregir |

Los roles de usuario **no se mantienen aquí**: viven en Keycloak (ADR-11).

### 3.3 CTX-03 Currícula (AGG-07 a AGG-09)

| Recurso | Operaciones | Historia | Actor | Tipo | Notas |
|---|---|---|---|---|---|
| `/v1/roles` | `POST`, `GET`, `GET /{id}`, `PATCH /{id}` | US-001 | JI, ADM | R | BR-001 |
| `/v1/competencias` | `POST`, `GET`, `GET /{id}`, `PATCH /{id}` | US-002 (I) | JI, ADM | R | `DefinirCompetencia` (DDM-001 §5); ver H-04 |
| `/v1/roles/{id}/perfil` | `PUT`, `GET` | US-002 | JI, ADM | R | Referencias a competencias (BR-055, BR-134) |
| `/v1/roles/{id}/niveles/{nivel}/niveles-minimos` | `PUT`, `GET` | US-003 | JI, ADM | R | Un mínimo por cada competencia del perfil (INV-11) |
| `/v1/seniorities` | `GET` | (I) | AUT | R | L1 a L4 sembrados (V2 de Flyway); solo lectura |

### 3.4 CTX-04 Formación (AGG-10, AGG-11)

| Recurso | Operaciones | Historia | Actor | Tipo | Notas |
|---|---|---|---|---|---|
| `/v1/cursos` | `POST`, `GET`, `GET /{id}`, `PATCH /{id}` | US-006 | JI, ADM | R | |
| `/v1/cursos/{id}/objetivos` | `POST`, `GET`, `PATCH /{oid}` | US-006 | JI, ADM | R | Cada objetivo: competencia y nivel (CON-05) |
| `/v1/cursos/{id}/objetivos/{oid}/rubrica` | `PUT`, `GET` | US-007 | JI, ADM | R | Rúbrica por nivel de logro |
| `/v1/cursos/{id}/evidencias-esperadas` | `POST`, `GET`, `PATCH` | US-006/US-007 (I) | JI, ADM | R | Obligatoria o deseable |
| `/v1/cursos/{id}/ediciones` | `POST`, `GET` | US-008 | JI, ADM | R | Evaluador validado por CON-01 |
| `/v1/ediciones/{id}` | `GET`, `PATCH` | US-008 | JI, ADM (escribir) | R | |
| `/v1/ediciones/{id}/enrolamientos` | `POST`, `GET` | US-009 | COL (propio) | R+D | `409` al llegar al cupo (INV-13) |
| `/v1/enrolamientos/{id}/desenrolar` | `POST` | US-010 | COL (propio) | R+D | Estado Desenrolado |
| `/v1/enrolamientos/{id}/certificacion` | `POST`, `GET` | US-012 | EVA | R+D | Solo con el 100 % de obligatorias validadas (CON-06, INV-14) |

### 3.5 CTX-05 Progresión (AGG-12 a AGG-16)

| Recurso | Operaciones | Historia | Actor | Tipo | Notas |
|---|---|---|---|---|---|
| `/v1/enrolamientos/{id}/evidencias` | `PUT /{evidencia_esperada_id}`, `GET` | US-013 | COL (enrolado) | R+D | Una por esperada, reemplazable mientras esté Pendiente (D-H11). Valida issue con CON-10 y pertenencia con CON-12 |
| `/v1/evidencias-de-proyecto` | `POST`, `GET` | US-014 | COL | R | Issue Closed de tipo Task o UserStory (BR-020) |
| `/v1/evidencias/{id}/validacion` | `POST` | US-011 (curso), US-015 (proyecto) | EVA (curso, CON-01); JP (proyecto, CON-09) | R+D | Pendiente → Validada; sin estado Rechazada. Emite el cambio que lee CON-06 |
| `/v1/colaboradores/{id}/valoraciones` | `POST`, `GET` | US-016 | JI, ADM | R | Solo se agregan (INV-16) |
| `/v1/colaboradores/{id}/evaluaciones-de-desempeno` | `POST`, `GET` | US-026 | JI, ADM | R | Fecha-hora y usuario; historial (INV-17) |
| `/v1/colaboradores/{id}/solicitudes-de-promocion` | `POST`, `GET` | US-014/US-017 (I) | COL (propia) | R+D | Registrada → evaluada → decidida; ver H-05 |
| `/v1/solicitudes-de-promocion/{id}/promocion` | `POST` | US-017 | JI, ADM | R | Exige evaluación de desempeño (INV-18). Inserta y publica EVT-01 por *outbox* |

### 3.5 bis — Lectura necesaria para la UI (I)

DDM-001 solo expone el nivel actual de competencias por CON-07 (interno). La interfaz necesita leerlo; no hay historia que lo declare. Ver H-03.

### 3.6 CTX-06 Portafolio y asignación (AGG-17 a AGG-20)

| Recurso | Operaciones | Historia | Actor | Tipo | Notas |
|---|---|---|---|---|---|
| `/v1/productos` | `POST`, `GET`, `GET /{id}`, `PATCH /{id}` | US-018 | JI, ADM | R | Vinculado a un `gitlab_project_id` |
| `/v1/productos/{id}/proyectos` | `POST`, `GET` | US-019 | JI, ADM | R | |
| `/v1/proyectos/{id}` | `GET`, `PATCH` | US-019 | JI, ADM (escribir) | R | |
| `/v1/proyectos/{id}/milestones` | `POST`, `GET`, `POST /{mid}/baja` (I) | US-019 | JI, ADM | R | Valida con CON-11 (K-30) |
| `/v1/proyectos/{id}/roles-nivel-requeridos` | `PUT`, `GET` | US-019 | JI, ADM | R | RQ-32 abierta: si el JP conserva algún permiso |
| `/v1/proyectos/{id}/jefatura` | `POST` (designar), `GET`, `POST /{jid}/finalizar` | US-019 | JI, ADM | R | Un jefe vigente (INV-20) |
| `/v1/asignaciones` | `POST`, `GET`, `GET /{id}` | US-021 | JI, ADM | R | Bloqueo por colaborador, `409` si > 100 % (INV-21). Nivel mínimo con CON-04 y CON-07. Resultado: vigente o Pendiente (INV-22) |
| `/v1/asignaciones/{id}/excepcion` | `POST`, `GET` | US-022 | JI, ADM | R | Motivo y aprobador (BR-006, BR-134) |
| `/v1/asignaciones/{id}/finalizar` | `POST` | US-021 (I) | JI, ADM | R | Fin de vigencia |
| `/v1/motivos-de-excepcion` | `POST`, `GET`, `PATCH /{id}` | US-023 | JI, ADM | R | Codificador |

### 3.7 CTX-07 Integración GitLab (AGG-21, RPL-01)

| Recurso | Operaciones | Historia | Actor | Tipo | Notas |
|---|---|---|---|---|---|
| `/v1/cargas` | `GET` (registro), `GET /{id}`, `POST` (reintentar) | US-020 | JI, ADM | R | La carga programada la lanza un planificador (ADR-P3, que requiere revisión por ADR-16), **no es API**. `POST` = reintento manual; `202` y recurso de carga |
| `/v1/gitlab/proyectos/{gitlab_project_id}/milestones` | `GET` | US-024 | JI, ADM | R | Lee la réplica; devuelve `datos_a` (BR-092) |
| `/v1/gitlab/proyectos/{gitlab_project_id}/issues` | `GET` | US-024 | JI, ADM | R | Filtros por milestone, tipo y estado |

El portal **no escribe** en GitLab (BR-036): ningún `POST`/`PUT` sobre milestones o issues.

## 4. API internas, evento y ACL (F2, F3, F4)

Provienen de ICP-001 y no se redefinen aquí. Resumen por proveedor, para detectar la carga de cada servicio:

| Proveedor | Contratos que debe servir | Consumidores |
|---|---|---|
| CTX-01 | CON-01 `PersonaConRolVigente`, CON-02 `RolNivelVigenteDePersona`, CON-13 `PersonaPorCorreo`; consume EVT-01 | CTX-02, 04, 05, 06 |
| CTX-03 | CON-03 `RolNivelExiste`, CON-04 `NivelesMinimosDeRolNivel`, CON-05 `CompetenciaExiste` | CTX-01, 04, 05, 06 |
| CTX-04 | CON-08 `CertificacionExiste`, CON-12 `EvidenciaEsperadaDeEnrolamiento` | CTX-05 |
| CTX-05 | CON-06 `EvidenciasObligatoriasValidadas`, CON-07 `NivelActualDeCompetencias`; publica EVT-01 | CTX-04, CTX-06, CTX-01 |
| CTX-06 | CON-09 `EsJefeVigenteDeProyectoDelMilestone` | CTX-05 |
| CTX-07 | CON-10 `IssueCerrado`, CON-11 `MilestoneExiste`; ACL-02 | CTX-05, CTX-06 |
| CTX-02 | ACL-01 (Keycloak); consume CON-13 | — |

CTX-02 no sirve ninguna consulta interna. CTX-05 es el servicio con más dependencias salientes: CON-01, 02, 03, 05, 08, 09, 10 y 12.

### Matriz de dependencias síncronas

| Consumidor ↓ / Proveedor → | CTX-01 | CTX-03 | CTX-04 | CTX-05 | CTX-06 | CTX-07 |
|---|---|---|---|---|---|---|
| CTX-01 | | 03 | | | | |
| CTX-02 | 13 | | | | | |
| CTX-04 | 01 | 05 | | 06 | | |
| CTX-05 | 01, 02 | 03, 05 | 08, 12 | | 09 | 10 |
| CTX-06 | 01 | 03, 04 | | 07 | | 11 |

Hay un par de consultas cruzadas CTX-04 ⇄ CTX-05 (CON-06 frente a CON-08 y CON-12). ICP-001 §6 lo acepta por ser lecturas sobre datos que cada proveedor posee, sin que una consulta dispare otra.

## 5. Fuera del alcance de las API de dominio

| Elemento | Dónde vive | Fuente |
|---|---|---|
| Login PKCE, callback, sesión, cierre de sesión (US-027, US-028) | BFF Next.js con Keycloak; no es un microservicio | ADR-01 a ADR-03 |
| Carga programada de GitLab | Tarea programada en CTX-07 (planificador por decidir, J-6 de ADR-16) | ADR-P3, ADR-08 |
| Rutas que ve el Gateway | Ninguna hasta ADR-P10 | ADR-14, ADR-P10 |
| Endpoints compuestos de pantalla (agregan varios servicios) | BFF; sin catálogo | ver H-02 |

## 6. Hallazgos y preguntas abiertas

| ID | Hallazgo | Severidad | Dueño / acción |
|---|---|---|---|
| H-01 | ADR-P2 no enumera los microservicios. A-01 (uno por contexto) es un supuesto. Con 7 servicios y CTX-05 con 8 dependencias, conviene confirmar si CTX-06/07 o CTX-01/02 se agrupan | Resuelta el 2026-10-12: 5 servicios, decididos por ianache (API-PRP-000) | Arquitectura: revisar la decisión |
| H-02 | No hay catálogo de las rutas del BFF que consume el Angular. Las pantallas necesitan consultas compuestas (por ejemplo, ficha del colaborador con roles, ocupación, valoraciones y evidencias) y ninguna fuente las define | Alta; propuesta en [API-PRP-006](API-PRP-006-bff-portal.md), pendiente de validar | Análisis funcional + UX: validar las vistas compuestas |
| H-03 | CON-07 (nivel actual) y CON-06 son **internas**; no hay API de negocio para que el colaborador o el JI vean sus valoraciones, evidencias o certificaciones. Ninguna historia pide la consulta | Media | Confirmar si falta historia de lectura (I) |
| H-04 | US-002 no dice quién mantiene el catálogo de competencias ni su alta; el comando `DefinirCompetencia` existe en DDM-001 §5 sin historia clara | Media | Verificar US-002 y BR-056/BR-060 |
| H-05 | `SolicitudDePromoción` (AGG-15) tiene transiciones «registrada → evaluada → decidida» (D-H13), pero el registro de la solicitud sigue como «historia pendiente» (RQ-18). `/solicitudes-de-promocion` no tiene historia propia | Media | Redactar la historia (RQ-18) |
| H-06 | BR-003: cualquier usuario autenticado lee datos personales de los colaboradores. Choca con el principio P-5 de ICP-001 y ASR-14. Decidido mantenerlo (P5-D3, riesgo en DT-01) | Media | Seguridad: DT-01 |
| H-07 | Valores operativos no decididos: tiempos de espera, apertura del circuito y reintentos de las consultas internas; límite de uso de CON-13 | Media | Infraestructura (ICP-001 §6) |
| H-08 | ADR-13 sigue en `draft` y su texto («no un JWT») fue enmendado por ADR-P9. La pareja ADR-P9 + ADR-P5 P5-D1 (token de máquina más token de usuario) debe quedar escrita como regla de autenticación del contrato | Media | Arquitectura: actualizar ADR-13 |
| H-09 | Convenciones de §2 (errores, paginación, idempotencia, concurrencia) no están en ningún ADR. Son propuestas (I) | Media | Arquitectura: decidir antes del contrato |
| H-10 | Las decisiones de arquitectura base no fueron revisadas por un arquitecto distinto del responsable (DSP-001 B3) | Info | Registrado |
| H-11 | US-025-Q1: qué hace el contrato si Keycloak no entrega correo o roles. ACL-01 rechaza solo si falta `sub` | Baja | Responsable funcional |

## 7. Trazabilidad historia → API

| Historia | Contexto | Recurso principal |
|---|---|---|
| US-001 | CTX-03 | `/v1/roles` |
| US-002 | CTX-03 | `/v1/competencias`, `/v1/roles/{id}/perfil` |
| US-003 | CTX-03 | `/v1/roles/{id}/niveles/{nivel}/niveles-minimos` |
| US-004, US-005 | CTX-01 | `/v1/personas` |
| US-006 | CTX-04 | `/v1/cursos`, `/objetivos` |
| US-007 | CTX-04 | `…/objetivos/{oid}/rubrica` |
| US-008 | CTX-04 | `/v1/cursos/{id}/ediciones` |
| US-009, US-010 | CTX-04 | `/enrolamientos`, `/desenrolar` |
| US-011 | CTX-05 | `/v1/evidencias/{id}/validacion` (curso) |
| US-012 | CTX-04 | `/v1/enrolamientos/{id}/certificacion` |
| US-013 | CTX-05 | `/v1/enrolamientos/{id}/evidencias` |
| US-014, US-015 | CTX-05 | `/v1/evidencias-de-proyecto`, `/validacion` (proyecto) |
| US-016 | CTX-05 | `/v1/colaboradores/{id}/valoraciones` |
| US-017 | CTX-05 (→ CTX-01 por EVT-01) | `/v1/solicitudes-de-promocion/{id}/promocion` |
| US-018 | CTX-06 | `/v1/productos` |
| US-019 | CTX-06 | `/v1/productos/{id}/proyectos`, `/milestones`, `/jefatura`, `/roles-nivel-requeridos` |
| US-020 | CTX-07 | `/v1/cargas` |
| US-021, US-022 | CTX-06 | `/v1/asignaciones`, `/excepcion` |
| US-023 | CTX-06 | `/v1/motivos-de-excepcion` |
| US-024 | CTX-07 | `/v1/gitlab/proyectos/{id}/milestones`, `/issues` |
| US-025 | CTX-02 | `/internal/v1/usuarios/registro-al-iniciar-sesion` |
| US-026 | CTX-05 | `/v1/colaboradores/{id}/evaluaciones-de-desempeno` |
| US-027, US-028 | BFF + Keycloak | sin API de dominio |
| US-029 | CTX-01 | `/v1/partes/{id}/contactos` |
| US-030, US-031 | CTX-01 | `/v1/plazas`, `/ocupaciones` |
| US-032 | CTX-01 | `/v1/personas/{id}/roles` |
| US-033 | CTX-02 | `/v1/usuarios/{id}/vinculo` |
| US-034 | CTX-01 | `/v1/relaciones` |
| US-035 | CTX-01 | `/v1/organizaciones` |

Las 35 historias quedan cubiertas: 33 con API de dominio y 2 (US-027, US-028) por el BFF.

## 8. Siguiente acción

1. Resolver H-01, H-02 y H-09 (Arquitectura y Análisis funcional); son las que cambian el contrato.
2. Con eso, redactar el contrato OpenAPI 3.1 por contexto, empezando por la ola 1 de DSP-001 (US-001, 018, 023, 025, 027) y CTX-03.
3. Redactar el AsyncAPI de EVT-01.
4. Pasar `api-contract-reviewer` y `api-security-reviewer` sobre cada contrato.
