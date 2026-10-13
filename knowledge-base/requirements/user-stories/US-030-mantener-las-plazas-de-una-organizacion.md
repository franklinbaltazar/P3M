---
type: User Story
title: "US-030 — Mantener las plazas de una organización"
description: "Como Jefe de Ingeniería o usuario con perfil ADMIN, quiero registrar las plazas de una organización con su rol/nivel, para que los colaboradores las ocupen y tengan un rol/nivel vigente."
tags: [user-story, partes, plazas]
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
gitlab_issue_id: 52941
gitlab_issue_iid: 31
gitlab_issue_url: https://project.comsatel.com.pe/comsatel/development/training/dev-juniors/p3m/collaboration/-/issues/31
---

# US-030 — Mantener las plazas de una organización

## 1. Ficha

| Campo | Valor |
|---|---|
| ID | US-030 |
| Épica / capacidad | Roles y competencias (IMD-001, bloque 1) |
| Horizonte / release | Por definir |
| Actor | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) o [ADMIN](../../business/glossary/terms/TRM-0028-admin.md) |
| Responsable de negocio (PO) | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) (responsable funcional del portal, /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L109) |
| Prioridad | Must: sin plazas un colaborador no tiene rol/nivel vigente (BR-047, BR-097). La decide el PO. |
| Dependencias | US-001, US-034 |
| Preparación | READY |

## 2. Historia

**Como** Jefe de Ingeniería o usuario con perfil ADMIN, **quiero** registrar y mantener las plazas de una organización, cada una de un rol/nivel, **para** que los colaboradores las ocupen y tengan un único rol/nivel vigente.

## 3. Contexto y valor

- **Problema que resuelve:** Cada organización tiene plazas, cada una de un rol/nivel, y el colaborador la ocupa durante un periodo (BR-097). Una plaza no tiene más datos propios que su organización, su rol/nivel y sus ocupaciones, y está vacante si no tiene ocupación vigente (BR-117). Una plaza la ocupa como máximo un colaborador (BR-106).
- **Valor esperado:** Plazas registradas por organización, con su rol/nivel y el historial de cambios de nivel.
- **Métrica o KPI que impacta:** Sin métrica asociada

## 4. Alcance

- **Incluye:**
  - Registrar una plaza de una organización con su rol/nivel.
  - Consultar si una plaza está vacante.
  - Consultar el historial del rol/nivel de una plaza.
- **Excluye:**
  - Registrar quién ocupa la plaza (US-031).
  - Decidir la promoción que cambia el rol/nivel de la plaza (US-017).
  - Plazas de proveedores (US-030-Q2).

## 5. Criterios de aceptación

### AC-1 — Registrar una plaza

```gherkin
Escenario: Registrar una plaza
  Dado una organización y un rol/nivel del catálogo
  Cuando se registra una plaza de esa organización con ese rol/nivel
  Entonces la plaza queda registrada
```

- **Regla / fuente:** BR-097

### AC-2 — Una plaza por colaborador requerido

```gherkin
Escenario: Una plaza por colaborador requerido
  Dado que se necesitan dos desarrolladores senior
  Cuando se registran las plazas
  Entonces se registran dos plazas distintas
```

- **Regla / fuente:** BR-106

### AC-3 — Plaza vacante

```gherkin
Escenario: Plaza vacante
  Dado una plaza sin ocupación vigente
  Cuando se consulta su estado
  Entonces está vacante
```

- **Regla / fuente:** BR-117

### AC-4 — Historial del rol/nivel de la plaza

```gherkin
Escenario: Historial del rol/nivel de la plaza
  Dado una plaza cuyo rol/nivel cambió por una promoción
  Cuando se consulta la plaza
  Entonces se conserva el historial de sus roles/niveles con vigencia
```

- **Regla / fuente:** BR-110

## 6. Casos negativos y límite

| Caso | Comportamiento esperado | Fuente o pregunta |
|---|---|---|
| Usuario sin permiso | No puede: lo mantienen el Jefe de Ingeniería y el ADMIN | BR-135 |
| Plaza con más datos propios (código, presupuesto, estado) | No hay: una plaza no tiene más datos que organización, rol/nivel y ocupaciones | BR-117 |
| Plaza ocupada por dos colaboradores a la vez | No es válido | BR-106 |
| Cambiar el rol/nivel de una plaza sin una promoción | Sin regla | US-030-Q4 |
| Retirar o cerrar una plaza | Sin regla | US-030-Q4 |
| Plazas de un proveedor | Sin regla | US-030-Q2 |

## 7. Reglas de negocio aplicables

| ID | Regla | Fuente |
|---|---|---|
| BR-097 | Cada organización tiene plazas. Cada plaza es de un rol/nivel (tipo de puesto) y el colaborador la ocupa durante un periodo, con vigencia desde y hasta. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L137 |
| BR-117 | Una plaza no tiene más datos propios que su organización, su rol/nivel y sus ocupaciones; está vacante cuando no tiene una ocupación vigente. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L157 |
| BR-106 | Una plaza la ocupa como máximo un colaborador a la vez. Si se requieren dos developers senior, se registran como dos plazas. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L146 |
| BR-110 | Al promover de nivel, la plaza cambia de rol/nivel y el colaborador sigue en la misma plaza. La plaza conserva el historial de su rol/nivel con vigencia. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L150 |
| BR-047 | Un colaborador tiene un único rol/nivel vigente en cada momento: el del puesto de la plaza que ocupa. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L87 |
| BR-002 | Solo el Jefe de Ingeniería o un usuario con perfil ADMIN registra y modifica colaboradores. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L42 |
| BR-135 | El Jefe de Ingeniería y el ADMIN mantienen los datos de contacto, las plazas, las ocupaciones de plaza, los roles de la parte, las relaciones entre partes y las organizaciones. | /business/rules\BRC-001-reglas-de-negocio-portal-curricula.md:L175 |

## 8. Datos y términos

| Término | Uso en esta historia | Glosario |
|---|---|---|
| Plaza | Elemento que se mantiene | [Plaza](../../business/glossary/terms/TRM-0063-plaza.md) |
| Organización | Dueña de la plaza | [Organización](../../business/glossary/terms/TRM-0050-organizacion.md) |
| Rol/nivel | Tipo de puesto de la plaza | [Rol/nivel](../../business/glossary/terms/TRM-0006-rol-nivel.md) |
| Ocupación de plaza | Periodo en que un colaborador la ocupa | [Ocupación de plaza](../../business/glossary/terms/TRM-0064-ocupacion-de-plaza.md) |
| Jefe de Ingeniería | Actor | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) |

## 9. Requisitos no funcionales

- **Accesibilidad:** WCAG 2.2 AA (estándar del repositorio).
- **Privacidad y datos personales:** No aplica: la historia no toca datos personales.
- **Otros:** Sin requisito identificado

## 10. Consideraciones de UX

- **Flujo esperado:** El actor elige una organización, registra una plaza y su rol/nivel, y ve si está vacante.
- **Estados de la interfaz:** Sin plazas, sin permisos, error, éxito.
- **Contenido clave:** Organización, rol/nivel, vacante u ocupada e historial.

## 11. Dependencias, supuestos e hipótesis

- **Depende de:** US-001 (catálogo de roles y niveles) y el registro de organizaciones (US-035).
- **Es prerrequisito de:** US-031, US-017.
- **Supuestos:** Ninguno
- **Hipótesis del agente:** Ninguna. El actor lo sostiene BR-135.

## 12. Preguntas abiertas

| ID | Pregunta | Responsable | Prioridad | Bloquea | Estado |
|---|---|---|---|---|---|
| US-030-Q1 | Cerrada el 2026-10-12: las organizaciones se registran en US-035. | Jefe de Ingeniería | Media | No | Cerrada |
| US-030-Q2 | ¿Los colaboradores de un proveedor ocupan plazas del proveedor o de COMSATEL? (IM-Q29, RQ-30) | Jefe de Ingeniería | Media | No | Abierta |
| US-030-Q3 | Cerrada el 2026-10-12: lo mantienen el Jefe de Ingeniería y el ADMIN (BR-135). | Jefe de Ingeniería | Media | No | Cerrada |
| US-030-Q4 | ¿Se puede cambiar el rol/nivel de una plaza sin una promoción, o retirar una plaza? | Jefe de Ingeniería | Baja | No | Abierta |

## 13. Evidencia y trazabilidad

| ID | Hallazgo | Fuente | Clasificación | Confianza |
|---|---|---|---|---|
| EVD-2026-0140 | Existen plazas por organización. El rol/nivel es el tipo de puesto de la plaza | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L537 | decision | high |
| EVD-2026-0141 | El colaborador ocupa una plaza con vigencia desde y hasta. Su rol/nivel es el de la plaza y el historial son sus ocupaciones | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L538 | decision | high |
| EVD-2026-0146 | Una plaza la ocupa como máximo un colaborador; dos requeridos son dos plazas | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L543 | decision | high |
| EVD-2026-0151 | La promoción cambia el rol/nivel de la plaza; la plaza conserva el historial | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L548 | decision | high |
| EVD-2026-0156 | Una plaza no tiene más datos propios que su organización, su rol/nivel y su ocupación; está vacante cuando no tiene una ocupación vigente | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L553 | decision | high |
| EVD-2026-0174 | El Jefe de Ingeniería y el ADMIN mantienen contactos, plazas, ocupaciones, roles de la parte, relaciones y organizaciones | /requirements/context-packs\RCP-001-portal-gestion-curricula-desarrollo.md:L573 | decision | high |

Evidencia compartida: `source_type: human`, `observed_at: 2026-10-11T00:00:00Z`, `freshness: current`, `owner: Jefe de Ingeniería`. La indicación del responsable del 2026-10-12 sobre las funcionalidades de mantenimiento de la parte se recoge en la sección 12.

- **Upstream:** [BRC-001](../../business/rules/BRC-001-reglas-de-negocio-portal-curricula.md), [IMD-001](../../business/information-model/IMD-001-portal-curricula.md), [GLS-001](../../business/glossary/GLS-001-glosario-de-negocio.md) y [RCP-001](../context-packs/RCP-001-portal-gestion-curricula-desarrollo.md).
- **Downstream (pendiente):** UXR → FLW → SCR → CMP → AC

## 14. Evaluación INVEST

| Criterio | ¿Cumple? | Justificación |
|---|---|---|
| Independiente | Parcial | Necesita el catálogo de roles (US-001) y las organizaciones. |
| Negociable | Parcial | Cambios y cierre de plazas abiertos (US-030-Q4). |
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
- **Motivo:** Los criterios están sostenidos por BR-097, BR-117 y BR-106. El actor está sostenido por BR-135 y las preguntas abiertas no bloquean los criterios.
- **Bloqueos de entrega:** Ninguno. Ninguno.
- **Propuesta de división (si no es pequeña):** No aplica
- **Siguiente rol o Skill:** `ux-requirements-analyzer`
- **Decisión humana requerida:** El Jefe de Ingeniería responde las preguntas abiertas y valida la historia.
- **Origen:** historia nueva del 2026-10-12, pedida por el responsable funcional (OI-11 del handoff de base de datos): «debemos incorporar funcionalidades para mantener los contactos de las Party, plazas, ocupaciones, roles de la parte, corrección de vínculo y relaciones».
- **Validación:** Pendiente · Responsable: Jefe de Ingeniería · Fecha: —
