---
type: User Story
title: "US-031 — Mantener las ocupaciones de plaza"
description: "Como Jefe de Ingeniería o usuario con perfil ADMIN, quiero registrar qué colaborador ocupa cada plaza y durante qué periodo, para que cada colaborador tenga su único rol/nivel vigente y su historial."
tags: [user-story, partes, plazas, ocupaciones]
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
gitlab_issue_id: 52942
gitlab_issue_iid: 32
gitlab_issue_url: https://project.comsatel.com.pe/comsatel/development/training/dev-juniors/p3m/collaboration/-/issues/32
---

# US-031 — Mantener las ocupaciones de plaza

## 1. Ficha

| Campo | Valor |
|---|---|
| ID | US-031 |
| Épica / capacidad | Roles y competencias (IMD-001, bloque 1) |
| Horizonte / release | Por definir |
| Actor | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) o [ADMIN](../../business/glossary/terms/TRM-0028-admin.md) |
| Responsable de negocio (PO) | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) (responsable funcional del portal, /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L109) |
| Prioridad | Must: la ocupación da al colaborador su rol/nivel vigente (BR-047). La decide el PO. |
| Dependencias | US-004, US-030 |
| Preparación | READY |

## 2. Historia

**Como** Jefe de Ingeniería o usuario con perfil ADMIN, **quiero** registrar la ocupación de una plaza por un colaborador, con su periodo, **para** que cada colaborador tenga su único rol/nivel vigente y se conserve su historial.

## 3. Contexto y valor

- **Problema que resuelve:** El colaborador ocupa una plaza durante un periodo, con vigencia desde y hasta (BR-097). Su único rol/nivel vigente es el de la plaza que ocupa (BR-047) y el historial son sus ocupaciones (BR-079). Una plaza la ocupa como máximo un colaborador (BR-106).
- **Valor esperado:** Cada colaborador con un único rol/nivel vigente y su historial de plazas.
- **Métrica o KPI que impacta:** Sin métrica asociada

## 4. Alcance

- **Incluye:**
  - Registrar que un colaborador ocupa una plaza desde una fecha.
  - Terminar una ocupación con una fecha hasta.
  - Conservar el historial de ocupaciones.
- **Excluye:**
  - Registrar las plazas (US-030).
  - Decidir la promoción (US-017), que cambia el rol/nivel de la plaza y mantiene a la persona en ella (BR-110).

## 5. Criterios de aceptación

### AC-1 — Ocupar una plaza

```gherkin
Escenario: Ocupar una plaza
  Dado un colaborador registrado y una plaza vacante
  Cuando se registra que la ocupa desde una fecha
  Entonces el colaborador ocupa la plaza y su rol/nivel vigente es el de la plaza
```

- **Regla / fuente:** BR-097, BR-047

### AC-2 — Una plaza no admite dos ocupantes

```gherkin
Escenario: Una plaza no admite dos ocupantes
  Dado una plaza con una ocupación vigente
  Cuando se intenta registrar a otro colaborador en la misma plaza
  Entonces el portal no lo permite
```

- **Regla / fuente:** BR-106

### AC-3 — Un único rol/nivel vigente

```gherkin
Escenario: Un único rol/nivel vigente
  Dado un colaborador que ya ocupa una plaza
  Cuando se intenta registrarlo en otra plaza con una ocupación vigente a la vez
  Entonces el portal no lo permite, porque su único rol/nivel vigente es el de la plaza que ocupa
```

- **Regla / fuente:** BR-047

### AC-4 — Terminar una ocupación

```gherkin
Escenario: Terminar una ocupación
  Dado una ocupación vigente
  Cuando se registra su fecha hasta
  Entonces la ocupación termina y se conserva en el historial
```

- **Regla / fuente:** BR-097, BR-079

## 6. Casos negativos y límite

| Caso | Comportamiento esperado | Fuente o pregunta |
|---|---|---|
| Usuario sin permiso | No puede: lo mantienen el Jefe de Ingeniería y el ADMIN | BR-135 |
| Ocupar una plaza con una persona que no es colaborador | Sin regla: la regla dice que el colaborador la ocupa | BR-097 |
| Fechas con hasta anterior a desde | Sin regla | US-031-Q2 |
| Registrar una ocupación en el pasado o con huecos entre ocupaciones | Sin regla | US-031-Q2 |
| Pasar de una plaza a otra: orden de las dos ocupaciones | Sin regla | US-031-Q2 |

## 7. Reglas de negocio aplicables

| ID | Regla | Fuente |
|---|---|---|
| BR-097 | Cada organización tiene plazas. Cada plaza es de un rol/nivel (tipo de puesto) y el colaborador la ocupa durante un periodo, con vigencia desde y hasta. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L137 |
| BR-047 | Un colaborador tiene un único rol/nivel vigente en cada momento: el del puesto de la plaza que ocupa. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L87 |
| BR-079 | Se conserva el historial de cambios de nivel y seniority (rol/nivel) de cada colaborador: es el historial de rol/nivel de la plaza que ocupa, con vigencia (BR-110). | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L119 |
| BR-106 | Una plaza la ocupa como máximo un colaborador a la vez. Si se requieren dos developers senior, se registran como dos plazas. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L146 |
| BR-110 | Al promover de nivel, la plaza cambia de rol/nivel y el colaborador sigue en la misma plaza. La plaza conserva el historial de su rol/nivel con vigencia. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L150 |
| BR-002 | Solo el Jefe de Ingeniería o un usuario con perfil ADMIN registra y modifica colaboradores. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L42 |
| BR-135 | El Jefe de Ingeniería y el ADMIN mantienen los datos de contacto, las plazas, las ocupaciones de plaza, los roles de la parte, las relaciones entre partes y las organizaciones. | /business/rules\BRC-001-reglas-de-negocio-portal-curricula.md:L175 |

## 8. Datos y términos

| Término | Uso en esta historia | Glosario |
|---|---|---|
| Ocupación de plaza | Elemento que se mantiene | [Ocupación de plaza](../../business/glossary/terms/TRM-0064-ocupacion-de-plaza.md) |
| Plaza | Plaza ocupada | [Plaza](../../business/glossary/terms/TRM-0063-plaza.md) |
| Colaborador | Quien la ocupa | [Colaborador](../../business/glossary/terms/TRM-0002-colaborador.md) |
| Rol/nivel | Resultado de ocupar la plaza | [Rol/nivel](../../business/glossary/terms/TRM-0006-rol-nivel.md) |
| Jefe de Ingeniería | Actor | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) |

## 9. Requisitos no funcionales

- **Accesibilidad:** WCAG 2.2 AA (estándar del repositorio).
- **Privacidad y datos personales:** Toca la identidad del colaborador y su historial laboral, que se retienen por siempre (BR-101). Política aplazada como deuda técnica DT-01 (RQ-34).
- **Otros:** Sin requisito identificado

## 10. Consideraciones de UX

- **Flujo esperado:** El actor elige una plaza vacante y un colaborador y registra la fecha desde; termina la ocupación con la fecha hasta.
- **Estados de la interfaz:** Sin plazas vacantes, sin permisos, error, éxito.
- **Contenido clave:** Plaza, colaborador, periodo y rol/nivel resultante.

## 11. Dependencias, supuestos e hipótesis

- **Depende de:** US-004 (colaborador) y US-030 (plaza).
- **Es prerrequisito de:** US-017, US-021 (la asignación usa el rol/nivel del colaborador).
- **Supuestos:** Ninguno
- **Hipótesis del agente:** Ninguna. El actor lo sostiene BR-135.

## 12. Preguntas abiertas

| ID | Pregunta | Responsable | Prioridad | Bloquea | Estado |
|---|---|---|---|---|---|
| US-031-Q1 | Cerrada el 2026-10-12: lo mantienen el Jefe de Ingeniería y el ADMIN (BR-135). | Jefe de Ingeniería | Media | No | Cerrada |
| US-031-Q2 | ¿Qué fechas son válidas (hasta posterior a desde, huecos y solapes entre ocupaciones, registros en el pasado)? | Jefe de Ingeniería | Media | No | Abierta |

## 13. Evidencia y trazabilidad

| ID | Hallazgo | Fuente | Clasificación | Confianza |
|---|---|---|---|---|
| EVD-2026-0070 | Un colaborador tiene un único rol/nivel vigente en cada momento | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L165 | decision | high |
| EVD-2026-0115 | Se conserva el historial de cambios de nivel y seniority de cada colaborador | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L499 | decision | high |
| EVD-2026-0141 | El colaborador ocupa una plaza con vigencia desde y hasta. Su rol/nivel es el de la plaza y el historial son sus ocupaciones | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L538 | decision | high |
| EVD-2026-0146 | Una plaza la ocupa como máximo un colaborador; dos requeridos son dos plazas | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L543 | decision | high |
| EVD-2026-0151 | La promoción cambia el rol/nivel de la plaza; la plaza conserva el historial | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L548 | decision | high |
| EVD-2026-0174 | El Jefe de Ingeniería y el ADMIN mantienen contactos, plazas, ocupaciones, roles de la parte, relaciones y organizaciones | /requirements/context-packs\RCP-001-portal-gestion-curricula-desarrollo.md:L573 | decision | high |

Evidencia compartida: `source_type: human`, `observed_at: 2026-10-11T00:00:00Z`, `freshness: current`, `owner: Jefe de Ingeniería`. La indicación del responsable del 2026-10-12 sobre las funcionalidades de mantenimiento de la parte se recoge en la sección 12.

- **Upstream:** [BRC-001](../../business/rules/BRC-001-reglas-de-negocio-portal-curricula.md), [IMD-001](../../business/information-model/IMD-001-portal-curricula.md), [GLS-001](../../business/glossary/GLS-001-glosario-de-negocio.md) y [RCP-001](../context-packs/RCP-001-portal-gestion-curricula-desarrollo.md).
- **Downstream (pendiente):** UXR → FLW → SCR → CMP → AC

## 14. Evaluación INVEST

| Criterio | ¿Cumple? | Justificación |
|---|---|---|
| Independiente | Parcial | Necesita US-004 y US-030. |
| Negociable | Parcial | Reglas de fechas abiertas (US-031-Q2). |
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
- **Motivo:** Los criterios están sostenidos por BR-097, BR-047 y BR-106. El actor está sostenido por BR-135 y las preguntas abiertas no bloquean los criterios.
- **Bloqueos de entrega:** Ninguno. Falta que existan US-004 y US-030.
- **Propuesta de división (si no es pequeña):** No aplica
- **Siguiente rol o Skill:** `ux-requirements-analyzer`
- **Decisión humana requerida:** El Jefe de Ingeniería responde las preguntas abiertas y valida la historia.
- **Origen:** historia nueva del 2026-10-12, pedida por el responsable funcional (OI-11 del handoff de base de datos): «debemos incorporar funcionalidades para mantener los contactos de las Party, plazas, ocupaciones, roles de la parte, corrección de vínculo y relaciones».
- **Validación:** Pendiente · Responsable: Jefe de Ingeniería · Fecha: —
