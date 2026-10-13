---
type: User Story
title: "US-007 — Definir la rúbrica de cada objetivo de un curso"
description: "Como Jefe de Ingeniería, quiero definir, para cada objetivo de aprendizaje de un curso, una rúbrica con el desempeño observable y las evidencias esperadas de cada nivel de logro, para que se sepa qué debe mostrar un colaborador en cada nivel y qué evidencias deben estar validadas para certificarlo."
tags: [user-story, por-definir, cursos, evidencias]
status: draft
generated:
  by: "af-user-story-refiner/2.0"
  at: "2026-10-10T12:00:00-05:00"
sources:
  - id: brc-001
    resource: /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md
  - id: rcp-001
    resource: /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md
  - id: gls-001
    resource: /business/glossary/GLS-001-glosario-de-negocio.md
  - id: imd-001
    resource: /business/information-model/IMD-001-portal-curricula.md
gitlab_issue_id: 52918
gitlab_issue_iid: 8
gitlab_issue_url: https://project.comsatel.com.pe/comsatel/development/training/dev-juniors/p3m/collaboration/-/issues/8
---

# US-007 — Definir la rúbrica de cada objetivo de un curso

## 1. Ficha

| Campo | Valor |
|---|---|
| ID | US-007 |
| Épica / capacidad | Cursos y evidencias (IMD-001, bloque 2) |
| Horizonte / release | Por definir |
| Actor | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) o [ADMIN](../../business/glossary/terms/TRM-0028-admin.md) |
| Responsable de negocio (PO) | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) (responsable funcional del portal, /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L109) |
| Prioridad | Must: sin rúbrica no se puede certificar una edición. La decide el PO. |
| Dependencias | US-006 |
| Preparación | READY |

## 2. Historia

**Como** Jefe de Ingeniería o usuario con perfil ADMIN, **quiero** definir, para cada objetivo de aprendizaje de un curso, una rúbrica con el desempeño observable y las evidencias esperadas de cada nivel de logro, **para** que se sepa qué debe mostrar un colaborador en cada nivel y qué evidencias deben estar validadas para certificarlo.

## 3. Contexto y valor

- **Problema que resuelve:** Cada objetivo de aprendizaje define una rúbrica: por nivel de logro, el nivel, la descripción observable del desempeño y las evidencias que se espera que muestre, indicando si cada una es mandatoria u opcional (BR-058, BR-018).
- **Valor esperado:** Cada objetivo tiene criterios de evaluación observables y evidencias esperadas claras.
- **Métrica o KPI que impacta:** Sin métrica asociada

## 4. Alcance

- **Incluye:**
  - Definir la rúbrica de un objetivo: por nivel de logro, la descripción observable del desempeño.
  - Definir las evidencias esperadas de cada nivel y marcar cada una como obligatoria u opcional.
  - Modificar la rúbrica de un objetivo.
- **Excluye:**
  - Crear el curso y sus objetivos (US-006).
  - Registrar las evidencias aportadas por los colaboradores (US-013).
  - Validar evidencias (US-011) y certificar (US-012).

## 5. Criterios de aceptación

### AC-1 — Definir la rúbrica de un objetivo

```gherkin
Escenario: Definir la rúbrica de un objetivo
  Dado un objetivo de aprendizaje de un curso
  Cuando se define su rúbrica con, para cada nivel de logro, el nivel y la descripción observable del desempeño
  Entonces el objetivo tiene una rúbrica con esas descripciones por nivel
```

- **Regla / fuente:** BR-058

### AC-2 — Definir una evidencia obligatoria

```gherkin
Escenario: Definir una evidencia obligatoria
  Dado la rúbrica de un objetivo y un nivel de logro
  Cuando se define una evidencia esperada como obligatoria
  Entonces esa evidencia debe estar validada para certificar la edición
```

- **Regla / fuente:** BR-018, BR-021, BR-058

### AC-3 — Definir una evidencia opcional

```gherkin
Escenario: Definir una evidencia opcional
  Dado la rúbrica de un objetivo y un nivel de logro
  Cuando se define una evidencia esperada como opcional
  Entonces esa evidencia no limita la certificación
```

- **Regla / fuente:** BR-018, BR-021, BR-058

### AC-4 — Solo el Jefe de Ingeniería o el ADMIN lo define

```gherkin
Escenario: Solo el Jefe de Ingeniería o el ADMIN lo define
  Dado que el usuario está autenticado y no es el Jefe de Ingeniería ni un ADMIN
  Cuando intenta definir la rúbrica de un objetivo
  Entonces el portal no permite la acción
```

- **Regla / fuente:** BR-055, BR-134

## 6. Casos negativos y límite

| Caso | Comportamiento esperado | Fuente o pregunta |
|---|---|---|
| Nivel de logro distinto de N1, N2 o N3 | No es válido | BR-013 |
| Evidencia esperada sin condición de obligatoria u opcional | Sin regla | US-007-Q2 |
| Cambiar la rúbrica cuando ya hay colaboradores enrolados o evidencias registradas | Sin regla | US-007-Q2 |
| Rúbrica con los tres niveles N1, N2 y N3 o solo con algunos | Sin regla | US-007-Q2 |
| Usuario que no es el Jefe de Ingeniería ni un ADMIN | No puede definir rúbricas | BR-055, BR-134 |

## 7. Reglas de negocio aplicables

| ID | Regla | Fuente |
|---|---|---|
| BR-058 | Cada objetivo de aprendizaje define una rúbrica: define los niveles de logro de la competencia y, para cada nivel, la descripción observable del desempeño y las evidencias requeridas para mostrar el logro. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L98 |
| BR-018 | La rúbrica de cada objetivo indica, para cada nivel de logro, si cada evidencia esperada es obligatoria (mandatoria) u opcional (deseable). | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L58 |
| BR-021 | Una edición se certifica cuando el 100% de las evidencias obligatorias están Validadas. Las evidencias deseables no limitan la certificación. La certificación es el mismo resultado que la promoción en el curso. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L61 |
| BR-054 | Se diferencian la evidencia esperada, definida en el curso o la competencia, y la evidencia aportada por un colaborador. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L94 |
| BR-055 | Solo el Jefe de Ingeniería define los perfiles de competencias, el nivel mínimo, los cursos con sus objetivos y evidencias esperadas, y las ediciones. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L95 |
| BR-134 | El ADMIN puede hacer también las seis capacidades que eran exclusivas del Jefe de Ingeniería (BR-005, BR-006, BR-007, BR-055, BR-083, BR-129). | /business/rules\BRC-001-reglas-de-negocio-portal-curricula.md:L174 |

## 8. Datos y términos

| Término | Uso en esta historia | Glosario |
|---|---|---|
| Rúbrica | Elemento que se define | [Rúbrica](../../business/glossary/terms/TRM-0045-rubrica.md) |
| Objetivo de curso | Dueño de la rúbrica | [Objetivo de curso](../../business/glossary/terms/TRM-0012-objetivo-de-curso.md) |
| Nivel de logro (N1–N3) | Niveles que se describen | [Nivel de logro (N1–N3)](../../business/glossary/terms/TRM-0008-nivel-de-logro-n1-n3.md) |
| Evidencia esperada | Evidencias esperadas | [Evidencia esperada](../../business/glossary/terms/TRM-0040-evidencia-esperada.md) |
| Evidencia obligatoria | Condición posible | [Evidencia obligatoria](../../business/glossary/terms/TRM-0019-evidencia-obligatoria.md) |
| Evidencia deseable | Condición posible | [Evidencia deseable](../../business/glossary/terms/TRM-0020-evidencia-deseable.md) |

## 9. Requisitos no funcionales

- **Accesibilidad:** WCAG 2.2 AA (estándar del repositorio).
- **Privacidad y datos personales:** No aplica: la historia no toca datos personales.
- **Otros:** Sin requisito identificado

## 10. Consideraciones de UX

- **Flujo esperado:** El actor abre un objetivo del curso, describe el desempeño observable de cada nivel de logro y define las evidencias esperadas con su condición.
- **Estados de la interfaz:** Vacío (objetivo sin rúbrica), sin permisos, error de validación, éxito.
- **Contenido clave:** Rúbrica por nivel de logro y evidencias esperadas obligatorias u opcionales.

## 11. Dependencias, supuestos e hipótesis

- **Depende de:** US-006 (curso y objetivos).
- **Es prerrequisito de:** US-011, US-012, US-013
- **Supuestos:** Ninguno
- **Hipótesis del agente:** Ninguna

## 12. Preguntas abiertas

| ID | Pregunta | Responsable | Prioridad | Bloquea | Estado |
|---|---|---|---|---|---|
| US-002-Q1 | Cerrada: los perfiles de competencias, los cursos y las ediciones los define el Jefe de Ingeniería (EVD-2026-0078, BR-055). | Jefe de Ingeniería | Alta | No | Cerrada |
| US-007-Q1 | Cerrada: la rúbrica indica por nivel de logro el nivel, la descripción observable y las evidencias esperadas, mandatorias u opcionales (EVD-2026-0085, BR-058). | Jefe de Ingeniería | Baja | No | Cerrada |
| US-007-Q2 | ¿Puede cambiarse la rúbrica con colaboradores enrolados? ¿Debe cubrir los tres niveles? ¿Toda evidencia esperada debe indicar su condición? | Jefe de Ingeniería | Baja | No | Abierta |
| RQ-17 | ¿Qué es la «sumilla» de un curso? | Jefe de Ingeniería | Baja | No | Abierta |

## 13. Evidencia y trazabilidad

| ID | Hallazgo | Fuente | Clasificación | Confianza |
|---|---|---|---|---|
| EVD-2026-0057 | Las competencias tienen evidencias obligatorias, que deben estar 100% validadas para certificar el curso, y deseables, que no limitan | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L152 | decision | high |
| EVD-2026-0059 | La regla de certificación está confirmada: se certifica cuando el 100% de las evidencias obligatorias están Validadas. Lo obligatorio u opcional se define en el curso (curso → objetivo del curso → competencia y nivel objetivo) | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L154 | decision | high |
| EVD-2026-0076 | Se diferencian la evidencia requerida (definida en el curso o la competencia) y la evidencia aportada (por un colaborador) | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L171 | decision | high |
| EVD-2026-0078 | El Jefe de Ingeniería define los perfiles de competencias, los cursos y las ediciones | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L173 | decision | high |
| EVD-2026-0079 | El Jefe de Ingeniería define también el nivel mínimo, las evidencias requeridas y los objetivos | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L174 | decision | high |
| EVD-2026-0085 | Cada objetivo de aprendizaje define una rúbrica: para cada nivel de logro, el nivel, la descripción observable del desempeño y las evidencias que se espera que muestre, indicando si cada evidencia es mandatoria/requerida u opcional | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L180 | decision | high |
| EVD-2026-0087 | Una rúbrica define los niveles de logro de la competencia, y cada nivel de logro define qué evidencias son requeridas para mostrar el logro del curso | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L182 | decision | high |
| EVD-2026-0088 | «Requerida» es sinónimo de «mandatoria» | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L183 | decision | high |
| EVD-2026-0173 | El ADMIN suple las seis capacidades exclusivas del Jefe de Ingeniería | /requirements/context-packs\RCP-001-portal-gestion-curricula-desarrollo.md:L572 | decision | high |

Evidencia compartida: `source_type: human`, `observed_at: 2026-10-10T12:00:00-05:00`, `freshness: current`, `owner: Jefe de Ingeniería`.

- **Upstream:** [BRC-001](../../business/rules/BRC-001-reglas-de-negocio-portal-curricula.md), [IMD-001](../../business/information-model/IMD-001-portal-curricula.md), [GLS-001](../../business/glossary/GLS-001-glosario-de-negocio.md) y [RCP-001](../context-packs/RCP-001-portal-gestion-curricula-desarrollo.md), todos en estado `draft`.
- **Downstream (pendiente):** UXR → FLW → SCR → CMP → AC

## 14. Evaluación INVEST

| Criterio | ¿Cumple? | Justificación |
|---|---|---|
| Independiente | Parcial | Depende de US-006. |
| Negociable | Sí | La cobertura de niveles y los cambios se pueden conversar (US-007-Q2). |
| Valiosa | Sí | Cada objetivo tiene criterios de evaluación observables y evidencias esperadas claras. |
| Estimable | Sí | Alcance acotado. |
| Pequeña (Small) | Sí | Cabe en una iteración. |
| Testeable | Sí | Los criterios son verificables. |

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
- **Motivo:** El actor (Jefe de Ingeniería o ADMIN, BR-055 y BR-134), el valor y los criterios están sostenidos por BR-058 y BR-018. Las preguntas abiertas no bloquean los criterios.
- **Bloqueos de entrega:** Ninguno
- **Propuesta de división (si no es pequeña):** No aplica
- **Siguiente rol o Skill:** `ux-requirements-analyzer`
- **Decisión humana requerida:** El Jefe de Ingeniería valida la historia y responde US-007-Q2.
- **Validación:** Pendiente · Responsable: Jefe de Ingeniería · Fecha: —
