---
artifact: development-scope-pack
okf: google-okf-v0.2
id: DSP-001
title: "Alcance candidato de desarrollo de P3M (People, Product and Project Management)"
generated: 2026-10-10
verified: true
status: READY_FOR_SPRINT_SELECTION
product: P3M
sources:
  - "requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md"
  - "requirements/user-stories/US-001-mantener-el-catalogo-de-roles.md"
  - "requirements/user-stories/US-002-definir-perfil-de-competencias-de-un-rol.md"
  - "requirements/user-stories/US-003-definir-el-nivel-minimo-por-rol-nivel.md"
  - "requirements/user-stories/US-004-registrar-y-modificar-colaboradores.md"
  - "requirements/user-stories/US-005-consultar-los-datos-de-los-colaboradores.md"
  - "requirements/user-stories/US-006-definir-un-curso-con-sus-objetivos.md"
  - "requirements/user-stories/US-007-definir-rubrica-de-objetivo-de-curso.md"
  - "requirements/user-stories/US-008-crear-una-edicion-de-un-curso.md"
  - "requirements/user-stories/US-009-enrolarse-en-una-edicion-de-un-curso.md"
  - "requirements/user-stories/US-010-desenrolarse-de-una-edicion-de-un-curso.md"
  - "requirements/user-stories/US-011-validar-las-evidencias-de-curso.md"
  - "requirements/user-stories/US-012-certificar-colaborador-en-una-edicion.md"
  - "requirements/user-stories/US-013-registrar-evidencias-de-un-objetivo.md"
  - "requirements/user-stories/US-014-aportar-evidencias-de-proyecto.md"
  - "requirements/user-stories/US-015-validar-evidencias-de-proyecto.md"
  - "requirements/user-stories/US-016-registrar-la-valoracion-de-un-colaborado.md"
  - "requirements/user-stories/US-017-decidir-la-promocion-de-nivel.md"
  - "requirements/user-stories/US-018-registrar-un-producto-vinculado-a-gitlab.md"
  - "requirements/user-stories/US-019-registrar-un-proyecto-con-sus-milestones.md"
  - "requirements/user-stories/US-020-cargar-automaticamente-desde-gitlab.md"
  - "requirements/user-stories/US-021-asignar-un-colaborador-a-un-proyecto.md"
  - "requirements/user-stories/US-022-aprobar-la-excepcion-de-una-asignacion.md"
  - "requirements/user-stories/US-023-mantener-el-codificador-de-motivos.md"
  - "requirements/user-stories/US-024-visualizar-milestones-e-issues-de-gitlab.md"
  - "requirements/user-stories/US-025-registrar-al-usuario-al-iniciar-sesion.md"
  - "requirements/user-stories/US-026-registrar-la-evaluacion-de-desempeno.md"
  - "requirements/user-stories/US-027-ingresar-al-portal-de-forma-segura.md"
  - "requirements/user-stories/US-028-cerrar-la-sesion.md"
provenance:
  created_by: claude-code (siguiendo el contrato del skill development-scope-pack-builder)
  method: derived-from-rcp-and-user-stories
  confidence: medium
human-reviewed: true
approved_by: ianache (Jefe de Ingeniería, PO)
approved_on: 2026-10-10
approval_note: "Aprobado por el PO. Los bloqueos DSP-B1 a B5 se cerraron por decisión del PO el 2026-10-10, con excepciones registradas: fuentes como rutas relativas (B1) y decisiones de arquitectura sin revisión de un arquitecto (B3)."
scope_state: READY_FOR_SPRINT_SELECTION
sprint:
  id: null
  name: null
project_id: 633
gitlab_project: "comsatel/development/training/dev-juniors/p3m/collaboration"
project_issue_id: 52911
project_issue_iid: 1
project_issue_url: "https://project.comsatel.com.pe/comsatel/development/training/dev-juniors/p3m/collaboration/-/issues/1"
---

# Alcance candidato de desarrollo de P3M (People, Product and Project Management)

> **Fuentes:** el contrato del skill pide una URL HTTP(S) completa (repositorio, ref y ruta). Por decisión del responsable (2026-10-10), `sources` usa rutas relativas a la raíz ``. Cuando el conocimiento tenga repositorio, anteponer su URL base.

## Scope and Identity

- **Scope ID:** `DSP-001`
- **Producto:** `P3M` (People, Product and Project Management)
- **Estado del alcance:** `READY_FOR_SPRINT_SELECTION` (aprobado por el PO el 2026-10-10; bloqueos DSP-B1 a B5 cerrados por decisión del PO, ver Open Questions and Blockers)
- **Proyecto de GitLab:** `project_id` 633 (`comsatel/development/training/dev-juniors/p3m/collaboration`). Reemplaza al proyecto 605, que se conserva sin cambios. Declarado por el responsable el 2026-10-12; el proyecto estaba vacío al recrear el Project Issue, el Milestone y los Issues de User Story.
- **Project Issue:** [#1](https://project.comsatel.com.pe/comsatel/development/training/dev-juniors/p3m/collaboration/-/issues/1) (`issue_id` 52911, `issue_iid` 1, label `Proyecto`), creado el 2026-10-12 en el proyecto 633 con aprobación del responsable. El Issue referencia este DSP por su ruta. El Issue #14 del proyecto 605 queda como histórico.
- **Sprint:** no asignado. Es un alcance candidato para la planificación de Scrum.
- **Responsable de negocio (PO):** Jefe de Ingeniería (rol de usuario; por defecto, el usuario ianache, D-95). Validado: aprobó el alcance el 2026-10-10.
- **Alcance:** 28 historias de usuario y 113 criterios de aceptación, organizadas en 9 olas por dependencia.

## Objective

Entregar el primer incremento funcional de P3M para el Área de Desarrollo: ingreso seguro de los usuarios, catálogo de roles, perfiles de competencias, registro de colaboradores, cursos con sus rúbricas, ediciones y evidencias, valoración, evaluación de desempeño y promoción, portafolio de productos y proyectos con carga automática de GitLab, y asignación de colaboradores a proyectos.

## Source RCPs

- `RCP-001` — P3M (People, Product and Project Management) del Área de Desarrollo. Decisiones D-01 a D-132, reglas [BRC-001](../../business/rules/BRC-001-reglas-de-negocio-portal-curricula.md), modelo [IMD-001](../../business/information-model/IMD-001-portal-curricula.md) y [glosario](../../business/glossary/GLS-001-glosario-de-negocio.md). Ruta: [RCP-001](../context-packs/RCP-001-portal-gestion-curricula-desarrollo.md).

## Included User Stories

El orden de las olas sale de las dependencias declaradas en cada historia. La prioridad es la MoSCoW propuesta en cada una y la decide el PO. **La estimación está en blanco: la hace el equipo.** Cada historia tiene sus criterios Dado/Cuando/Entonces, casos negativos y reglas de negocio citadas en su archivo.

### Ola 1

| ID | Historia | Prioridad (MoSCoW propuesta) | Depende de | Criterios | Preparación | Preguntas abiertas | Fuente |
|---|---|---|---|---|---|---|---|
| US-001 | Mantener el catálogo oficial de roles | Must | — | 4 | READY | US-001-Q1 (no bloquea), US-001-Q2 (no bloquea) | [US-001-mantener-el-catalogo-de-roles.md](../user-stories/US-001-mantener-el-catalogo-de-roles.md) |
| US-018 | Registrar un producto y vincularlo a un proyecto de GitLab | Must | — | 1 | READY | US-018-Q2 (no bloquea) | [US-018-registrar-un-producto-vinculado-a-gitlab.md](../user-stories/US-018-registrar-un-producto-vinculado-a-gitlab.md) |
| US-023 | Mantener el codificador de motivos de excepción | Must | — | 2 | READY | US-023-Q3 (no bloquea) | [US-023-mantener-el-codificador-de-motivos.md](../user-stories/US-023-mantener-el-codificador-de-motivos.md) |
| US-025 | Registrar al usuario autenticado al iniciar sesión | Must | — | 2 | READY | RQ-22 (no bloquea), US-025-Q1 (no bloquea) | [US-025-registrar-al-usuario-al-iniciar-sesion.md](../user-stories/US-025-registrar-al-usuario-al-iniciar-sesion.md) |
| US-027 | Ingresar al portal de forma segura | Must | US-004 (solo para el AC-4) | 5 | READY | — | [US-027-ingresar-al-portal-de-forma-segura.md](../user-stories/US-027-ingresar-al-portal-de-forma-segura.md) |

### Ola 2

| ID | Historia | Prioridad (MoSCoW propuesta) | Depende de | Criterios | Preparación | Preguntas abiertas | Fuente |
|---|---|---|---|---|---|---|---|
| US-002 | Definir el perfil de competencias de un rol | Must | US-001 | 6 | READY | US-002-Q4 (no bloquea) | [US-002-definir-perfil-de-competencias-de-un-rol.md](../user-stories/US-002-definir-perfil-de-competencias-de-un-rol.md) |
| US-004 | Registrar y modificar colaboradores | Must | US-001 | 5 | READY | US-004-Q1 (no bloquea), G-11 (no bloquea), G-12 (no bloquea), G-06 (no bloquea) | [US-004-registrar-y-modificar-colaboradores.md](../user-stories/US-004-registrar-y-modificar-colaboradores.md) |
| US-019 | Registrar un proyecto de un producto con sus milestones | Must | US-018 | 4 | READY | — | [US-019-registrar-un-proyecto-con-sus-milestones.md](../user-stories/US-019-registrar-un-proyecto-con-sus-milestones.md) |
| US-028 | Cerrar la sesión a demanda o por vencimiento | Must | US-027 | 6 | READY | RQ-31 (no bloquea) | [US-028-cerrar-la-sesion.md](../user-stories/US-028-cerrar-la-sesion.md) |

### Ola 3

| ID | Historia | Prioridad (MoSCoW propuesta) | Depende de | Criterios | Preparación | Preguntas abiertas | Fuente |
|---|---|---|---|---|---|---|---|
| US-003 | Definir el nivel mínimo de cada competencia para un rol/nivel | Must | US-001, US-002 | 4 | READY | IM-Q6 (no bloquea) | [US-003-definir-el-nivel-minimo-por-rol-nivel.md](../user-stories/US-003-definir-el-nivel-minimo-por-rol-nivel.md) |
| US-005 | Consultar los datos de los colaboradores | Should | US-004 | 2 | READY | US-005-Q1 (no bloquea), G-12 (no bloquea), US-005-Q2 (no bloquea) | [US-005-consultar-los-datos-de-los-colaboradores.md](../user-stories/US-005-consultar-los-datos-de-los-colaboradores.md) |
| US-006 | Definir un curso con sus objetivos | Must | US-002 | 5 | READY | G-37 (no bloquea) | [US-006-definir-un-curso-con-sus-objetivos.md](../user-stories/US-006-definir-un-curso-con-sus-objetivos.md) |
| US-014 | Aportar evidencias de proyecto | Must | US-004 | 3 | READY | US-014-Q2 (no bloquea) | [US-014-aportar-evidencias-de-proyecto.md](../user-stories/US-014-aportar-evidencias-de-proyecto.md) |
| US-016 | Registrar la valoración de un colaborador | Must | US-002, US-004 | 3 | READY | US-016-Q1 (no bloquea) | [US-016-registrar-la-valoracion-de-un-colaborado.md](../user-stories/US-016-registrar-la-valoracion-de-un-colaborado.md) |
| US-020 | Cargar automáticamente los datos de GitLab y consultar el registro de cargas | Should | US-018, US-019 | 10 | READY | — | [US-020-cargar-automaticamente-desde-gitlab.md](../user-stories/US-020-cargar-automaticamente-desde-gitlab.md) |

### Ola 4

| ID | Historia | Prioridad (MoSCoW propuesta) | Depende de | Criterios | Preparación | Preguntas abiertas | Fuente |
|---|---|---|---|---|---|---|---|
| US-007 | Definir la rúbrica de cada objetivo de un curso | Must | US-006 | 4 | READY | US-007-Q2 (no bloquea), RQ-17 (no bloquea) | [US-007-definir-rubrica-de-objetivo-de-curso.md](../user-stories/US-007-definir-rubrica-de-objetivo-de-curso.md) |
| US-008 | Crear una edición de un curso | Must | US-006 | 4 | READY | US-008-Q1 (no bloquea), US-008-Q2 (no bloquea) | [US-008-crear-una-edicion-de-un-curso.md](../user-stories/US-008-crear-una-edicion-de-un-curso.md) |
| US-015 | Validar las evidencias de proyecto | Must | US-014 | 2 | READY | US-011-Q2 (no bloquea) | [US-015-validar-evidencias-de-proyecto.md](../user-stories/US-015-validar-evidencias-de-proyecto.md) |
| US-021 | Asignar un colaborador a un proyecto | Must | US-016, US-019 | 7 | READY | US-021-Q1 (no bloquea), G-08 (no bloquea) | [US-021-asignar-un-colaborador-a-un-proyecto.md](../user-stories/US-021-asignar-un-colaborador-a-un-proyecto.md) |
| US-024 | Visualizar los milestones e issues de GitLab de un proyecto | Should | US-018, US-019, US-020 | 5 | READY | — | [US-024-visualizar-milestones-e-issues-de-gitlab.md](../user-stories/US-024-visualizar-milestones-e-issues-de-gitlab.md) |

### Ola 5

| ID | Historia | Prioridad (MoSCoW propuesta) | Depende de | Criterios | Preparación | Preguntas abiertas | Fuente |
|---|---|---|---|---|---|---|---|
| US-009 | Enrolarse en una edición de un curso | Must | US-004, US-008 | 3 | READY | US-009-Q1 (no bloquea), G-11 (no bloquea) | [US-009-enrolarse-en-una-edicion-de-un-curso.md](../user-stories/US-009-enrolarse-en-una-edicion-de-un-curso.md) |
| US-022 | Aprobar la excepción de una asignación | Must | US-021, US-023 | 2 | READY | G-33 (no bloquea) | [US-022-aprobar-la-excepcion-de-una-asignacion.md](../user-stories/US-022-aprobar-la-excepcion-de-una-asignacion.md) |

### Ola 6

| ID | Historia | Prioridad (MoSCoW propuesta) | Depende de | Criterios | Preparación | Preguntas abiertas | Fuente |
|---|---|---|---|---|---|---|---|
| US-010 | Desenrolarse de una edición de un curso | Should | US-009 | 2 | READY | US-010-Q1 (no bloquea) | [US-010-desenrolarse-de-una-edicion-de-un-curso.md](../user-stories/US-010-desenrolarse-de-una-edicion-de-un-curso.md) |
| US-013 | Registrar evidencias del logro de un objetivo en una edición | Must | US-007, US-009 | 3 | READY | US-013-Q1 (no bloquea), IM-Q2 (no bloquea) | [US-013-registrar-evidencias-de-un-objetivo.md](../user-stories/US-013-registrar-evidencias-de-un-objetivo.md) |

### Ola 7

| ID | Historia | Prioridad (MoSCoW propuesta) | Depende de | Criterios | Preparación | Preguntas abiertas | Fuente |
|---|---|---|---|---|---|---|---|
| US-011 | Validar las evidencias aportadas en una edición de curso | Must | US-007, US-008, US-009, US-013 | 3 | READY | US-011-Q2 (no bloquea), IM-Q2 (no bloquea) | [US-011-validar-las-evidencias-de-curso.md](../user-stories/US-011-validar-las-evidencias-de-curso.md) |
| US-026 | Registrar la evaluación de desempeño de un colaborador | Must | US-013, US-014 | 7 | READY | US-026-Q1 (no bloquea) | [US-026-registrar-la-evaluacion-de-desempeno.md](../user-stories/US-026-registrar-la-evaluacion-de-desempeno.md) |

### Ola 8

| ID | Historia | Prioridad (MoSCoW propuesta) | Depende de | Criterios | Preparación | Preguntas abiertas | Fuente |
|---|---|---|---|---|---|---|---|
| US-012 | Certificar a un colaborador en una edición de curso | Must | US-007, US-011 | 4 | READY | US-012-Q1 (no bloquea), IM-Q10 (no bloquea) | [US-012-certificar-colaborador-en-una-edicion.md](../user-stories/US-012-certificar-colaborador-en-una-edicion.md) |

### Ola 9

| ID | Historia | Prioridad (MoSCoW propuesta) | Depende de | Criterios | Preparación | Preguntas abiertas | Fuente |
|---|---|---|---|---|---|---|---|
| US-017 | Decidir la promoción de nivel o seniority de un colaborador | Must | US-012, US-015, US-016 | 5 | READY | US-017-Q1 (no bloquea), G-06 (no bloquea) | [US-017-decidir-la-promocion-de-nivel.md](../user-stories/US-017-decidir-la-promocion-de-nivel.md) |

## Excluded Work

Fuera de este alcance, porque no hay historia ni decisión suficiente:

| Exclusión | Motivo | Referencia |
|---|---|---|
| Gestión de plazas y su ocupación | Se modelaron (Position y Position Fulfillment) pero faltan sus datos y reglas | BR-097, RQ-30, IM-Q28, IM-Q29 |
| Registro de contactos, «reporta a», membresía a organizaciones y vínculo con el usuario | US-004 solo cubre los datos originales del colaborador | BR-070, BR-071, BR-076, BR-077 |
| Gestión de organizaciones (COMSATEL, Área de Desarrollo, proveedores) | No hay historia | BR-072 |
| Funciones de la solicitud de promoción distintas del registro con evidencias | Cubierta solo en US-014 y US-017 | BR-064, BR-068 |
| Escritura en GitLab, creación de user stories o sprints en el portal | El portal solo lee de GitLab | BR-036, BR-037 |
| Exposición de API a terceros (API Gateway) | Depende de la elección del producto y de los consumidores | ADR-14, ADR-P8, ADR-P10 |
| Infraestructura productiva, entornos y recuperación ante desastres | No hay modelo de despliegue ni objetivos | INF-P3M-001, INF-Q01 a INF-Q05 |
| Política de datos personales | Pendiente | G-12, ADR-P4 |

## Dependencies and Constraints

**Dependencias entre historias:** definidas en cada historia y resumidas por ola en la sección anterior. La ola 1 no depende de otras historias.

**Restricciones de arquitectura (vigentes, aceptadas por el responsable y sin revisión de un arquitecto):**
- SPA en Angular con BFF en Next.js, autenticación con Keycloak mediante PKCE, sesión alineada (ADR-01 a ADR-03).
- Micro UI y catálogo de componentes con Atomic Design (ADR-04).
- MySQL 8.x, Redis en el BFF y microservicios en Python con FastAPI (ADR-05 a ADR-07).
- Carga programada de GitLab de solo lectura con delta, reintentos y circuit breaker (ADR-08, ADR-09).
- Secretos en Vault bajo `secret/p3m/*` (ADR-12) y plataforma contenerizada (ADR-15).
- Catálogos: [asr-catalog](../../architecture/asr/asr-catalog.md), [CAT-ADR-001](../../architecture/CAT-ADR-001-decisiones-de-arquitectura.md) e [INF-P3M-001](../../deployment/INF-P3M-001-arquitectura-de-infraestructura.md).

**Decisiones de arquitectura tomadas el 2026-10-10 (por el responsable, sin revisión de un arquitecto):** ADR-P1 (caché), ADR-P2 (DDD, REST y RabbitMQ), ADR-P3 (Celery Beat), ADR-P5 (guards de Angular y validación en servidor), ADR-P6 (historial en MySQL), ADR-P7 (Docker y OKE) y ADR-P9 (OAuth2 Client Credentials).

## QA and Acceptance Evidence

- Las pruebas se derivan de los 113 criterios de aceptación de las 28 historias y de sus casos negativos. Este DSP no agrega reglas de negocio.
- Los criterios que dependen de reglas sin valor definido (tiempo de sesión, retención de datos personales) no se pueden aceptar hasta cerrar RQ-31 y G-12.
- Evidencia mínima por historia: pruebas de aceptación de cada escenario, prueba de los casos negativos, revisión de accesibilidad WCAG 2.2 AA y confirmación de la privacidad de los datos personales.
- Pruebas de infraestructura: las de la sección 14 de INF-P3M-001 (conmutación de MySQL, restauración, caída de GitLab simulada, cierre de sesión alineado).

## Provider Handoff

El equipo o proveedor de desarrollo implementa solo las historias incluidas, entrega evidencia de pruebas, documenta las desviaciones y eleva cualquier cambio fuera de alcance para su revisión. El paquete de desarrollo detallado lo prepara `development-handoff-builder` una vez aprobado el alcance y resueltas las decisiones de arquitectura pendientes.

## Open Questions and Blockers

> **Aprobación (2026-10-10):** el PO aprobó el alcance y lo pasó a `READY_FOR_SPRINT_SELECTION`. Cierra DSP-B2. DSP-B1 a B5 quedaron cerrados por decisión del PO el mismo día, con las excepciones indicadas en la tabla (rutas relativas en B1; decisiones de arquitectura sin revisión de un arquitecto en B3).

**Bloqueos (estado tras la aprobación):**

| ID | Bloqueo | Responsable |
|---|---|---|
| DSP-B1 (CERRADO 2026-10-10: raíz ``; sin URL HTTP(S) hasta que haya repositorio) | Falta la URL del repositorio, ref y ruta de cada fuente (contrato del skill) | Equipo de gestión del conocimiento |
| DSP-B2 (CERRADO 2026-10-10: el PO aprobó el alcance y las 28 historias) | Nadie ha validado el alcance ni las historias: el PO no firmó ninguna | Jefe de Ingeniería |
| DSP-B3 (CERRADO 2026-10-10: el responsable decidió ADR-P1, P2, P3, P5, P6, P7, P9 e INF-Q01; sin revisión de un arquitecto) | Decisiones de arquitectura pendientes y modelo de despliegue sin decidir | Arquitectura |
| DSP-B4 (CERRADO 2026-10-10: disponibilidad 99,9 %, RTO 4 h, RPO 1 h con respaldos cada hora, más de 50 colaboradores; siguen sin dato usuarios concurrentes y crecimiento, que no bloquean) | Objetivos de disponibilidad, RTO, RPO y carga sin definir (INF-Q02, INF-Q03) | Responsable funcional y arquitectura |
| DSP-B5 (CERRADO 2026-10-10: PO aprobó las 28 historias) | US-026, US-027 y US-028 son nuevas y no están aprobadas. US-002, US-004, US-006, US-017, US-019, US-020, US-021 y US-024 se editaron después de su aprobación y conviene revalidarlas | Jefe de Ingeniería |

**Preguntas abiertas de las historias que bloquean:** ninguna.

**Preguntas generales abiertas:** RQ-31 (tiempo de sesión), RQ-30 y IM-Q28 (datos de la plaza), IM-Q26 (contactos de organizaciones), IM-Q27 (roles de la parte), GQ-10 y GQ-12 (fuentes y siglas del glosario) e INF-Q01 a INF-Q15.

## Definition of Ready

- Las historias incluidas tienen IDs estables, fuentes con ruta relativa a `` (excepción del PO; sin URL HTTP(S) hasta que haya repositorio) y criterios de aceptación validados.
- Los límites del alcance, las dependencias y los bloqueos están revisados.
- Las responsabilidades de desarrollo y de QA están claras.
- Las decisiones de arquitectura que condicionan la ola elegida están tomadas (ADR-P2, ADR-P6 y ADR-P7 como mínimo): cumplido el 2026-10-10 por decisión del responsable, sin revisión de un arquitecto.

## Definition of Done

- Las historias incluidas cumplen sus criterios de aceptación.
- Las pruebas requeridas y su evidencia están disponibles.
- Se conserva la trazabilidad del RCP a la historia y a la evidencia de entrega.
