---
type: User Story
title: "US-011 — Validar las evidencias aportadas en una edición de curso"
description: "Como Evaluador, quiero validar las evidencias que los colaboradores aportan en mi edición de curso, para dejar constancia de lo que cada colaborador logró y poder certificarlo."
tags: [user-story, por-definir, cursos, evidencias]
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
gitlab_issue_id: 52922
gitlab_issue_iid: 12
gitlab_issue_url: https://project.comsatel.com.pe/comsatel/development/training/dev-juniors/p3m/collaboration/-/issues/12
---

# US-011 — Validar las evidencias aportadas en una edición de curso

## 1. Ficha

| Campo | Valor |
|---|---|
| ID | US-011 |
| Épica / capacidad | Cursos y evidencias (IMD-001, bloque 2) |
| Horizonte / release | Por definir |
| Actor | [Evaluador](../../business/glossary/terms/TRM-0016-evaluador.md) |
| Responsable de negocio (PO) | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) (responsable funcional del portal, /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L109) |
| Prioridad | Must: sin validación no hay certificación. La decide el PO. |
| Dependencias | US-007, US-008, US-009, US-013 |
| Preparación | READY |

## 2. Historia

**Como** Evaluador, **quiero** validar las evidencias que los colaboradores aportan en mi edición de curso, **para** dejar constancia de lo que cada colaborador logró y poder certificarlo.

## 3. Contexto y valor

- **Problema que resuelve:** El instructor de la edición, que actúa como Evaluador, valida las evidencias de curso. Las evidencias aportadas están en estado Pendiente o Validada (BR-009, BR-019).
- **Valor esperado:** Evidencias de curso validadas por quien dicta la edición.
- **Métrica o KPI que impacta:** Sin métrica asociada

## 4. Alcance

- **Incluye:**
  - Validar una evidencia aportada de curso de la edición propia.
  - Consultar las evidencias pendientes de validar.
- **Excluye:**
  - Registrar la evidencia (US-013).
  - Certificar la edición (US-012).
  - Validar evidencias de proyecto (jefe de proyecto, historia por redactar).

## 5. Criterios de aceptación

### AC-1 — Validar una evidencia aportada

```gherkin
Escenario: Validar una evidencia aportada
  Dado una evidencia aportada de curso en estado Pendiente en la edición del Evaluador
  Cuando el Evaluador la valida
  Entonces la evidencia queda en estado Validada
```

- **Regla / fuente:** BR-009, BR-019

### AC-2 — Solo valida el Evaluador de la edición

```gherkin
Escenario: Solo valida el Evaluador de la edición
  Dado una evidencia aportada en una edición cuyo Evaluador es otro usuario
  Cuando un Evaluador distinto intenta validarla
  Entonces el portal no permite la validación
```

- **Regla / fuente:** BR-009

### AC-3 — Una evidencia está Pendiente o Validada

```gherkin
Escenario: Una evidencia está Pendiente o Validada
  Dado una evidencia aportada de curso
  Cuando se consulta su estado
  Entonces el estado es Pendiente o Validada
```

- **Regla / fuente:** BR-019

## 6. Casos negativos y límite

| Caso | Comportamiento esperado | Fuente o pregunta |
|---|---|---|
| Usuario que no es el Evaluador de la edición | No puede validar | BR-009 |
| Evidencia ya Validada | Sin regla sobre volver a Pendiente | US-011-Q2 |
| Evidencia que el Evaluador no acepta (rechazo) | Sin regla | US-011-Q2 |
| Evidencia que no es una referencia a un issue cerrado | No se acepta como evidencia aportada | BR-020 |
| Evidencia aportada sin evidencia esperada asociada | Sin regla | IM-Q2 |

## 7. Reglas de negocio aplicables

| ID | Regla | Fuente |
|---|---|---|
| BR-009 | El Evaluador de una edición valida las evidencias de curso, evalúa, emite el certificado y promociona al colaborador en el curso. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L49 |
| BR-019 | Una evidencia aportada está en estado Pendiente o Validada. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L59 |
| BR-054 | Se diferencian la evidencia esperada, definida en el curso o la competencia, y la evidencia aportada por un colaborador. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L94 |

## 8. Datos y términos

| Término | Uso en esta historia | Glosario |
|---|---|---|
| Evaluador | Actor | [Evaluador](../../business/glossary/terms/TRM-0016-evaluador.md) |
| Evidencia aportada | Elemento que se valida | [Evidencia aportada](../../business/glossary/terms/TRM-0041-evidencia-aportada.md) |
| Estado de evidencia | Pendiente o Validada | [Estado de evidencia](../../business/glossary/terms/TRM-0021-estado-de-evidencia.md) |
| Edición de curso | Ámbito de validación | [Edición de curso](../../business/glossary/terms/TRM-0013-edicion-de-curso.md) |

## 9. Requisitos no funcionales

- **Accesibilidad:** WCAG 2.2 AA (estándar del repositorio).
- **Privacidad y datos personales:** Toca evidencias asociadas a un colaborador identificable. Restricción: BR-003 y la política pendiente G-12.
- **Otros:** Sin requisito identificado

## 10. Consideraciones de UX

- **Flujo esperado:** El Evaluador consulta las evidencias pendientes de su edición y valida las que corresponden.
- **Estados de la interfaz:** Sin evidencias pendientes, sin permisos, error, éxito.
- **Contenido clave:** Colaborador, evidencia esperada asociada y estado.

## 11. Dependencias, supuestos e hipótesis

- **Depende de:** US-007, US-008, US-009 y US-013 (registro de evidencias).
- **Es prerrequisito de:** US-012
- **Supuestos:** Ninguno
- **Hipótesis del agente:** H-1: una evidencia aportada nace en estado Pendiente. Origen: BR-019 la define Pendiente o Validada. Lo confirmaría US-011-Q2.

## 12. Preguntas abiertas

| ID | Pregunta | Responsable | Prioridad | Bloquea | Estado |
|---|---|---|---|---|---|
| US-011-Q1 | Cerrada: el colaborador registra en la edición, contra el objetivo, referencias a issues cerrados (EVD-2026-0080, BR-059). | Jefe de Ingeniería | Alta | No | Cerrada |
| US-011-Q2 | ¿Una evidencia puede rechazarse o volver de Validada a Pendiente? | Jefe de Ingeniería | Media | No | Abierta |
| IM-Q2 | ¿Cómo se asocia una evidencia aportada con la requerida y con la edición? | Jefe de Ingeniería | Media | No | Abierta |

## 13. Evidencia y trazabilidad

| ID | Hallazgo | Fuente | Clasificación | Confianza |
|---|---|---|---|---|
| EVD-2026-0019 | Quien dicta el curso evalúa y emite el certificado. Cada curso define las competencias que desarrolla y las evidencias que evalúa con una rúbrica definida para el curso | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L114 | decision | high |
| EVD-2026-0055 | Los estados de una evidencia son Pendiente y Validada | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L150 | decision | high |
| EVD-2026-0060 | Las evidencias del curso las valida el instructor del curso/edición | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L155 | decision | high |
| EVD-2026-0076 | Se diferencian la evidencia requerida (definida en el curso o la competencia) y la evidencia aportada (por un colaborador) | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L171 | decision | high |
| EVD-2026-0080 | El colaborador registra, en la edición de curso en que está enrolado y en el objetivo del curso, las referencias a issues cerrados (Task o UserStory) que son evidencias del logro del objetivo | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L175 | decision | high |

Evidencia compartida: `source_type: human`, `observed_at: 2026-10-10T12:00:00-05:00`, `freshness: current`, `owner: Jefe de Ingeniería`.

- **Upstream:** [BRC-001](../../business/rules/BRC-001-reglas-de-negocio-portal-curricula.md), [IMD-001](../../business/information-model/IMD-001-portal-curricula.md), [GLS-001](../../business/glossary/GLS-001-glosario-de-negocio.md) y [RCP-001](../context-packs/RCP-001-portal-gestion-curricula-desarrollo.md), todos en estado `draft`.
- **Downstream (pendiente):** UXR → FLW → SCR → CMP → AC

## 14. Evaluación INVEST

| Criterio | ¿Cumple? | Justificación |
|---|---|---|
| Independiente | Parcial | Depende de US-007, US-008 y US-009, y de la historia de aportar evidencias. |
| Negociable | Parcial | Rechazo y reversión quedan abiertos (US-011-Q2). |
| Valiosa | Sí | Evidencias de curso validadas por quien dicta la edición. |
| Estimable | Sí | Alcance acotado. |
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
- **Motivo:** Actor, valor y criterios están sostenidos por BR-009 y BR-019. Las preguntas abiertas no bloquean los criterios.
- **Bloqueos de entrega:** Ninguno: US-013 registra las evidencias.
- **Propuesta de división (si no es pequeña):** No aplica
- **Siguiente rol o Skill:** `ux-requirements-analyzer`
- **Decisión humana requerida:** El Jefe de Ingeniería responde US-011-Q2 y valida la historia.
- **Validación:** Pendiente · Responsable: Jefe de Ingeniería · Fecha: —
