---
type: User Story
title: "US-024 — Visualizar los milestones e issues de GitLab de un proyecto"
description: "Como Jefe de Ingeniería o ADMIN, quiero ver el avance de los milestones y el detalle de los issues de un proyecto, obtenidos de GitLab, para seguir la ejecución sin salir del portal."
tags: [user-story, por-definir, gitlab, ejecucion]
status: approved
generated:
  by: "af-user-story-refiner/2.0"
  at: "2026-10-10T12:00:00-05:00"
verified:
  by: "ianache (Functional Analysis)"
  at: "2026-10-10T23:30:00-05:00"
sources:
  - id: brc-001
    resource: /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md
  - id: rcp-001
    resource: /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md
  - id: gls-001
    resource: /business/glossary/GLS-001-glosario-de-negocio.md
  - id: imd-001
    resource: /business/information-model/IMD-001-portal-curricula.md
gitlab_issue_id: 52935
gitlab_issue_iid: 25
gitlab_issue_url: https://project.comsatel.com.pe/comsatel/development/training/dev-juniors/p3m/collaboration/-/issues/25
---

# US-024 — Visualizar los milestones e issues de GitLab de un proyecto

## 1. Ficha

| Campo | Valor |
|---|---|
| ID | US-024 |
| Épica / capacidad | Portafolio y asignación (IMD-001, bloque 4) |
| Horizonte / release | Por definir |
| Actor | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) o [ADMIN](../../business/glossary/terms/TRM-0028-admin.md) (BR-069) |
| Responsable de negocio (PO) | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) (responsable funcional del portal, /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L109) |
| Prioridad | Should: da visibilidad de la ejecución, pero no bloquea la asignación. La decide el PO. |
| Dependencias | US-018, US-019, US-020 |
| Preparación | READY |

## 2. Historia

**Como** Jefe de Ingeniería o ADMIN, **quiero** ver el avance de los milestones y el detalle de los issues de un proyecto, obtenidos de GitLab, **para** seguir la ejecución sin salir del portal.

## 3. Contexto y valor

- **Problema que resuelve:** El portal solo visualiza lo que existe en GitLab, a nivel de milestone e issue, en solo lectura, consultado automáticamente cada 30 s por defecto (BR-036, BR-037, BR-038, BR-039).
- **Valor esperado:** Visibilidad de la ejecución con datos de GitLab.
- **Métrica o KPI que impacta:** Sin métrica asociada

## 4. Alcance

- **Incluye:**
  - Mostrar de cada milestone: id, nombre, tareas totales, tareas cerradas y % de avance.
  - Mostrar de cada issue: id, título, esfuerzo estimado, status, esfuerzo spent y due date.
- **Excluye:**
  - Crear o modificar user stories, sprints o issues (el portal no los crea, BR-036).

## 5. Criterios de aceptación

### AC-1 — Ver milestones

```gherkin
Escenario: Ver milestones
  Dado un proyecto compuesto por milestones de GitLab
  Cuando un Jefe de Ingeniería o un ADMIN consulta su ejecución
  Entonces ve de cada milestone su id, nombre, tareas totales, tareas cerradas y porcentaje de avance
```

- **Regla / fuente:** BR-038

### AC-2 — Ver issues

```gherkin
Escenario: Ver issues
  Dado un milestone
  Cuando un Jefe de Ingeniería o un ADMIN consulta sus issues
  Entonces ve de cada issue su id, título, esfuerzo estimado, status, esfuerzo spent y due date
```

- **Regla / fuente:** BR-038

### AC-3 — Solo lectura

```gherkin
Escenario: Solo lectura
  Dado un usuario que consulta un issue o milestone
  Cuando intenta modificarlo desde el portal
  Entonces el portal no lo permite
```

- **Regla / fuente:** BR-036, BR-037

### AC-4 — Datos de la última consulta automática

```gherkin
Escenario: Datos de la última consulta automática
  Dado un issue modificado en GitLab
  Cuando la carga automática lo trae al portal
  Entonces el portal muestra el cambio
```

- **Regla / fuente:** BR-039, BR-065

### AC-5 — Aviso si GitLab no responde

```gherkin
Escenario: Aviso de datos desactualizados
  Dado que GitLab no responde
  Cuando el usuario consulta los milestones e issues
  Entonces el portal muestra «datos al <fecha y hora de la última carga exitosa>» en formato UTC-05
```

- **Regla / fuente:** BR-092

## 6. Casos negativos y límite

| Caso | Comportamiento esperado | Fuente o pregunta |
|---|---|---|
| Usuario que no es Jefe de Ingeniería ni ADMIN | No ve la ejecución | BR-069 |
| GitLab no responde en la carga | El portal muestra «datos al <fecha y hora de la última carga exitosa>» (UTC-05) | BR-092 |
| Cambio hecho en GitLab antes de la próxima sincronización | El portal muestra el dato anterior hasta la sincronización | BR-039 |

## 7. Reglas de negocio aplicables

| ID | Regla | Fuente |
|---|---|---|
| BR-036 | El portal no crea user stories ni sprints: solo visualiza lo que existe en GitLab a nivel de issue y milestone. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L76 |
| BR-037 | La integración con GitLab es de solo lectura, con credenciales de servicio de solo lectura. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L77 |
| BR-038 | De cada milestone se visualizan id, nombre, tareas totales, tareas cerradas y % de avance. De cada issue se visualizan id, título, esfuerzo estimado, status, esfuerzo spent y due date. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L78 |
| BR-039 | El portal consulta GitLab de forma automática, cada 30 segundos por defecto, para obtener issues y milestones. Las funcionalidades no consultan GitLab directamente. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L79 |
| BR-069 | Los milestones e issues de un proyecto (la ejecución) los ven el Jefe de Ingeniería y los usuarios con rol ADMIN. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L109 |
| BR-092 | Si GitLab no responde, el portal muestra el aviso «datos al <fecha y hora de la última carga exitosa>», en formato UTC-05. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L132 |

## 8. Datos y términos

| Término | Uso en esta historia | Glosario |
|---|---|---|
| Sprint | Milestone que se muestra | [Sprint](../../business/glossary/terms/TRM-0031-sprint.md) |
| Issue de GitLab | Issue que se muestra | [Issue de GitLab](../../business/glossary/terms/TRM-0032-issue-de-gitlab.md) |
| GitLab | Origen de los datos | [GitLab](../../business/glossary/terms/TRM-0036-gitlab.md) |
| Proyecto | Contexto | [Proyecto](../../business/glossary/terms/TRM-0030-proyecto.md) |

## 9. Requisitos no funcionales

- **Accesibilidad:** WCAG 2.2 AA (estándar del repositorio).
- **Privacidad y datos personales:** No aplica: la historia no toca datos personales.
- **Otros:** Las funcionalidades leen la copia local y no consultan GitLab directamente (BR-039).

## 10. Consideraciones de UX

- **Flujo esperado:** El usuario abre un proyecto, ve sus milestones y entra al detalle de los issues.
- **Estados de la interfaz:** Sin milestones, sin datos consultados, error, éxito.
- **Contenido clave:** Avance por milestone y datos de cada issue.

## 11. Dependencias, supuestos e hipótesis

- **Depende de:** US-018, US-019 y US-020 (la carga automática que alimenta lo que se muestra).
- **Es prerrequisito de:** US-013, US-014 (referencian issues)
- **Supuestos:** Ninguno
- **Hipótesis del agente:** Ninguna

## 12. Preguntas abiertas

| ID | Pregunta | Responsable | Prioridad | Bloquea | Estado |
|---|---|---|---|---|---|
| US-024-Q1 | ¿Qué usuarios ven los milestones e issues de un proyecto? | Jefe de Ingeniería | Alta | No | Cerrada: el Jefe de Ingeniería y los ADMIN (EVD-2026-0098, BR-069) |
| RQ-09 | ¿Qué hace el portal si GitLab no responde? | Arquitectura | Baja | No | Cerrada: muestra el aviso «datos al <fecha y hora de la última carga exitosa>» (EVD-2026-0134, BR-092) |

## 13. Evidencia y trazabilidad

| ID | Hallazgo | Fuente | Clasificación | Confianza |
|---|---|---|---|---|
| EVD-2026-0032 | El portal solo visualiza lo que existe en GitLab, al nivel de issue y milestone | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L127 | decision | high |
| EVD-2026-0033 | De cada milestone se visualiza: id, nombre, tareas totales, tareas cerradas y % de avance | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L128 | decision | high |
| EVD-2026-0034 | De cada issue se visualiza: id, título, esfuerzo estimado, status, esfuerzo spent y due date | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L129 | decision | high |
| EVD-2026-0093 | El portal consulta GitLab de forma automática, cada 30 segundos por defecto. Las funcionalidades no consultan GitLab directamente | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L188 | decision | high |
| EVD-2026-0038 | La integración con GitLab es de solo lectura | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L133 | decision | high |
| EVD-2026-0098 | Los milestones e issues de un proyecto los ven el Jefe de Ingeniería y los usuarios con rol ADMIN | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L479 | decision | high |
| EVD-2026-0134 | Si GitLab no responde, el portal muestra «datos al <fecha y hora de la última carga exitosa>» en UTC-05 | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L519 | decision | high |

Evidencia compartida: `source_type: human`, `observed_at: 2026-10-10T12:00:00-05:00`, `freshness: current`, `owner: Jefe de Ingeniería`.

- **Upstream:** [BRC-001](../../business/rules/BRC-001-reglas-de-negocio-portal-curricula.md), [IMD-001](../../business/information-model/IMD-001-portal-curricula.md), [GLS-001](../../business/glossary/GLS-001-glosario-de-negocio.md) y [RCP-001](../context-packs/RCP-001-portal-gestion-curricula-desarrollo.md), todos en estado `draft`.
- **Downstream (pendiente):** UXR → FLW → SCR → CMP → AC

## 14. Evaluación INVEST

| Criterio | ¿Cumple? | Justificación |
|---|---|---|
| Independiente | Parcial | Necesita US-018 y US-019. |
| Negociable | Parcial | Falla de la consulta automática abierta (RQ-09). |
| Valiosa | Sí | Visibilidad de la ejecución con datos de GitLab. |
| Estimable | Sí | Alcance y actor definidos. |
| Pequeña (Small) | Sí | Cabe en una iteración. |
| Testeable | Sí | Los 5 criterios son verificables. |

## 15. Definition of Ready

- [x] El actor y el valor están sostenidos por una fuente
- [x] Los criterios de aceptación son verificables y citan su regla o fuente
- [x] Los casos negativos y límite tienen comportamiento o pregunta asignada
- [x] No hay preguntas abiertas que bloqueen
- [x] Las dependencias están identificadas
- [x] Los términos de negocio están en el glosario, o tienen una pregunta para el glosario
- [ ] El PO validó la historia

## 16. Definition of Done (funcional)

- [ ] Todos los criterios de aceptación pasan sus pruebas de aceptación
- [ ] Los casos negativos y límite están cubiertos por pruebas
- [ ] La accesibilidad WCAG 2.2 AA está revisada
- [ ] Los requisitos de privacidad se cumplen
- [ ] El PO aceptó la historia en la revisión

## 17. Preparación y validación

- **Estado:** READY
- **Motivo:** Se separó de US-020. Actor, valor y criterios sostenidos por BR-038 y BR-069. US-024-Q1 quedó cerrada.
- **Bloqueos de entrega:** Ninguno
- **Propuesta de división (si no es pequeña):** No aplica
- **Siguiente rol o Skill:** `ux-requirements-analyzer`
- **Decisión humana requerida:** El Jefe de Ingeniería valida la historia.
- **Validación:** Pendiente · Responsable: Jefe de Ingeniería · Fecha: —
