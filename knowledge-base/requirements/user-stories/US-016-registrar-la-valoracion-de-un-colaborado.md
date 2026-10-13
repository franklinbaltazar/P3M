---
type: User Story
title: "US-016 — Registrar la valoración de un colaborador"
description: "Como Jefe de Ingeniería o usuario con perfil ADMIN, quiero registrar el nivel actual (N1, N2 o N3) de cada competencia de un colaborador, conservando el historial, para conocer su situación frente a su rol/nivel y decidir asignaciones y promociones."
tags: [user-story, por-definir, valoracion, progresion]
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
gitlab_issue_id: 52927
gitlab_issue_iid: 17
gitlab_issue_url: https://project.comsatel.com.pe/comsatel/development/training/dev-juniors/p3m/collaboration/-/issues/17
---

# US-016 — Registrar la valoración de un colaborador

## 1. Ficha

| Campo | Valor |
|---|---|
| ID | US-016 |
| Épica / capacidad | Progresión (IMD-001, bloque 3) |
| Horizonte / release | Por definir |
| Actor | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) / [ADMIN](../../business/glossary/terms/TRM-0028-admin.md) |
| Responsable de negocio (PO) | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) (responsable funcional del portal, /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L109) |
| Prioridad | Must: la brecha, la asignación y la promoción dependen del nivel actual. La decide el PO. |
| Dependencias | US-002, US-004 |
| Preparación | READY |

## 2. Historia

**Como** Jefe de Ingeniería o usuario con perfil ADMIN, **quiero** registrar el nivel actual (N1, N2 o N3) de cada competencia de un colaborador, conservando el historial, **para** conocer su situación frente a su rol/nivel y decidir asignaciones y promociones.

## 3. Contexto y valor

- **Problema que resuelve:** La valoración registra el nivel actual de cada competencia del colaborador, con historial, y la registran el Jefe de Ingeniería o un ADMIN (BR-004, BR-051).
- **Valor esperado:** Un registro vigente e histórico del nivel de cada colaborador.
- **Métrica o KPI que impacta:** Sin métrica asociada

## 4. Alcance

- **Incluye:**
  - Registrar el nivel actual de una competencia de un colaborador.
  - Conservar el historial de valoraciones.
- **Excluye:**
  - Mostrar la brecha (US-017).
  - Decidir la promoción (US-017).

## 5. Criterios de aceptación

### AC-1 — Registrar el nivel actual

```gherkin
Escenario: Registrar el nivel actual
  Dado un colaborador y una competencia
  Cuando el Jefe de Ingeniería o un ADMIN registra el nivel N2 como su nivel actual
  Entonces la valoración del colaborador muestra N2 en esa competencia
```

- **Regla / fuente:** BR-004

### AC-2 — Se conserva el historial

```gherkin
Escenario: Se conserva el historial
  Dado un colaborador con una valoración N1 en una competencia
  Cuando se registra una nueva valoración N2
  Entonces el historial conserva N1 y N2
```

- **Regla / fuente:** BR-051

### AC-3 — Solo el Jefe de Ingeniería o un ADMIN valora

```gherkin
Escenario: Solo el Jefe de Ingeniería o un ADMIN valora
  Dado un usuario que no es el Jefe de Ingeniería ni tiene perfil ADMIN
  Cuando intenta registrar una valoración
  Entonces el portal no lo permite
```

- **Regla / fuente:** BR-004

## 6. Casos negativos y límite

| Caso | Comportamiento esperado | Fuente o pregunta |
|---|---|---|
| Nivel distinto de N1, N2 o N3 | No es válido | BR-013 |
| Usuario sin perfil de Jefe de Ingeniería ni ADMIN | No puede valorar | BR-004 |
| Competencia que no pertenece al perfil del colaborador | Sin regla | US-016-Q1 |
| Datos de la valoración (fecha, comentario, evidencias que la sustentan) | Sin regla | US-016-Q1 |

## 7. Reglas de negocio aplicables

| ID | Regla | Fuente |
|---|---|---|
| BR-004 | Solo el Jefe de Ingeniería o un usuario con perfil ADMIN registra la valoración del colaborador: el nivel actual (N1 a N3) de cada una de sus competencias. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L44 |
| BR-051 | La valoración conserva el historial de los niveles actuales de las competencias del colaborador. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L91 |
| BR-013 | La escala de logro de una competencia es: N1 no desarrollada, N2 en desarrollo, N3 desarrollada. No equivale a los niveles L1–L4. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L53 |

## 8. Datos y términos

| Término | Uso en esta historia | Glosario |
|---|---|---|
| Valoración de cumplimiento | Registro que se crea | [Valoración de cumplimiento](../../business/glossary/terms/TRM-0025-valoracion-de-cumplimiento.md) |
| Competencia | Competencia valorada | [Competencia](../../business/glossary/terms/TRM-0007-competencia.md) |
| Nivel de logro (N1–N3) | Nivel registrado | [Nivel de logro (N1–N3)](../../business/glossary/terms/TRM-0008-nivel-de-logro-n1-n3.md) |
| Colaborador | Valorado | [Colaborador](../../business/glossary/terms/TRM-0002-colaborador.md) |

## 9. Requisitos no funcionales

- **Accesibilidad:** WCAG 2.2 AA (estándar del repositorio).
- **Privacidad y datos personales:** Toca la identidad de colaboradores. Restricción: BR-003 y la política pendiente G-12.
- **Otros:** Auditoría: el historial conserva las valoraciones anteriores (BR-051).

## 10. Consideraciones de UX

- **Flujo esperado:** El actor elige un colaborador, ve sus competencias y registra el nivel actual de cada una.
- **Estados de la interfaz:** Sin valoración previa, sin permisos, error, éxito.
- **Contenido clave:** Nivel actual, historial y nivel mínimo del rol/nivel.

## 11. Dependencias, supuestos e hipótesis

- **Depende de:** US-002 (competencias) y US-004 (colaboradores).
- **Es prerrequisito de:** US-017, US-021
- **Supuestos:** Ninguno
- **Hipótesis del agente:** Ninguna

## 12. Preguntas abiertas

| ID | Pregunta | Responsable | Prioridad | Bloquea | Estado |
|---|---|---|---|---|---|
| US-016-Q1 | ¿Qué datos tiene una valoración (fecha, comentario, evidencias) y puede valorarse una competencia ajena al perfil? | Jefe de Ingeniería | Media | No | Abierta |

## 13. Evidencia y trazabilidad

| ID | Hallazgo | Fuente | Clasificación | Confianza |
|---|---|---|---|---|
| EVD-2026-0062 | La valoración del colaborador (su nivel actual en las competencias) la registra el Jefe de Ingeniería o un usuario con rol ADMIN | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L157 | decision | medium |
| EVD-2026-0073 | La valoración registra el nivel actual de cada competencia del colaborador, con historial, y el portal muestra la brecha frente al siguiente nivel | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L168 | decision | high |

Evidencia compartida: `source_type: human`, `observed_at: 2026-10-10T12:00:00-05:00`, `freshness: current`, `owner: Jefe de Ingeniería`.

- **Upstream:** [BRC-001](../../business/rules/BRC-001-reglas-de-negocio-portal-curricula.md), [IMD-001](../../business/information-model/IMD-001-portal-curricula.md), [GLS-001](../../business/glossary/GLS-001-glosario-de-negocio.md) y [RCP-001](../context-packs/RCP-001-portal-gestion-curricula-desarrollo.md), todos en estado `draft`.
- **Downstream (pendiente):** UXR → FLW → SCR → CMP → AC

## 14. Evaluación INVEST

| Criterio | ¿Cumple? | Justificación |
|---|---|---|
| Independiente | Parcial | Necesita US-002 y US-004. |
| Negociable | Parcial | Los datos de la valoración quedan abiertos (US-016-Q1). |
| Valiosa | Sí | Un registro vigente e histórico del nivel de cada colaborador. |
| Estimable | Sí | Alcance acotado. |
| Pequeña (Small) | Sí | Cabe en una iteración. |
| Testeable | Sí | Los 3 criterios son verificables. |

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
- **Motivo:** Actor, valor y criterios sostenidos por BR-004 y BR-051. La pregunta abierta no bloquea.
- **Bloqueos de entrega:** Ninguno
- **Propuesta de división (si no es pequeña):** No aplica
- **Siguiente rol o Skill:** `ux-requirements-analyzer`
- **Decisión humana requerida:** El Jefe de Ingeniería valida la historia y responde US-016-Q1.
- **Validación:** Pendiente · Responsable: Jefe de Ingeniería · Fecha: —
