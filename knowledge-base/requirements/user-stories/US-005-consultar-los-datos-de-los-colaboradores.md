---
type: User Story
title: "US-005 — Consultar los datos de los colaboradores"
description: "Como Usuario autenticado, quiero consultar los datos personales y el rol/nivel de los colaboradores, para conocer quiénes forman el Área de Desarrollo y en qué rol/nivel están."
tags: [user-story, por-definir, colaboradores]
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
gitlab_issue_id: 52916
gitlab_issue_iid: 6
gitlab_issue_url: https://project.comsatel.com.pe/comsatel/development/training/dev-juniors/p3m/collaboration/-/issues/6
---

# US-005 — Consultar los datos de los colaboradores

## 1. Ficha

| Campo | Valor |
|---|---|
| ID | US-005 |
| Épica / capacidad | Colaboradores (IMD-001, bloque 1) |
| Horizonte / release | Por definir |
| Actor | Usuario autenticado. Cualquier usuario autenticado del portal (BR-003). El glosario no define este actor. |
| Responsable de negocio (PO) | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) (responsable funcional del portal, /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L109) |
| Prioridad | Should: ayuda a asignar, valorar y promover, pero depende del registro (US-004). La decide el PO. |
| Dependencias | US-004 |
| Preparación | READY |

## 2. Historia

**Como** Usuario autenticado, **quiero** consultar los datos personales y el rol/nivel de los colaboradores, **para** conocer quiénes forman el Área de Desarrollo y en qué rol/nivel están.

## 3. Contexto y valor

- **Problema que resuelve:** Cualquier usuario autenticado puede consultar los datos personales de los colaboradores (BR-003).
- **Valor esperado:** Los usuarios autenticados acceden a información vigente de los colaboradores.
- **Métrica o KPI que impacta:** Sin métrica asociada

## 4. Alcance

- **Incluye:**
  - Consultar el listado de colaboradores.
  - Consultar los datos de un colaborador.
- **Excluye:**
  - Registrar o modificar colaboradores (US-004).
  - Consultar valoraciones o evidencias (historias por redactar).

## 5. Criterios de aceptación

### AC-1 — Un usuario autenticado consulta colaboradores

```gherkin
Escenario: Un usuario autenticado consulta colaboradores
  Dado que el usuario está autenticado y existen colaboradores registrados
  Cuando consulta los datos de un colaborador
  Entonces ve sus nombres, apellido paterno, apellido materno, fecha de ingreso y rol/nivel
```

- **Regla / fuente:** BR-002, BR-003

### AC-2 — La consulta no permite modificar

```gherkin
Escenario: La consulta no permite modificar
  Dado que el usuario está autenticado y no es el Jefe de Ingeniería ni tiene perfil ADMIN
  Cuando consulta los datos de un colaborador
  Entonces no puede modificar esos datos
```

- **Regla / fuente:** BR-002, BR-003

## 6. Casos negativos y límite

| Caso | Comportamiento esperado | Fuente o pregunta |
|---|---|---|
| Usuario no autenticado | No consulta datos personales: la regla se limita a usuarios autenticados | BR-003 |
| Usuario autenticado sin perfil ADMIN ni Jefe de Ingeniería | Consulta pero no modifica | BR-002, BR-003 |
| Sin colaboradores registrados | Sin regla | US-005-Q1 |
| Política de datos personales sobre qué datos se muestran a todo usuario | Sin regla | G-12 |

## 7. Reglas de negocio aplicables

| ID | Regla | Fuente |
|---|---|---|
| BR-003 | Cualquier usuario autenticado puede consultar los datos personales de los colaboradores. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L43 |
| BR-002 | Solo el Jefe de Ingeniería o un usuario con perfil ADMIN registra y modifica colaboradores. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L42 |

## 8. Datos y términos

| Término | Uso en esta historia | Glosario |
|---|---|---|
| Colaborador | Registro que se consulta | [Colaborador](../../business/glossary/terms/TRM-0002-colaborador.md) |
| Rol/nivel | Dato que se muestra | [Rol/nivel](../../business/glossary/terms/TRM-0006-rol-nivel.md) |

## 9. Requisitos no funcionales

- **Accesibilidad:** WCAG 2.2 AA (estándar del repositorio).
- **Privacidad y datos personales:** Muestra nombres, apellido paterno, apellido materno y fecha de ingreso a todo usuario autenticado (BR-003). La política de datos personales está pendiente (G-12).
- **Otros:** Sin requisito identificado

## 10. Consideraciones de UX

- **Flujo esperado:** El actor busca o recorre el listado y abre el detalle de un colaborador.
- **Estados de la interfaz:** Vacío (sin colaboradores), sin autenticación, éxito.
- **Contenido clave:** Nombres, apellidos, fecha de ingreso y rol/nivel.

## 11. Dependencias, supuestos e hipótesis

- **Depende de:** US-004 (registro de colaboradores).
- **Es prerrequisito de:** —
- **Supuestos:** Ninguno
- **Hipótesis del agente:** H-1: la consulta puede incluir búsqueda o filtros. Ninguna fuente lo exige; lo confirmaría US-005-Q1.

## 12. Preguntas abiertas

| ID | Pregunta | Responsable | Prioridad | Bloquea | Estado |
|---|---|---|---|---|---|
| US-005-Q1 | ¿La consulta requiere búsqueda, filtros o exportación? ¿Qué ocurre si no hay colaboradores? | Jefe de Ingeniería | Baja | No | Abierta |
| G-12 | ¿Qué política de datos personales aplica a la consulta abierta a todo usuario autenticado? | Jefe de Ingeniería | Media | No | Abierta |
| US-005-Q2 | El actor «usuario autenticado» no está en el glosario. Se pide a `af-business-glossary-curator` decidir si se agrega. | Analista Funcional | Baja | No | Abierta |

## 13. Evidencia y trazabilidad

| ID | Hallazgo | Fuente | Clasificación | Confianza |
|---|---|---|---|---|
| EVD-2026-0004 | Por colaborador se registra: nombres, apellido paterno, apellido materno, fecha de ingreso, rol/nivel | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L99 | fact | high |
| EVD-2026-0020 | Los colaboradores los registra y modifica el Jefe de Ingeniería o cualquier usuario con perfil ADMIN | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L115 | decision | high |
| EVD-2026-0027 | Cualquier usuario autenticado puede consultar los datos personales de los colaboradores | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L122 | decision | high |

Evidencia compartida: `source_type: human`, `observed_at: 2026-10-10T12:00:00-05:00`, `freshness: current`, `owner: Jefe de Ingeniería`.

- **Upstream:** [BRC-001](../../business/rules/BRC-001-reglas-de-negocio-portal-curricula.md), [IMD-001](../../business/information-model/IMD-001-portal-curricula.md), [GLS-001](../../business/glossary/GLS-001-glosario-de-negocio.md) y [RCP-001](../context-packs/RCP-001-portal-gestion-curricula-desarrollo.md), todos en estado `draft`.
- **Downstream (pendiente):** UXR → FLW → SCR → CMP → AC

## 14. Evaluación INVEST

| Criterio | ¿Cumple? | Justificación |
|---|---|---|
| Independiente | Parcial | Necesita datos de US-004 para tener qué mostrar. |
| Negociable | Sí | Búsqueda y filtros se pueden conversar. |
| Valiosa | Sí | Los usuarios autenticados acceden a información vigente de los colaboradores. |
| Estimable | Sí | Alcance acotado. |
| Pequeña (Small) | Sí | Cabe en una iteración. |
| Testeable | Sí | Los 2 criterios son verificables. |

## 15. Definition of Ready

- [x] El actor y el valor están sostenidos por una fuente
- [x] Los criterios de aceptación son verificables y citan su regla o fuente
- [x] Los casos negativos y límite tienen comportamiento o pregunta asignada
- [x] No hay preguntas abiertas que bloqueen
- [x] Las dependencias están identificadas
- [ ] Los términos de negocio están en el glosario, o tienen una pregunta para el glosario
- [ ] El PO validó la historia

## 16. Definition of Done (funcional)

- [ ] Todos los criterios de aceptación pasan sus pruebas de aceptación
- [ ] Los casos negativos y límite están cubiertos por pruebas
- [ ] La accesibilidad WCAG 2.2 AA está revisada
- [ ] Los requisitos de privacidad se cumplen
- [ ] El PO aceptó la historia en la revisión

## 17. Preparación y validación

- **Estado:** READY
- **Motivo:** La regla BR-003 sostiene actor, valor y criterios. Las preguntas abiertas no bloquean. El actor «usuario autenticado» no está en el glosario; se deja como pregunta.
- **Bloqueos de entrega:** Ninguno
- **Propuesta de división (si no es pequeña):** No aplica
- **Siguiente rol o Skill:** `ux-requirements-analyzer`
- **Decisión humana requerida:** El Jefe de Ingeniería valida la historia y responde G-12.
- **Validación:** Pendiente · Responsable: Jefe de Ingeniería · Fecha: —
