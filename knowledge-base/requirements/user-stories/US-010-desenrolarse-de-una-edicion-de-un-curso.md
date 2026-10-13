---
type: User Story
title: "US-010 — Desenrolarse de una edición de un curso"
description: "Como Colaborador, quiero desenrolarme de una edición en la que estoy enrolado, para dejar de participar cuando ya no me corresponda o no pueda asistir."
tags: [user-story, por-definir, cursos, enrolamiento]
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
gitlab_issue_id: 52921
gitlab_issue_iid: 11
gitlab_issue_url: https://project.comsatel.com.pe/comsatel/development/training/dev-juniors/p3m/collaboration/-/issues/11
---

# US-010 — Desenrolarse de una edición de un curso

## 1. Ficha

| Campo | Valor |
|---|---|
| ID | US-010 |
| Épica / capacidad | Cursos y evidencias (IMD-001, bloque 2) |
| Horizonte / release | Por definir |
| Actor | [Colaborador](../../business/glossary/terms/TRM-0002-colaborador.md) |
| Responsable de negocio (PO) | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) (responsable funcional del portal, /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L109) |
| Prioridad | Should: complementa el enrolamiento, pero no lo bloquea. La decide el PO. |
| Dependencias | US-009 |
| Preparación | READY |

## 2. Historia

**Como** Colaborador, **quiero** desenrolarme de una edición en la que estoy enrolado, **para** dejar de participar cuando ya no me corresponda o no pueda asistir.

## 3. Contexto y valor

- **Problema que resuelve:** El colaborador puede desenrolarse de una edición (BR-027).
- **Valor esperado:** El colaborador controla su participación en el entrenamiento.
- **Métrica o KPI que impacta:** Sin métrica asociada

## 4. Alcance

- **Incluye:**
  - Desenrolarse de una edición en la que el colaborador está enrolado.
- **Excluye:**
  - Enrolarse (US-009).
  - Reglas de plazo, con evidencias aportadas o con certificación (US-010-Q1).

## 5. Criterios de aceptación

### AC-1 — Desenrolarse de una edición

```gherkin
Escenario: Desenrolarse de una edición
  Dado un colaborador enrolado en una edición
  Cuando se desenrola de esa edición
  Entonces deja de estar enrolado en la edición
```

- **Regla / fuente:** BR-027

### AC-2 — Solo el colaborador enrolado puede desenrolarse

```gherkin
Escenario: Solo el colaborador enrolado puede desenrolarse
  Dado una edición en la que el colaborador no está enrolado
  Cuando intenta desenrolarse
  Entonces el portal no tiene un enrolamiento que quitar
```

- **Regla / fuente:** BR-027

## 6. Casos negativos y límite

| Caso | Comportamiento esperado | Fuente o pregunta |
|---|---|---|
| Colaborador no enrolado en la edición | No hay enrolamiento que quitar | BR-027 |
| Desenrolarse con evidencias ya aportadas o validadas | Sin regla | US-010-Q1 |
| Desenrolarse de una edición ya iniciada, finalizada o certificada | Sin regla | US-010-Q1 |
| El cupo liberado puede ocuparlo otro colaborador | Sin regla | US-010-Q1 |
| Volver a enrolarse después de desenrolarse | Se puede (ver US-009, AC-4) | BR-122 |
| El desenrolamiento borra el registro o lo conserva | Sin regla | US-010-Q2 |

## 7. Reglas de negocio aplicables

| ID | Regla | Fuente |
|---|---|---|
| BR-027 | El colaborador puede desenrolarse de una edición. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L67 |
| BR-025 | El colaborador se auto-enrola en una edición. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L65 |
| BR-122 | El colaborador que se desenrola de una edición puede volver a enrolarse en ella. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L162 |
| BR-101 | Los datos personales se retienen igual que los logs: por siempre. El tratamiento de clasificación, cifrado y acceso sigue pendiente (RQ-34). | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L141 |

## 8. Datos y términos

| Término | Uso en esta historia | Glosario |
|---|---|---|
| Enrolamiento | Registro que se da por terminado. Si se borra o se conserva como histórico: US-010-Q2 | [Enrolamiento](../../business/glossary/terms/TRM-0015-enrolamiento.md) |
| Colaborador | Actor | [Colaborador](../../business/glossary/terms/TRM-0002-colaborador.md) |
| Edición de curso | Edición de la que se sale | [Edición de curso](../../business/glossary/terms/TRM-0013-edicion-de-curso.md) |

## 9. Requisitos no funcionales

- **Accesibilidad:** WCAG 2.2 AA (estándar del repositorio).
- **Privacidad y datos personales:** Toca la identidad del colaborador. Restricción: BR-003 y la política pendiente G-12.
- **Otros:** Sin requisito identificado

## 10. Consideraciones de UX

- **Flujo esperado:** El colaborador abre sus enrolamientos y se desenrola de uno.
- **Estados de la interfaz:** Sin enrolamientos, error, éxito.
- **Contenido clave:** Edición de la que se sale y confirmación del resultado.

## 11. Dependencias, supuestos e hipótesis

- **Depende de:** US-009 (enrolamiento).
- **Es prerrequisito de:** —
- **Supuestos:** Ninguno
- **Hipótesis del agente:** H-1: el desenrolamiento no borra el registro del enrolamiento, porque BR-101 retiene los datos personales por siempre. Lo confirmaría US-010-Q2.

## 12. Preguntas abiertas

| ID | Pregunta | Responsable | Prioridad | Bloquea | Estado |
|---|---|---|---|---|---|
| US-010-Q1 | ¿Hay un plazo o condiciones para desenrolarse (edición iniciada, con evidencias aportadas o certificada)? ¿El cupo liberado puede ocuparse? | Jefe de Ingeniería | Media | No | Abierta |
| US-010-Q2 | ¿El desenrolamiento borra el registro del enrolamiento o lo conserva como histórico, dado que los datos personales se retienen por siempre (BR-101)? | Jefe de Ingeniería | Media | No | Abierta |

## 13. Evidencia y trazabilidad

| ID | Hallazgo | Fuente | Clasificación | Confianza |
|---|---|---|---|---|
| EVD-2026-0061 | El curso tiene fecha de inicio y fin. Al llegar al cupo no se admite más enrolamiento. El colaborador puede desenrolarse | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L156 | decision | medium |
| EVD-2026-0143 | Los datos personales se retienen igual que los logs | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L540 | decision | high |
| EVD-2026-0161 | Quien se desenrola de una edición puede volver a enrolarse en la misma edición | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L558 | decision | high |

Evidencia compartida: `source_type: human`, `observed_at: 2026-10-10T12:00:00-05:00`, `freshness: current`, `owner: Jefe de Ingeniería`. Las evidencias EVD-2026-0143 a EVD-2026-0169 se observaron el 2026-10-11T00:00:00Z.

- **Upstream:** [BRC-001](../../business/rules/BRC-001-reglas-de-negocio-portal-curricula.md), [IMD-001](../../business/information-model/IMD-001-portal-curricula.md), [GLS-001](../../business/glossary/GLS-001-glosario-de-negocio.md) y [RCP-001](../context-packs/RCP-001-portal-gestion-curricula-desarrollo.md), todos en estado `draft`.
- **Downstream (pendiente):** UXR → FLW → SCR → CMP → AC

## 14. Evaluación INVEST

| Criterio | ¿Cumple? | Justificación |
|---|---|---|
| Independiente | Parcial | Necesita US-009. |
| Negociable | Sí | Los plazos se pueden conversar (US-010-Q1). |
| Valiosa | Sí | El colaborador controla su participación en el entrenamiento. |
| Estimable | Sí | Alcance acotado. |
| Pequeña (Small) | Sí | Cabe en una iteración. |
| Testeable | Parcial | El comportamiento sostenido por la fuente es mínimo: puede desenrolarse. |

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
- **Motivo:** Actor, valor y criterios están sostenidos por BR-027. Las preguntas abiertas no bloquean los criterios.
- **Bloqueos de entrega:** Ninguno
- **Propuesta de división (si no es pequeña):** No aplica
- **Siguiente rol o Skill:** `ux-requirements-analyzer`
- **Decisión humana requerida:** El Jefe de Ingeniería (validó la historia el 2026-10-12) responde US-010-Q1 y US-010-Q2.
- **Actualización 2026-10-12:** se registra que quien se desenrola puede volver a enrolarse (BR-122) y se abre US-010-Q2 sobre qué ocurre con el registro (BR-101). Verificada de nuevo por ianache el 2026-10-12.
- **Validación:** Aprobada · Responsable: Jefe de Ingeniería (ianache) · Fecha: 2026-10-12
