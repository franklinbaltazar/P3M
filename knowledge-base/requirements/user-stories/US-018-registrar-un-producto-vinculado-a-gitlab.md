---
type: User Story
title: "US-018 — Registrar un producto y vincularlo a un proyecto de GitLab"
description: "Como Jefe de Ingeniería, quiero registrar un producto con su código y nombre y vincularlo a un proyecto de GitLab mediante su project_id, para gestionar el portafolio de software y traer de GitLab sus milestones e issues."
tags: [user-story, por-definir, portafolio, gitlab]
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
gitlab_issue_id: 52929
gitlab_issue_iid: 19
gitlab_issue_url: https://project.comsatel.com.pe/comsatel/development/training/dev-juniors/p3m/collaboration/-/issues/19
---

# US-018 — Registrar un producto y vincularlo a un proyecto de GitLab

## 1. Ficha

| Campo | Valor |
|---|---|
| ID | US-018 |
| Épica / capacidad | Portafolio y asignación (IMD-001, bloque 4) |
| Horizonte / release | Por definir |
| Actor | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) o [ADMIN](../../business/glossary/terms/TRM-0028-admin.md) (BR-061) |
| Responsable de negocio (PO) | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) (responsable funcional del portal, /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L109) |
| Prioridad | Must: sin productos no hay proyectos ni asignaciones. La decide el PO. |
| Dependencias | — |
| Preparación | READY |

## 2. Historia

**Como** Jefe de Ingeniería, **quiero** registrar un producto con su código y nombre y vincularlo a un proyecto de GitLab mediante su project_id, **para** gestionar el portafolio de software y traer de GitLab sus milestones e issues.

## 3. Contexto y valor

- **Problema que resuelve:** Un producto es software que desarrollan los colaboradores, con código y nombre, y se vincula a un proyecto de GitLab por su project_id (BR-032).
- **Valor esperado:** Portafolio de productos vinculado a GitLab.
- **Métrica o KPI que impacta:** Sin métrica asociada

## 4. Alcance

- **Incluye:**
  - Registrar y modificar un producto con código, nombre y project_id.
- **Excluye:**
  - Registrar proyectos (US-019).
  - Visualizar milestones e issues (US-020).

## 5. Criterios de aceptación

### AC-1 — Registrar un producto

```gherkin
Escenario: Registrar un producto
  Dado un Jefe de Ingeniería o un ADMIN
  Cuando registra un producto con código, nombre y project_id de GitLab
  Entonces el producto queda registrado y vinculado a ese proyecto de GitLab
```

- **Regla / fuente:** BR-032

## 6. Casos negativos y límite

| Caso | Comportamiento esperado | Fuente o pregunta |
|---|---|---|
| Usuario que no es Jefe de Ingeniería ni ADMIN | No puede mantenerlo | BR-061 |
| project_id inexistente o ya vinculado a otro producto | Sin regla | US-018-Q2 |
| Producto con código repetido | Sin regla | US-018-Q2 |

## 7. Reglas de negocio aplicables

| ID | Regla | Fuente |
|---|---|---|
| BR-032 | Un producto es software desarrollado por los colaboradores, con código y nombre, y se vincula a un proyecto de GitLab mediante su project_id. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L72 |
| BR-061 | Los productos, los proyectos y el codificador de motivos de excepción los mantiene el Jefe de Ingeniería o un colaborador con rol de usuario ADMIN. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L101 |

## 8. Datos y términos

| Término | Uso en esta historia | Glosario |
|---|---|---|
| Producto | Elemento que se registra | [Producto](../../business/glossary/terms/TRM-0029-producto.md) |
| GitLab | Sistema vinculado | [GitLab](../../business/glossary/terms/TRM-0036-gitlab.md) |

## 9. Requisitos no funcionales

- **Accesibilidad:** WCAG 2.2 AA (estándar del repositorio).
- **Privacidad y datos personales:** No aplica: la historia no toca datos personales.
- **Otros:** Sin requisito identificado

## 10. Consideraciones de UX

- **Flujo esperado:** El actor registra el producto con su código, nombre y project_id.
- **Estados de la interfaz:** Vacío, sin permisos, error de validación, éxito.
- **Contenido clave:** Código, nombre y vínculo con GitLab.

## 11. Dependencias, supuestos e hipótesis

- **Depende de:** Acceso de solo lectura a GitLab (BR-037).
- **Es prerrequisito de:** US-019, US-020
- **Supuestos:** Ninguno
- **Hipótesis del agente:** Ninguna

## 12. Preguntas abiertas

| ID | Pregunta | Responsable | Prioridad | Bloquea | Estado |
|---|---|---|---|---|---|
| US-018-Q1 | ¿Quién registra y mantiene los productos, los proyectos y su vínculo con GitLab? | Jefe de Ingeniería | Alta | No | Cerrada: el Jefe de Ingeniería o un ADMIN (EVD-2026-0092, BR-061) |
| US-018-Q2 | ¿Qué validaciones tiene el vínculo (project_id existente, único) y cómo se garantiza el acceso de solo lectura? | Arquitectura | Media | No | Abierta |

## 13. Evidencia y trazabilidad

| ID | Hallazgo | Fuente | Clasificación | Confianza |
|---|---|---|---|---|
| EVD-2026-0023 | Un producto es software desarrollado por los colaboradores. Se conoce su código y nombre | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L118 | decision | high |
| EVD-2026-0030 | Un producto se vincula a un proyecto de GitLab mediante su `project_id`. En ese proyecto, los issues con label `UserStory` representan user stories y hay milestones | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L125 | decision | high |
| EVD-2026-0092 | Productos, proyectos y codificadores los mantiene el Jefe de Ingeniería o un ADMIN. Los roles de usuario son ADMIN, Instructor y Jefe de Ingeniería. Los demás roles son puestos de la organización | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L187 | decision | high |

Evidencia compartida: `source_type: human`, `observed_at: 2026-10-10T12:00:00-05:00`, `freshness: current`, `owner: Jefe de Ingeniería`.

- **Upstream:** [BRC-001](../../business/rules/BRC-001-reglas-de-negocio-portal-curricula.md), [IMD-001](../../business/information-model/IMD-001-portal-curricula.md), [GLS-001](../../business/glossary/GLS-001-glosario-de-negocio.md) y [RCP-001](../context-packs/RCP-001-portal-gestion-curricula-desarrollo.md), todos en estado `draft`.
- **Downstream (pendiente):** UXR → FLW → SCR → CMP → AC

## 14. Evaluación INVEST

| Criterio | ¿Cumple? | Justificación |
|---|---|---|
| Independiente | Sí | No depende de otra historia. |
| Negociable | Parcial | Las validaciones del vínculo quedan abiertas. |
| Valiosa | Sí | Portafolio de productos vinculado a GitLab. |
| Estimable | Sí | Alcance y actor definidos. |
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
- **Motivo:** Actor y valor sostenidos por BR-061 y BR-032. US-018-Q1 quedó cerrada. US-018-Q2 no bloquea.
- **Bloqueos de entrega:** Ninguno
- **Propuesta de división (si no es pequeña):** No aplica
- **Siguiente rol o Skill:** `ux-requirements-analyzer`
- **Decisión humana requerida:** El Jefe de Ingeniería valida la historia.
- **Validación:** Pendiente · Responsable: Jefe de Ingeniería · Fecha: —
