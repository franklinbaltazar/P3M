---
type: API Proposal
title: "API-PRP-006 — BFF del portal (catálogo de rutas)"
description: "Catálogo propuesto de las rutas del BFF en Next.js que consume el SPA de Angular: autenticación y sesión, perfil del usuario, rutas de paso hacia los 5 servicios y vistas compuestas. Propuesta para H-02 de API-ANL-001."
tags: [api, bff, h-02]
status: draft
gate_status: REQUIRES_REVIEW
version: "0.3.0"
generated:
  by: "api-refiner"
  at: "2026-10-12T22:00:00-05:00"
human-reviewed: false
sources:
  - id: api-anl-001
    resource: /design/api-contracts/API-ANL-001-analisis-de-apis-por-dominio.md
  - id: api-prp-000
    resource: /design/api-contracts/API-PRP-000-resumen.md
  - id: adr-01-02-03
    resource: /architecture/adr/ADR-01-spa-en-angular-con-bff-en-next-js.md
  - id: adr-p1-p5-p9
    resource: /architecture/adr/ADR-P5-estrategia-de-autorizacion-por-rol.md
  - id: us-025-027-028
    resource: /requirements/user-stories/US-027-ingresar-al-portal-de-forma-segura.md
---

# API-PRP-006 — BFF del portal (catálogo de rutas)

> **Estado:** `draft`, `REQUIRES_REVIEW`. Es una **propuesta para H-02**: ninguna fuente define las pantallas ni las rutas del BFF. Las vistas compuestas se **contrastaron con los criterios de aceptación** en [UXR-001](../ux/UXR-001-vistas-del-bff.md) y se ajustaron en la versión 0.2.0; siguen siendo **inferidas (I)** hasta que UX las valide con diseños. Pantallas candidatas en [SCR-001](../ux/SCR-001-pantallas-del-bff.md). Sin revisión humana.

## 1. Identidad
| Campo | Valor |
|---|---|
| ID | API-PRP-006 |
| Servicio | `bff-portal` (Next.js). **No es uno de los 5 microservicios de dominio** |
| Contextos alojados | Ninguno. No posee datos de negocio |
| Propietario de datos | Solo la sesión y la caché, en Redis (ADR-P1) |
| Consumidor | SPA de Angular y sus micro UI (ADR-01, ADR-04). El SPA solo habla con el BFF |
| Modo | propose |
| Versión de la propuesta | 0.1.0 |

## 2. Propósito y alcance
Concentrar la autenticación y la sesión (ADR-01, ADR-02, ADR-03), reenviar las llamadas a los servicios con la identidad del usuario (ADR-P5 P5-D1) y componer las lecturas que una pantalla necesita para no llamar a varios servicios desde el navegador. **Fuera:** reglas de negocio (viven en los servicios), consumo por terceros (API Gateway, ADR-P10 pendiente) y diseño de pantallas.

## 3. Principios de diseño
| ID | Principio | Fuente |
|---|---|---|
| B-1 | Los tokens nunca llegan al navegador; el SPA solo tiene una cookie de sesión del BFF (`HttpOnly`, `Secure`, `SameSite`) | ADR-02 |
| B-2 | Hacia los servicios: JWT de máquina (Client Credentials) **y** el token del usuario; sin `sub` ni roles en cabeceras sin firma | ADR-P9, ADR-P5 §3.2 |
| B-3 | El BFF comprueba el rol grueso y oculta lo que no corresponde; **el servicio decide** y es la fuente de verdad | ADR-P5 §3.1 |
| B-4 | Rutas de paso por defecto; vista compuesta solo cuando una pantalla necesita datos de 2 o más servicios | (I) |
| B-5 | Una vista compuesta es de **solo lectura**. Toda escritura va por una ruta de paso, para que cada servicio conserve sus invariantes | (I), DDM-001 |
| B-6 | Nada de `/internal/**` se publica al navegador | ICP-001 §2.1 |
| B-7 | La sesión vive en Redis, no en la memoria de una réplica | ADR-P1 |

## 4. Rutas de autenticación y sesión
| Ruta | Método | Historia | Qué hace | Fuente |
|---|---|---|---|---|
| `/auth/login` | `GET` | US-027 | Inicia PKCE y redirige a Keycloak | ADR-02 |
| `/auth/callback` | `GET` | US-027, US-025 | Intercambia el código, crea la sesión y llama a `API-PRP-001 /internal/v1/usuarios/registro-al-iniciar-sesion`. Si no hay persona y el rol no es JI, ADM ni INSTRUCTOR, cierra la sesión y vuelve al login (INV-08) | ADR-02, ICP-001 |
| `/auth/logout` | `POST` | US-028 | Cierre a demanda: borra la sesión del BFF y cierra la de Keycloak de forma coordinada | ADR-03 |
| `/auth/session` | `GET` | US-028 | Estado de la sesión (vigente, vencimiento, aviso previo). Valores de tiempo pendientes (RQ-31) | ADR-03 |
| `/auth/backchannel-logout` | `POST` | US-028 **(I)** | Keycloak avisa el cierre o vencimiento para alinear ambas sesiones. Mecanismo **inferido**; ADR-03 solo exige el cierre coordinado | ADR-03 |

Si Keycloak no está disponible, el SPA muestra la página inicial del portal (US-027); no es una ruta de API.

## 5. Perfil del usuario
| Ruta | Método | Historia | Fuentes de datos | Notas |
|---|---|---|---|---|
| `/api/v1/me` | `GET` | US-025, US-027 **(I)** | Token (roles); `API-PRP-001 GET /v1/usuarios?keycloak_guid=` y `GET /v1/personas/{id}` | Devuelve usuario, roles, `persona_ref` y banderas de la interfaz. Los guards de Angular solo ocultan; no autorizan |

## 6. Rutas de paso (pass-through)
El BFF expone **cada recurso F1** de los servicios bajo `/api/v1/<recurso>`, con el mismo método y contrato, mediante esta tabla de prefijos. Se reenvía `Idempotency-Key`, `If-Match` y el identificador de correlación.

| Prefijo en el BFF (`/api/v1/…`) | Servicio | Propuesta |
|---|---|---|
| `personas`, `organizaciones`, `partes`, `relaciones`, `plazas`, `usuarios` | [API-PRP-001](API-PRP-001-svc-partes-identidad.md) | Paso |
| `roles`, `competencias`, `seniorities` | [API-PRP-002](API-PRP-002-svc-curricula.md) | Paso |
| `cursos`, `ediciones`, `enrolamientos`, `evidencias`, `evidencias-de-proyecto`, `solicitudes-de-promocion`, y `colaboradores/{id}/valoraciones`, `…/evaluaciones-de-desempeno`, `…/solicitudes-de-promocion`, `…/certificaciones` | [API-PRP-003](API-PRP-003-svc-formacion-progresion.md) | Paso |
| `productos`, `proyectos`, `asignaciones`, `motivos-de-excepcion` | [API-PRP-004](API-PRP-004-svc-portafolio.md) | Paso |
| `cargas`, `gitlab` | [API-PRP-005](API-PRP-005-svc-gitlab.md) | Paso |

**Rol grueso que comprueba el BFF** (ADR-P5 anexo §3; el servicio vuelve a comprobar y añade la condición del recurso):

| Grupo de rutas | Roles que pueden llamar | Condición que solo comprueba el servicio |
|---|---|---|
| Escritura de partes, plazas, ocupaciones, roles, relaciones, contactos, organizaciones | JEFE_INGENIERIA, ADMIN | — |
| Lectura de personas | Cualquier usuario autenticado (BR-003; riesgo en DT-01) | — |
| Corrección del vínculo usuario–persona | JEFE_INGENIERIA, ADMIN | Registra quién y cuándo |
| Roles, competencias, perfiles, niveles mínimos, cursos, ediciones | JEFE_INGENIERIA, ADMIN | — |
| Enrolar, desenrolar, registrar evidencias de curso | COLABORADOR | Dueño del enrolamiento; edición en que está enrolado |
| Validar evidencias de curso, certificar | INSTRUCTOR | Evaluador **de esa** edición |
| Aportar evidencias de proyecto | COLABORADOR | — |
| Validar evidencias de proyecto | Usuario con jefatura de proyecto | Jefe **vigente** del proyecto (CON-09) |
| Valoraciones, evaluaciones de desempeño, promoción | JEFE_INGENIERIA, ADMIN | — |
| Solicitar promoción | COLABORADOR | Su propia solicitud |
| Productos, proyectos, asignaciones, excepciones, motivos | JEFE_INGENIERIA, ADMIN | — |
| Cargas y datos de GitLab | JEFE_INGENIERIA, ADMIN | — |

El jefe de proyecto **no es un rol de Keycloak** (ADR-P5 anexo §2): el BFF no puede decidirlo por el token, así que deja pasar a cualquier COLABORADOR y el servicio decide con CON-09.

## 7. Vistas compuestas (solo lectura) — **todas (I)**
Cada una reúne en una llamada lo que una pantalla probable necesita. Se contrastaron con los criterios de aceptación (UXR-001 §3). **Siguen sin diseños de pantalla en las fuentes**: se validan con UX antes de contratar.

| ID | Ruta | Historias | Fuentes de datos | Notas |
|---|---|---|---|---|
| BFF-V7 | `GET /api/v1/colaboradores/{id}` | US-005 | 001: `personas/{id}`, `plazas/{id}/rol-nivel` | **Cualquier usuario autenticado** (BR-003). Solo nombres, apellidos, fecha de ingreso y rol/nivel (US-005 AC-1). Sin contactos (D-UX-4): los contactos solo los ven JI, ADM y el propio colaborador |
| BFF-V1 | `GET /api/v1/colaboradores/{id}/ficha` | US-004, US-016, US-021 | 001: `personas/{id}`, `contactos`, `roles`, `ocupaciones`, `plazas/{id}/rol-nivel`; 003: `colaboradores/{id}/valoraciones`, `enrolamientos?colaborador_ref`, `colaboradores/{id}/certificaciones`; 004: `asignaciones?colaborador_ref` | **Ficha de gestión: solo JEFE_INGENIERIA y ADMIN.** Lectura de valoraciones y asignaciones según D-UX-3 (mínimo privilegio) |
| BFF-V2 | `GET /api/v1/mis-cursos` | US-010, US-013 | 003: `enrolamientos?colaborador_ref=me`, `ediciones/{id}`, `cursos/{id}/objetivos`, `cursos/{id}/evidencias-esperadas`, `evidencias?enrolamiento_ref` | `me` se resuelve con el token |
| BFF-V8 | `GET /api/v1/ediciones-disponibles` | US-009 | 003: `cursos`, `cursos/{id}/ediciones`, `enrolamientos?edicion_id` (para el cupo) | Catálogo con cupo disponible (UXR-F1). Nueva en 0.2.0 |
| BFF-V3 | `GET /api/v1/ediciones/{id}/panel-evaluador` | US-011, US-012 | 003: `ediciones/{id}`, `enrolamientos?edicion_id`, `cursos/{id}/evidencias-esperadas`, `evidencias?edicion_id&estado=PENDIENTE` | Muestra por enrolado las obligatorias validadas frente a las exigidas. Solo el evaluador de la edición (lo decide el servicio) |
| BFF-V4 | `GET /api/v1/proyectos/{id}/panel` | US-019, US-021, US-024 | 004: `proyectos/{id}`, `milestones`, `jefatura`, `roles-nivel-requeridos`, `asignaciones?proyecto_ref`; 005: `gitlab/proyectos/{gitlab_project_id}/milestones` y `issues` | Incluye `datos_a` (UTC-05). Los campos de US-024 (estimado, spent, due date, status y totales por milestone) dependen de ampliar la réplica de GitLab (D-UX-1) |
| BFF-V5 | `GET /api/v1/colaboradores/{id}/promocion` | US-017, US-026 | 001: `plazas/{id}/rol-nivel`; **002: `roles/{id}/niveles/{nivel}/niveles-minimos` y `…/siguiente`**; 003: `certificaciones`, `valoraciones`, `evaluaciones-de-desempeno`, `evidencias?tipo=PROYECTO`, `solicitudes-de-promocion` | Calcula la brecha frente al «siguiente» rol/nivel; el siguiente se obtiene de API-PRP-002 (CON-14, D-UX-2); Senior L4 no tiene siguiente y la vista lo indica |
| BFF-V9 | `GET /api/v1/mi-progreso` | US-012, US-013, US-016, US-021 **(I)** | 003: `colaboradores/{id}/valoraciones`, `enrolamientos?colaborador_ref=me`, `evidencias`, `colaboradores/{id}/certificaciones`; 004: `asignaciones?colaborador_ref=me` | **COLABORADOR, solo lo suyo (D-UX-3).** Nueva en 0.3.0 |
| BFF-V10 | `GET /api/v1/pendientes` | — **(I)** | 003: `evidencias?estado=PENDIENTE` (por edición del evaluador o proyecto del jefe) y certificables; 004: `asignaciones?estado=PENDIENTE` | Solo **conteos** para los contadores de la barra lateral y la campana (D-UX-6). Nueva en 0.3.0 |
| ~~BFF-V6~~ | `RETIRED` | US-020 | — | Lo cubre la ruta de paso `GET /api/v1/cargas` (US-020 AC-3). El ID no se reutiliza |

**Si un servicio no responde,** la vista devuelve las secciones que sí llegaron, marca las demás como no disponibles y no inventa datos. Las escrituras nunca se componen (B-5).

## 8. Caché (Redis, ADR-P1)
| Dato | Propuesta | Estado |
|---|---|---|
| Sesión del BFF | En Redis; se destruye en el cierre de sesión | Decidido (ADR-P1) |
| Catálogos (roles, competencias, seniorities) | Caché de lectura; se invalida al escribir por el BFF | TTL **por definir** |
| Vistas compuestas (BFF-V1 a V5 y V7 a V10) | Sin caché o TTL muy corto **(I)** | Por definir |
| Datos de GitLab | TTL corto y `datos_a` visible; invalidación con el delta | **Pendiente** (consecuencia de ADR-06) |

Los TTL concretos por escenario siguen sin decidirse (ADR-P1 §5).

## 9. Seguridad
| Aspecto | Propuesta | Fuente |
|---|---|---|
| Cookie | `HttpOnly`, `Secure`, `SameSite` | ADR-02 |
| CSRF | Token anti-CSRF en métodos que escriben, además de `SameSite` **(I)** | — |
| Token del usuario | Se guarda en la sesión (Redis) y se reenvía; se maneja su caducidad (renovación pendiente, RQ-31) | ADR-P5 §5 |
| Cabeceras | No se aceptan `sub` ni roles del navegador | ADR-P5 §3.2 |
| Datos personales | Los logs del BFF no registran su contenido | ICP-001 §5 |
| Límites de uso | Por usuario y por ruta **(I)** | ADR-P10 pendiente |

## 10. Fallos y errores
| Situación | Comportamiento propuesto |
|---|---|
| Sesión vencida (`401` de un servicio o sesión inexistente) | `401` al SPA, que lleva a `/auth/login` |
| Rol insuficiente | `403` con `problem+json` |
| Servicio caído o con circuit breaker abierto | `503 dependencia no disponible`, sin escritura parcial |
| Keycloak caído | El SPA muestra la página inicial (US-027); no se crea sesión |
| Error del servicio | Se transmite `application/problem+json` sin reescribir el código de negocio |
| Reintento de una escritura | Solo con `Idempotency-Key`; el BFF no reintenta comandos por sí mismo |

## 11. Observabilidad
Genera el identificador de correlación y lo propaga a los servicios; métricas por ruta (latencia, errores, `401`, `403`, `503`), de sesiones activas y de aciertos de caché; los logs no incluyen tokens ni datos personales. **(I)**

## 12. Pruebas de contrato
| Tipo | Qué verifica | Dueño |
|---|---|---|
| Proveedor | OpenAPI del BFF (`/auth`, `/api/v1`) | Equipo de desarrollo |
| Consumidor | El SPA contra las vistas BFF-V1 a V5 y V7 a V10 | Equipo de desarrollo |
| Paso | La tabla de prefijos contra cada servicio; reenvío de cabeceras e identidad | Equipo de desarrollo |
| Seguridad | Token en el navegador (no debe haber); cierre coordinado con Keycloak; CSRF; `403` por rol | QA y seguridad |
| Degradación | Vista con un servicio caído | QA |

## 13. Trazabilidad
| Historia | Ruta |
|---|---|
| US-025 | `/auth/callback` (llama al registro de usuario de API-PRP-001) |
| US-027 | `/auth/login`, `/auth/callback` |
| US-028 | `/auth/logout`, `/auth/session`, `/auth/backchannel-logout` |
| Las 33 historias con API de dominio | Ruta de paso (§6) y, donde aplica, BFF-V1 a V5 y V7 a V10 |

## 14. Riesgos y preguntas abiertas
| ID | Pregunta o riesgo | Severidad | Dueño | Impacto |
|---|---|---|---|---|
| BQ-1 | Las vistas se contrastaron con los criterios (UXR-001) y se bajaron a pantallas con el IA Design System (SCR-001 v0.2.0). **Siguen sin flujos de usuario ni diseños aprobados**, y el sistema tiene brechas de componentes (DSG-1 a DSG-8) y de contraste (DSA-1 a DSA-5) | Media | UX y análisis funcional | Las vistas compuestas |
| BQ-8 | UXQ-1: la réplica de GitLab no guarda los campos de US-024. **Decidido (D-UX-1):** se amplía; **falta** la migración Flyway y la ampliación de ACL-02 | Media | Datos y arquitectura | BFF-V4, API-PRP-005 |
| BQ-9 | UXQ-2. **Decidido (D-UX-2):** se deriva de BR-031. **Falta** definir qué pasa en Senior L4 (hoy: sin siguiente) | Media | Responsable funcional | BFF-V5, US-017 |
| BQ-10 | UXQ-3. **Decidido (D-UX-3):** mínimo privilegio. **Falta** registrarlo en BRC-001 | Baja | Análisis funcional | BFF-V1, V9 |
| BQ-2 | RQ-31: tiempo de sesión, anticipación del aviso y renovación | Media | Responsable funcional | `/auth/session` |
| BQ-3 | TTL por escenario e invalidación con el delta de GitLab (ADR-P1, ADR-06) | Media | Arquitectura | Caché |
| BQ-4 | Mecanismo de cierre coordinado (¿back-channel logout?) | Media | Arquitectura y seguridad | `/auth/backchannel-logout` |
| BQ-5 | Anti-CSRF y límites de uso no están en ningún ADR | Media | Seguridad | Seguridad del BFF |
| BQ-6 | El BFF es punto único de fallo del SPA: requiere varias réplicas y Redis disponible | Media | Infraestructura | Disponibilidad (99,9 %) |
| BQ-7 | Lecturas que el BFF necesita y los servicios aún no tienen: propuestas añadidas en API-PRP-001, 003 y 004 v0.2.0 | Media | Arquitectura | Cobertura |

## 15. Historial de refinamiento
| Versión | Fecha | Cambio | Clase | Pedido |
|---|---|---|---|---|
| 0.1.0 | 2026-10-12 | Propuesta inicial del catálogo de rutas del BFF | additive | Propuesta para H-02 |
| 0.3.0 | 2026-10-13 | Se añaden BFF-V9 (mi progreso) y BFF-V10 (pendientes); BFF-V5 usa CON-14; se registran D-UX-1 a D-UX-7 | additive | Decisiones del responsable (UXR-001 §7) |
| 0.2.0 | 2026-10-12 | BFF-V1 se restringe a JI y ADM y se separa BFF-V7 (datos básicos); se añade BFF-V8; BFF-V3 y V5 amplían sus fuentes; BFF-V6 `RETIRED` | breaking (sin consumidores aún) | Validación con los criterios de aceptación (UXR-001) |

## 16. Siguiente acción
Resolver BQ-8 y BQ-9 (cambian datos y servicios) y BQ-10. Validar BQ-1 con diseños de pantalla (`user-flow-designer` y un Design System). Decidir BQ-2 a BQ-5. Luego `api-designer` redacta el OpenAPI del BFF.
