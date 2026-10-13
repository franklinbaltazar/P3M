---
type: UX Requirement
title: "UXR-001 — Requisitos UX de las vistas del BFF"
description: "Contraste de las vistas compuestas propuestas en API-PRP-006 con los criterios de aceptación de las historias, para validar H-02. Veredicto por vista, requisitos UX derivados y preguntas abiertas."
tags: [ux, bff, h-02, requirements]
status: draft
generated:
  by: "ux-requirements-analyzer (aplicado por Claude Code)"
  at: "2026-10-12T23:00:00-05:00"
human-reviewed: false
sources:
  - id: api-prp-006
    resource: /design/api-contracts/API-PRP-006-bff-portal.md
  - id: us-004-005-009-010-011-012-013
    resource: /requirements/user-stories/
  - id: us-016-017-019-020-021-024-025-026-027-028
    resource: /requirements/user-stories/
  - id: brc-001
    resource: /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md
  - id: dsp-001
    resource: /requirements/scope-packs/DSP-001-p3m-alcance-candidato.md
  - id: adr-p5
    resource: /architecture/adr/ADR-P5-estrategia-de-autorizacion-por-rol.md
  - id: replica-gitlab-ddl
    resource: /data/flyway/p3m_gitlab/V1__baseline_gitlab.sql
---

# UXR-001 — Requisitos UX de las vistas del BFF

> **Estado:** `draft`. Sin revisión humana. No hay investigación con usuarios, diseños de pantalla ni flujos de usuario en las fuentes: nada de lo que sigue es resultado de investigación. Se derivó solo de los criterios de aceptación de las historias (**hechos**) y de la lectura del agente (**inferencias**, marcadas **(I)**).

## 1. Qué se pidió y qué se hizo
Validar las 6 vistas compuestas de API-PRP-006 (inferidas de los títulos de las historias) contra los **criterios de aceptación reales**. Se leyeron los de 17 historias (US-004, 005, 009 a 013, 016, 017, 019 a 021, 024 a 028).

## 2. Hechos de contexto
| ID | Hecho | Fuente |
|---|---|---|
| UX-F1 | Las pruebas incluyen revisión de accesibilidad WCAG 2.2 AA | DSP-001 «QA and Acceptance Evidence» |
| UX-F2 | El SPA es Angular con micro UI y un catálogo de componentes con Atomic Design | ADR-04 |
| UX-F3 | No hay flujos de usuario ni diseños de pantalla en el repositorio. El Design System es el **IA Design System** de Comsatel (artefacto de Claude, fuera del repositorio), indicado por ianache el 2026-10-13; ver [SCR-001](SCR-001-pantallas-del-bff.md) | Búsqueda en el repositorio; artefacto |
| UX-F4 | Cualquier usuario autenticado puede consultar datos personales de los colaboradores; el riesgo se trata en DT-01 | BR-003, ADR-P5 P5-D3 |
| UX-F5 | El jefe de proyecto no es un rol de Keycloak | ADR-P5 anexo §2 |
| UX-F6 | Las fechas de «datos al …» se muestran en UTC-05 | US-020 AC-10, US-024 AC-5 |

## 3. Veredicto por vista de API-PRP-006

| Vista propuesta | Veredicto | Motivo (criterio) | Cambio propuesto |
|---|---|---|---|
| BFF-V1 ficha del colaborador | **Ajustar** | US-005 AC-1 solo da a cualquier usuario autenticado: nombres, apellido paterno, apellido materno, fecha de ingreso y rol/nivel. La vista propuesta reunía además contactos, roles, ocupaciones, valoraciones, asignaciones y certificaciones: excede lo que dicen las reglas y amplía la exposición de datos personales (UX-F4) | **Dividir:** BFF-V7 «datos del colaborador» (AUT) y BFF-V1 «ficha de gestión» (solo JI y ADM) |
| BFF-V2 mis cursos | **Ajustar** | US-009 exige elegir una edición con cupo: falta una vista de **ediciones disponibles**. «Mis cursos» sirve a US-010 y US-013 | Mantener V2 y **añadir BFF-V8** «catálogo de ediciones» |
| BFF-V3 panel del evaluador | **Confirmada**, con ajuste | US-011 y US-012: validar evidencias y certificar con el 100 % de obligatorias. El evaluador necesita ver, por enrolado, las obligatorias validadas frente a las exigidas | Añadir el avance de obligatorias por enrolamiento |
| BFF-V4 panel del proyecto | **Confirmada**, con **brecha de datos** | US-024 AC-1 y AC-2 piden de cada milestone: id, nombre, tareas totales, cerradas y % de avance; y de cada issue: id, título, esfuerzo estimado, status, esfuerzo spent y due date. **La réplica solo guarda** título, estado, tipo, URL, milestone y fecha de actualización | Ver UXQ-1 (bloqueante para US-024) |
| BFF-V5 contexto de promoción | **Ajustar** | US-017 AC-1 pide la **brecha** entre el nivel actual de cada competencia y el mínimo del **siguiente** rol/nivel. Faltaban los niveles mínimos (svc-curricula) | Añadir `svc-curricula` como fuente; ver UXQ-2 |
| BFF-V6 resumen de cargas | **Retirar** | US-020 AC-3 es una consola con fecha, hora y estado de cada ejecución: lo cubre la ruta de paso `GET /api/v1/cargas` | Marcar `RETIRED` |

## 4. Requisitos UX derivados
Cada uno cita su criterio. **(I)** = inferido.

### Sesión (US-025, US-027, US-028)
| ID | Requisito | Criterio |
|---|---|---|
| UXR-S1 | Un acceso sin autenticar lleva a Keycloak y no muestra datos | US-027 AC-2 |
| UXR-S2 | Si Keycloak no está disponible se muestra la página inicial del portal | US-027 AC-5 |
| UXR-S3 | Un usuario sin persona y sin rol JI, ADM o INSTRUCTOR no entra: se cierra su sesión en el BFF y en Keycloak y vuelve al login. La pantalla de login no debe revelar por qué | US-027 AC-4; ICP-001 CON-13 |
| UXR-S4 | Antes del vencimiento se muestra un mensaje emergente (**anticipación sin definir**) | US-028 AC-4; RQ-31 |
| UXR-S5 | Al vencer o cerrar, el trabajo en curso se pierde y el usuario debe volver a autenticarse. El cierre se refleja en todo el portal | US-028 AC-2, AC-5, AC-6 |
| UXR-S6 | Si Keycloak cierra la sesión, el portal se entera y la termina | US-028 AC-3 |

### Datos del colaborador y gestión (US-004, US-005, US-016, US-021)
| ID | Requisito | Criterio |
|---|---|---|
| UXR-C1 | Cualquier usuario autenticado ve nombres, apellidos, fecha de ingreso y rol/nivel, **sin controles de edición** | US-005 AC-1, AC-2 |
| UXR-C2 | Solo JI y ADM ven las acciones de registrar y modificar | US-004 AC-4 |
| UXR-C3 | La asignación muestra una advertencia si no cumple el nivel mínimo y queda Pendiente; se rechaza si supera 100 % de dedicación | US-021 AC-2, AC-7 |
| UXR-C4 | Se muestra el historial de asignaciones, con vigencia, porcentaje y estado (pendiente, vigente, finalizada) | US-021 AC-5, AC-6, AC-8 |
| UXR-C5 | Se muestra el nivel actual de la competencia y su historial | US-016 AC-1, AC-2 |

### Formación (US-009, US-010, US-011, US-012, US-013)
| ID | Requisito | Criterio |
|---|---|---|
| UXR-F1 | El colaborador elige una edición con cupo; al llegar al cupo no se admite enrolar | US-009 AC-1, AC-2 |
| UXR-F2 | Puede desenrolarse y volver a enrolarse | US-010 AC-1; US-009 AC-4 |
| UXR-F3 | Al registrar una evidencia indica el issue; solo se acepta uno **cerrado**, y solo en la edición en que está enrolado | US-013 AC-2, AC-3 |
| UXR-F4 | La evidencia está **Pendiente** o **Validada**; no hay Rechazada | US-011 AC-3; D-H11 |
| UXR-F5 | Solo el evaluador de la edición valida y certifica | US-011 AC-2; US-012 |
| UXR-F6 | No se emite la certificación con obligatorias sin validar; las deseables no limitan; la certificación no cambia el nivel de las competencias | US-012 AC-2, AC-3, AC-4 |

### Portafolio y GitLab (US-019, US-020, US-024)
| ID | Requisito | Criterio |
|---|---|---|
| UXR-P1 | Un proyecto se registra bajo un producto, con milestones, roles/niveles requeridos con cantidades y un jefe vigente | US-019 AC-1 a AC-4 |
| UXR-P2 | Los milestones e issues se ven en solo lectura; no hay controles de edición | US-024 AC-3 |
| UXR-P3 | Cuando GitLab no responde se muestra «datos al <fecha y hora de la última carga exitosa>» en UTC-05 | US-020 AC-10; US-024 AC-5 |
| UXR-P4 | La consola de cargas lista cada ejecución con fecha, hora y estado, y permite reintentar | US-020 AC-3, AC-4 |

### Promoción y desempeño (US-017, US-026)
| ID | Requisito | Criterio |
|---|---|---|
| UXR-D1 | El JI o ADM ve la brecha entre el nivel actual y el mínimo del siguiente rol/nivel, y los sustentos: certificaciones, evidencias de proyecto y valoraciones | US-017 AC-1, AC-2 |
| UXR-D2 | No se puede decidir la promoción sin evaluación de desempeño | US-017 AC-5 |
| UXR-D3 | La evaluación muestra certificaciones y evidencias validadas; registra resultado (supera, cumple, parcial, no cumple), periodo, comentarios, fecha y usuario | US-026 AC-1, AC-2, AC-6 |

### Transversales (I)
| ID | Requisito |
|---|---|
| UXR-X1 | Estados vacío, cargando, error y **parcial** en cada vista compuesta; cuando un servicio no responde se muestran las secciones que sí llegaron |
| UXR-X2 | Cumplir WCAG 2.2 AA (UX-F1) en todas las pantallas |
| UXR-X3 | Cualquier acción no permitida por rol se oculta o se desactiva, pero la decisión la toma el servidor (ADR-P5) |

## 5. Preguntas abiertas

> **Resueltas el 2026-10-13** (ver §7): UXQ-1, UXQ-2, UXQ-3, UXQ-4, UXQ-6 y UXQ-8. **Siguen abiertas:** UXQ-5 (tiempo de sesión, RQ-31) y UXQ-7 (estados vacíos).
| ID | Pregunta | Dueño | Impacto | Bloquea |
|---|---|---|---|---|
| UXQ-1 | **La réplica de GitLab no guarda los campos que US-024 muestra** (estimado, spent, due date, status del issue; total y cerradas por milestone). ¿Se amplía el modelo de `p3m_gitlab` y la ACL-02, o se consulta GitLab en línea (contra ICP-001 y BR-092)? | Análisis funcional y datos | US-024, BFF-V4, API-PRP-005 | US-024 |
| UXQ-2 | ¿Cómo se determina el «siguiente» rol/nivel de un colaborador (BR-031)? Ningún servicio lo ofrece hoy | Análisis funcional | BFF-V5, US-017 | US-017 |
| UXQ-3 | ¿Quién puede ver las valoraciones y las asignaciones de un colaborador? Las reglas fijan quién las escribe, no quién las lee | Responsable funcional | BFF-V1, BFF-V7 | Alcance de V1 |
| UXQ-4 | ¿Qué incluye «datos del colaborador» (UXR-C1) en lo relativo a contactos? US-005 no los menciona | Responsable funcional | BFF-V7 | — |
| UXQ-5 | Tiempo de sesión, anticipación del aviso y renovación (RQ-31) | Responsable funcional | UXR-S4 | US-028 AC-4 |
| ~~UXQ-6~~ | **Resuelta 2026-10-13:** el Design System es el IA Design System. Quedan brechas y hallazgos de accesibilidad (SCR-001 §5 y §6; SCRQ-3) | UX y diseño | Todas las pantallas | — |
| UXQ-7 | ¿Cómo se ve un colaborador sin enrolamientos, un evaluador sin ediciones o un proyecto sin milestones? Los estados vacíos no están definidos | UX | Todas | — |
| UXQ-8 | US-013: ¿cómo identifica el colaborador el issue (pega la URL o lo elige de una lista de issues cerrados de su proyecto)? | Análisis funcional y UX | BFF-V2 | US-013 |

## 6. Siguiente acción (anterior, sustituida por §7)
Resolver UXQ-1 y UXQ-2 (cambian datos y servicios), UXQ-3 y UXQ-4 (cambian el alcance de las vistas) y UXQ-6 (sin Design System no hay tokens). Con las vistas ajustadas, API-PRP-006 pasa a 0.2.0 y SCR-001 las baja a pantallas.

## 7. Decisiones del responsable funcional (2026-10-13)
Decididas por ianache en sesión. Cada una sale de una pregunta abierta de §5.

| ID | Pregunta | Decisión | Efecto |
|---|---|---|---|
| D-UX-1 | UXQ-1: campos de US-024 que la réplica no guarda | **Ampliar la réplica de GitLab:** estimado, spent, due date y status del issue, y total y cerradas por milestone, cargados con el delta | Migración Flyway nueva en `p3m_gitlab` y ampliar ACL-02 de ICP-001 (**pendientes**, ver API-PRP-005). Desbloquea US-024 y BFF-V4 |
| D-UX-2 | UXQ-2: siguiente rol/nivel | **Derivarlo de BR-031** en `svc-curricula`: L1→L2→L3→L4, Junior L4→Semisenior L1, Semisenior L4→Senior L1. **Senior L4 no tiene siguiente** y la promoción queda bloqueada con ese motivo hasta que haya regla | Nueva consulta CON-14 (propuesta) y recurso `…/siguiente` en API-PRP-002; BFF-V5 la usa |
| D-UX-3 | UXQ-3 y FLQ-4: quién lee | **Mínimo privilegio:** COLABORADOR ve lo suyo (valoraciones, evidencias, certificaciones, asignaciones); JI y ADM ven todo; INSTRUCTOR ve las evidencias de sus ediciones; el jefe de proyecto ve las asignaciones de su proyecto, no las valoraciones | Regla de lectura en API-PRP-003 y 004; nueva vista BFF-V9 «mi progreso». Falta registrarla en BRC-001 |
| D-UX-4 | UXQ-4: vista básica | **Solo lo de US-005.** Contactos solo para JI, ADM y el propio colaborador | BFF-V7 sin contactos |
| D-UX-5 | UXQ-8: indicar el issue | **Pegar la URL**, con validación inmediata contra la réplica | SCR-05 con un campo de texto |
| D-UX-6 | FLQ-2: pendientes | **Contadores sin bandeja:** en los ítems de la barra lateral y en la campana de TopNav (Badge primario) | Nueva vista BFF-V10 `pendientes` |
| D-UX-7 | FLQ-3: desfase del evento | **Estado intermedio visible:** «promoción registrada, aplicando el cambio de plaza» hasta que la plaza lo refleja | FLW-05 y SCR-08 |
| D-UX-8 | SCRQ-3: Design System | **Completar todo** (los 9 componentes que faltan y los 5 contrastes), antes del diseño visual | [DSC-001](DSC-001-cambios-al-design-system.md) |

Decisiones sin revisión de un arquitecto ni de seguridad. D-UX-3 y D-UX-4 afectan datos personales (DT-01).

Decisiones del mismo día sobre las preguntas de SCR-001:

| ID | Pregunta | Decisión | Efecto |
|---|---|---|---|
| D-UX-9 | SCRQ-2: ¿se requieren flujos de usuario? | **Sí.** | FLW-001 cubre 5 flujos; faltan los de las pantallas aún no especificadas (SCRQ-5) |
| D-UX-10 | SCRQ-4: radio de botones e inputs | **6–8 px** | `radius-md` pasa de 12 a 6 px (candidato en DSC-001 §1) |
