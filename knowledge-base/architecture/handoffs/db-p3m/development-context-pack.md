---
type: Development Context Pack
title: "Development Context Pack — Base de datos del P3M"
description: "Pack de contexto para desarrollo: persistencia de los 7 contextos, migraciones, permisos, contratos entre contextos y su verificación."
tags: [handoff, database, development-context-pack]
status: draft
generated:
  by: "architecture-development-handoff"
  at: "2026-10-12T04:00:00-05:00"
sources:
  - id: wp-db-001
    resource: /data/WP-DB-001-plan-de-trabajo-diseno-bd.md
  - id: ddp-001
    resource: /data/DDP-001-descubrimiento-de-dominio.md
  - id: ddm-001
    resource: /data/DDM-001-modelo-ddd.md
  - id: ldm-001
    resource: /data/LDM-001-modelo-logico.md
  - id: icp-001
    resource: /data/ICP-001-contratos-de-integracion.md
  - id: pdm-001
    resource: /data/PDM-001-modelo-fisico-mysql.md
  - id: rpt-ddr-001
    resource: /data/RPT-DDR-001-revision-del-diseno.md
  - id: inf-p3m-001
    resource: /deployment/INF-P3M-001-arquitectura-de-infraestructura.md
  - id: asr-catalog
    resource: /architecture/asr/asr-catalog.md
  - id: cat-adr-001
    resource: /architecture/CAT-ADR-001-decisiones-de-arquitectura.md
  - id: adr-db-001
    resource: /architecture/adr/ADR-DB-001.md
  - id: adr-db-002
    resource: /architecture/adr/ADR-DB-002.md
  - id: adr-db-003
    resource: /architecture/adr/ADR-DB-003.md
  - id: brc-001
    resource: /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md
  - id: imd-001
    resource: /business/information-model/IMD-001-portal-curricula.md
---

# Development Context Pack — Base de datos del P3M

## Metadata
- Product: P3M (People, Product and Project Management), Área de Desarrollo de COMSATEL
- Feature / Increment: Capa de persistencia del P3M: 7 esquemas MySQL 8.x, migraciones Flyway, permisos, contratos entre contextos y verificación
- Pack version: 1.0
- Status: READY_FOR_REVIEW (recomendación: READY_WITH_OBSERVATIONS; la aprobación es del Solution Architect)
- Created at: 2026-10-12T04:00:00-05:00
- Verified at: — (nunca asignado por este skill)
- Architecture owner: Solution Architect, **por definir**: ningún arquitecto ha revisado los ADR (OI-01)

> **Cómo usar este pack.** Es el límite de arquitectura para implementar. Contexto mínimo: aquí van identificadores y reglas, y el detalle se recupera de los documentos citados. Los elementos abiertos de la sección 10 **no se resuelven por suposición**.

## 1. Scope
### User Stories
| ID | Summary | In scope | Evidence |
|---|---|---|---|
| US-001 | Mantener el catálogo oficial de roles (CTX-03; historia en `approved`) | Sí: solo su persistencia y contratos | `requirements/user-stories/US-001-*.md` |
| US-002 | Definir el perfil de competencias de un rol (CTX-03; historia en `approved`) | Sí: solo su persistencia y contratos | `requirements/user-stories/US-002-*.md` |
| US-003 | Definir el nivel mínimo de cada competencia para un rol/nivel (CTX-03; historia en `approved`) | Sí: solo su persistencia y contratos | `requirements/user-stories/US-003-*.md` |
| US-004 | Registrar y modificar colaboradores (CTX-01; historia en `approved`) | Sí: solo su persistencia y contratos | `requirements/user-stories/US-004-*.md` |
| US-005 | Consultar los datos de los colaboradores (CTX-01; historia en `approved`) | Sí: solo su persistencia y contratos | `requirements/user-stories/US-005-*.md` |
| US-006 | Definir un curso con sus objetivos (CTX-04; historia en `approved`) | Sí: solo su persistencia y contratos | `requirements/user-stories/US-006-*.md` |
| US-007 | Definir la rúbrica de cada objetivo de un curso (CTX-04; historia en `approved`) | Sí: solo su persistencia y contratos | `requirements/user-stories/US-007-*.md` |
| US-008 | Crear una edición de un curso (CTX-04; historia en `approved`) | Sí: solo su persistencia y contratos | `requirements/user-stories/US-008-*.md` |
| US-009 | Enrolarse en una edición de un curso (CTX-04; historia en `approved`) | Sí: solo su persistencia y contratos | `requirements/user-stories/US-009-*.md` |
| US-010 | Desenrolarse de una edición de un curso (CTX-04; historia en `approved`) | Sí: solo su persistencia y contratos | `requirements/user-stories/US-010-*.md` |
| US-011 | Validar las evidencias aportadas en una edición de curso (CTX-05 y CTX-04; historia en `approved`) | Sí: solo su persistencia y contratos | `requirements/user-stories/US-011-*.md` |
| US-012 | Certificar a un colaborador en una edición de curso (CTX-04; historia en `approved`) | Sí: solo su persistencia y contratos | `requirements/user-stories/US-012-*.md` |
| US-013 | Registrar evidencias del logro de un objetivo en una edición (CTX-05; historia en `approved`) | Sí: solo su persistencia y contratos | `requirements/user-stories/US-013-*.md` |
| US-014 | Aportar evidencias de proyecto (CTX-05; historia en `approved`) | Sí: solo su persistencia y contratos | `requirements/user-stories/US-014-*.md` |
| US-015 | Validar las evidencias de proyecto (CTX-05; historia en `approved`) | Sí: solo su persistencia y contratos | `requirements/user-stories/US-015-*.md` |
| US-016 | Registrar la valoración de un colaborador (CTX-05; historia en `approved`) | Sí: solo su persistencia y contratos | `requirements/user-stories/US-016-*.md` |
| US-017 | Decidir la promoción de nivel o seniority de un colaborador (CTX-05 y CTX-01; historia en `approved`) | Sí: solo su persistencia y contratos | `requirements/user-stories/US-017-*.md` |
| US-018 | Registrar un producto y vincularlo a un proyecto de GitLab (CTX-06; historia en `approved`) | Sí: solo su persistencia y contratos | `requirements/user-stories/US-018-*.md` |
| US-019 | Registrar un proyecto de un producto con sus milestones (CTX-06; historia en `approved`) | Sí: solo su persistencia y contratos | `requirements/user-stories/US-019-*.md` |
| US-020 | Cargar automáticamente los datos de GitLab y consultar el registro de cargas (CTX-07; historia en `approved`) | Sí: solo su persistencia y contratos | `requirements/user-stories/US-020-*.md` |
| US-021 | Asignar un colaborador a un proyecto (CTX-06; historia en `approved`) | Sí: solo su persistencia y contratos | `requirements/user-stories/US-021-*.md` |
| US-022 | Aprobar la excepción de una asignación (CTX-06; historia en `approved`) | Sí: solo su persistencia y contratos | `requirements/user-stories/US-022-*.md` |
| US-023 | Mantener el codificador de motivos de excepción (CTX-06; historia en `approved`) | Sí: solo su persistencia y contratos | `requirements/user-stories/US-023-*.md` |
| US-024 | Visualizar los milestones e issues de GitLab de un proyecto (CTX-07; historia en `approved`) | Sí: solo su persistencia y contratos | `requirements/user-stories/US-024-*.md` |
| US-025 | Registrar al usuario autenticado al iniciar sesión (CTX-02; historia en `approved`) | Sí: solo su persistencia y contratos | `requirements/user-stories/US-025-*.md` |
| US-026 | Registrar la evaluación de desempeño de un colaborador (CTX-05; historia en `approved`) | Sí: solo su persistencia y contratos | `requirements/user-stories/US-026-*.md` |
| US-029 | Mantener los datos de contacto de las partes (CTX-01; historia en `draft`) | Sí: solo su persistencia y contratos | `requirements/user-stories/US-029-*.md` |
| US-030 | Mantener las plazas de una organización (CTX-01; historia en `draft`) | Sí: solo su persistencia y contratos | `requirements/user-stories/US-030-*.md` |
| US-031 | Mantener las ocupaciones de plaza (CTX-01; historia en `draft`) | Sí: solo su persistencia y contratos | `requirements/user-stories/US-031-*.md` |
| US-032 | Mantener los roles de la parte (CTX-01; historia en `draft`) | Sí: solo su persistencia y contratos | `requirements/user-stories/US-032-*.md` |
| US-033 | Corregir el vínculo entre un usuario y su persona (CTX-02; historia en `draft`) | Sí: solo su persistencia y contratos | `requirements/user-stories/US-033-*.md` |
| US-034 | Mantener las relaciones entre partes (CTX-01; historia en `draft`) | Sí: solo su persistencia y contratos | `requirements/user-stories/US-034-*.md` |
| US-035 | Registrar las organizaciones (CTX-01; historia en `draft`) | Sí: solo su persistencia y contratos | `requirements/user-stories/US-035-*.md` |

### Out of Scope
- **US-027 y US-028** (ingreso y cierre de sesión): no usan la base de datos (OI-17).
- La lógica de negocio de los servicios y su capa de autorización: este pack transfiere la persistencia y los contratos. Las restricciones que la base no garantiza están en ARCH-RULE-014 y se implementan en cada servicio.
- Interfaz, BFF, API Gateway y plataforma de contenedores.
- Controles de datos personales (ADR-P4 aprobada con el aplazamiento DT-01, DT-01).
- Los issues «Proyecto» y los campos de BR-038 (DT-03).

## 2. Architecture Context
### Affected Components
| Component | Change / responsibility | Evidence |
|---|---|---|
| `p3m_partes` (CTX-01) | Partes y organización: parte, persona, organización, contactos, roles de la parte, relaciones, plazas y ocupaciones. 9 tablas | PDM-001 §1, LDM-001 §2.1 |
| `p3m_identidad` (CTX-02) | Usuario vinculado a Keycloak y corrección de vínculo. 3 tablas | PDM-001 §1, LDM-001 §2.2 |
| `p3m_curricula` (CTX-03) | Seniority, niveles, competencias, roles y rol/nivel. 8 tablas y semillas BR-011 | PDM-001 §1, LDM-001 §2.3 |
| `p3m_formacion` (CTX-04) | Cursos, objetivos, rúbricas, evidencias esperadas, ediciones, enrolamientos y certificaciones. 7 tablas | PDM-001 §1, LDM-001 §2.4 |
| `p3m_progresion` (CTX-05) | Evidencias aportadas, valoraciones, evaluaciones de desempeño, solicitudes y promociones, y el outbox de EVT-01. 12 tablas | PDM-001 §1, LDM-001 §2.5 |
| `p3m_portafolio` (CTX-06) | Productos, proyectos, jefaturas, asignaciones, excepciones, motivos y fila de bloqueo por colaborador. 9 tablas | PDM-001 §1, LDM-001 §2.6 |
| `p3m_gitlab` (CTX-07) | Registro de cargas y réplica de solo lectura de milestones e issues. 3 tablas | PDM-001 §1, LDM-001 §2.7 |
| Servicio por contexto (nombre y número **por definir**) | Aplica las restricciones que la base no garantiza (R-014) y expone los contratos de ICP-001. FastAPI (ADR-07) | ICP-001, ADR-P2, OI-14 |
| Cuentas MySQL `flyway_<ctx>`, `svc_<ctx>`, `svc_gitlab_carga`, `svc_identidad_correccion` | Migraciones y acceso con mínimo privilegio | PDM-001 §5, `flyway/provision/` |
| RabbitMQ | Entrega de EVT-01 con outbox | ADR-P2, ICP-001 §2.2 |
| Keycloak (federado con Active Directory) y GitLab | Capas anticorrupción ACL-01 y ACL-02 | ICP-001 §2.3, INF-DEC-22 |

## 3. ASRs
| ASR | Requirement / quality attribute | Applies to | Source |
|---|---|---|---|
| ASR-03 | Roles de usuario en Keycloak; el portal registra al usuario al iniciar sesión | CTX-02 | `asr/asr-03.md` |
| ASR-04 | Integración con GitLab de solo lectura | CTX-07 | `asr/asr-04.md` |
| ASR-05 | Carga automática y programada, con delta | CTX-07 | `asr/asr-05.md` |
| ASR-06 | Reintentos con esperas incrementales y circuit breaker | CTX-07 | `asr/asr-06.md` |
| ASR-07 | Aviso «datos al …» si GitLab no responde | CTX-07 | `asr/asr-07.md` |
| ASR-08 | Logs de carga por siempre; la evaluación registra fecha, hora y usuario | CTX-07, CTX-05 | `asr/asr-08.md` |
| ASR-09 | Historiales con vigencia: rol/nivel, asignaciones, jefe de proyecto, «reporta a», membresía, valoraciones y evaluaciones | CTX-01, CTX-05, CTX-06 | `asr/asr-09.md` |
| ASR-10 | Restricciones garantizadas: suma de dedicación ≤ 100 %, un milestone por proyecto, una membresía y un jefe vigentes, evaluación obligatoria para promover, evidencias solo de issues cerrados | CTX-01, CTX-05, CTX-06 | `asr/asr-10.md` |
| ASR-11 | Registro de colaboradores alineado con el UDM (Party Management) | CTX-01 | `asr/asr-11.md` |
| ASR-14 | Tratamiento de datos personales (política pendiente) | Todos | `asr/asr-14.md` |
| ASR-16 | MySQL 8.x, microservicios en Python con FastAPI | Todos | `asr/asr-16.md` |
| ASR-17 | Parámetros y datos sensibles en Vault bajo `secret/p3m/*` | Todos | `asr/asr-17.md` |
| ASR-18 | Protocolo de consumo seguro entre el BFF y los microservicios | Contratos | `asr/asr-18.md` |
| ASR-20 | Plataforma contenerizada | Despliegue | `asr/asr-20.md` |

Los 20 ASR tienen disposición humana **PENDIENTE**: ningún arquitecto los clasificó como `CANDIDATE`, `REJECT` o `INVESTIGATE`. Se citan como requisitos de origen, no como ASR aprobados (OI-02).

## 4. Architecture Decisions
| ADR | Decision | Status | Implementation implication | Source |
|---|---|---|---|---|
| ADR-DB-001 | El SSOT de un concepto se registra antes de modelar; el esquema no crea propiedad de negocio | Aprobado por ianache el 2026-10-12 (sin revisión de arquitecto distinto) | Las decisiones de negocio están en RCP-001 y BRC-001 antes de que el esquema las use | /architecture/adr/ADR-DB-001.md |
| ADR-DB-002 | Cada contexto posee sus agregados y su persistencia; datos entre contextos por contratos, identificadores o ACL; sin tablas compartidas | Aprobado por ianache el 2026-10-12 (sin revisión de arquitecto distinto) | Un esquema por contexto, sin FK entre esquemas, referencias `*_ref` | /architecture/adr/ADR-DB-002.md |
| ADR-DB-003 | MySQL 8.x con charset y collation explícitos e índices; migraciones Flyway versionadas y observables; cambios destructivos solo con expand/contract o forward-fix aprobado | Aprobado por ianache el 2026-10-12 (sin revisión de arquitecto distinto) | DDL de `flyway/`, inmutabilidad de migraciones | /architecture/adr/ADR-DB-003.md |
| ADR-05 | La base de datos es MySQL 8.x | Aceptada | Motor y versión mínima 8.0.16 | /architecture/adr/ADR-05-mysql-8-x-como-base-de-datos.md |
| ADR-07 | Microservicios en Python con FastAPI | Aceptada | Lenguaje y marco de los servicios | /architecture/adr/ADR-07-microservicios-en-python-con-fastapi.md |
| ADR-08 | Integración con GitLab de solo lectura, con carga programada y delta | Aceptada | Réplica de solo lectura y bitácora de cargas | /architecture/adr/ADR-08-carga-programada-de-gitlab-de-solo-lectura-co.md |
| ADR-09 | Reintentos con esperas incrementales y circuit breaker | Aceptada el patrón; parámetros propuestos | Comportamiento del proceso de carga | /architecture/adr/ADR-09-reintentos-con-esperas-incrementales-y-circui.md |
| ADR-10 | Modelo de personas y organizaciones alineado con el UDM | Aceptada; la correspondencia concreta es propuesta | Partes, roles de la parte y relaciones con vigencia | /architecture/adr/ADR-10-modelo-de-personas-y-organizaciones-alineado.md |
| ADR-11 | Identidad y roles de usuario gestionados en Keycloak; el portal guarda el GUID | Aceptada; falta decidir si se actualiza en cada inicio (RQ-22) | Usuario con GUID y vínculo con la persona | /architecture/adr/ADR-11-identidad-y-roles-de-usuario-gestionados-en-k.md |
| ADR-12 | Secretos y parámetros en HashiCorp Vault | Aceptada; faltan rotación y autenticación (ADR-P11) | Contraseñas de las cuentas MySQL fuera del repositorio | /architecture/adr/ADR-12-secretos-y-parametros-en-hashicorp-vault.md |
| ADR-P2 | Microservicios delimitados con DDD; REST seguro síncrono y RabbitMQ como único mensajero | Aprobada por ianache el 2026-10-12 (sin revisión de arquitecto distinto) | Contextos de DDM-001; contratos y EVT-01 | /architecture/adr/ADR-P2-descomposicion-en-microservicios-y-su-comunic.md |
| ADR-P3 | La carga de GitLab corre como proceso independiente con Celery Beat y workers | Aprobada por ianache el 2026-10-12 (sin revisión de arquitecto distinto) | Cuenta `svc_gitlab_carga` y una sola carga a la vez | /architecture/adr/ADR-P3-ejecucion-de-la-carga-programada-de-gitlab.md |
| ADR-P6 | Historial con vigencia y «una sola vigente» por índice único sobre columna calculada; la suma ≤ 100 % se valida en el servicio con bloqueo de filas | Aprobada por ianache el 2026-10-12 (sin revisión de arquitecto distinto) | Índices únicos sobre columnas generadas; protocolo de `colaborador_carga` (corrige el bloqueo simple, RPT-DDR-001 R-02) | /architecture/adr/ADR-P6-historial-con-vigencia-y-restricciones-en-mys.md |
| ADR-P9 | El BFF obtiene un JWT de máquina con OAuth2 Client Credentials y lo presenta a los microservicios | Aprobada por ianache el 2026-10-12 (sin revisión de arquitecto distinto) | Autenticación de los contratos internos | /architecture/adr/ADR-P9-nombre-del-protocolo-de-consumo-seguro-bffmic.md |
| ADR-P4 | Tratamiento de datos personales: clasificación, cifrado, acceso y retención | **Aprobada** por ianache el 2026-10-12: la decisión es retener los datos personales como los logs y aplazar la política (DT-01) | Sin controles específicos de datos personales; ver OI-03 | /architecture/adr/ADR-P4-tratamiento-de-datos-personales.md |
| ADR-P5 | Autorización por roles: guards en Angular y validación en servidor | **Aprobada** por ianache el 2026-10-12: el BFF reenvía el token del usuario además del JWT de máquina; cada servicio comprueba rol más condición del recurso | Los permisos de negocio (por ejemplo K-34, BR-002, BR-134, BR-135) los aplica el servicio; el mapa está en el anexo de ADR-P5 | /architecture/adr/ADR-P5-estrategia-de-autorizacion-por-rol.md |

ADR-P2, P3, P6, P7, P9 y ADR-DB-001 a 003 los aprobó ianache el 2026-10-12, en su rol de responsable funcional; no consta la revisión de un arquitecto distinto. Un ADR «Pendiente» **no** es una restricción: es una decisión abierta (sección 10).

## 5. Architecture Rules
Todas en estado `PROPOSED`: derivan de las decisiones de la sección 4 y de los diseños aprobados (PDM-001, ICP-001); ninguna introduce una decisión nueva. Plantilla: `assets/architecture-rule-template.md`. **En caso de violación: `ARCHITECTURE_CONFLICT`, escalar a Arquitectura.**

| Rule | Statement | Source ADR/ASR | Severity | Verification |
|---|---|---|---|---|
| ARCH-RULE-001 | MUST: cada contexto tiene su propio esquema; no hay claves foráneas ni tablas compartidas entre esquemas; cada servicio accede solo a su esquema. | ADR-DB-002, ADR-P2, INF-DEC-15; ASR-16 | REQUIRED | FIT-001 |
| ARCH-RULE-002 | MUST: MySQL 8.x (mínimo 8.0.16), InnoDB, `utf8mb4` y `utf8mb4_0900_ai_ci` explícitos; `issue_url` y `web_url` con `utf8mb4_bin`; GUID de Keycloak en `ascii_bin`. | ADR-DB-003, ADR-05; ASR-16 | REQUIRED | FIT-002 |
| ARCH-RULE-003 | MUST: todo cambio de esquema es una migración Flyway versionada e inmutable (`validateOnMigrate=true`, `cleanDisabled=true`). Los cambios destructivos exigen expand/contract o forward-fix aprobado. Una migración aplicada no se edita. | ADR-DB-003 | REQUIRED | FIT-003 |
| ARCH-RULE-004 | MUST: los historiales con vigencia no se borran. «Una sola vigente» se garantiza con un índice único sobre una columna generada. | ADR-P6; ASR-09, ASR-10 | REQUIRED | FIT-004 |
| ARCH-RULE-005 | MUST: antes de sumar la dedicación de un colaborador, la transacción hace `INSERT IGNORE` y `SELECT … FOR UPDATE` sobre su fila de `colaborador_carga`, con cualquier nivel de aislamiento; reintenta ante el error 1213. | ADR-P6; ASR-10 (PDM-001 F-15) | REQUIRED | FIT-005 |
| ARCH-RULE-006 | MUST: mínimo privilegio por tabla. Sin `DELETE` salvo en `rol_competencia`, `rol_nivel_competencia_minimo`, `proyecto_milestone`, `proyecto_rol_nivel_requerido` y `usuario_rol_de_usuario`. Sin `UPDATE` ni `DELETE` en las tablas de solo inserción. Sin `DELETE` en `carga_de_gitlab`. | INF-DEC-15; ASR-08, ASR-09 (PDM-001 §5, D-H28) | REQUIRED | FIT-006 |
| ARCH-RULE-007 | MUST: toda conexión a MySQL usa SSL. Las contraseñas viven en Vault bajo `secret/p3m/*` y nunca en el repositorio, las imágenes ni las migraciones. | ADR-12; ASR-17; INF-DEC-07, INF-DEC-14 | REQUIRED | FIT-007 |
| ARCH-RULE-008 | MUST: entre contextos solo se intercambia por los contratos de ICP-001 (CON-01 a CON-13, EVT-01). Las referencias a otro contexto son `*_ref` sin clave foránea. MUST NOT leer tablas ajenas. | ADR-DB-002, ADR-P2, ADR-P9; ASR-18 | REQUIRED | FIT-008 |
| ARCH-RULE-009 | MUST: `PromocionDeNivelDecidida` viaja por RabbitMQ con outbox transaccional. El consumidor es idempotente por `promocion_ref` y descarta, registrando, los eventos con `decidida_en` no posterior a la vigencia actual de la plaza. | ADR-P2; ASR-09 (ICP-001 EVT-01, K-42, K-46) | REQUIRED | FIT-009 |
| ARCH-RULE-010 | MUST: la réplica de GitLab es de solo lectura, la escribe solo el proceso de carga y solo guarda issues `UserStory` o `Task`. El proceso de carga ignora y registra los demás issues y MUST NOT fallar por ellos. | ADR-08, ADR-P3, ADR-09; ASR-04 a ASR-08 (DT-03) | REQUIRED | FIT-010 |
| ARCH-RULE-011 | MUST: el usuario se vincula con la persona por el correo vigente, único entre las personas, la primera vez que inicia sesión. El vínculo se fija una sola vez; solo la cuenta de corrección lo cambia y deja registro de quién y cuándo. MUST NOT existir registro libre ni auto-registro de cuentas. | ADR-11; ASR-03 (ICP-001 CON-13, BRC-001 BR-125, BR-128, BR-129) | REQUIRED | FIT-011 |
| ARCH-RULE-012 | MUST: los actores de las escrituras (`*_por_ref`) se guardan con el GUID de Keycloak (claim `sub`), sin consultar a Identidad. El `sub` sale del token del usuario que el BFF reenvía (ADR-P5). | ADR-11 (ICP-001 D-H20); ADR-P5 | REQUIRED | FIT-012 |
| ARCH-RULE-013 | MUST NOT: los contratos entre contextos y los eventos llevan datos personales. Solo identificadores, booleanos y niveles. Los registros de integración no contienen datos personales. | ASR-14; ICP-001 P-5; ADR-P4 aprobada con el aplazamiento DT-01 | REQUIRED | FIT-013 |
| ARCH-RULE-014 | MUST: el servicio implementa y prueba las restricciones que la base no garantiza: K-01, K-07, K-09, K-12, K-13, K-16, K-18, K-20, K-23, K-33 y K-34. | ASR-10 (PDM-001 §3, §9) | REQUIRED | FIT-014 |
| ARCH-RULE-015 | SHOULD NOT: añadir particionado, desnormalización ni índices especulativos sin evidencia de carga real. | PDM-001 F-11; LDM-001 §7 (D-H29) | RECOMMENDED | FIT-015 |
| ARCH-RULE-016 | MUST: los contratos internos se versionan (`/internal/v1`, `schema_version`), usan un JWT de máquina OAuth2 Client Credentials y evolucionan solo de forma aditiva dentro de una versión mayor. | ADR-P9; ASR-18 (ICP-001 §5, §7) | REQUIRED | FIT-016 |

## 6. Contracts
### APIs
Contratos internos de solo lectura, REST, versión `/internal/v1/…`, JWT de máquina (ADR-P9). Definidos en ICP-001 §2.1.

| ID | Consulta | Proveedor → consumidor |
|---|---|---|
| CON-01 | PersonaConRolVigente | CTX-01 → CTX-04, CTX-06 |
| CON-02 | RolNivelVigenteDePersona | CTX-01 → CTX-05 |
| CON-03 | RolNivelExiste | CTX-03 → CTX-01, CTX-05, CTX-06 |
| CON-04 | NivelesMinimosDeRolNivel | CTX-03 → CTX-06 |
| CON-05 | CompetenciaExiste | CTX-03 → CTX-04, CTX-05 |
| CON-06 | EvidenciasObligatoriasValidadas | CTX-05 → CTX-04 |
| CON-07 | NivelActualDeCompetencias | CTX-05 → CTX-06 |
| CON-08 | CertificacionExiste | CTX-04 → CTX-05 |
| CON-09 | EsJefeVigenteDeProyectoDelMilestone | CTX-06 → CTX-05 |
| CON-10 | IssueCerrado | CTX-07 → CTX-05 |
| CON-11 | MilestoneExiste | CTX-07 → CTX-06 |
| CON-12 | EvidenciaEsperadaDeEnrolamiento | CTX-04 → CTX-05 |
| CON-13 | PersonaPorCorreo | CTX-01 → CTX-02 |

Entradas, respuestas y propósito de cada uno: ICP-001 §2.1. CON-13 responde solo un identificador y un booleano, con el mismo mensaje de rechazo en todos los casos y sin revelar si el correo existe.

### Events
`PromocionDeNivelDecidida` v1 (EVT-01): CTX-05 → CTX-01, por RabbitMQ con outbox. Carga útil: `evento_id`, `promocion_ref`, `persona_ref`, `rol_nivel_destino_ref`, `decidida_en`, `schema_version`. Sin datos personales. Idempotencia, reentrega y eventos obsoletos: ICP-001 §2.2 y ARCH-RULE-009.

### Data
DDL, semillas, permisos y verificación en `data/flyway/`. Migraciones y checksums esperados de Flyway:

| Esquema | Migración | Checksum esperado |
|---|---|---|
| p3m_partes | V1__baseline_partes.sql | 1242511565 |
| p3m_identidad | V1__baseline_identidad.sql | 1916221164 |
| p3m_curricula | V1__baseline_curricula.sql | 641202384 |
| p3m_curricula | V2__seed_seniority_niveles.sql | -75542515 |
| p3m_formacion | V1__baseline_formacion.sql | 1941176407 |
| p3m_progresion | V1__baseline_progresion.sql | -1388612769 |
| p3m_portafolio | V1__baseline_portafolio.sql | -1868510700 |
| p3m_gitlab | V1__baseline_gitlab.sql | 1057650316 |

- **Secuencia de despliegue:** (1) `provision/00_esquemas_y_cuentas.sql`; (2) `flyway migrate` por esquema con la cuenta `flyway_<ctx>` (conexión cifrada); (3) `provision/01_permisos_por_tabla.sql`; (4) `verify/preflight_postflight.sql`.
- **Un `V1` aplicado no se edita.** Todo cambio es una versión nueva (ARCH-RULE-003).
- **Una tabla sin permiso explícito queda inaccesible** para el servicio: hay que añadirla a `01_permisos_por_tabla.sql`.
- **Protocolo obligatorio de K-31** (ARCH-RULE-005): `INSERT IGNORE` y `SELECT … FOR UPDATE` sobre `colaborador_carga` antes de sumar. La base **no lo obliga**: un único punto del servicio debe crear asignaciones.
- Modelo lógico y trazabilidad de restricciones K-01 a K-47: LDM-001. Linaje de agregados: DDM-001.

## 7. Quality
### NFRs
| ID | Requisito | Clasificación | Observación |
|---|---|---|---|
| NFR-01 | Disponibilidad 99,9 % en fallas normales; RTO 4 h y RPO 1 h con respaldos horarios en desastre (INF-DEC-23). | FACT (INF-Q02, 2026-10-10) | El diseño de recuperación está sin verificar (OI-06) |
| NFR-02 | Más de 50 colaboradores; resto de la carga desconocido. | FACT parcial (INF-Q03); resto UNKNOWN | OI-07 |
| NFR-03 | Retención por siempre de los logs de carga y de los datos personales. | FACT (BR-090, BR-101) | Unas 2 880 filas al día en `carga_de_gitlab`, cerca de 1,05 millones al año. **INFERENCE** (BR-039, BR-094), del orden de 100 a 150 MB al año |
| NFR-04 | Tiempos en UTC (`DATETIME(3)`); la presentación en UTC-05 es del cliente (BR-092). | FACT | — |
| NFR-05 | Zona horaria del servidor `+00:00`, modo SQL estricto, versión mínima 8.0.16. | FACT (PDM-001 §6, preflight) | Probado solo en 8.4.11 |

### Fitness Criteria
| ID | Rule | Description | Type | Evidence required | Expected result | Current state |
|---|---|---|---|---|---|---|
| FIT-001 | ARCH-RULE-001 | Ninguna FK cruza esquemas | AUTOMATED | `python -I flyway/verify/analisis_estatico_ddl.py flyway` y postflight Q3 | 0 FK entre esquemas | PASS (51 tablas, 46 FK, 0 entre esquemas) |
| FIT-002 | ARCH-RULE-002 | Todas las tablas son InnoDB y `utf8mb4_0900_ai_ci` | AUTOMATED | Postflight Q1 (`flyway/verify/preflight_postflight.sql`) | 0 tablas fuera de la norma | PASS |
| FIT-003 | ARCH-RULE-003 | Migraciones válidas, inmutables y sin cambios destructivos no aprobados | HYBRID | `flyway migrate` con `validateOnMigrate=true`; checksums de PDM-001 §6; revisión humana de todo `DROP`, `RENAME` o `ALTER` destructivo | Checksums iguales; sin migración fallida | PASS (8 migraciones, checksums coinciden) |
| FIT-004 | ARCH-RULE-004 | «Una sola vigente» y no borrado de historiales | AUTOMATED | `flyway/verify/pruebas_restricciones.sh` (111 pruebas) y postflight Q6 (7 índices) | 111 de 111; 7 índices únicos | PASS |
| FIT-005 | ARCH-RULE-005 | Suma de dedicación ≤ 100 % bajo concurrencia | HYBRID | `ciclo_completo.sh` (K-31 con `svc_portafolio`, `READ COMMITTED` y `REPEATABLE READ`); prueba del servicio | Suma 60 % y 0 interbloqueos en ambos niveles | PASS en la base; prueba del servicio NOT_VERIFIABLE |
| FIT-006 | ARCH-RULE-006 | Permisos por tabla conformes a la política | AUTOMATED | Postflight Q9 y 18 pruebas de permisos de `ciclo_completo.sh` | 0 permisos fuera de política | PASS |
| FIT-007 | ARCH-RULE-007 | SSL obligatorio y secretos fuera del repositorio | HYBRID | Prueba «conexión sin SSL rechazada»; escaneo de secretos en el pipeline | Conexión sin SSL rechazada; ningún secreto en el repositorio | PASS el SSL; el escaneo de secretos es NOT_VERIFIABLE (no hay pipeline) |
| FIT-008 | ARCH-RULE-008 | Sin acceso entre contextos fuera de los contratos | HYBRID | Prueba de permisos entre esquemas; pruebas de contrato por cada CON-xx | El servicio de un contexto no lee otro esquema; cada contrato cumple su esquema | PASS los permisos; las pruebas de contrato son NOT_VERIFIABLE |
| FIT-009 | ARCH-RULE-009 | EVT-01 idempotente y sin eventos obsoletos | HYBRID | Pruebas SQL de K-42 y K-46 (4 pruebas); pruebas del consumidor | Un evento repetido o antiguo no modifica la plaza | PASS en SQL; el consumidor es NOT_VERIFIABLE |
| FIT-010 | ARCH-RULE-010 | Réplica de GitLab de solo lectura y carga tolerante | HYBRID | Prueba «svc_gitlab no inserta réplicas»; prueba del proceso de carga con un issue de otro tipo | La carga completa sin fallar y registra lo ignorado | PASS los permisos; el proceso de carga es NOT_VERIFIABLE |
| FIT-011 | ARCH-RULE-011 | Vínculo inmutable y sin auto-registro | HYBRID | Pruebas de permisos por columna sobre `usuario.persona_ref` y de K-43, K-44, K-45; prueba del flujo de login con CON-13 | Solo la cuenta de corrección cambia el vínculo | PASS en la base; el flujo de login es NOT_VERIFIABLE |
| FIT-012 | ARCH-RULE-012 | Columnas de actor con el GUID de Keycloak | AUTOMATED | Consulta a `information_schema.columns`: las columnas `*_por_ref` de actor son `CHAR(36)` `ascii_bin`. **La consulta no existe todavía y debe escribirse** | Todas conformes | NOT_VERIFIABLE (por escribir) |
| FIT-013 | ARCH-RULE-013 | Contratos y eventos sin datos personales | HYBRID | Prueba de contrato con lista blanca de campos; revisión de los registros de integración | Ningún campo personal en los mensajes | NOT_VERIFIABLE (no existen los servicios) |
| FIT-014 | ARCH-RULE-014 | Restricciones del servicio probadas | AUTOMATED | Una prueba por cada K de la regla, en el servicio | Todas pasan | NOT_VERIFIABLE (no existen los servicios) |
| FIT-015 | ARCH-RULE-015 | Sin particionado ni desnormalización sin evidencia | MANUAL | Revisión del Merge Request | Sin cambios de ese tipo no justificados | NOT_APPLICABLE por ahora |
| FIT-016 | ARCH-RULE-016 | Contratos versionados y autenticados | HYBRID | Pruebas de contrato y de autenticación con JWT de máquina | Rutas `/internal/v1`, `schema_version` y token válido | NOT_VERIFIABLE (no existen los servicios) |

### Testability
- **Reproducible hoy:** `bash data/flyway/verify/ciclo_completo.sh` levanta un MySQL 8.4 desechable en Docker, aplica las migraciones con Flyway real y ejecuta el postflight, las 111 pruebas de restricciones, las 18 de permisos y la concurrencia de K-31. Requiere Docker y las imágenes `mysql:8.4` y `flyway/flyway:10`. Usa solo contraseñas de prueba y **no debe usarse contra una instancia real**.
- **Sin cubrir:** concurrencia de K-18 (cupo), otras versiones de MySQL, certificados TLS reales, copias y restauración, alta disponibilidad, y toda restricción que garantiza el servicio.
- **Falta por escribir:** la consulta de FIT-012 y las pruebas de contrato de cada CON-xx y de EVT-01.
- El driver MariaDB 2.7 de la imagen de Flyway se usó solo para las pruebas: el pipeline de producción debe probarse con su propio driver.

## 8. Security Constraints
| ID | Constraint | Source | Rule / item |
|---|---|---|---|
| SEC-01 | Todas las cuentas MySQL exigen SSL; los hosts `%` se restringen a la red de los servicios al desplegar. | PDM-001 §5; INF-DEC-07 | ARCH-RULE-007 |
| SEC-02 | Mínimo privilegio por tabla y por columna (`persona_ref`); ningún servicio lee otro esquema. | PDM-001 §5; INF-DEC-15 | ARCH-RULE-001, ARCH-RULE-006 |
| SEC-03 | Contraseñas en Vault bajo `secret/p3m/*`; los scripts usan marcadores y nunca se escriben valores. | ADR-12; INF-DEC-14 | ARCH-RULE-007 |
| SEC-04 | No hay registro libre ni auto-registro; las identidades vienen de Active Directory vía Keycloak y el correo es de solo lectura. Es un requisito de despliegue: si cambia, vuelve el riesgo de suplantación (RPT-DDR-001 R-01). | INF-DEC-22; BRC-001 BR-128 | ARCH-RULE-011 |
| SEC-05 | Las llamadas internas usan un JWT de máquina OAuth2 Client Credentials; las rutas `/internal/…` no se publican en el API Gateway. | ADR-P9; ICP-001 §5 | ARCH-RULE-016 |
| SEC-06 | Los mensajes entre contextos no llevan datos personales; los registros de integración tampoco. | ICP-001 P-5 | ARCH-RULE-013 |
| SEC-07 | Los datos personales se retienen por siempre y no hay mecanismo de borrado; la clasificación y el cifrado de columna están diferidos (DT-01). **No debilitar los controles que ya existen.** | BR-101; ADR-P4 aprobada con el aplazamiento DT-01 | OI-03 |
| SEC-08 | Una URL de issue solo se acepta bajo la URL base de GitLab configurada en Vault. | ICP-001 §2.3 (ACL-02) | ARCH-RULE-010 |

## 9. Evidence & Provenance
| Evidence ID | Claim supported | Source | Version/date | Freshness |
|---|---|---|---|---|
| E-01 | El diseño físico está aprobado por una persona (D-H36, D-H37) y su gate pasó | PDM-001 §10, §11 | 2026-10-12 | Vigente |
| E-02 | Las migraciones se aplican con Flyway 10 y cuentas de mínimo privilegio en MySQL 8.4.11 limpio, sin fallas | PDM-001 §9; `flyway/verify/ciclo_completo.sh` | 2026-10-12 | Vigente |
| E-03 | 111 pruebas de restricciones, 18 de permisos, 48 comprobaciones de postflight y la prueba de concurrencia de K-31 pasan | PDM-001 §9 | 2026-10-12 | Vigente; se repite con cada cambio |
| E-04 | Checksums de Flyway iguales a los calculados (8 de 8) | PDM-001 §6 | 2026-10-12 | Vigente |
| E-05 | La revisión independiente del diseño dio el gate PASSED con riesgos residuales aceptados | RPT-DDR-001 §1, §6 | 2026-10-12 | Vigente; la hizo el mismo agente que produjo el diseño |
| E-06 | Contratos entre contextos y capas anticorrupción definidos y aprobados | ICP-001 §2, §11 | 2026-10-11 | Vigente |
| E-07 | Objetivos de disponibilidad, RTO, RPO y carga parcial | INF-P3M-001 INF-Q02, INF-Q03, INF-DEC-23 | 2026-10-12 | Vigente; INF-P3M-001 0.1.2 |
| E-08 | ADR-P2, P3, P6, P7, P9 y ADR-DB-001 a 003 aprobados por ianache; ADR-P5 en revisión; ADR-P4 aprobada con el aplazamiento DT-01 | ADR-P2, P3, P6, P7, P9 §1 y §7; CAT-ADR-001 §4 | 2026-10-12 | Vigente; OI-01 |
| E-09 | Las decisiones de negocio están registradas en RCP-001 (D-133 a D-159) y BRC-001 (BR-101 a BR-130), verificados por ianache | BRC-001, RCP-001, LDM-001 §10 | 2026-10-12 | Vigente |
| E-10 | Las seis historias actualizadas fueron verificadas por ianache; las siete nuevas (US-029 a US-035) están en draft | `requirements/user-stories/` | 2026-10-12 | Vigente |

Clasificación de lo afirmado: lo anterior es **FACT** salvo lo marcado como INFERENCE en la sección 7.

## 10. Open Items
| ID | Type | Description | Blocking? | Owner | Required action |
|---|---|---|---|---|---|
| OI-01 | OPEN_DECISION | **Resuelto en parte.** ianache aprobó el 2026-10-12 ADR-P2, P3, P6, P7, P9 y ADR-DB-001/002/003, en su rol de responsable funcional. **ADR-P5 no se aprobó** (OI-04, OI-18). No consta la revisión de un arquitecto distinto. Las reglas ARCH-RULE siguen en `PROPOSED` hasta que el Solution Architect las apruebe. | No | Solution Architect | Aprobar o devolver las reglas ARCH-RULE |
| OI-02 | MISSING_EVIDENCE | Los 20 ASR tienen disposición humana PENDIENTE. Ninguno está clasificado como `CANDIDATE`, `REJECT` o `INVESTIGATE`. | No | Solution Architect | Clasificar los ASR citados (ASR-03 a ASR-11, ASR-14, ASR-16 a ASR-18, ASR-20) |
| OI-03 | OPEN_DECISION | ADR-P4 (datos personales) fue **aprobada el 2026-10-12** y su decisión es aplazar la política (DT-01): sin clasificación, cifrado de columna, acceso ni borrado a solicitud del titular; los datos personales se retienen por siempre (BR-101). **Seguridad aceptó el aplazamiento (DT-01)** según ianache el 2026-10-12; no consta el nombre del aceptante ni una referencia. | No para el esquema. Sí antes de producción decidir ADR-P4 | Seguridad y responsable funcional | Adjuntar el nombre y la referencia de la aceptación; decidir ADR-P4 y aplicarlo con una migración nueva |
| OI-04 | FACT | **RESUELTO el 2026-10-12:** ianache respondió P5-D1 a P5-D7 y aprobó ADR-P5 (con su anexo). Antes: ADR-P5: el mapa rol-permiso está **propuesto** en `ADR-P5-anexo-mapa-rol-permiso-propuesta.md` y **no aprobado**. Hay 7 decisiones pendientes (P5-D1 a P5-D7). Los permisos de negocio (BR-002, BR-005, BR-055, BR-109 y otros) los aplica el servicio. | No para el esquema. Sí para la capa de servicios | Arquitectura y responsable funcional | Responder P5-D1 a P5-D7 y aprobar ADR-P5 antes de implementar los servicios |
| OI-05 | OPEN_DECISION | Alojamiento y modo de alta disponibilidad de MySQL: ¿servicio gestionado o contenedor?, ¿replicación semisíncrona o de grupo? (INF-DEC-11). INF-DEC-23 exige conmutación en minutos. | No para las migraciones. Sí antes de producción | Arquitectura e infraestructura | Decidirlo y probar la conmutación |
| OI-06 | MISSING_EVIDENCE | La recuperación de MySQL no está verificada: sin conmutación ni restauración de prueba contra 99,9 % / RTO 4 h / RPO 1 h. **Aceptado como deuda técnica DT-04** (D-H39), confirmado por ianache el 2026-10-12 (D-H43). | No | Infraestructura | Conmutación y restauración de prueba antes de producción |
| OI-07 | UNKNOWN | Carga parcial: más de 50 colaboradores. Faltan usuarios concurrentes, volumen de issues, crecimiento e IOPS (DT-02). Los índices cubren solo restricciones y consultas de contrato. | No | Arquitectura | Revisar los índices con datos reales y el registro de consultas lentas |
| OI-08 | OPEN_DECISION | Issues de tipo «Proyecto» (BR-039) y campos que BR-038 manda mostrar (esfuerzo estimado, esfuerzo gastado, fecha de vencimiento): la réplica no los guarda (DT-03). | No | Jefe de Ingeniería | Decidir el tratamiento y añadir una `V2` de `p3m_gitlab` |
| OI-09 | ASSUMPTION | Ningún ambiente aplicó los `V1` anteriores de `p3m_partes`, `p3m_identidad` y `p3m_portafolio`. El responsable aprobó F-18 sin confirmarlo expresamente. | No | Responsable funcional | Confirmarlo. Si algún ambiente los aplicó, añadir una `V2` por esquema |
| OI-10 | STALE_EVIDENCE | **Resuelto en parte.** IMD-001, BRC-001, RCP-001 y las seis historias actualizadas fueron **verificadas por ianache el 2026-10-12** (D-H41). Siguen desfasados los issues de GitLab #17, #19 y #21 y TRC-SSP-001, que reflejan la versión anterior de las historias. Las historias US-029 a US-035 son nuevas y están en `draft`. | No | Análisis funcional | Republicar los issues y la trazabilidad; verificar las historias nuevas |
| OI-11 | UNKNOWN | **Resuelto en parte.** Se redactaron el 2026-10-12 las historias US-029 (contactos), US-030 (plazas), US-031 (ocupaciones), US-032 (roles de la parte), US-033 (corrección de vínculo) y US-034 (relaciones). Cinco están CONDITIONAL y una READY; todas en `draft`. **Se redactó después US-035 para el registro de las organizaciones** (BR-072). | No | Análisis funcional | Verificar las historias, responder sus preguntas y redactar la de organizaciones |
| OI-12 | ASSUMPTION | Se asume un servicio por contexto (7). ADR-P2 dice que falta enumerar los servicios; DDM-001 enumera contextos, no servicios. | No | Arquitectura | Confirmar el número y el nombre de los servicios |
| OI-13 | OPEN_DECISION | Parámetros operativos de los contratos internos (tiempos de espera, circuit breaker, reintentos). ADR-09 solo propone parámetros para GitLab. | No para el esquema. Sí para los servicios | Infraestructura | Fijarlos antes de implementar los clientes de contrato |
| OI-14 | UNKNOWN | Preguntas abiertas de las historias que afectan a la implementación: US-010-Q2 (el desenrolamiento y el registro), US-025-Q1 y US-025-Q2 (datos que no entrega Keycloak; correo ya vinculado), RQ-32 (permiso del jefe de proyecto), RQ-33 (roles de la parte simultáneos), RQ-22 (actualizar el usuario en cada inicio). | No | Jefe de Ingeniería | Responderlas antes de implementar cada historia |
| OI-15 | UNKNOWN | INF-Q17: cómo se federa Keycloak con Active Directory y qué pasa si no responde. Afecta al ingreso (US-025, US-027). | No | Infraestructura y seguridad | Definirlo |
| OI-16 | CONFLICT | INF-P3M-001 mantiene INF-DEC-02 como «PENDIENTE» (plataforma de contenedores) mientras ADR-P7 decide Docker local y Kubernetes en Oracle OKE. Queda por confirmar si DEV también va en OKE. | No | Arquitectura | Alinear INF-DEC-02 con ADR-P7 |
| OI-17 | OPEN_DECISION | Fuera de este alcance: US-027 y US-028 (ingreso y cierre de sesión) no usan la base de datos; los resuelven el BFF y Keycloak. | No | Arquitectura | Transferir en otro pack |
| OI-18 | FACT | **RESUELTO el 2026-10-12 (P5-D1 = A):** el BFF reenvía el token del usuario además del JWT de máquina y cada servicio lo valida contra Keycloak; ADR-P9 no cambia. Antes: ADR-P5 dice que cada microservicio valida el rol del usuario; ADR-P9 (aprobado) hace que el BFF llame con un JWT de máquina, no el del usuario. El servicio no recibe la identidad ni los roles del usuario, ni el GUID del actor que exige ARCH-RULE-012. Opciones y recomendación en el anexo de ADR-P5 (G-1). | No para el esquema. **Sí para implementar los servicios** | Arquitectura y responsable funcional | Decidir P5-D1 (recomendación: reenviar el token del usuario además del de máquina) |
| OI-19 | FACT | RESUELTO el 2026-10-12 (D-160, BR-131: toda parte tiene contactos; F-19). Faltan tipos y obligatoriedad para organizaciones (RQ-36). Antes: BR-121 y D-150 dicen que solo las personas tienen contactos; el responsable indicó el 2026-10-12 «contactos de las Party (Person u Organization)». Afecta a `dato_de_contacto`, que hoy solo se relaciona con `persona`. | Parcial: bloquea la parte de organizaciones de US-029 y un posible cambio del esquema | Jefe de Ingeniería | Confirmar si las organizaciones tienen contactos, con qué tipos y cuáles obligatorios; si es así, registrar la decisión y añadir una migración |
| OI-20 | FACT | **RESUELTO el 2026-10-12 (D-166, BR-135):** los mantienen el Jefe de Ingeniería y el ADMIN. Antes: Ninguna regla dice quién mantiene los contactos, plazas, ocupaciones, roles de la parte y relaciones. Las historias lo asumen como hipótesis (Jefe de Ingeniería o ADMIN, por analogía con BR-002). | No para el esquema | Jefe de Ingeniería | Responder P5-D6 |
| OI-21 | ASSUMPTION | Los nombres de rol de Keycloak (ADMIN, COLABORADOR, INSTRUCTOR, JEFE_INGENIERIA) son un supuesto del responsable (D-164); no se contrastaron con la configuración real de Keycloak. El DDL (`ck_usuario_rol`) y ACL-01 ya los usan. | No para el esquema. Sí para implementar los servicios | Infraestructura / responsable funcional | Contrastar con Keycloak antes de implementar la autorización |
| OI-22 | STALE_EVIDENCE | BR-134 (D-165): el ADMIN suple las seis capacidades exclusivas del Jefe de Ingeniería. Las historias aprobadas US-002, US-003, US-006, US-007, US-008, US-017, US-021, US-022 y US-026 aún dicen «solo el Jefe de Ingeniería». Cambiarlas devuelve a `draft` lo verificado. | No para el esquema | Jefe de Ingeniería | Decidir si se actualizan esas historias y se verifican de nuevo |

Detalle con evidencia en `open-items.md`.

## 11. Traceability
| US | ASR | ADR | Architecture Rule | Fitness Criterion |
|---|---|---|---|---|
| US-001 | ASR-16 | ADR-05, ADR-DB-001, ADR-DB-002, ADR-DB-003 | ARCH-RULE-001, ARCH-RULE-002, ARCH-RULE-003, ARCH-RULE-006, ARCH-RULE-014 | FIT-001, FIT-002, FIT-003, FIT-006, FIT-014 |
| US-002 | ASR-16 | ADR-05, ADR-DB-001, ADR-DB-002, ADR-DB-003 | ARCH-RULE-001, ARCH-RULE-002, ARCH-RULE-003, ARCH-RULE-006, ARCH-RULE-014 | FIT-001, FIT-002, FIT-003, FIT-006, FIT-014 |
| US-003 | ASR-16 | ADR-05, ADR-DB-001, ADR-DB-002, ADR-DB-003 | ARCH-RULE-001, ARCH-RULE-002, ARCH-RULE-003, ARCH-RULE-006, ARCH-RULE-014 | FIT-001, FIT-002, FIT-003, FIT-006, FIT-014 |
| US-004 | ASR-09, ASR-11, ASR-14, ASR-16 | ADR-05, ADR-10, ADR-P6, ADR-P4 | ARCH-RULE-001, ARCH-RULE-002, ARCH-RULE-004, ARCH-RULE-006, ARCH-RULE-013, ARCH-RULE-014 | FIT-001, FIT-002, FIT-004, FIT-006, FIT-013, FIT-014 |
| US-005 | ASR-09, ASR-11, ASR-14, ASR-16 | ADR-05, ADR-10, ADR-P6, ADR-P4 | ARCH-RULE-001, ARCH-RULE-002, ARCH-RULE-004, ARCH-RULE-006, ARCH-RULE-013, ARCH-RULE-014 | FIT-001, FIT-002, FIT-004, FIT-006, FIT-013, FIT-014 |
| US-006 | ASR-16 | ADR-05, ADR-P2, ADR-DB-002 | ARCH-RULE-001, ARCH-RULE-002, ARCH-RULE-003, ARCH-RULE-006, ARCH-RULE-008, ARCH-RULE-014 | FIT-001, FIT-002, FIT-003, FIT-006, FIT-008, FIT-014 |
| US-007 | ASR-16 | ADR-05, ADR-P2, ADR-DB-002 | ARCH-RULE-001, ARCH-RULE-002, ARCH-RULE-003, ARCH-RULE-006, ARCH-RULE-008, ARCH-RULE-014 | FIT-001, FIT-002, FIT-003, FIT-006, FIT-008, FIT-014 |
| US-008 | ASR-16 | ADR-05, ADR-P2, ADR-DB-002 | ARCH-RULE-001, ARCH-RULE-002, ARCH-RULE-003, ARCH-RULE-006, ARCH-RULE-008, ARCH-RULE-014 | FIT-001, FIT-002, FIT-003, FIT-006, FIT-008, FIT-014 |
| US-009 | ASR-10, ASR-16 | ADR-05, ADR-P2, ADR-P6 | ARCH-RULE-001, ARCH-RULE-004, ARCH-RULE-006, ARCH-RULE-014 | FIT-001, FIT-004, FIT-006, FIT-014 |
| US-010 | ASR-10, ASR-16 | ADR-05, ADR-P2, ADR-P6 | ARCH-RULE-001, ARCH-RULE-004, ARCH-RULE-006, ARCH-RULE-014 | FIT-001, FIT-004, FIT-006, FIT-014 |
| US-011 | ASR-10, ASR-16 | ADR-P2, ADR-P9, ADR-DB-002 | ARCH-RULE-008, ARCH-RULE-013, ARCH-RULE-014, ARCH-RULE-016 | FIT-008, FIT-013, FIT-014, FIT-016 |
| US-012 | ASR-10, ASR-16 | ADR-P2, ADR-P9, ADR-DB-002 | ARCH-RULE-008, ARCH-RULE-013, ARCH-RULE-014, ARCH-RULE-016 | FIT-008, FIT-013, FIT-014, FIT-016 |
| US-013 | ASR-04, ASR-05, ASR-10 | ADR-08, ADR-P2, ADR-P9 | ARCH-RULE-006, ARCH-RULE-008, ARCH-RULE-010, ARCH-RULE-013, ARCH-RULE-014, ARCH-RULE-016 | FIT-006, FIT-008, FIT-010, FIT-013, FIT-014, FIT-016 |
| US-014 | ASR-04, ASR-05, ASR-10 | ADR-08, ADR-P2, ADR-P9 | ARCH-RULE-006, ARCH-RULE-008, ARCH-RULE-010, ARCH-RULE-013, ARCH-RULE-014, ARCH-RULE-016 | FIT-006, FIT-008, FIT-010, FIT-013, FIT-014, FIT-016 |
| US-015 | ASR-04, ASR-05, ASR-10 | ADR-08, ADR-P2, ADR-P9 | ARCH-RULE-006, ARCH-RULE-008, ARCH-RULE-010, ARCH-RULE-013, ARCH-RULE-014, ARCH-RULE-016 | FIT-006, FIT-008, FIT-010, FIT-013, FIT-014, FIT-016 |
| US-016 | ASR-09, ASR-14 | ADR-P6, ADR-P4 | ARCH-RULE-004, ARCH-RULE-006, ARCH-RULE-012, ARCH-RULE-013 | FIT-004, FIT-006, FIT-012, FIT-013 |
| US-017 | ASR-09, ASR-10, ASR-14 | ADR-P2, ADR-P6, ADR-P4 | ARCH-RULE-004, ARCH-RULE-008, ARCH-RULE-009, ARCH-RULE-012, ARCH-RULE-013, ARCH-RULE-014 | FIT-004, FIT-008, FIT-009, FIT-012, FIT-013, FIT-014 |
| US-018 | ASR-09, ASR-10 | ADR-05, ADR-P6 | ARCH-RULE-001, ARCH-RULE-004, ARCH-RULE-006, ARCH-RULE-014 | FIT-001, FIT-004, FIT-006, FIT-014 |
| US-019 | ASR-09, ASR-10 | ADR-05, ADR-P6 | ARCH-RULE-001, ARCH-RULE-004, ARCH-RULE-006, ARCH-RULE-014 | FIT-001, FIT-004, FIT-006, FIT-014 |
| US-020 | ASR-04, ASR-05, ASR-06, ASR-07, ASR-08 | ADR-08, ADR-09, ADR-P3, ADR-12 | ARCH-RULE-006, ARCH-RULE-007, ARCH-RULE-010 | FIT-006, FIT-007, FIT-010 |
| US-021 | ASR-09, ASR-10 | ADR-P6, ADR-P9 | ARCH-RULE-004, ARCH-RULE-005, ARCH-RULE-006, ARCH-RULE-008, ARCH-RULE-012, ARCH-RULE-014 | FIT-004, FIT-005, FIT-006, FIT-008, FIT-012, FIT-014 |
| US-022 | ASR-09, ASR-10 | ADR-P6, ADR-P9 | ARCH-RULE-004, ARCH-RULE-005, ARCH-RULE-006, ARCH-RULE-008, ARCH-RULE-012, ARCH-RULE-014 | FIT-004, FIT-005, FIT-006, FIT-008, FIT-012, FIT-014 |
| US-023 | ASR-09, ASR-10 | ADR-P6, ADR-P9 | ARCH-RULE-004, ARCH-RULE-005, ARCH-RULE-006, ARCH-RULE-008, ARCH-RULE-012, ARCH-RULE-014 | FIT-004, FIT-005, FIT-006, FIT-008, FIT-012, FIT-014 |
| US-024 | ASR-04, ASR-05, ASR-06, ASR-07, ASR-08 | ADR-08, ADR-09, ADR-P3, ADR-12 | ARCH-RULE-006, ARCH-RULE-007, ARCH-RULE-010 | FIT-006, FIT-007, FIT-010 |
| US-025 | ASR-03, ASR-14 | ADR-11, ADR-P5, ADR-12 | ARCH-RULE-007, ARCH-RULE-008, ARCH-RULE-011, ARCH-RULE-012, ARCH-RULE-013 | FIT-007, FIT-008, FIT-011, FIT-012, FIT-013 |
| US-026 | ASR-08, ASR-09, ASR-14 | ADR-P6, ADR-P4 | ARCH-RULE-004, ARCH-RULE-006, ARCH-RULE-012, ARCH-RULE-013 | FIT-004, FIT-006, FIT-012, FIT-013 |
| US-029 | ASR-11, ASR-14, ASR-16 | ADR-10, ADR-P6, ADR-P4, ADR-DB-002 | ARCH-RULE-001, ARCH-RULE-004, ARCH-RULE-006, ARCH-RULE-013, ARCH-RULE-014 | FIT-001, FIT-004, FIT-006, FIT-013, FIT-014 |
| US-030 | ASR-09, ASR-11, ASR-16 | ADR-10, ADR-P6, ADR-DB-002 | ARCH-RULE-001, ARCH-RULE-004, ARCH-RULE-006, ARCH-RULE-009, ARCH-RULE-014 | FIT-001, FIT-004, FIT-006, FIT-009, FIT-014 |
| US-031 | ASR-09, ASR-11, ASR-16 | ADR-10, ADR-P6, ADR-DB-002 | ARCH-RULE-001, ARCH-RULE-004, ARCH-RULE-006, ARCH-RULE-009, ARCH-RULE-014 | FIT-001, FIT-004, FIT-006, FIT-009, FIT-014 |
| US-032 | ASR-09, ASR-10, ASR-11 | ADR-10, ADR-P6 | ARCH-RULE-004, ARCH-RULE-006, ARCH-RULE-014 | FIT-004, FIT-006, FIT-014 |
| US-033 | ASR-03, ASR-14 | ADR-11, ADR-P5 | ARCH-RULE-006, ARCH-RULE-011, ARCH-RULE-012, ARCH-RULE-013 | FIT-006, FIT-011, FIT-012, FIT-013 |
| US-034 | ASR-09, ASR-10, ASR-11 | ADR-10, ADR-P6 | ARCH-RULE-004, ARCH-RULE-006, ARCH-RULE-014 | FIT-004, FIT-006, FIT-014 |
| US-035 | ASR-09, ASR-10, ASR-11 | ADR-10, ADR-P6 | ARCH-RULE-004, ARCH-RULE-006, ARCH-RULE-014 | FIT-004, FIT-006, FIT-014 |

Mapa ampliado para el seguimiento posterior: `traceability-map.md`.

## 12. Handoff Readiness
- Recommendation: **READY_WITH_OBSERVATIONS**
- Blocking findings: ninguno para el esquema, las migraciones, los permisos ni los contratos.
- Observations: OI-01 a OI-22. Las de mayor peso: los nombres de rol de Keycloak sin contrastar (OI-21), las historias aprobadas desfasadas respecto de BR-134 (OI-22), ADR-P4 aprobada con el aplazamiento DT-01 (OI-03) y la recuperación sin verificar (OI-06).
- Evidence coverage: 10 evidencias con fuente y fecha; los criterios de aptitud tienen evidencia ejecutada en la base y están sin verificar en los servicios.

## 13. Human Decision Gate
- Decision: PENDING
- Decision maker: Solution Architect (por definir)
- Date: —
- Conditions / observations: ver `ready-for-dev.md` y `open-items.md`
