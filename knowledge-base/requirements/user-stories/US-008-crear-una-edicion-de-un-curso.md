---
type: User Story
title: "US-008 — Crear una edición de un curso"
description: "Como Jefe de Ingeniería, quiero crear ediciones de un curso con su número, fechas, cupo e instructor, para que los colaboradores puedan enrolarse y que el instructor evalúe."
tags: [user-story, por-definir, cursos, ediciones]
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
gitlab_issue_id: 52919
gitlab_issue_iid: 9
gitlab_issue_url: https://project.comsatel.com.pe/comsatel/development/training/dev-juniors/p3m/collaboration/-/issues/9
---

# US-008 — Crear una edición de un curso

## 1. Ficha

| Campo | Valor |
|---|---|
| ID | US-008 |
| Épica / capacidad | Cursos y evidencias (IMD-001, bloque 2) |
| Horizonte / release | Por definir |
| Actor | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) o [ADMIN](../../business/glossary/terms/TRM-0028-admin.md) |
| Responsable de negocio (PO) | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) (responsable funcional del portal, /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L109) |
| Prioridad | Must: los colaboradores se enrolan en ediciones, no en cursos. La decide el PO. |
| Dependencias | US-006 |
| Preparación | READY |

## 2. Historia

**Como** Jefe de Ingeniería o usuario con perfil ADMIN, **quiero** crear ediciones de un curso con su número, fechas, cupo e instructor, **para** que los colaboradores puedan enrolarse y que el instructor evalúe.

## 3. Contexto y valor

- **Problema que resuelve:** Una edición tiene número de edición, fecha de inicio y fin, cupo e instructor asignado, que actúa como Evaluador (BR-024, BR-008).
- **Valor esperado:** Ediciones de curso disponibles para enrolamiento, con instructor asignado.
- **Métrica o KPI que impacta:** Sin métrica asociada

## 4. Alcance

- **Incluye:**
  - Crear una edición de un curso con número, fecha de inicio y fin, y cupo.
  - Asignar el instructor que actúa como Evaluador.
- **Excluye:**
  - Enrolarse en una edición (US-009).
  - Validar evidencias y certificar (US-011, US-012).

## 5. Criterios de aceptación

### AC-1 — Crear una edición

```gherkin
Escenario: Crear una edición
  Dado el curso "Análisis de requisitos"
  Cuando se crea la edición número 1 con fecha de inicio y fin y un cupo
  Entonces el curso tiene esa edición con esos datos
```

- **Regla / fuente:** BR-024

### AC-2 — Asignar el instructor de la edición

```gherkin
Escenario: Asignar el instructor de la edición
  Dado una edición de un curso y un usuario con el rol Evaluador
  Cuando se le asigna como instructor de la edición
  Entonces ese usuario es el Evaluador de la edición
```

- **Regla / fuente:** BR-008, BR-024

### AC-3 — Un curso tiene varias ediciones

```gherkin
Escenario: Un curso tiene varias ediciones
  Dado el curso "Análisis de requisitos" con la edición 1
  Cuando se crea la edición 2
  Entonces el curso tiene dos ediciones
```

- **Regla / fuente:** BR-024

### AC-4 — Solo el Jefe de Ingeniería o el ADMIN lo define

```gherkin
Escenario: Solo el Jefe de Ingeniería o el ADMIN lo define
  Dado que el usuario está autenticado y no es el Jefe de Ingeniería ni un ADMIN
  Cuando intenta crear una edición de un curso
  Entonces el portal no permite la acción
```

- **Regla / fuente:** BR-055, BR-134

## 6. Casos negativos y límite

| Caso | Comportamiento esperado | Fuente o pregunta |
|---|---|---|
| Edición sin instructor asignado | Sin regla | US-008-Q1 |
| Asignar un usuario que no tiene el rol Evaluador | Sin regla | US-008-Q1 |
| Fecha de fin anterior a la de inicio, o cupo cero o negativo | Sin regla | US-008-Q2 |
| Número de edición: se asigna solo o lo indica el actor | Sin regla | US-008-Q2 |
| La fecha de inicio y fin pertenece a la edición | Es de la edición | EVD-2026-0114 |
| Usuario que no es el Jefe de Ingeniería ni un ADMIN | No puede crear ediciones | BR-055, BR-134 |

## 7. Reglas de negocio aplicables

| ID | Regla | Fuente |
|---|---|---|
| BR-024 | Una edición tiene número de edición, fecha de inicio y fin, cupo e instructor asignado. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L64 |
| BR-008 | El Evaluador es un rol que se asigna a usuarios del portal en Keycloak y corresponde al instructor asignado a una edición de curso. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L48 |
| BR-016 | Los cursos son internos. La modalidad (virtual, presencial o híbrida) no cambia su tratamiento. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L56 |
| BR-055 | Solo el Jefe de Ingeniería define los perfiles de competencias, el nivel mínimo, los cursos con sus objetivos y evidencias esperadas, y las ediciones. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L95 |
| BR-134 | El ADMIN puede hacer también las seis capacidades que eran exclusivas del Jefe de Ingeniería (BR-005, BR-006, BR-007, BR-055, BR-083, BR-129). | /business/rules\BRC-001-reglas-de-negocio-portal-curricula.md:L174 |

## 8. Datos y términos

| Término | Uso en esta historia | Glosario |
|---|---|---|
| Edición de curso | Elemento que se crea | [Edición de curso](../../business/glossary/terms/TRM-0013-edicion-de-curso.md) |
| Cupo | Límite de enrolamientos | [Cupo](../../business/glossary/terms/TRM-0014-cupo.md) |
| Evaluador | Instructor asignado | [Evaluador](../../business/glossary/terms/TRM-0016-evaluador.md) |
| Keycloak | Donde se asigna el rol Evaluador | [Keycloak](../../business/glossary/terms/TRM-0037-keycloak.md) |

## 9. Requisitos no funcionales

- **Accesibilidad:** WCAG 2.2 AA (estándar del repositorio).
- **Privacidad y datos personales:** No aplica: la historia no toca datos personales de colaboradores.
- **Otros:** Sin requisito identificado

## 10. Consideraciones de UX

- **Flujo esperado:** El actor abre un curso, crea una edición con sus datos y asigna al instructor.
- **Estados de la interfaz:** Vacío (curso sin ediciones), sin permisos, error de validación, éxito.
- **Contenido clave:** Número de edición, fechas, cupo e instructor.

## 11. Dependencias, supuestos e hipótesis

- **Depende de:** US-006 (curso) y usuarios con rol Evaluador en Keycloak (BR-008).
- **Es prerrequisito de:** US-009, US-011, US-012
- **Supuestos:** Ninguno. La fecha de inicio y fin que la fuente atribuía al curso es de la edición (EVD-2026-0114).
- **Hipótesis del agente:** Ninguna

## 12. Preguntas abiertas

| ID | Pregunta | Responsable | Prioridad | Bloquea | Estado |
|---|---|---|---|---|---|
| US-002-Q1 | Cerrada: los perfiles de competencias, los cursos y las ediciones los define el Jefe de Ingeniería (EVD-2026-0078, BR-055). | Jefe de Ingeniería | Alta | No | Cerrada |
| US-008-Q1 | ¿Una edición puede existir sin instructor? ¿Solo se puede asignar a usuarios con el rol Evaluador? | Jefe de Ingeniería | Media | No | Abierta |
| US-008-Q2 | ¿Cómo se asigna el número de edición y qué validaciones tienen las fechas y el cupo? | Jefe de Ingeniería | Baja | No | Abierta |
| RQ-12 | ¿La fecha de inicio y fin pertenece al curso o a cada edición? | Jefe de Ingeniería | Baja | No | Cerrada: pertenece a la edición (EVD-2026-0114) |

## 13. Evidencia y trazabilidad

| ID | Hallazgo | Fuente | Clasificación | Confianza |
|---|---|---|---|---|
| EVD-2026-0049 | El Evaluador es el instructor asignado a la edición de un curso. Los cursos tienen ediciones | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L144 | decision | high |
| EVD-2026-0058 | El colaborador se auto-enrola en las ediciones de curso. Una edición tiene número de edición, fecha y cupo. El avance, la evaluación y el certificado se registran por edición | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L153 | decision | high |
| EVD-2026-0061 | El curso tiene fecha de inicio y fin. Al llegar al cupo no se admite más enrolamiento. El colaborador puede desenrolarse | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L156 | decision | medium |
| EVD-2026-0114 | La fecha de inicio y fin corresponde a la edición del curso, no al curso | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L498 | decision | high |
| EVD-2026-0048 | El Evaluador es un rol que se asigna a los usuarios del portal a través de Keycloak, donde se mantiene el IdM | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L143 | decision | high |
| EVD-2026-0078 | El Jefe de Ingeniería define los perfiles de competencias, los cursos y las ediciones | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L173 | decision | high |
| EVD-2026-0173 | El ADMIN suple las seis capacidades exclusivas del Jefe de Ingeniería | /requirements/context-packs\RCP-001-portal-gestion-curricula-desarrollo.md:L572 | decision | high |

Evidencia compartida: `source_type: human`, `observed_at: 2026-10-10T12:00:00-05:00`, `freshness: current`, `owner: Jefe de Ingeniería`.

- **Upstream:** [BRC-001](../../business/rules/BRC-001-reglas-de-negocio-portal-curricula.md), [IMD-001](../../business/information-model/IMD-001-portal-curricula.md), [GLS-001](../../business/glossary/GLS-001-glosario-de-negocio.md) y [RCP-001](../context-packs/RCP-001-portal-gestion-curricula-desarrollo.md), todos en estado `draft`.
- **Downstream (pendiente):** UXR → FLW → SCR → CMP → AC

## 14. Evaluación INVEST

| Criterio | ¿Cumple? | Justificación |
|---|---|---|
| Independiente | Parcial | Depende de US-006. |
| Negociable | Sí | Validaciones de fechas y cupo se pueden conversar. |
| Valiosa | Sí | Ediciones de curso disponibles para enrolamiento, con instructor asignado. |
| Estimable | Parcial | Las validaciones están abiertas (US-008-Q2). |
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
- **Motivo:** El actor (Jefe de Ingeniería o ADMIN, BR-055 y BR-134), el valor y los criterios están sostenidos por las reglas citadas. Las preguntas abiertas no bloquean los criterios.
- **Bloqueos de entrega:** Ninguno
- **Propuesta de división (si no es pequeña):** No aplica
- **Siguiente rol o Skill:** `ux-requirements-analyzer`
- **Decisión humana requerida:** El Jefe de Ingeniería valida la historia y responde US-008-Q1 y US-008-Q2.
- **Validación:** Pendiente · Responsable: Jefe de Ingeniería · Fecha: —
