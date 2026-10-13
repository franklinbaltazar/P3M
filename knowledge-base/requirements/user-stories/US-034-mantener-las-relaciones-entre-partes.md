---
type: User Story
title: "US-034 — Mantener las relaciones entre partes"
description: "Como Jefe de Ingeniería o usuario con perfil ADMIN, quiero registrar las relaciones entre partes (reporta a, membresía y es parte de) con su vigencia, para conocer la estructura de la organización y de sus colaboradores."
tags: [user-story, partes, relaciones]
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
gitlab_issue_id: 52945
gitlab_issue_iid: 35
gitlab_issue_url: https://project.comsatel.com.pe/comsatel/development/training/dev-juniors/p3m/collaboration/-/issues/35
---

# US-034 — Mantener las relaciones entre partes

## 1. Ficha

| Campo | Valor |
|---|---|
| ID | US-034 |
| Épica / capacidad | Roles y competencias (IMD-001, bloque 1) |
| Horizonte / release | Por definir |
| Actor | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) o [ADMIN](../../business/glossary/terms/TRM-0028-admin.md) |
| Responsable de negocio (PO) | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) (responsable funcional del portal, /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L109) |
| Prioridad | Should: la estructura de reporte y la membresía no bloquean otras historias. La decide el PO. |
| Dependencias | US-004 |
| Preparación | READY |

## 2. Historia

**Como** Jefe de Ingeniería o usuario con perfil ADMIN, **quiero** registrar y terminar las relaciones «reporta a», membresía y «es parte de», con su vigencia, **para** conocer la estructura de la organización y de sus colaboradores.

## 3. Contexto y valor

- **Problema que resuelve:** Un colaborador reporta a otro, con vigencia y un solo jefe (BR-071). Un colaborador es miembro de una organización, con una sola membresía vigente (BR-076). Una organización es parte de otra, como máximo una a la vez (BR-072, BR-118).
- **Valor esperado:** Relaciones con vigencia e historial, con las restricciones de «una sola vigente».
- **Métrica o KPI que impacta:** Sin métrica asociada

## 4. Alcance

- **Incluye:**
  - Registrar y terminar «reporta a» entre colaboradores.
  - Registrar y terminar la membresía de un colaborador a una organización.
  - Registrar y terminar que una organización es parte de otra.
- **Excluye:**
  - Registrar las organizaciones y las personas (US-004, US-030-Q1).
  - Roles de la parte (US-032).

## 5. Criterios de aceptación

### AC-1 — Registrar «reporta a»

```gherkin
Escenario: Registrar «reporta a»
  Dado dos colaboradores
  Cuando se registra que uno reporta al otro, con su vigencia
  Entonces la relación queda registrada
```

- **Regla / fuente:** BR-071

### AC-2 — Un solo jefe vigente

```gherkin
Escenario: Un solo jefe vigente
  Dado un colaborador con un jefe vigente
  Cuando se intenta registrar un segundo jefe vigente
  Entonces el portal no lo permite
```

- **Regla / fuente:** BR-071

### AC-3 — Registrar la membresía

```gherkin
Escenario: Registrar la membresía
  Dado un colaborador y una organización
  Cuando se registra su membresía con vigencia
  Entonces la membresía queda registrada
```

- **Regla / fuente:** BR-076

### AC-4 — Una sola membresía vigente

```gherkin
Escenario: Una sola membresía vigente
  Dado un colaborador con una membresía vigente
  Cuando se intenta registrar otra membresía vigente
  Entonces el portal no lo permite
```

- **Regla / fuente:** BR-076

### AC-5 — Una organización es parte de otra

```gherkin
Escenario: Una organización es parte de otra
  Dado dos organizaciones
  Cuando se registra que una es parte de la otra
  Entonces la relación queda registrada, y solo hay una vigente por organización
```

- **Regla / fuente:** BR-072, BR-118

## 6. Casos negativos y límite

| Caso | Comportamiento esperado | Fuente o pregunta |
|---|---|---|
| Usuario sin permiso | No puede: lo mantienen el Jefe de Ingeniería y el ADMIN | BR-135 |
| «Reporta a» entre una persona y una organización | No es válido: es entre colaboradores | BR-071 |
| Membresía de un proveedor que luego pasa a COMSATEL | Es válido: se termina una y se registra otra, con vigencia | BR-076 |
| Ciclos en «reporta a» (A reporta a B y B a A) | Sin regla | US-034-Q2 |
| Registrar las organizaciones | Sin historia que las registre | US-030-Q1 |

## 7. Reglas de negocio aplicables

| ID | Regla | Fuente |
|---|---|---|
| BR-071 | Un colaborador puede reportar a otro colaborador (relación «reporta a»). La relación tiene vigencia y un colaborador tiene un solo jefe. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L111 |
| BR-072 | COMSATEL y el Área de Desarrollo se registran como organizaciones, y el Área de Desarrollo es parte de COMSATEL. Pueden existir otras organizaciones, como los proveedores que proporcionan colaboradores. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L112 |
| BR-076 | El vínculo entre un colaborador y una organización es una relación de tipo «membership» (miembro de), con vigencia. Un colaborador de un proveedor puede pasar a ser miembro definitivo de COMSATEL. Como máximo hay una membresía vigente (fecha hasta abierta) por colaborador: no puede estar vigente en más de una organización a la vez. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L116 |
| BR-118 | Una organización es parte de, como máximo, una organización a la vez. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L158 |
| BR-079 | Se conserva el historial de cambios de nivel y seniority (rol/nivel) de cada colaborador: es el historial de rol/nivel de la plaza que ocupa, con vigencia (BR-110). | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L119 |
| BR-002 | Solo el Jefe de Ingeniería o un usuario con perfil ADMIN registra y modifica colaboradores. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L42 |
| BR-135 | El Jefe de Ingeniería y el ADMIN mantienen los datos de contacto, las plazas, las ocupaciones de plaza, los roles de la parte, las relaciones entre partes y las organizaciones. | /business/rules\BRC-001-reglas-de-negocio-portal-curricula.md:L175 |

## 8. Datos y términos

| Término | Uso en esta historia | Glosario |
|---|---|---|
| Relación entre partes | Elemento que se mantiene | [Relación entre partes](../../business/glossary/terms/TRM-0062-relacion-entre-partes.md) |
| Colaborador | Origen de «reporta a» y de la membresía | [Colaborador](../../business/glossary/terms/TRM-0002-colaborador.md) |
| Organización | Destino de la membresía; origen y destino de «es parte de» | [Organización](../../business/glossary/terms/TRM-0050-organizacion.md) |
| Jefe de Ingeniería | Actor | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) |

## 9. Requisitos no funcionales

- **Accesibilidad:** WCAG 2.2 AA (estándar del repositorio).
- **Privacidad y datos personales:** Toca datos de personas y su estructura de reporte, que se retienen por siempre (BR-101). Política aplazada como deuda técnica DT-01 (RQ-34).
- **Otros:** Sin requisito identificado

## 10. Consideraciones de UX

- **Flujo esperado:** El actor abre un colaborador u organización, agrega una relación con su vigencia y ve la vigente y el historial.
- **Estados de la interfaz:** Sin relaciones, sin permisos, error de «una sola vigente», éxito.
- **Contenido clave:** Tipo de relación, partes, desde y hasta.

## 11. Dependencias, supuestos e hipótesis

- **Depende de:** US-004 (colaboradores) y las organizaciones (sin historia, US-030-Q1).
- **Es prerrequisito de:** Ninguno.
- **Supuestos:** Ninguno
- **Hipótesis del agente:** Ninguna. El actor lo sostiene BR-135.

## 12. Preguntas abiertas

| ID | Pregunta | Responsable | Prioridad | Bloquea | Estado |
|---|---|---|---|---|---|
| US-034-Q1 | Cerrada el 2026-10-12: lo mantienen el Jefe de Ingeniería y el ADMIN (BR-135). | Jefe de Ingeniería | Media | No | Cerrada |
| US-034-Q2 | ¿Se impiden los ciclos en «reporta a»? | Jefe de Ingeniería | Baja | No | Abierta |

## 13. Evidencia y trazabilidad

| ID | Hallazgo | Fuente | Clasificación | Confianza |
|---|---|---|---|---|
| EVD-2026-0100 | Un colaborador puede reportar a otro colaborador | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L480 | decision | high |
| EVD-2026-0101 | COMSATEL y el Área de Desarrollo son organizaciones; el Área es parte de COMSATEL; habrá otras organizaciones, como proveedores | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L482 | decision | high |
| EVD-2026-0105 | «Reporta a» tiene vigencia y un colaborador tiene un solo jefe | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L486 | decision | high |
| EVD-2026-0106 | El vínculo colaborador–organización es una relación de tipo membership | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L487 | decision | high |
| EVD-2026-0113 | La membresía vigente de un colaborador a una organización es como máximo una; no puede haber vigentes en más de una organización | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L494 | decision | high |
| EVD-2026-0157 | Una organización es parte de, como máximo, una organización a la vez | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L554 | decision | high |
| EVD-2026-0174 | El Jefe de Ingeniería y el ADMIN mantienen contactos, plazas, ocupaciones, roles de la parte, relaciones y organizaciones | /requirements/context-packs\RCP-001-portal-gestion-curricula-desarrollo.md:L573 | decision | high |

Evidencia compartida: `source_type: human`, `observed_at: 2026-10-11T00:00:00Z`, `freshness: current`, `owner: Jefe de Ingeniería`. La indicación del responsable del 2026-10-12 sobre las funcionalidades de mantenimiento de la parte se recoge en la sección 12.

- **Upstream:** [BRC-001](../../business/rules/BRC-001-reglas-de-negocio-portal-curricula.md), [IMD-001](../../business/information-model/IMD-001-portal-curricula.md), [GLS-001](../../business/glossary/GLS-001-glosario-de-negocio.md) y [RCP-001](../context-packs/RCP-001-portal-gestion-curricula-desarrollo.md).
- **Downstream (pendiente):** UXR → FLW → SCR → CMP → AC

## 14. Evaluación INVEST

| Criterio | ¿Cumple? | Justificación |
|---|---|---|
| Independiente | Parcial | Necesita US-004 y las organizaciones. |
| Negociable | Parcial | Ciclos en «reporta a» abiertos (US-034-Q2). |
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
- **Motivo:** Los criterios están sostenidos por BR-071, BR-072, BR-076 y BR-118. El actor está sostenido por BR-135 y las preguntas abiertas no bloquean los criterios.
- **Bloqueos de entrega:** Ninguno. Faltan US-004 y una historia que registre las organizaciones.
- **Propuesta de división (si no es pequeña):** No aplica
- **Siguiente rol o Skill:** `ux-requirements-analyzer`
- **Decisión humana requerida:** El Jefe de Ingeniería responde las preguntas abiertas y valida la historia.
- **Origen:** historia nueva del 2026-10-12, pedida por el responsable funcional (OI-11 del handoff de base de datos): «debemos incorporar funcionalidades para mantener los contactos de las Party, plazas, ocupaciones, roles de la parte, corrección de vínculo y relaciones».
- **Validación:** Pendiente · Responsable: Jefe de Ingeniería · Fecha: —
