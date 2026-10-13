---
type: User Story
title: "US-014 — Aportar evidencias de proyecto"
description: "Como Colaborador, quiero aportar como evidencias de proyecto las referencias a issues cerrados (Task o UserStory) de los proyectos en los que participo, para sustentar mi nivel de logro en las competencias de mi rol/nivel y mi posible promoción."
tags: [user-story, por-definir, evidencias, proyectos]
status: approved
generated:
  by: "af-user-story-refiner/2.0"
  at: "2026-10-10T12:00:00-05:00"
verified:
  by: "ianache (Functional Analysis)"
  at: "2026-10-10T22:00:00-05:00"
sources:
  - id: brc-001
    resource: /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md
  - id: rcp-001
    resource: /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md
  - id: gls-001
    resource: /business/glossary/GLS-001-glosario-de-negocio.md
  - id: imd-001
    resource: /business/information-model/IMD-001-portal-curricula.md
gitlab_issue_id: 52925
gitlab_issue_iid: 15
gitlab_issue_url: https://project.comsatel.com.pe/comsatel/development/training/dev-juniors/p3m/collaboration/-/issues/15
---

# US-014 — Aportar evidencias de proyecto

## 1. Ficha

| Campo | Valor |
|---|---|
| ID | US-014 |
| Épica / capacidad | Progresión (IMD-001, bloque 3) |
| Horizonte / release | Por definir |
| Actor | [Colaborador](../../business/glossary/terms/TRM-0002-colaborador.md) |
| Responsable de negocio (PO) | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) (responsable funcional del portal, /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L109) |
| Prioridad | Must: las evidencias de proyecto sustentan la promoción de nivel. La decide el PO. |
| Dependencias | US-004 |
| Preparación | READY |

## 2. Historia

**Como** Colaborador, **quiero** aportar como evidencias de proyecto las referencias a issues cerrados (Task o UserStory) de los proyectos en los que participo y elegir el perfil (rol y nivel) al que considero que debería evolucionar, **para** solicitar mi promoción al Jefe de Ingeniería con evidencias.

## 3. Contexto y valor

- **Problema que resuelve:** Las evidencias de proyecto las aporta el colaborador y son referencias a issues de GitLab cerrados (BR-028, BR-020).
- **Valor esperado:** Evidencias de proyecto trazables a issues de GitLab.
- **Métrica o KPI que impacta:** Sin métrica asociada

## 4. Alcance

- **Incluye:**
  - Registrar la referencia a un issue cerrado (Task o UserStory) de un proyecto en el que el colaborador participa.
  - Elegir el perfil (rol y nivel) al que el colaborador considera que debería evolucionar y presentar esas evidencias al Jefe de Ingeniería como solicitud de promoción (BR-064).
- **Excluye:**
  - Validar la evidencia (US-015).
  - Evidencias de curso (US-013), que se registran en la edición en que el colaborador está enrolado.
  - Decidir la promoción (US-017).

## 5. Criterios de aceptación

### AC-1 — Aportar una evidencia de proyecto

```gherkin
Escenario: Aportar una evidencia de proyecto
  Dado un colaborador asignado a un proyecto y un issue Task o UserStory en estado Closed de ese proyecto
  Cuando registra la referencia del issue como evidencia de proyecto
  Entonces la evidencia queda registrada a su nombre para que el jefe de proyecto la valide
```

- **Regla / fuente:** BR-028, BR-020

### AC-2 — Solo issues cerrados

```gherkin
Escenario: Solo issues cerrados
  Dado un issue de GitLab que no está en estado Closed
  Cuando el colaborador intenta aportarlo como evidencia
  Entonces el portal no lo acepta
```

- **Regla / fuente:** BR-020

### AC-3 — Solicitar promoción con evidencias

```gherkin
Escenario: Solicitar promoción con evidencias
  Dado un colaborador con evidencias de proyecto registradas
  Cuando registra una solicitud de promoción eligiendo el rol y nivel al que considera que debería evolucionar, con sus evidencias
  Entonces el Jefe de Ingeniería la evalúa y valora todas las evidencias aportadas
```

- **Regla / fuente:** BR-064, BR-068

## 6. Casos negativos y límite

| Caso | Comportamiento esperado | Fuente o pregunta |
|---|---|---|
| Issue que no está Closed | No se acepta | BR-020 |
| Issue de un proyecto en el que el colaborador no participa | No corresponde: la evidencia es de un proyecto donde participa | EVD-2026-0018 |
| Competencia o nivel de logro que la evidencia sustenta | La evidencia sustenta la solicitud de promoción al rol/nivel elegido por el colaborador | BR-064 |
| Issue repetido o aún no consultado de GitLab (la consulta es automática, cada 30 s por defecto) | Sin regla | US-014-Q2 |

## 7. Reglas de negocio aplicables

| ID | Regla | Fuente |
|---|---|---|
| BR-028 | Las evidencias de proyecto las aporta el colaborador. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L68 |
| BR-020 | Una evidencia aportada, de proyecto o de curso, referencia un issue de GitLab con label Task o UserStory, y solo es válida si el issue está en estado Closed. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L60 |
| BR-039 | El portal consulta GitLab de forma automática, cada 30 segundos por defecto, para obtener issues y milestones. Las funcionalidades no consultan GitLab directamente. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L79 |
| BR-064 | El colaborador puede aportar evidencias para solicitar su promoción al Jefe de Ingeniería, eligiendo el perfil (rol y nivel) al que considera que debería evolucionar en su línea de carrera. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L104 |
| BR-068 | La solicitud de promoción a un nuevo rol/nivel la registra el colaborador y la evalúa el Jefe de Ingeniería, quien valora todas las evidencias aportadas. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L108 |

## 8. Datos y términos

| Término | Uso en esta historia | Glosario |
|---|---|---|
| Evidencia de proyecto | Elemento que se aporta | [Evidencia de proyecto](../../business/glossary/terms/TRM-0018-evidencia-de-proyecto.md) |
| Issue de GitLab | Referencia que se registra | [Issue de GitLab](../../business/glossary/terms/TRM-0032-issue-de-gitlab.md) |
| Colaborador | Actor | [Colaborador](../../business/glossary/terms/TRM-0002-colaborador.md) |
| Proyecto | Contexto de la evidencia | [Proyecto](../../business/glossary/terms/TRM-0030-proyecto.md) |

## 9. Requisitos no funcionales

- **Accesibilidad:** WCAG 2.2 AA (estándar del repositorio).
- **Privacidad y datos personales:** Toca la identidad de colaboradores. Restricción: BR-003 y la política pendiente G-12.
- **Otros:** Sin requisito identificado

## 10. Consideraciones de UX

- **Flujo esperado:** El colaborador elige un proyecto en el que participa y registra las referencias a los issues cerrados que evidencian su trabajo.
- **Estados de la interfaz:** Sin evidencias, issue no cerrado, error, éxito.
- **Contenido clave:** Issue (id, título, status) y proyecto.

## 11. Dependencias, supuestos e hipótesis

- **Depende de:** US-004 y la consulta automática de issues de GitLab (BR-039). Depende de la historia de asignación (US-021).
- **Es prerrequisito de:** US-015, US-017
- **Supuestos:** Ninguno
- **Hipótesis del agente:** H-1: la evidencia queda Pendiente hasta que la valide el jefe de proyecto. Origen: BR-019 y BR-010. Lo confirmaría US-011-Q2.

## 12. Preguntas abiertas

| ID | Pregunta | Responsable | Prioridad | Bloquea | Estado |
|---|---|---|---|---|---|
| US-014-Q1 | ¿Contra qué competencia y nivel de logro registra el colaborador la evidencia de proyecto? | Jefe de Ingeniería | Alta | No | Cerrada: las evidencias se registran en la edición del curso y, para solicitar promoción, eligiendo el rol/nivel destino (EVD-2026-0090, BR-064) |
| US-014-Q2 | ¿Qué validaciones aplican (issue repetido, no consultado aún, fuera del proyecto)? | Jefe de Ingeniería | Baja | No | Abierta |
| US-014-Q3 | ¿Cómo se registra la solicitud de promoción y quién valida las evidencias que la sustentan? (RQ-18) | Jefe de Ingeniería | Media | No | Cerrada: la registra el colaborador y la evalúa el Jefe de Ingeniería, que valora todas las evidencias (EVD-2026-0097, BR-068) |

## 13. Evidencia y trazabilidad

| ID | Hallazgo | Fuente | Clasificación | Confianza |
|---|---|---|---|---|
| EVD-2026-0045 | Las evidencias de cursos las evalúa el instructor. Las evidencias de proyectos las aporta el colaborador | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L140 | decision | high |
| EVD-2026-0044 | Una evidencia de proyecto referencia un issue de GitLab etiquetado como "Task" o "UserStory" y el issue debe estar en estado "Closed" | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L139 | decision | high |
| EVD-2026-0018 | La certificación es una forma de evidencia del logro de una competencia de un rol/nivel. La aprueba el instructor del curso. Si la evidencia es una tarea o entregable de un proyecto donde participa el colaborador, la aprueba el jefe de proyecto | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L113 | decision | high |
| EVD-2026-0093 | El portal consulta GitLab de forma automática, cada 30 segundos por defecto. Las funcionalidades no consultan GitLab directamente | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L188 | decision | high |
| EVD-2026-0090 | Las evidencias se registran en el contexto de la edición de un curso y también para solicitar promoción: el colaborador elige el perfil (rol y nivel) al que considera que debería evolucionar y aporta evidencia al Jefe de Ingeniería | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L185 | decision | high |
| EVD-2026-0097 | La solicitud de promoción la registra el colaborador y la evalúa el Jefe de Ingeniería, que valora todas las evidencias | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L192 | decision | high |

Evidencia compartida: `source_type: human`, `observed_at: 2026-10-10T12:00:00-05:00`, `freshness: current`, `owner: Jefe de Ingeniería`.

- **Upstream:** [BRC-001](../../business/rules/BRC-001-reglas-de-negocio-portal-curricula.md), [IMD-001](../../business/information-model/IMD-001-portal-curricula.md), [GLS-001](../../business/glossary/GLS-001-glosario-de-negocio.md) y [RCP-001](../context-packs/RCP-001-portal-gestion-curricula-desarrollo.md), todos en estado `draft`.
- **Downstream (pendiente):** UXR → FLW → SCR → CMP → AC

## 14. Evaluación INVEST

| Criterio | ¿Cumple? | Justificación |
|---|---|---|
| Independiente | Parcial | Necesita US-021 (participar en un proyecto) y la consulta automática a GitLab. |
| Negociable | Sí | Alcance y reglas definidos. |
| Valiosa | Sí | Evidencias de proyecto trazables a issues de GitLab. |
| Estimable | Sí | Alcance y actor definidos. |
| Pequeña (Small) | Sí | Cabe en una iteración. |
| Testeable | Sí | Los 3 criterios son verificables. |

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
- **Motivo:** Actor, valor y criterios sostenidos por BR-020, BR-028, BR-064 y BR-068. US-014-Q1 y US-014-Q3 quedaron cerradas. US-014-Q2 no bloquea.
- **Bloqueos de entrega:** Ninguno
- **Propuesta de división (si no es pequeña):** No aplica. Si AC-3 crece, separar «Solicitar promoción».
- **Siguiente rol o Skill:** `ux-requirements-analyzer`
- **Decisión humana requerida:** El Jefe de Ingeniería valida la historia.
- **Validación:** Pendiente · Responsable: Jefe de Ingeniería · Fecha: —
