---
type: User Story
title: "US-032 — Mantener los roles de la parte"
description: "Como Jefe de Ingeniería o usuario con perfil ADMIN, quiero registrar y terminar los roles de una persona (colaborador o evaluador) con su vigencia, para saber en qué periodos desempeñó cada función."
tags: [user-story, partes, roles]
status: draft
generated:
  by: "af-user-story-refiner/2.0"
  at: "2026-10-12T11:00:00-05:00"
sources:
  - id: brc-001
    resource: /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md
  - id: rcp-001
    resource: /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md
  - id: gls-001
    resource: /business/glossary/GLS-001-glosario-de-negocio.md
  - id: imd-001
    resource: /business/information-model/IMD-001-portal-curricula.md
gitlab_issue_id: 52943
gitlab_issue_iid: 33
gitlab_issue_url: https://project.comsatel.com.pe/comsatel/development/training/dev-juniors/p3m/collaboration/-/issues/33
---

# US-032 — Mantener los roles de la parte

## 1. Ficha

| Campo | Valor |
|---|---|
| ID | US-032 |
| Épica / capacidad | Roles y competencias (IMD-001, bloque 1) |
| Horizonte / release | Por definir |
| Actor | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) o [ADMIN](../../business/glossary/terms/TRM-0028-admin.md) |
| Responsable de negocio (PO) | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) (responsable funcional del portal, /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L109) |
| Prioridad | Must: enrolarse, evaluar y asignar consultan el rol vigente de la persona (CON-01). La decide el PO. |
| Dependencias | US-004 |
| Preparación | READY |

## 2. Historia

**Como** Jefe de Ingeniería o usuario con perfil ADMIN, **quiero** registrar y terminar el rol de colaborador o de evaluador de una persona, con su vigencia, **para** saber en qué periodos desempeñó cada función.

## 3. Contexto y valor

- **Problema que resuelve:** El evaluador (instructor) y el colaborador son roles de la parte con vigencia (BR-108). Una persona no repite el mismo tipo de rol con vigencias solapadas (BR-120). El jefe de proyecto también es un rol con vigencia, pero se designa al gestionar el proyecto (US-019, BR-063, BR-102).
- **Valor esperado:** Roles con vigencia consultables, sin solapes del mismo tipo.
- **Métrica o KPI que impacta:** Sin métrica asociada

## 4. Alcance

- **Incluye:**
  - Iniciar el rol de colaborador o de evaluador de una persona con una fecha desde.
  - Terminar un rol con una fecha hasta.
  - Impedir dos roles del mismo tipo con vigencias solapadas.
- **Excluye:**
  - Designar al jefe de proyecto (US-019).
  - Asignar los roles de usuario de Keycloak (se hace en Keycloak, BR-044).

## 5. Criterios de aceptación

### AC-1 — Iniciar un rol de la parte

```gherkin
Escenario: Iniciar un rol de la parte
  Dado una persona registrada
  Cuando se inicia su rol de colaborador o de evaluador desde una fecha
  Entonces la persona desempeña ese rol desde esa fecha
```

- **Regla / fuente:** BR-108

### AC-2 — Terminar un rol

```gherkin
Escenario: Terminar un rol
  Dado un rol vigente de una persona
  Cuando se registra su fecha hasta
  Entonces el rol deja de estar vigente y se conserva su periodo
```

- **Regla / fuente:** BR-108

### AC-3 — Sin solapes del mismo tipo

```gherkin
Escenario: Sin solapes del mismo tipo
  Dado una persona con un rol de evaluador vigente
  Cuando se intenta iniciar otro rol de evaluador que se solapa
  Entonces el portal no lo permite
```

- **Regla / fuente:** BR-120

## 6. Casos negativos y límite

| Caso | Comportamiento esperado | Fuente o pregunta |
|---|---|---|
| Usuario sin permiso | No puede: lo mantienen el Jefe de Ingeniería y el ADMIN | BR-135 |
| Una persona con roles de tipos distintos a la vez (colaborador y evaluador) | Sin regla | US-032-Q2 |
| Relación entre el rol Evaluador de la parte y el rol Instructor de Keycloak | Sin regla | US-032-Q3 |
| Jefe de proyecto como rol de la parte | Se designa en el proyecto, con vigencia | BR-063, BR-102 |
| Fecha de ingreso del colaborador | Es el inicio de su rol de colaborador (IMD-001, sección 5.1); sin regla propia | US-032-Q4 |

## 7. Reglas de negocio aplicables

| ID | Regla | Fuente |
|---|---|---|
| BR-108 | El Evaluador (instructor) y el jefe de proyecto son roles de la parte con vigencia, igual que el colaborador. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L148 |
| BR-120 | Una persona no tiene dos veces el mismo tipo de rol de la parte (colaborador o evaluador) con vigencias solapadas. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L160 |
| BR-063 | El jefe de proyecto se registra en el portal al gestionar los proyectos de un producto: es un colaborador con el rol Jefe de Proyecto, con historial de cambios y vigencia desde y hasta. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L103 |
| BR-102 | Un proyecto tiene jefes de proyecto a lo largo del tiempo, con vigencia desde y hasta, pero solo uno vigente a la vez. Un colaborador puede ser jefe de varios proyectos. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L142 |
| BR-008 | El Evaluador es un rol que se asigna a usuarios del portal en Keycloak y corresponde al instructor asignado a una edición de curso. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L48 |
| BR-002 | Solo el Jefe de Ingeniería o un usuario con perfil ADMIN registra y modifica colaboradores. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L42 |
| BR-135 | El Jefe de Ingeniería y el ADMIN mantienen los datos de contacto, las plazas, las ocupaciones de plaza, los roles de la parte, las relaciones entre partes y las organizaciones. | /business/rules\BRC-001-reglas-de-negocio-portal-curricula.md:L175 |

## 8. Datos y términos

| Término | Uso en esta historia | Glosario |
|---|---|---|
| Rol de la parte | Elemento que se mantiene | [Rol de la parte](../../business/glossary/terms/TRM-0061-rol-de-la-parte.md) |
| Persona | Quien desempeña el rol | [Persona](../../business/glossary/terms/TRM-0060-persona.md) |
| Colaborador | Rol de la parte | [Colaborador](../../business/glossary/terms/TRM-0002-colaborador.md) |
| Evaluador | Rol de la parte | [Evaluador](../../business/glossary/terms/TRM-0016-evaluador.md) |
| Jefe de Ingeniería | Actor | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) |

## 9. Requisitos no funcionales

- **Accesibilidad:** WCAG 2.2 AA (estándar del repositorio).
- **Privacidad y datos personales:** Toca la identidad y el historial laboral de la persona, que se retienen por siempre (BR-101). Política aplazada como deuda técnica DT-01 (RQ-34).
- **Otros:** Sin requisito identificado

## 10. Consideraciones de UX

- **Flujo esperado:** El actor abre una persona, inicia o termina un rol y ve sus roles con vigencia.
- **Estados de la interfaz:** Sin roles, sin permisos, error de solape, éxito.
- **Contenido clave:** Rol, desde y hasta.

## 11. Dependencias, supuestos e hipótesis

- **Depende de:** US-004 (persona registrada).
- **Es prerrequisito de:** US-008 (la edición necesita un evaluador), US-009, US-021.
- **Supuestos:** Ninguno
- **Hipótesis del agente:** Ninguna. El actor lo sostiene BR-135.

## 12. Preguntas abiertas

| ID | Pregunta | Responsable | Prioridad | Bloquea | Estado |
|---|---|---|---|---|---|
| US-032-Q1 | Cerrada el 2026-10-12: lo mantienen el Jefe de Ingeniería y el ADMIN (BR-135). | Jefe de Ingeniería | Media | No | Cerrada |
| US-032-Q2 | ¿Una persona puede tener a la vez roles de tipos distintos? (RQ-33) | Jefe de Ingeniería | Media | No | Abierta |
| US-032-Q3 | ¿Cómo se relaciona el rol Evaluador de la parte con el rol Instructor que se asigna en Keycloak (BR-008)? | Jefe de Ingeniería | Media | No | Abierta |
| US-032-Q4 | ¿El rol de colaborador se registra al dar de alta al colaborador (US-004) o con esta historia? | Jefe de Ingeniería | Baja | No | Abierta |

## 13. Evidencia y trazabilidad

| ID | Hallazgo | Fuente | Clasificación | Confianza |
|---|---|---|---|---|
| EVD-2026-0148 | Evaluador y jefe de proyecto son roles de la parte con vigencia | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L545 | decision | high |
| EVD-2026-0159 | Una persona no tiene dos veces el mismo tipo de rol de la parte con vigencias solapadas | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L556 | decision | high |
| EVD-2026-0091 | La gestión de los proyectos de un producto registra a un colaborador con el rol Jefe de Proyecto, con historial de cambios y vigencia desde y hasta | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L186 | decision | high |
| EVD-2026-0144 | Un proyecto tiene un solo jefe de proyecto vigente; puede haber varios a lo largo del tiempo | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L541 | decision | high |
| EVD-2026-0174 | El Jefe de Ingeniería y el ADMIN mantienen contactos, plazas, ocupaciones, roles de la parte, relaciones y organizaciones | /requirements/context-packs\RCP-001-portal-gestion-curricula-desarrollo.md:L573 | decision | high |

Evidencia compartida: `source_type: human`, `observed_at: 2026-10-11T00:00:00Z`, `freshness: current`, `owner: Jefe de Ingeniería`. La indicación del responsable del 2026-10-12 sobre las funcionalidades de mantenimiento de la parte se recoge en la sección 12.

- **Upstream:** [BRC-001](../../business/rules/BRC-001-reglas-de-negocio-portal-curricula.md), [IMD-001](../../business/information-model/IMD-001-portal-curricula.md), [GLS-001](../../business/glossary/GLS-001-glosario-de-negocio.md) y [RCP-001](../context-packs/RCP-001-portal-gestion-curricula-desarrollo.md).
- **Downstream (pendiente):** UXR → FLW → SCR → CMP → AC

## 14. Evaluación INVEST

| Criterio | ¿Cumple? | Justificación |
|---|---|---|
| Independiente | Parcial | Necesita la persona registrada (US-004). |
| Negociable | Parcial | Roles simultáneos de tipos distintos abiertos (US-032-Q2). |
| Valiosa | Sí | Sin esta funcionalidad el dato no se puede mantener desde el portal. |
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
- **Motivo:** Los criterios están sostenidos por BR-108 y BR-120. El actor está sostenido por BR-135 y las preguntas abiertas no bloquean los criterios.
- **Bloqueos de entrega:** Ninguno. Falta que exista US-004.
- **Propuesta de división (si no es pequeña):** No aplica
- **Siguiente rol o Skill:** `ux-requirements-analyzer`
- **Decisión humana requerida:** El Jefe de Ingeniería responde las preguntas abiertas y valida la historia.
- **Origen:** historia nueva del 2026-10-12, pedida por el responsable funcional (OI-11 del handoff de base de datos): «debemos incorporar funcionalidades para mantener los contactos de las Party, plazas, ocupaciones, roles de la parte, corrección de vínculo y relaciones».
- **Validación:** Pendiente · Responsable: Jefe de Ingeniería · Fecha: —
