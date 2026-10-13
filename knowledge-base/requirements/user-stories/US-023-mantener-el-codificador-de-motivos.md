---
type: User Story
title: "US-023 — Mantener el codificador de motivos de excepción"
description: "Como Jefe de Ingeniería, quiero mantener el codificador de motivos de excepción, con su código y descripción, para que las excepciones de asignación usen motivos uniformes."
tags: [user-story, por-definir, asignacion, excepcion]
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
gitlab_issue_id: 52934
gitlab_issue_iid: 24
gitlab_issue_url: https://project.comsatel.com.pe/comsatel/development/training/dev-juniors/p3m/collaboration/-/issues/24
---

# US-023 — Mantener el codificador de motivos de excepción

## 1. Ficha

| Campo | Valor |
|---|---|
| ID | US-023 |
| Épica / capacidad | Portafolio y asignación (IMD-001, bloque 4) |
| Horizonte / release | Por definir |
| Actor | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) o [ADMIN](../../business/glossary/terms/TRM-0028-admin.md) (BR-061) |
| Responsable de negocio (PO) | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) (responsable funcional del portal, /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L109) |
| Prioridad | Must: sin motivos no se puede aprobar excepciones. La decide el PO. |
| Dependencias | — |
| Preparación | READY |

## 2. Historia

**Como** Jefe de Ingeniería, **quiero** mantener el codificador de motivos de excepción, con su código y descripción, **para** que las excepciones de asignación usen motivos uniformes.

## 3. Contexto y valor

- **Problema que resuelve:** El motivo de una excepción se toma de un codificador prestablecido (código y descripción) y debe existir una funcionalidad para mantenerlo (BR-043, BR-053).
- **Valor esperado:** Un codificador uniforme de motivos.
- **Métrica o KPI que impacta:** Sin métrica asociada

## 4. Alcance

- **Incluye:**
  - Crear y modificar motivos con código y descripción.
- **Excluye:**
  - Aprobar excepciones (US-022).

## 5. Criterios de aceptación

### AC-1 — Crear un motivo

```gherkin
Escenario: Crear un motivo
  Dado que el actor está autorizado a mantener el codificador
  Cuando registra un motivo con código y descripción
  Entonces el motivo queda disponible para las excepciones de asignación
```

- **Regla / fuente:** BR-043, BR-053

### AC-2 — No retirar un motivo usado

```gherkin
Escenario: No retirar un motivo usado
  Dado un motivo de excepción que ya fue usado en una excepción de asignación
  Cuando el Jefe de Ingeniería o el ADMIN intenta retirarlo
  Entonces el portal no lo permite
```

- **Regla / fuente:** BR-067

## 6. Casos negativos y límite

| Caso | Comportamiento esperado | Fuente o pregunta |
|---|---|---|
| Usuario que no es Jefe de Ingeniería ni ADMIN | No puede mantenerlo | BR-061 |
| Código repetido | Sin regla | US-023-Q3 |
| Valores iniciales | El codificador parte sin ningún valor registrado | BR-067 |
| Retirar un motivo ya usado | No se puede retirar | BR-067 |

## 7. Reglas de negocio aplicables

| ID | Regla | Fuente |
|---|---|---|
| BR-043 | De una excepción de asignación se registran el motivo, tomado de un codificador prestablecido (código y descripción), y quién la aprobó. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L83 |
| BR-053 | Existe una funcionalidad del portal para mantener el codificador de motivos de excepción. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L93 |
| BR-061 | Los productos, los proyectos y el codificador de motivos de excepción los mantiene el Jefe de Ingeniería o un colaborador con rol de usuario ADMIN. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L101 |
| BR-067 | El codificador de motivos de excepción parte sin ningún valor registrado y no se puede retirar un motivo que ya fue usado. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L107 |

## 8. Datos y términos

| Término | Uso en esta historia | Glosario |
|---|---|---|
| Motivo de excepción | Elemento que se mantiene | [Motivo de excepción](../../business/glossary/terms/TRM-0039-motivo-de-excepcion.md) |
| Excepción de asignación | Uso de los motivos | [Excepción de asignación](../../business/glossary/terms/TRM-0035-excepcion-de-asignacion.md) |

## 9. Requisitos no funcionales

- **Accesibilidad:** WCAG 2.2 AA (estándar del repositorio).
- **Privacidad y datos personales:** No aplica: la historia no toca datos personales.
- **Otros:** Sin requisito identificado

## 10. Consideraciones de UX

- **Flujo esperado:** El actor consulta el codificador y crea o modifica motivos.
- **Estados de la interfaz:** Vacío, sin permisos, error de validación, éxito.
- **Contenido clave:** Código y descripción de cada motivo.

## 11. Dependencias, supuestos e hipótesis

- **Depende de:** Ninguna.
- **Es prerrequisito de:** US-022
- **Supuestos:** Ninguno
- **Hipótesis del agente:** Ninguna

## 12. Preguntas abiertas

| ID | Pregunta | Responsable | Prioridad | Bloquea | Estado |
|---|---|---|---|---|---|
| US-023-Q1 | ¿Quién puede mantener el codificador? | Jefe de Ingeniería | Alta | No | Cerrada: el Jefe de Ingeniería o un ADMIN (EVD-2026-0092, BR-061) |
| US-023-Q3 | ¿Qué validaciones aplican al código del motivo (único, formato)? | Jefe de Ingeniería | Baja | No | Abierta |
| US-023-Q2 | ¿Cuáles son los valores iniciales del codificador y puede retirarse un motivo ya usado? (G-33) | Jefe de Ingeniería | Media | No | Cerrada: parte sin ningún valor y no se puede retirar un motivo usado (EVD-2026-0096, BR-067) |

## 13. Evidencia y trazabilidad

| ID | Hallazgo | Fuente | Clasificación | Confianza |
|---|---|---|---|---|
| EVD-2026-0064 | Si el colaborador no cumple el nivel mínimo, la asignación queda pendiente hasta que el Jefe de Ingeniería apruebe la excepción. Se registra el motivo, tomado de un codificador prestablecido (código y descripción), y quién aprobó | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L159 | decision | high |
| EVD-2026-0075 | Debe existir una funcionalidad para mantener el codificador de motivos de excepción | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L170 | decision | high |
| EVD-2026-0092 | Productos, proyectos y codificadores los mantiene el Jefe de Ingeniería o un ADMIN. Los roles de usuario son ADMIN, Instructor y Jefe de Ingeniería. Los demás roles son puestos de la organización | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L187 | decision | high |
| EVD-2026-0096 | El codificador de motivos parte vacío, lo mantiene el Jefe de Ingeniería o un ADMIN y no se retira un motivo usado | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L191 | decision | high |

Evidencia compartida: `source_type: human`, `observed_at: 2026-10-10T12:00:00-05:00`, `freshness: current`, `owner: Jefe de Ingeniería`.

- **Upstream:** [BRC-001](../../business/rules/BRC-001-reglas-de-negocio-portal-curricula.md), [IMD-001](../../business/information-model/IMD-001-portal-curricula.md), [GLS-001](../../business/glossary/GLS-001-glosario-de-negocio.md) y [RCP-001](../context-packs/RCP-001-portal-gestion-curricula-desarrollo.md), todos en estado `draft`.
- **Downstream (pendiente):** UXR → FLW → SCR → CMP → AC

## 14. Evaluación INVEST

| Criterio | ¿Cumple? | Justificación |
|---|---|---|
| Independiente | Sí | No depende de otra historia. |
| Negociable | Parcial | La validación del código queda abierta (US-023-Q3). |
| Valiosa | Sí | Un codificador uniforme de motivos. |
| Estimable | Sí | Alcance y actor definidos. |
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
- **Motivo:** Actor y valor sostenidos por BR-061, BR-053 y BR-067. US-023-Q1 y US-023-Q2 quedaron cerradas. US-023-Q3 no bloquea.
- **Bloqueos de entrega:** Ninguno
- **Propuesta de división (si no es pequeña):** No aplica
- **Siguiente rol o Skill:** `ux-requirements-analyzer`
- **Decisión humana requerida:** El Jefe de Ingeniería valida la historia.
- **Validación:** Pendiente · Responsable: Jefe de Ingeniería · Fecha: —
