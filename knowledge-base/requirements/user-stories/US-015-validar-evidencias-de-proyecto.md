---
type: User Story
title: "US-015 — Validar las evidencias de proyecto"
description: "Como Jefe de proyecto, quiero validar las evidencias de proyecto que aportan los colaboradores de mi proyecto, para dejar constancia de su trabajo para sustentar su progresión."
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
gitlab_issue_id: 52926
gitlab_issue_iid: 16
gitlab_issue_url: https://project.comsatel.com.pe/comsatel/development/training/dev-juniors/p3m/collaboration/-/issues/16
---

# US-015 — Validar las evidencias de proyecto

## 1. Ficha

| Campo | Valor |
|---|---|
| ID | US-015 |
| Épica / capacidad | Progresión (IMD-001, bloque 3) |
| Horizonte / release | Por definir |
| Actor | [Jefe de proyecto](../../business/glossary/terms/TRM-0027-jefe-de-proyecto.md) |
| Responsable de negocio (PO) | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) (responsable funcional del portal, /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L109) |
| Prioridad | Must: sin validación la evidencia de proyecto no sustenta una promoción. La decide el PO. |
| Dependencias | US-014 |
| Preparación | READY |

## 2. Historia

**Como** Jefe de proyecto, **quiero** validar las evidencias de proyecto que aportan los colaboradores de mi proyecto, **para** dejar constancia de su trabajo para sustentar su progresión.

## 3. Contexto y valor

- **Problema que resuelve:** El jefe de proyecto valida las evidencias de proyecto, que están Pendientes o Validadas (BR-010, BR-019).
- **Valor esperado:** Evidencias de proyecto validadas por quien conoce el trabajo.
- **Métrica o KPI que impacta:** Sin métrica asociada

## 4. Alcance

- **Incluye:**
  - Validar una evidencia de proyecto Pendiente de su proyecto.
  - Consultar las evidencias Pendientes.
- **Excluye:**
  - Aportar evidencias (US-014).
  - Rechazo o reversión (US-011-Q2).

## 5. Criterios de aceptación

### AC-1 — Validar una evidencia de proyecto

```gherkin
Escenario: Validar una evidencia de proyecto
  Dado una evidencia de proyecto Pendiente de un proyecto del que el actor es jefe
  Cuando la valida
  Entonces la evidencia queda Validada
```

- **Regla / fuente:** BR-010, BR-019

### AC-2 — Solo valida el jefe del proyecto

```gherkin
Escenario: Solo valida el jefe del proyecto
  Dado una evidencia de un proyecto del que el usuario no es jefe de proyecto
  Cuando intenta validarla
  Entonces el portal no lo permite
```

- **Regla / fuente:** BR-010

## 6. Casos negativos y límite

| Caso | Comportamiento esperado | Fuente o pregunta |
|---|---|---|
| Usuario que no es jefe de ese proyecto | No puede validar | BR-010 |
| Evidencia ya Validada, o rechazo | Sin regla | US-011-Q2 |
| Cómo se identifica al jefe de proyecto | Se registra en el portal como colaborador con el rol Jefe de Proyecto, con vigencia desde y hasta | BR-063 |

## 7. Reglas de negocio aplicables

| ID | Regla | Fuente |
|---|---|---|
| BR-010 | El jefe de proyecto, que es un colaborador asignado al proyecto, valida las evidencias de proyecto. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L50 |
| BR-019 | Una evidencia aportada está en estado Pendiente o Validada. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L59 |
| BR-063 | El jefe de proyecto se registra en el portal al gestionar los proyectos de un producto: es un colaborador con el rol Jefe de Proyecto, con historial de cambios y vigencia desde y hasta. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L103 |

## 8. Datos y términos

| Término | Uso en esta historia | Glosario |
|---|---|---|
| Jefe de proyecto | Actor | [Jefe de proyecto](../../business/glossary/terms/TRM-0027-jefe-de-proyecto.md) |
| Evidencia de proyecto | Elemento que se valida | [Evidencia de proyecto](../../business/glossary/terms/TRM-0018-evidencia-de-proyecto.md) |
| Estado de evidencia | Pendiente o Validada | [Estado de evidencia](../../business/glossary/terms/TRM-0021-estado-de-evidencia.md) |

## 9. Requisitos no funcionales

- **Accesibilidad:** WCAG 2.2 AA (estándar del repositorio).
- **Privacidad y datos personales:** Toca la identidad de colaboradores. Restricción: BR-003 y la política pendiente G-12.
- **Otros:** Sin requisito identificado

## 10. Consideraciones de UX

- **Flujo esperado:** El jefe de proyecto consulta las evidencias Pendientes de su proyecto y valida las que corresponden.
- **Estados de la interfaz:** Sin pendientes, sin permisos, error, éxito.
- **Contenido clave:** Colaborador, issue referenciado y estado.

## 11. Dependencias, supuestos e hipótesis

- **Depende de:** US-014 y el registro del jefe de proyecto (US-019, BR-063).
- **Es prerrequisito de:** US-017
- **Supuestos:** S-1: el jefe de proyecto es un colaborador asignado al proyecto (EVD-2026-0069).
- **Hipótesis del agente:** Ninguna

## 12. Preguntas abiertas

| ID | Pregunta | Responsable | Prioridad | Bloquea | Estado |
|---|---|---|---|---|---|
| G-14 | ¿Cómo se identifica al jefe de proyecto de cada proyecto y cómo llega al portal? | Jefe de Ingeniería | Alta | No | Cerrada: se registra en el portal, con historial y vigencia (EVD-2026-0091, BR-063) |
| US-011-Q2 | ¿Una evidencia puede rechazarse o volver de Validada a Pendiente? | Jefe de Ingeniería | Media | No | Abierta |

## 13. Evidencia y trazabilidad

| ID | Hallazgo | Fuente | Clasificación | Confianza |
|---|---|---|---|---|
| EVD-2026-0056 | El jefe de proyecto aprueba (valida) las evidencias del proyecto | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L151 | decision | high |
| EVD-2026-0055 | Los estados de una evidencia son Pendiente y Validada | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L150 | decision | high |
| EVD-2026-0069 | El jefe de proyecto es un colaborador asignado a ese proyecto | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L164 | decision | high |
| EVD-2026-0018 | La certificación es una forma de evidencia del logro de una competencia de un rol/nivel. La aprueba el instructor del curso. Si la evidencia es una tarea o entregable de un proyecto donde participa el colaborador, la aprueba el jefe de proyecto | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L113 | decision | high |
| EVD-2026-0091 | La gestión de los proyectos de un producto registra a un colaborador con el rol Jefe de Proyecto, con historial de cambios y vigencia desde y hasta | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L186 | decision | high |

Evidencia compartida: `source_type: human`, `observed_at: 2026-10-10T12:00:00-05:00`, `freshness: current`, `owner: Jefe de Ingeniería`.

- **Upstream:** [BRC-001](../../business/rules/BRC-001-reglas-de-negocio-portal-curricula.md), [IMD-001](../../business/information-model/IMD-001-portal-curricula.md), [GLS-001](../../business/glossary/GLS-001-glosario-de-negocio.md) y [RCP-001](../context-packs/RCP-001-portal-gestion-curricula-desarrollo.md), todos en estado `draft`.
- **Downstream (pendiente):** UXR → FLW → SCR → CMP → AC

## 14. Evaluación INVEST

| Criterio | ¿Cumple? | Justificación |
|---|---|---|
| Independiente | Parcial | Necesita US-014. |
| Negociable | Parcial | Rechazo y reversión abiertos (US-011-Q2). |
| Valiosa | Sí | Evidencias de proyecto validadas por quien conoce el trabajo. |
| Estimable | Sí | Alcance y actor definidos. |
| Pequeña (Small) | Sí | Cabe en una iteración. |
| Testeable | Sí | Los 2 criterios son verificables. |

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
- **Motivo:** Actor, valor y permiso sostenidos: el jefe de proyecto se registra con vigencia (BR-063). G-14 quedó cerrada.
- **Bloqueos de entrega:** Ninguno
- **Propuesta de división (si no es pequeña):** No aplica
- **Siguiente rol o Skill:** `ux-requirements-analyzer`
- **Decisión humana requerida:** El Jefe de Ingeniería valida la historia.
- **Validación:** Pendiente · Responsable: Jefe de Ingeniería · Fecha: —
