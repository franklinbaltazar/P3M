---
type: User Story
title: "US-001 — Mantener el catálogo oficial de roles"
description: "Como Jefe de Ingeniería o usuario con perfil ADMIN, quiero crear y mantener los roles del catálogo oficial, para que colaboradores, perfiles de competencias y proyectos se refieran siempre a roles oficiales."
tags: [user-story, por-definir, roles-competencias]
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
gitlab_issue_id: 52912
gitlab_issue_iid: 2
gitlab_issue_url: https://project.comsatel.com.pe/comsatel/development/training/dev-juniors/p3m/collaboration/-/issues/2
---

# US-001 — Mantener el catálogo oficial de roles

## 1. Ficha

| Campo | Valor |
|---|---|
| ID | US-001 |
| Épica / capacidad | Roles y competencias (IMD-001, bloque 1) |
| Horizonte / release | Por definir |
| Actor | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) / [ADMIN](../../business/glossary/terms/TRM-0028-admin.md) |
| Responsable de negocio (PO) | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) (responsable funcional del portal, /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L109) |
| Prioridad | Must: sin roles no se pueden registrar colaboradores ni definir perfiles de competencias. La decide el PO. |
| Dependencias | — |
| Preparación | READY |

## 2. Historia

**Como** Jefe de Ingeniería o usuario con perfil ADMIN, **quiero** crear y mantener los roles del catálogo oficial, **para** que colaboradores, perfiles de competencias y proyectos se refieran siempre a roles oficiales.

## 3. Contexto y valor

- **Problema que resuelve:** El catálogo oficial de roles lo mantiene el portal y no existe un conjunto inicial que cargar (BR-001).
- **Valor esperado:** Un catálogo único y oficial de roles disponible para el resto del portal.
- **Métrica o KPI que impacta:** Sin métrica asociada

## 4. Alcance

- **Incluye:**
  - Crear un rol en el catálogo.
  - Modificar un rol existente.
  - Consultar el catálogo de roles.
- **Excluye:**
  - Definir el perfil de competencias de un rol (US-002).
  - Definir los niveles L1–L4 y los seniority, que son una escala fija (BR-011).
  - Retirar roles: no hay regla (US-001-Q2).

## 5. Criterios de aceptación

### AC-1 — Crear un rol

```gherkin
Escenario: Crear un rol
  Dado que el usuario es el Jefe de Ingeniería o tiene perfil ADMIN
  Y que el catálogo de roles no contiene el rol "Analista"
  Cuando crea el rol "Analista"
  Entonces el rol "Analista" forma parte del catálogo oficial de roles
```

- **Regla / fuente:** BR-001

### AC-2 — Modificar un rol

```gherkin
Escenario: Modificar un rol
  Dado que el usuario es el Jefe de Ingeniería o tiene perfil ADMIN
  Y que el catálogo contiene el rol "Analista"
  Cuando modifica el nombre del rol a "Analista funcional"
  Entonces el catálogo muestra el rol con el nombre "Analista funcional"
```

- **Regla / fuente:** BR-001

### AC-3 — Un usuario sin permiso no mantiene el catálogo

```gherkin
Escenario: Un usuario sin permiso no mantiene el catálogo
  Dado que el usuario está autenticado y no es el Jefe de Ingeniería ni tiene perfil ADMIN
  Cuando intenta crear o modificar un rol
  Entonces el portal no permite la acción y el catálogo no cambia
```

- **Regla / fuente:** BR-001

### AC-4 — El catálogo inicia sin roles

```gherkin
Escenario: El catálogo inicia sin roles
  Dado un portal recién puesto en uso
  Cuando el Jefe de Ingeniería consulta el catálogo de roles
  Entonces el catálogo no contiene ningún rol
```

- **Regla / fuente:** BR-001

## 6. Casos negativos y límite

| Caso | Comportamiento esperado | Fuente o pregunta |
|---|---|---|
| Usuario autenticado sin perfil ADMIN ni Jefe de Ingeniería | No puede crear ni modificar roles | BR-001 |
| Catálogo vacío | El catálogo se muestra sin roles, porque no hay conjunto inicial | BR-001 |
| Rol con nombre repetido | Sin regla | US-001-Q1 |
| Retirar un rol que ya usan colaboradores o perfiles | Sin regla | US-001-Q2 |

## 7. Reglas de negocio aplicables

| ID | Regla | Fuente |
|---|---|---|
| BR-001 | Solo el Jefe de Ingeniería o un usuario con perfil ADMIN crea y mantiene los roles del catálogo oficial. El catálogo no tiene un conjunto inicial de roles. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L41 |
| BR-044 | Los usuarios y sus roles (ADMIN, Jefe de Ingeniería, Evaluador y colaborador) se gestionan en Keycloak, donde se mantiene el IdM. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L84 |

## 8. Datos y términos

| Término | Uso en esta historia | Glosario |
|---|---|---|
| Rol | Elemento del catálogo que se crea y modifica | [Rol](../../business/glossary/terms/TRM-0003-rol.md) |
| Jefe de Ingeniería | Actor autorizado | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) |
| ADMIN | Actor autorizado | [ADMIN](../../business/glossary/terms/TRM-0028-admin.md) |

## 9. Requisitos no funcionales

- **Accesibilidad:** WCAG 2.2 AA (estándar del repositorio).
- **Privacidad y datos personales:** No aplica: la historia no toca datos personales.
- **Otros:** Sin requisito identificado

## 10. Consideraciones de UX

- **Flujo esperado:** El actor consulta el catálogo, crea un rol o abre uno existente para modificarlo, y confirma.
- **Estados de la interfaz:** Vacío (catálogo sin roles), sin permisos, error de validación, éxito.
- **Contenido clave:** Nombre de cada rol y confirmación de que forma parte del catálogo oficial.

## 11. Dependencias, supuestos e hipótesis

- **Depende de:** Perfiles y roles de usuario administrados en Keycloak (BR-044).
- **Es prerrequisito de:** US-002, US-004
- **Supuestos:** Ninguno
- **Hipótesis del agente:** Ninguna

## 12. Preguntas abiertas

| ID | Pregunta | Responsable | Prioridad | Bloquea | Estado |
|---|---|---|---|---|---|
| US-001-Q1 | ¿Qué atributos tiene un rol además del nombre y el nombre debe ser único? | Jefe de Ingeniería | Baja | No | Abierta |
| US-001-Q2 | ¿Puede retirarse un rol del catálogo y qué ocurre si hay colaboradores o perfiles que lo usan? | Jefe de Ingeniería | Baja | No | Abierta |

## 13. Evidencia y trazabilidad

| ID | Hallazgo | Fuente | Clasificación | Confianza |
|---|---|---|---|---|
| EVD-2026-0010 | Existe un catálogo oficial de roles, mantenido por la plataforma y no predefinido. Lo mantienen el Jefe de Ingeniería o un ADMIN. No hay conjunto inicial para cargar | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L105 | decision | high |
| EVD-2026-0020 | Los colaboradores los registra y modifica el Jefe de Ingeniería o cualquier usuario con perfil ADMIN | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L115 | decision | high |
| EVD-2026-0068 | Los perfiles del portal incluyen ADMIN, Jefe de Ingeniería, Evaluador (instructor de una edición) y colaborador, administrados en Keycloak | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L163 | decision | high |

Evidencia compartida: `source_type: human`, `observed_at: 2026-10-10T12:00:00-05:00`, `freshness: current`, `owner: Jefe de Ingeniería`.

- **Upstream:** [BRC-001](../../business/rules/BRC-001-reglas-de-negocio-portal-curricula.md), [IMD-001](../../business/information-model/IMD-001-portal-curricula.md), [GLS-001](../../business/glossary/GLS-001-glosario-de-negocio.md) y [RCP-001](../context-packs/RCP-001-portal-gestion-curricula-desarrollo.md), todos en estado `draft`.
- **Downstream (pendiente):** UXR → FLW → SCR → CMP → AC

## 14. Evaluación INVEST

| Criterio | ¿Cumple? | Justificación |
|---|---|---|
| Independiente | Sí | No depende de otra historia. |
| Negociable | Parcial | Los atributos del rol y el retiro quedan abiertos (US-001-Q1, US-001-Q2). |
| Valiosa | Sí | Un catálogo único y oficial de roles disponible para el resto del portal. |
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
- **Motivo:** El actor, el valor y los criterios están sostenidos por BR-001. Las 2 preguntas abiertas no bloquean los criterios.
- **Bloqueos de entrega:** Ninguno
- **Propuesta de división (si no es pequeña):** No aplica
- **Siguiente rol o Skill:** `ux-requirements-analyzer`
- **Decisión humana requerida:** El Jefe de Ingeniería valida la historia y responde US-001-Q1 y US-001-Q2.
- **Validación:** Pendiente · Responsable: Jefe de Ingeniería · Fecha: —
