---
type: User Story
title: "US-019 — Registrar un proyecto de un producto con sus milestones"
description: "Como Jefe de Ingeniería, quiero registrar un proyecto de un producto, con sus estimaciones, seleccionando entre los milestones registrados los que le corresponden, para organizar el trabajo de cada producto y poder asignar colaboradores."
tags: [user-story, por-definir, portafolio, gitlab]
status: approved
generated:
  by: "af-user-story-refiner/2.0"
  at: "2026-10-12T01:30:00-05:00"
verified:
  by: "ianache (Functional Analysis)"
  at: "2026-10-12T09:00:00-05:00"
sources:
  - id: brc-001
    resource: /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md
  - id: rcp-001
    resource: /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md
  - id: gls-001
    resource: /business/glossary/GLS-001-glosario-de-negocio.md
  - id: imd-001
    resource: /business/information-model/IMD-001-portal-curricula.md
gitlab_issue_id: 52930
gitlab_issue_iid: 20
gitlab_issue_url: https://project.comsatel.com.pe/comsatel/development/training/dev-juniors/p3m/collaboration/-/issues/20
---

# US-019 — Registrar un proyecto de un producto con sus milestones

## 1. Ficha

| Campo | Valor |
|---|---|
| ID | US-019 |
| Épica / capacidad | Portafolio y asignación (IMD-001, bloque 4) |
| Horizonte / release | Por definir |
| Actor | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) o [ADMIN](../../business/glossary/terms/TRM-0028-admin.md) (BR-061) |
| Responsable de negocio (PO) | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) (responsable funcional del portal, /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L109) |
| Prioridad | Must: los proyectos reciben colaboradores asignados. La decide el PO. |
| Dependencias | US-018 |
| Preparación | READY |

## 2. Historia

**Como** Jefe de Ingeniería, **quiero** registrar un proyecto de un producto, con sus estimaciones, seleccionando entre los milestones registrados los que le corresponden, **para** organizar el trabajo de cada producto y poder asignar colaboradores.

## 3. Contexto y valor

- **Problema que resuelve:** Un proyecto tiene código, nombre, fechas, costo y esfuerzo estimados, pertenece a un solo producto y es un conjunto de milestones que el usuario selecciona (BR-033, BR-034, BR-048).
- **Valor esperado:** Proyectos registrados, vinculados a sus milestones de GitLab.
- **Métrica o KPI que impacta:** Sin métrica asociada

## 4. Alcance

- **Incluye:**
  - Registrar y modificar un proyecto de un producto.
  - Seleccionar los milestones que lo componen.
  - Indicar los roles/niveles que requiere, con cantidades. Lo hace un usuario con rol Jefe de Ingeniería o ADMIN (BR-109).
- **Excluye:**
  - Asignar colaboradores (US-021).
  - Visualizar la ejecución (US-020).

## 5. Criterios de aceptación

### AC-1 — Registrar un proyecto

```gherkin
Escenario: Registrar un proyecto
  Dado un producto registrado
  Cuando se registra un proyecto con código, nombre, fechas estimadas de inicio y fin, costo estimado en soles peruanos y esfuerzo estimado en horas-persona
  Entonces el proyecto queda registrado bajo ese producto
```

- **Regla / fuente:** BR-033, BR-048, BR-127

### AC-2 — Seleccionar milestones

```gherkin
Escenario: Seleccionar milestones
  Dado los milestones registrados del producto
  Cuando se seleccionan los que corresponden al proyecto
  Entonces el proyecto queda compuesto por esos milestones
```

- **Regla / fuente:** BR-034

### AC-3 — Roles/niveles requeridos con cantidades

```gherkin
Escenario: Roles/niveles requeridos con cantidades
  Dado un proyecto registrado
  Cuando el Jefe de Ingeniería o un ADMIN indica varios roles/niveles con cantidades
  Entonces el proyecto requiere esos roles/niveles y cantidades
```

- **Regla / fuente:** BR-046, BR-109

### AC-4 — Registrar el jefe de proyecto

```gherkin
Escenario: Registrar el jefe de proyecto con su vigencia
  Dado un Jefe de Ingeniería o un ADMIN que gestiona los proyectos de un producto
  Cuando registra a un colaborador con el rol Jefe de Proyecto en un proyecto, con vigencia desde y hasta
  Entonces el portal conserva el historial de cambios de jefe de proyecto de ese proyecto y el proyecto tiene un solo jefe de proyecto vigente
```

- **Regla / fuente:** BR-063, BR-102

## 6. Casos negativos y límite

| Caso | Comportamiento esperado | Fuente o pregunta |
|---|---|---|
| Usuario que no es Jefe de Ingeniería ni ADMIN | No puede mantenerlo | BR-061 |
| Proyecto sin producto | No es válido: pertenece a un solo producto | BR-048 |
| Milestone ya usado en otro proyecto | No se puede seleccionar: un milestone pertenece a un único proyecto | BR-091 |
| Quién define los roles/niveles requeridos | Un usuario con rol Jefe de Ingeniería o ADMIN. El jefe de proyecto designado ya no los registra por sí solo (se confirma en RQ-32) | BR-109 |
| Segundo jefe de proyecto vigente en el mismo proyecto | No es válido: solo hay uno vigente | BR-102 |
| Un colaborador como jefe de varios proyectos | Es válido | BR-102 |
| Costo en otra moneda o esfuerzo en otra unidad | Sin regla: el costo está en soles peruanos y el esfuerzo en horas-persona | BR-127 |

## 7. Reglas de negocio aplicables

| ID | Regla | Fuente |
|---|---|---|
| BR-033 | Un proyecto tiene código, nombre, fechas estimadas de inicio y fin, costo estimado y esfuerzo estimado, y pertenece a un solo producto. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L73 |
| BR-034 | Un proyecto es un conjunto de milestones. Al registrarlo, el usuario selecciona entre los milestones registrados los que le corresponden. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L74 |
| BR-046 | Un proyecto puede requerir varios roles/niveles, con cantidades. Quién los define: BR-109 (antes los registraba el Jefe de Proyecto designado, EVD-2026-0121). | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L86 |
| BR-109 | Los roles/niveles que requiere un proyecto, con sus cantidades, los define cualquier usuario con rol de usuario Jefe de Ingeniería o ADMIN. Reemplaza la segunda frase de BR-046. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L149 |
| BR-048 | Un proyecto pertenece a un solo producto, y un producto puede tener varios proyectos. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L88 |
| BR-061 | Los productos, los proyectos y el codificador de motivos de excepción los mantiene el Jefe de Ingeniería o un colaborador con rol de usuario ADMIN. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L101 |
| BR-063 | El jefe de proyecto se registra en el portal al gestionar los proyectos de un producto: es un colaborador con el rol Jefe de Proyecto, con historial de cambios y vigencia desde y hasta. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L103 |
| BR-102 | Un proyecto tiene jefes de proyecto a lo largo del tiempo, con vigencia desde y hasta, pero solo uno vigente a la vez. Un colaborador puede ser jefe de varios proyectos. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L142 |
| BR-091 | Un milestone pertenece a un único proyecto. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L131 |
| BR-127 | El costo estimado de un proyecto se expresa en soles peruanos (PEN) y el esfuerzo estimado en horas-persona. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L167 |

## 8. Datos y términos

| Término | Uso en esta historia | Glosario |
|---|---|---|
| Proyecto | Elemento que se registra | [Proyecto](../../business/glossary/terms/TRM-0030-proyecto.md) |
| Producto | Dueño del proyecto | [Producto](../../business/glossary/terms/TRM-0029-producto.md) |
| Sprint | Milestone seleccionado | [Sprint](../../business/glossary/terms/TRM-0031-sprint.md) |
| Rol/nivel | Requerido por el proyecto | [Rol/nivel](../../business/glossary/terms/TRM-0006-rol-nivel.md) |

## 9. Requisitos no funcionales

- **Accesibilidad:** WCAG 2.2 AA (estándar del repositorio).
- **Privacidad y datos personales:** Toca al colaborador designado como jefe de proyecto. Los datos personales se retienen por siempre (BR-101); la política aplicable está aplazada como deuda técnica DT-01 (RQ-34).
- **Otros:** Sin requisito identificado

## 10. Consideraciones de UX

- **Flujo esperado:** El actor elige un producto, registra el proyecto y selecciona sus milestones y los roles/niveles que requiere.
- **Estados de la interfaz:** Sin milestones, sin permisos, error, éxito.
- **Contenido clave:** Datos del proyecto, milestones disponibles y roles/niveles con cantidades.

## 11. Dependencias, supuestos e hipótesis

- **Depende de:** US-018 (producto) y los milestones sincronizados de GitLab.
- **Es prerrequisito de:** US-020, US-021
- **Supuestos:** Ninguno
- **Hipótesis del agente:** Ninguna

## 12. Preguntas abiertas

| ID | Pregunta | Responsable | Prioridad | Bloquea | Estado |
|---|---|---|---|---|---|
| US-018-Q1 | ¿Quién registra y mantiene los productos, los proyectos y su vínculo con GitLab? | Jefe de Ingeniería | Alta | No | Cerrada: el Jefe de Ingeniería o un ADMIN (EVD-2026-0092, BR-061) |
| G-27 | ¿Un milestone puede pertenecer a más de un proyecto? | Jefe de Ingeniería | Baja | No | Cerrada: a un único proyecto (EVD-2026-0131, BR-091) |
| G-28 | ¿El Jefe de Ingeniería también define los roles/niveles y cantidades que requiere cada proyecto? | Jefe de Ingeniería | Baja | No | Cerrada: sí, el Jefe de Ingeniería o un ADMIN los define (EVD-2026-0149, BR-109); reemplaza a EVD-2026-0121 |
| RQ-32 | ¿El jefe de proyecto conserva algún permiso para registrar los roles/niveles que requiere su proyecto, o solo el Jefe de Ingeniería y el ADMIN? | Jefe de Ingeniería | Media | No | Abierta |

## 13. Evidencia y trazabilidad

| ID | Hallazgo | Fuente | Clasificación | Confianza |
|---|---|---|---|---|
| EVD-2026-0024 | De un proyecto se conoce: código, nombre, fechas estimadas de inicio y fin, costo estimado, esfuerzo estimado y alcance (conjunto de user stories) | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L119 | decision | high |
| EVD-2026-0036 | Un proyecto es un conjunto de milestones | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L131 | decision | high |
| EVD-2026-0043 | Al registrar un proyecto de un producto, el usuario selecciona entre los milestones registrados cuáles le corresponden | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L138 | decision | high |
| EVD-2026-0071 | Un proyecto pertenece a un solo producto (relación Producto–Proyecto de 1 a N) | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L166 | decision | high |
| EVD-2026-0066 | Un proyecto puede requerir varios roles/niveles con cantidades | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L161 | decision | high |
| EVD-2026-0092 | Productos, proyectos y codificadores los mantiene el Jefe de Ingeniería o un ADMIN. Los roles de usuario son ADMIN, Instructor y Jefe de Ingeniería. Los demás roles son puestos de la organización | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L187 | decision | high |
| EVD-2026-0091 | La gestión de los proyectos de un producto registra a un colaborador con el rol Jefe de Proyecto, con historial de cambios y vigencia desde y hasta | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L186 | decision | high |
| EVD-2026-0121 | Los roles/niveles y cantidades que requiere un proyecto los registra el Jefe de Proyecto designado. **Reemplazada por EVD-2026-0149** | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L506 | decision | high |
| EVD-2026-0131 | Un milestone pertenece a un único proyecto | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L516 | decision | high |
| EVD-2026-0144 | Un proyecto tiene un solo jefe de proyecto vigente; puede haber varios a lo largo del tiempo | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L541 | decision | high |
| EVD-2026-0149 | Los roles/niveles requeridos los define el Jefe de Ingeniería o un ADMIN | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L546 | decision | high |
| EVD-2026-0166 | El costo estimado de un proyecto se expresa en soles peruanos (PEN) y el esfuerzo estimado en horas-persona | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L563 | decision | high |

Evidencia compartida: `source_type: human`, `observed_at: 2026-10-10T12:00:00-05:00`, `freshness: current`, `owner: Jefe de Ingeniería`. Las evidencias EVD-2026-0143 a EVD-2026-0169 se observaron el 2026-10-11T00:00:00Z.

- **Upstream:** [BRC-001](../../business/rules/BRC-001-reglas-de-negocio-portal-curricula.md), [IMD-001](../../business/information-model/IMD-001-portal-curricula.md), [GLS-001](../../business/glossary/GLS-001-glosario-de-negocio.md) y [RCP-001](../context-packs/RCP-001-portal-gestion-curricula-desarrollo.md), todos en estado `draft`.
- **Downstream (pendiente):** UXR → FLW → SCR → CMP → AC

## 14. Evaluación INVEST

| Criterio | ¿Cumple? | Justificación |
|---|---|---|
| Independiente | Parcial | Necesita US-018. |
| Negociable | Parcial | Sin preguntas abiertas que condicionen el comportamiento. |
| Valiosa | Sí | Proyectos registrados, vinculados a sus milestones de GitLab. |
| Estimable | Sí | Alcance y actor definidos. |
| Pequeña (Small) | Sí | Cabe en una iteración. |
| Testeable | Sí | Los 4 criterios son verificables. |

## 15. Definition of Ready

- [x] El actor y el valor están sostenidos por una fuente
- [x] Los criterios de aceptación son verificables y citan su regla o fuente
- [x] Los casos negativos y límite tienen comportamiento o pregunta asignada
- [x] No hay preguntas abiertas que bloqueen
- [x] Las dependencias están identificadas
- [x] Los términos de negocio están en el glosario, o tienen una pregunta para el glosario
- [x] El PO validó la historia

## 16. Definition of Done (funcional)

- [ ] Todos los criterios de aceptación pasan sus pruebas de aceptación
- [ ] Los casos negativos y límite están cubiertos por pruebas
- [ ] La accesibilidad WCAG 2.2 AA está revisada
- [ ] Los requisitos de privacidad se cumplen
- [ ] El PO aceptó la historia en la revisión

## 17. Preparación y validación

- **Estado:** READY
- **Motivo:** Actor y valor sostenidos por BR-061, BR-033 y BR-034. US-018-Q1 quedó cerrada. Falta que exista US-018.
- **Bloqueos de entrega:** Ninguno
- **Propuesta de división (si no es pequeña):** Valorar separar en otra historia el registro del jefe de proyecto con su vigencia (BR-063, BR-102). Ya no hay motivo de actor para separar los roles/niveles requeridos: los define el mismo Jefe de Ingeniería o ADMIN (BR-109).
- **Siguiente rol o Skill:** `ux-requirements-analyzer`
- **Decisión humana requerida:** El Jefe de Ingeniería (validó la historia el 2026-10-12) responde RQ-32.
- **Actualización 2026-10-12:** los roles/niveles requeridos los define el Jefe de Ingeniería o un ADMIN (BR-109), el costo está en soles y el esfuerzo en horas-persona (BR-127), y el proyecto tiene un solo jefe de proyecto vigente (BR-102); se abre RQ-32. Verificada de nuevo por ianache el 2026-10-12.
- **Validación:** Aprobada · Responsable: Jefe de Ingeniería (ianache) · Fecha: 2026-10-12
