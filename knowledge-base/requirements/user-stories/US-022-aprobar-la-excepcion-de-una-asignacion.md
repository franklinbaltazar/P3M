---
type: User Story
title: "US-022 — Aprobar la excepción de una asignación"
description: "Como Jefe de Ingeniería, quiero aprobar la excepción de una asignación Pendiente, registrando el motivo, para asignar a un colaborador aunque no alcance el nivel mínimo, con trazabilidad."
tags: [user-story, por-definir, asignacion, excepcion]
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
gitlab_issue_id: 52933
gitlab_issue_iid: 23
gitlab_issue_url: https://project.comsatel.com.pe/comsatel/development/training/dev-juniors/p3m/collaboration/-/issues/23
---

# US-022 — Aprobar la excepción de una asignación

## 1. Ficha

| Campo | Valor |
|---|---|
| ID | US-022 |
| Épica / capacidad | Portafolio y asignación (IMD-001, bloque 4) |
| Horizonte / release | Por definir |
| Actor | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) o [ADMIN](../../business/glossary/terms/TRM-0028-admin.md) |
| Responsable de negocio (PO) | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) (responsable funcional del portal, /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L109) |
| Prioridad | Must: sin ella las asignaciones Pendientes quedan detenidas. La decide el PO. |
| Dependencias | US-021, US-023 |
| Preparación | READY |

## 2. Historia

**Como** Jefe de Ingeniería o usuario con perfil ADMIN, **quiero** aprobar la excepción de una asignación Pendiente, registrando el motivo, **para** asignar a un colaborador aunque no alcance el nivel mínimo, con trazabilidad.

## 3. Contexto y valor

- **Problema que resuelve:** Solo el Jefe de Ingeniería o el ADMIN aprueba la excepción. Se registran el motivo, tomado de un codificador prestablecido, y quién aprobó (BR-006, BR-042, BR-043).
- **Valor esperado:** Excepciones controladas y trazables.
- **Métrica o KPI que impacta:** Sin métrica asociada

## 4. Alcance

- **Incluye:**
  - Aprobar la excepción de una asignación Pendiente.
  - Registrar el motivo del codificador y quién aprobó.
- **Excluye:**
  - Mantener el codificador (US-023).
  - Rechazo de la excepción (G-33).

## 5. Criterios de aceptación

### AC-1 — Aprobar la excepción

```gherkin
Escenario: Aprobar la excepción
  Dado una asignación Pendiente porque el colaborador no alcanza el nivel mínimo
  Cuando el Jefe de Ingeniería aprueba la excepción eligiendo un motivo del codificador
  Entonces la asignación deja de estar Pendiente y queda registrado el motivo y quién la aprobó
```

- **Regla / fuente:** BR-006, BR-042, BR-043

### AC-2 — Solo el Jefe de Ingeniería o el ADMIN lo define

```gherkin
Escenario: Solo el Jefe de Ingeniería o el ADMIN lo define
  Dado que el usuario está autenticado y no es el Jefe de Ingeniería ni un ADMIN
  Cuando intenta aprobar una excepción de asignación
  Entonces el portal no permite la acción
```

- **Regla / fuente:** BR-006, BR-134

## 6. Casos negativos y límite

| Caso | Comportamiento esperado | Fuente o pregunta |
|---|---|---|
| Usuario que no es el Jefe de Ingeniería ni un ADMIN | No aprueba excepciones | BR-006, BR-134 |
| Aprobar sin elegir un motivo | Sin regla | G-33 |
| Rechazar la excepción y otros estados de la asignación | Sin regla | G-33 |

## 7. Reglas de negocio aplicables

| ID | Regla | Fuente |
|---|---|---|
| BR-006 | Solo el Jefe de Ingeniería aprueba una excepción de asignación. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L46 |
| BR-042 | Si el colaborador no cumple el nivel mínimo, el portal advierte y la asignación queda Pendiente hasta que el Jefe de Ingeniería apruebe la excepción. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L82 |
| BR-043 | De una excepción de asignación se registran el motivo, tomado de un codificador prestablecido (código y descripción), y quién la aprobó. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L83 |
| BR-134 | El ADMIN puede hacer también las seis capacidades que eran exclusivas del Jefe de Ingeniería (BR-005, BR-006, BR-007, BR-055, BR-083, BR-129). | /business/rules\BRC-001-reglas-de-negocio-portal-curricula.md:L174 |

## 8. Datos y términos

| Término | Uso en esta historia | Glosario |
|---|---|---|
| Excepción de asignación | Elemento que se aprueba | [Excepción de asignación](../../business/glossary/terms/TRM-0035-excepcion-de-asignacion.md) |
| Motivo de excepción | Dato que se registra | [Motivo de excepción](../../business/glossary/terms/TRM-0039-motivo-de-excepcion.md) |
| Asignación | Asignación Pendiente | [Asignación](../../business/glossary/terms/TRM-0034-asignacion.md) |
| Jefe de Ingeniería | Actor | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) |
| ADMIN | Actor; suple al Jefe de Ingeniería (BR-134) | [ADMIN](../../business/glossary/terms/TRM-0028-admin.md) |

## 9. Requisitos no funcionales

- **Accesibilidad:** WCAG 2.2 AA (estándar del repositorio).
- **Privacidad y datos personales:** Toca la identidad de colaboradores. Restricción: BR-003 y la política pendiente G-12.
- **Otros:** Auditoría: se registran motivo y aprobador (BR-043).

## 10. Consideraciones de UX

- **Flujo esperado:** El Jefe de Ingeniería abre una asignación Pendiente, elige el motivo y aprueba.
- **Estados de la interfaz:** Sin asignaciones pendientes, sin permisos, error, éxito.
- **Contenido clave:** Competencias que no cumplen, motivos del codificador y aprobador.

## 11. Dependencias, supuestos e hipótesis

- **Depende de:** US-021 (asignación Pendiente) y US-023 (codificador de motivos).
- **Es prerrequisito de:** —
- **Supuestos:** Ninguno
- **Hipótesis del agente:** Ninguna

## 12. Preguntas abiertas

| ID | Pregunta | Responsable | Prioridad | Bloquea | Estado |
|---|---|---|---|---|---|
| G-33 | ¿Qué pasa si se rechaza la excepción, qué otros estados tiene la asignación y quién mantiene el codificador? | Jefe de Ingeniería | Media | No | Abierta |

## 13. Evidencia y trazabilidad

| ID | Hallazgo | Fuente | Clasificación | Confianza |
|---|---|---|---|---|
| EVD-2026-0028 | El nivel mínimo de competencia para asignar es N2 (en desarrollo). Reemplaza el N1 de S-05. El N2 fue solo un ejemplo (E-63). Si no se cumple, el portal advierte, y la excepción consiste en que la aprueba el Jefe de Ingeniería, único que puede hacerlo | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L123 | decision | high |
| EVD-2026-0064 | Si el colaborador no cumple el nivel mínimo, la asignación queda pendiente hasta que el Jefe de Ingeniería apruebe la excepción. Se registra el motivo, tomado de un codificador prestablecido (código y descripción), y quién aprobó | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L159 | decision | high |
| EVD-2026-0075 | Debe existir una funcionalidad para mantener el codificador de motivos de excepción | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L170 | decision | high |
| EVD-2026-0173 | El ADMIN suple las seis capacidades exclusivas del Jefe de Ingeniería | /requirements/context-packs\RCP-001-portal-gestion-curricula-desarrollo.md:L572 | decision | high |

Evidencia compartida: `source_type: human`, `observed_at: 2026-10-10T12:00:00-05:00`, `freshness: current`, `owner: Jefe de Ingeniería`.

- **Upstream:** [BRC-001](../../business/rules/BRC-001-reglas-de-negocio-portal-curricula.md), [IMD-001](../../business/information-model/IMD-001-portal-curricula.md), [GLS-001](../../business/glossary/GLS-001-glosario-de-negocio.md) y [RCP-001](../context-packs/RCP-001-portal-gestion-curricula-desarrollo.md), todos en estado `draft`.
- **Downstream (pendiente):** UXR → FLW → SCR → CMP → AC

## 14. Evaluación INVEST

| Criterio | ¿Cumple? | Justificación |
|---|---|---|
| Independiente | Parcial | Necesita US-021 y US-023. |
| Negociable | Parcial | Rechazo y estados abiertos (G-33). |
| Valiosa | Sí | Excepciones controladas y trazables. |
| Estimable | Sí | Alcance acotado. |
| Pequeña (Small) | Sí | Cabe en una iteración. |
| Testeable | Sí | El criterio es verificable. |

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
- **Motivo:** Actor, valor y criterio sostenidos por BR-134, BR-006, BR-042 y BR-043. La pregunta abierta no bloquea.
- **Bloqueos de entrega:** Ninguno
- **Propuesta de división (si no es pequeña):** No aplica
- **Siguiente rol o Skill:** `ux-requirements-analyzer`
- **Decisión humana requerida:** El Jefe de Ingeniería valida la historia y responde G-33.
- **Validación:** Pendiente · Responsable: Jefe de Ingeniería · Fecha: —
