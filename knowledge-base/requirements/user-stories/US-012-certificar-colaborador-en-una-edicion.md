---
type: User Story
title: "US-012 — Certificar a un colaborador en una edición de curso"
description: "Como Evaluador, quiero certificar a un colaborador en mi edición cuando cumple las evidencias obligatorias, para acreditar el logro de los objetivos del curso y aportar a su progresión."
tags: [user-story, por-definir, cursos, certificacion]
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
gitlab_issue_id: 52923
gitlab_issue_iid: 13
gitlab_issue_url: https://project.comsatel.com.pe/comsatel/development/training/dev-juniors/p3m/collaboration/-/issues/13
---

# US-012 — Certificar a un colaborador en una edición de curso

## 1. Ficha

| Campo | Valor |
|---|---|
| ID | US-012 |
| Épica / capacidad | Cursos y evidencias (IMD-001, bloque 2) |
| Horizonte / release | Por definir |
| Actor | [Evaluador](../../business/glossary/terms/TRM-0016-evaluador.md) |
| Responsable de negocio (PO) | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) (responsable funcional del portal, /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L109) |
| Prioridad | Must: la certificación es insumo de la promoción de nivel. La decide el PO. |
| Dependencias | US-007, US-011 |
| Preparación | READY |

## 2. Historia

**Como** Evaluador, **quiero** certificar a un colaborador en mi edición cuando cumple las evidencias obligatorias, **para** acreditar el logro de los objetivos del curso y aportar a su progresión.

## 3. Contexto y valor

- **Problema que resuelve:** Una edición se certifica cuando el 100% de las evidencias obligatorias están Validadas. La certificación es lo mismo que la promoción en el curso y no acredita por sí sola el nivel de una competencia (BR-021, BR-022).
- **Valor esperado:** Certificaciones de curso emitidas con una regla única y verificable.
- **Métrica o KPI que impacta:** Sin métrica asociada

## 4. Alcance

- **Incluye:**
  - Certificar a un colaborador cuando el 100% de las evidencias obligatorias están Validadas.
  - Impedir la certificación si falta alguna evidencia obligatoria.
- **Excluye:**
  - Validar evidencias (US-011).
  - Decidir la promoción de nivel (historia por redactar).
  - Contenido y formato del certificado (US-012-Q1).

## 5. Criterios de aceptación

### AC-1 — Certificar con el 100% de las evidencias obligatorias

```gherkin
Escenario: Certificar con el 100% de las evidencias obligatorias
  Dado un colaborador enrolado cuyas evidencias obligatorias están todas Validadas
  Cuando el Evaluador lo certifica en la edición
  Entonces el colaborador queda certificado, es decir, promocionado en el curso
```

- **Regla / fuente:** BR-021, BR-022

### AC-2 — No se certifica con evidencias obligatorias sin validar

```gherkin
Escenario: No se certifica con evidencias obligatorias sin validar
  Dado un colaborador con una evidencia obligatoria en estado Pendiente
  Cuando el Evaluador intenta certificarlo
  Entonces el portal no emite la certificación
```

- **Regla / fuente:** BR-021

### AC-3 — Las evidencias deseables no limitan

```gherkin
Escenario: Las evidencias deseables no limitan
  Dado un colaborador con todas las obligatorias Validadas y alguna deseable Pendiente
  Cuando el Evaluador lo certifica
  Entonces la certificación se emite igualmente
```

- **Regla / fuente:** BR-021

### AC-4 — La certificación no cambia el nivel de las competencias

```gherkin
Escenario: La certificación no cambia el nivel de las competencias
  Dado un colaborador recién certificado en una edición
  Cuando se consulta el nivel actual de sus competencias
  Entonces la certificación no lo modifica por sí sola
```

- **Regla / fuente:** BR-022

## 6. Casos negativos y límite

| Caso | Comportamiento esperado | Fuente o pregunta |
|---|---|---|
| Alguna evidencia obligatoria Pendiente | No se certifica | BR-021 |
| Usuario que no es el Evaluador de la edición | No puede certificar | BR-009 |
| Curso sin evidencias obligatorias definidas | Sin regla | US-012-Q1 |
| Contenido del certificado (código, fecha) y revocación | Sin regla | US-012-Q1 |
| La certificación es una evidencia aportada por el colaborador o un resultado del Evaluador | Sin regla | IM-Q10 |

## 7. Reglas de negocio aplicables

| ID | Regla | Fuente |
|---|---|---|
| BR-021 | Una edición se certifica cuando el 100% de las evidencias obligatorias están Validadas. Las evidencias deseables no limitan la certificación. La certificación es el mismo resultado que la promoción en el curso. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L61 |
| BR-022 | La promoción en el curso la realiza el Evaluador y es el mismo resultado que la certificación de la edición. Acredita el logro de los objetivos del curso, pero no acredita por sí sola el nivel de las competencias. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L62 |
| BR-009 | El Evaluador de una edición valida las evidencias de curso, evalúa, emite el certificado y promociona al colaborador en el curso. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L49 |

## 8. Datos y términos

| Término | Uso en esta historia | Glosario |
|---|---|---|
| Certificación de curso | Resultado que se emite | [Certificación de curso](../../business/glossary/terms/TRM-0022-certificacion-de-curso.md) |
| Promoción en el curso | Mismo resultado | [Promoción en el curso](../../business/glossary/terms/TRM-0023-promocion-en-el-curso.md) |
| Evidencia obligatoria | Condición de la certificación | [Evidencia obligatoria](../../business/glossary/terms/TRM-0019-evidencia-obligatoria.md) |
| Evidencia deseable | No limita | [Evidencia deseable](../../business/glossary/terms/TRM-0020-evidencia-deseable.md) |
| Evaluador | Actor | [Evaluador](../../business/glossary/terms/TRM-0016-evaluador.md) |

## 9. Requisitos no funcionales

- **Accesibilidad:** WCAG 2.2 AA (estándar del repositorio).
- **Privacidad y datos personales:** Toca el resultado de un colaborador identificable. Restricción: BR-003 y la política pendiente G-12.
- **Otros:** Sin requisito identificado

## 10. Consideraciones de UX

- **Flujo esperado:** El Evaluador revisa el estado de las evidencias de un colaborador y emite la certificación cuando corresponde.
- **Estados de la interfaz:** Evidencias obligatorias pendientes, sin permisos, error, éxito.
- **Contenido clave:** Evidencias obligatorias y deseables con su estado, y el resultado de la certificación.

## 11. Dependencias, supuestos e hipótesis

- **Depende de:** US-007 (evidencias esperadas) y US-011 (validación).
- **Es prerrequisito de:** Valoración y promoción de nivel (historias por redactar)
- **Supuestos:** Ninguno
- **Hipótesis del agente:** Ninguna

## 12. Preguntas abiertas

| ID | Pregunta | Responsable | Prioridad | Bloquea | Estado |
|---|---|---|---|---|---|
| US-012-Q1 | ¿Qué contiene el certificado, puede revocarse y qué ocurre con un curso sin evidencias obligatorias? | Jefe de Ingeniería | Media | No | Abierta |
| IM-Q10 | ¿La certificación es una evidencia aportada por el colaborador o un resultado que emite el Evaluador? | Jefe de Ingeniería | Baja | No | Abierta |

## 13. Evidencia y trazabilidad

| ID | Hallazgo | Fuente | Clasificación | Confianza |
|---|---|---|---|---|
| EVD-2026-0057 | Las competencias tienen evidencias obligatorias, que deben estar 100% validadas para certificar el curso, y deseables, que no limitan | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L152 | decision | high |
| EVD-2026-0059 | La regla de certificación está confirmada: se certifica cuando el 100% de las evidencias obligatorias están Validadas. Lo obligatorio u opcional se define en el curso (curso → objetivo del curso → competencia y nivel objetivo) | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L154 | decision | high |
| EVD-2026-0074 | La promoción en el curso y la certificación son el mismo resultado | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L169 | decision | high |
| EVD-2026-0054 | Aprobar un curso no acredita por sí solo el nivel objetivo de las competencias, pero sí el logro de los objetivos del curso | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L149 | decision | high |

Evidencia compartida: `source_type: human`, `observed_at: 2026-10-10T12:00:00-05:00`, `freshness: current`, `owner: Jefe de Ingeniería`.

- **Upstream:** [BRC-001](../../business/rules/BRC-001-reglas-de-negocio-portal-curricula.md), [IMD-001](../../business/information-model/IMD-001-portal-curricula.md), [GLS-001](../../business/glossary/GLS-001-glosario-de-negocio.md) y [RCP-001](../context-packs/RCP-001-portal-gestion-curricula-desarrollo.md), todos en estado `draft`.
- **Downstream (pendiente):** UXR → FLW → SCR → CMP → AC

## 14. Evaluación INVEST

| Criterio | ¿Cumple? | Justificación |
|---|---|---|
| Independiente | Parcial | Depende de US-007 y US-011. |
| Negociable | Sí | El contenido del certificado se puede conversar. |
| Valiosa | Sí | Certificaciones de curso emitidas con una regla única y verificable. |
| Estimable | Sí | Alcance acotado. |
| Pequeña (Small) | Sí | Cabe en una iteración. |
| Testeable | Sí | Los 4 criterios son verificables. |

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
- **Motivo:** Actor, valor y criterios están sostenidos por BR-021 y BR-022. Las preguntas abiertas no bloquean los criterios.
- **Bloqueos de entrega:** Ninguno
- **Propuesta de división (si no es pequeña):** No aplica
- **Siguiente rol o Skill:** `ux-requirements-analyzer`
- **Decisión humana requerida:** El Jefe de Ingeniería valida la historia y responde US-012-Q1.
- **Validación:** Pendiente · Responsable: Jefe de Ingeniería · Fecha: —
