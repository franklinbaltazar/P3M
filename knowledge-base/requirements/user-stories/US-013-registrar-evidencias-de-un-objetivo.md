---
type: User Story
title: "US-013 — Registrar evidencias del logro de un objetivo en una edición"
description: "Como Colaborador, quiero registrar, en la edición en que estoy enrolado y en el objetivo del curso, las referencias a los issues cerrados que evidencian mi logro, para demostrar el logro del objetivo y poder ser validado y certificado."
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
gitlab_issue_id: 52924
gitlab_issue_iid: 14
gitlab_issue_url: https://project.comsatel.com.pe/comsatel/development/training/dev-juniors/p3m/collaboration/-/issues/14
---

# US-013 — Registrar evidencias del logro de un objetivo en una edición

## 1. Ficha

| Campo | Valor |
|---|---|
| ID | US-013 |
| Épica / capacidad | Cursos y evidencias (IMD-001, bloque 2) |
| Horizonte / release | Por definir |
| Actor | [Colaborador](../../business/glossary/terms/TRM-0002-colaborador.md) |
| Responsable de negocio (PO) | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) (responsable funcional del portal, /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L109) |
| Prioridad | Must: sin evidencias registradas no hay validación ni certificación. La decide el PO. |
| Dependencias | US-007, US-009 |
| Preparación | READY |

## 2. Historia

**Como** Colaborador, **quiero** registrar, en la edición en que estoy enrolado y en el objetivo del curso, las referencias a los issues cerrados que evidencian mi logro, **para** demostrar el logro del objetivo y poder ser validado y certificado.

## 3. Contexto y valor

- **Problema que resuelve:** El colaborador registra en la edición en que está enrolado, y en el objetivo del curso, las referencias a issues cerrados (Task o UserStory) que evidencian el logro del objetivo (BR-059, BR-020).
- **Valor esperado:** Evidencias de curso trazables a issues de GitLab.
- **Métrica o KPI que impacta:** Sin métrica asociada

## 4. Alcance

- **Incluye:**
  - Registrar la referencia a un issue de GitLab cerrado (Task o UserStory) como evidencia de un objetivo, en la edición en que el colaborador está enrolado.
- **Excluye:**
  - Validar la evidencia (US-011).
  - Definir la rúbrica y las evidencias esperadas (US-007).
  - Evidencias de proyecto, que valida el jefe de proyecto (historia por redactar).

## 5. Criterios de aceptación

### AC-1 — Registrar una evidencia de un objetivo

```gherkin
Escenario: Registrar una evidencia de un objetivo
  Dado un colaborador enrolado en una edición y un issue de GitLab Task o UserStory en estado Closed
  Cuando registra la referencia de ese issue en un objetivo del curso
  Entonces queda registrada como evidencia aportada de ese objetivo en su edición
```

- **Regla / fuente:** BR-059, BR-020

### AC-2 — Solo se aceptan issues cerrados

```gherkin
Escenario: Solo se aceptan issues cerrados
  Dado un issue de GitLab que no está en estado Closed
  Cuando el colaborador intenta registrarlo como evidencia
  Entonces el portal no lo acepta
```

- **Regla / fuente:** BR-020

### AC-3 — Solo en la edición en que está enrolado

```gherkin
Escenario: Solo en la edición en que está enrolado
  Dado un colaborador que no está enrolado en una edición
  Cuando intenta registrar una evidencia en esa edición
  Entonces el portal no lo permite
```

- **Regla / fuente:** BR-059

## 6. Casos negativos y límite

| Caso | Comportamiento esperado | Fuente o pregunta |
|---|---|---|
| Issue en estado distinto de Closed | No se acepta | BR-020 |
| Colaborador no enrolado en la edición | No registra evidencias | BR-059 |
| Issue que no existe en GitLab o que aún no se sincronizó (la consulta a GitLab es automática, cada 30 s por defecto) | Sin regla | US-013-Q1 |
| Mismo issue registrado en más de un objetivo o por más de un colaborador | Sin regla | US-013-Q1 |
| Registro después de terminada la edición | Sin regla | US-013-Q1 |
| Evidencia que no corresponde a ninguna evidencia esperada de la rúbrica | Sin regla | IM-Q2 |

## 7. Reglas de negocio aplicables

| ID | Regla | Fuente |
|---|---|---|
| BR-059 | Una competencia general (por ejemplo, comunicación) puede estar en más de un perfil de competencias. Las demás competencias son exclusivas de un perfil. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L99 |
| BR-020 | Una evidencia aportada, de proyecto o de curso, referencia un issue de GitLab con label Task o UserStory, y solo es válida si el issue está en estado Closed. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L60 |
| BR-039 | El portal consulta GitLab de forma automática, cada 30 segundos por defecto, para obtener issues y milestones. Las funcionalidades no consultan GitLab directamente. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L79 |
| BR-054 | Se diferencian la evidencia esperada, definida en el curso o la competencia, y la evidencia aportada por un colaborador. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L94 |

## 8. Datos y términos

| Término | Uso en esta historia | Glosario |
|---|---|---|
| Evidencia aportada | Elemento que se registra | [Evidencia aportada](../../business/glossary/terms/TRM-0041-evidencia-aportada.md) |
| Issue de GitLab | Referencia que se registra | [Issue de GitLab](../../business/glossary/terms/TRM-0032-issue-de-gitlab.md) |
| Objetivo de curso | Objetivo evidenciado | [Objetivo de curso](../../business/glossary/terms/TRM-0012-objetivo-de-curso.md) |
| Enrolamiento | Condición para registrar | [Enrolamiento](../../business/glossary/terms/TRM-0015-enrolamiento.md) |
| Colaborador | Actor | [Colaborador](../../business/glossary/terms/TRM-0002-colaborador.md) |
| GitLab | Origen de los issues | [GitLab](../../business/glossary/terms/TRM-0036-gitlab.md) |

## 9. Requisitos no funcionales

- **Accesibilidad:** WCAG 2.2 AA (estándar del repositorio).
- **Privacidad y datos personales:** Toca la identidad del colaborador. Restricción: BR-003 y la política pendiente G-12.
- **Otros:** Sin requisito identificado

## 10. Consideraciones de UX

- **Flujo esperado:** El colaborador abre su edición, elige un objetivo y registra las referencias a los issues cerrados que evidencian su logro.
- **Estados de la interfaz:** Sin evidencias, issue no cerrado, sin enrolamiento, error, éxito.
- **Contenido clave:** Objetivo, evidencias esperadas de la rúbrica, issues registrados y su estado.

## 11. Dependencias, supuestos e hipótesis

- **Depende de:** US-009 (enrolamiento), US-007 (rúbrica) y la consulta automática de issues de GitLab (BR-039).
- **Es prerrequisito de:** US-011, US-012
- **Supuestos:** Ninguno
- **Hipótesis del agente:** H-1: la evidencia registrada queda en estado Pendiente hasta que el Evaluador la valide. Origen: BR-019 y BR-009. Lo confirmaría US-011-Q2.

## 12. Preguntas abiertas

| ID | Pregunta | Responsable | Prioridad | Bloquea | Estado |
|---|---|---|---|---|---|
| US-013-Q1 | ¿Qué validaciones aplican al registrar (issue existente y sincronizado, repetido, fuera de plazo)? | Jefe de Ingeniería | Media | No | Abierta |
| IM-Q2 | ¿Una evidencia aportada responde a una sola evidencia esperada de la rúbrica? | Jefe de Ingeniería | Baja | No | Abierta |

## 13. Evidencia y trazabilidad

| ID | Hallazgo | Fuente | Clasificación | Confianza |
|---|---|---|---|---|
| EVD-2026-0044 | Una evidencia de proyecto referencia un issue de GitLab etiquetado como "Task" o "UserStory" y el issue debe estar en estado "Closed" | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L139 | decision | high |
| EVD-2026-0080 | El colaborador registra, en la edición de curso en que está enrolado y en el objetivo del curso, las referencias a issues cerrados (Task o UserStory) que son evidencias del logro del objetivo | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L175 | decision | high |
| EVD-2026-0058 | El colaborador se auto-enrola en las ediciones de curso. Una edición tiene número de edición, fecha y cupo. El avance, la evaluación y el certificado se registran por edición | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L153 | decision | high |
| EVD-2026-0093 | El portal consulta GitLab de forma automática, cada 30 segundos por defecto. Las funcionalidades no consultan GitLab directamente | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L188 | decision | high |

Evidencia compartida: `source_type: human`, `observed_at: 2026-10-10T12:00:00-05:00`, `freshness: current`, `owner: Jefe de Ingeniería`.

- **Upstream:** [BRC-001](../../business/rules/BRC-001-reglas-de-negocio-portal-curricula.md), [IMD-001](../../business/information-model/IMD-001-portal-curricula.md), [GLS-001](../../business/glossary/GLS-001-glosario-de-negocio.md) y [RCP-001](../context-packs/RCP-001-portal-gestion-curricula-desarrollo.md), todos en estado `draft`.
- **Downstream (pendiente):** UXR → FLW → SCR → CMP → AC

## 14. Evaluación INVEST

| Criterio | ¿Cumple? | Justificación |
|---|---|---|
| Independiente | Parcial | Necesita US-009 y la rúbrica de US-007. |
| Negociable | Sí | Las validaciones se pueden conversar (US-013-Q1). |
| Valiosa | Sí | Evidencias de curso trazables a issues de GitLab. |
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
- **Motivo:** Actor, valor y criterios están sostenidos por BR-059 y BR-020. Las preguntas abiertas no bloquean los criterios.
- **Bloqueos de entrega:** Ninguno
- **Propuesta de división (si no es pequeña):** No aplica
- **Siguiente rol o Skill:** `ux-requirements-analyzer`
- **Decisión humana requerida:** El Jefe de Ingeniería valida la historia y responde US-013-Q1.
- **Validación:** Pendiente · Responsable: Jefe de Ingeniería · Fecha: —
