---
type: User Story
title: "US-026 — Registrar la evaluación de desempeño de un colaborador"
description: "Como Jefe de Ingeniería, quiero registrar la evaluación de desempeño de un colaborador con la información de sus cursos y sus evidencias de proyecto, para decidir con fundamento si cambia de rol/nivel."
tags: [user-story, evaluacion-de-desempeno, promocion]
status: draft
generated:
  by: "af-user-story-refiner/2.0"
  at: "2026-10-10T23:00:00-05:00"
sources:
  - id: brc-001
    resource: /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md
  - id: rcp-001
    resource: /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md
  - id: gls-001
    resource: /business/glossary/GLS-001-glosario-de-negocio.md
  - id: imd-001
    resource: /business/information-model/IMD-001-portal-curricula.md
gitlab_issue_id: 52937
gitlab_issue_iid: 27
gitlab_issue_url: https://project.comsatel.com.pe/comsatel/development/training/dev-juniors/p3m/collaboration/-/issues/27
---

# US-026 — Registrar la evaluación de desempeño de un colaborador

## 1. Ficha

| Campo | Valor |
|---|---|
| ID | US-026 |
| Épica / capacidad | Progresión (IMD-001, bloque 3) |
| Horizonte / release | Por definir |
| Actor | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) o [ADMIN](../../business/glossary/terms/TRM-0028-admin.md) |
| Responsable de negocio (PO) | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) (responsable funcional del portal, /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L109) |
| Prioridad | Must: es el insumo de la promoción. La decide el PO. |
| Dependencias | US-013, US-014 |
| Preparación | READY |

## 2. Historia

**Como** Jefe de Ingeniería o usuario con perfil ADMIN, **quiero** registrar la evaluación de desempeño de un colaborador, con la información de evaluación de sus cursos y las evidencias que aportó sobre su desempeño en los proyectos, **para** decidir con fundamento si cambia de rol/nivel.

## 3. Contexto y valor

- **Problema que resuelve:** La promoción necesita una evaluación periódica basada en las evidencias disponibles (BR-083, BR-086).
- **Valor esperado:** Promociones decididas con evidencia y una evaluación semestral trazable.
- **Métrica o KPI que impacta:** Sin métrica asociada

## 4. Alcance

- **Incluye:**
  - Registrar la evaluación de desempeño de un colaborador, semestral o a demanda.
  - Consultar la información de evaluación de sus cursos y sus evidencias de proyecto.
  - Registrar el resultado: supera, cumple, parcial o no cumple.
- **Excluye:**
  - Decidir la promoción (US-017).
  - Aportar o validar evidencias (US-013, US-014, US-015).

## 5. Criterios de aceptación

### AC-1 — Evaluar con la información disponible

```gherkin
Escenario: Evaluar con la información disponible
  Dado un Jefe de Ingeniería y un colaborador con certificaciones y evidencias validadas
  Cuando registra la evaluación de desempeño del colaborador
  Entonces el portal le muestra las certificaciones y evidencias validadas y guarda la evaluación
```

- **Regla / fuente:** BR-083

### AC-2 — Escala de resultado

```gherkin
Escenario: Registrar el resultado
  Dado una evaluación de desempeño en curso
  Cuando el Jefe de Ingeniería registra el resultado
  Entonces el resultado es supera, cumple, parcial o no cumple
```

- **Regla / fuente:** BR-085

### AC-3 — Semestral o a demanda

```gherkin
Escenario: Evaluar a demanda
  Dado un colaborador, sin que haya llegado la evaluación semestral
  Cuando el Jefe de Ingeniería decide evaluarlo, por criterio propio o a solicitud del colaborador
  Entonces el portal permite registrar la evaluación
```

- **Regla / fuente:** BR-084

### AC-4 — Insumo de la promoción

```gherkin
Escenario: La evaluación alimenta la promoción
  Dado una evaluación de desempeño registrada
  Cuando el Jefe de Ingeniería decide sobre un cambio de rol/nivel
  Entonces dispone de la evaluación para valorar el cumplimiento de las competencias del nuevo rol/nivel con las evidencias disponibles
```

- **Regla / fuente:** BR-086

### AC-5 — Solo el Jefe de Ingeniería o el ADMIN

```gherkin
Escenario: Solo el Jefe de Ingeniería o el ADMIN evalúa
  Dado un usuario que no es Jefe de Ingeniería
  Cuando intenta registrar una evaluación de desempeño
  Entonces el portal no lo permite
```

- **Regla / fuente:** BR-083, BR-134

### AC-6 — Datos que se registran

```gherkin
Escenario: Datos de la evaluación
  Dado una evaluación de desempeño que el Jefe de Ingeniería guarda
  Cuando el portal la registra
  Entonces conserva el resultado, el periodo, los comentarios, las evidencias consideradas, la fecha y hora del registro y el usuario que la registra
```

- **Regla / fuente:** BR-087

### AC-7 — Historial de evaluaciones

```gherkin
Escenario: Conservar el historial
  Dado un colaborador con una evaluación de desempeño anterior
  Cuando se registra una nueva evaluación
  Entonces el portal conserva el historial de las evaluaciones del colaborador
```

- **Regla / fuente:** BR-089

## 6. Casos negativos y límite

| Caso | Comportamiento esperado | Fuente o pregunta |
|---|---|---|
| Colaborador sin certificaciones ni evidencias validadas | Sin regla | US-026-Q1 |
| Evaluación obligatoria para promover | Sin ella no se promueve | BR-088 |
| Datos que se registran además del resultado | Periodo, comentarios, evidencias consideradas, fecha y hora y usuario | BR-087 |
| Conservación del historial de evaluaciones | Se conserva | BR-089 |

## 7. Reglas de negocio aplicables

| ID | Regla | Fuente |
|---|---|---|
| BR-083 | La evaluación de desempeño de un colaborador la realiza el Jefe de Ingeniería con las certificaciones y las evidencias validadas del colaborador, que incluyen la información de evaluación de los cursos y las evidencias que aporta sobre su desempeño en los proyectos. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L123 |
| BR-084 | La evaluación de desempeño es semestral. El Jefe de Ingeniería puede realizarla a demanda, por criterio propio o a solicitud del colaborador. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L124 |
| BR-085 | El resultado de la evaluación de desempeño se expresa con la escala supera, cumple, parcial o no cumple. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L125 |
| BR-086 | La evaluación de desempeño es un insumo para la promoción. De ella se decide si hay un cambio de rol/nivel según el cumplimiento de los requisitos de las competencias del nuevo rol/nivel con las evidencias disponibles. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L126 |
| BR-087 | La evaluación de desempeño registra el resultado, el periodo, los comentarios, las evidencias consideradas, la fecha y hora del registro y el usuario que la registra. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L127 |
| BR-089 | Se conserva el historial de evaluaciones de desempeño de cada colaborador. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L129 |
| BR-088 | La evaluación de desempeño es obligatoria para promover al colaborador a un nuevo rol/nivel. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L128 |
| BR-134 | El ADMIN puede hacer también las seis capacidades que eran exclusivas del Jefe de Ingeniería (BR-005, BR-006, BR-007, BR-055, BR-083, BR-129). | /business/rules\BRC-001-reglas-de-negocio-portal-curricula.md:L174 |


## 8. Datos y términos

| Término | Uso en esta historia | Glosario |
|---|---|---|
| Evaluación de desempeño | Elemento que se registra | [Evaluación de desempeño](../../business/glossary/terms/TRM-0053-evaluacion-de-desempeno.md) |
| Evidencia aportada | Insumo de la evaluación | [Evidencia aportada](../../business/glossary/terms/TRM-0041-evidencia-aportada.md) |
| Promoción de nivel | Decisión que alimenta | [Promoción de nivel](../../business/glossary/terms/TRM-0024-promocion-de-nivel.md) |
| Colaborador | Persona evaluada | [Colaborador](../../business/glossary/terms/TRM-0002-colaborador.md) |

## 9. Requisitos no funcionales

- **Accesibilidad:** WCAG 2.2 AA (estándar del repositorio).
- **Privacidad y datos personales:** Toca la evaluación de un colaborador. Restricción: BR-003 y la política pendiente G-12.
- **Otros:** Sin requisito identificado

## 10. Consideraciones de UX

- **Flujo esperado:** El Jefe de Ingeniería elige un colaborador, revisa sus cursos y evidencias, y registra el resultado.
- **Estados de la interfaz:** Sin información previa, sin permisos, error, éxito.
- **Contenido clave:** Evaluaciones de cursos, evidencias de proyecto y resultado.

## 11. Dependencias, supuestos e hipótesis

- **Depende de:** US-013 y US-014 (evidencias) y la certificación de cursos (US-012).
- **Es prerrequisito de:** US-017
- **Supuestos:** Ninguno
- **Hipótesis del agente:** Ninguna

## 12. Preguntas abiertas

| ID | Pregunta | Responsable | Prioridad | Bloquea | Estado |
|---|---|---|---|---|---|
| US-026-Q1 | ¿Se puede evaluar a un colaborador que no tiene evaluaciones de cursos ni evidencias de proyecto? | Jefe de Ingeniería | Baja | No | Abierta |

## 13. Evidencia y trazabilidad

| ID | Hallazgo | Fuente | Clasificación | Confianza |
|---|---|---|---|---|
| EVD-2026-0123 | La evaluación de desempeño usa la evaluación de los cursos y las evidencias de proyecto; la realiza el Jefe de Ingeniería | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L508 | decision | high |
| EVD-2026-0124 | La evaluación de desempeño es semestral y puede hacerse a demanda | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L509 | decision | high |
| EVD-2026-0125 | La escala es supera, cumple, parcial o no cumple | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L510 | decision | high |
| EVD-2026-0126 | La evaluación es un insumo para la promoción | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L511 | decision | high |
| EVD-2026-0127 | La evaluación registra resultado, periodo, comentarios, evidencias, fecha y hora y usuario | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L512 | decision | high |
| EVD-2026-0129 | Se conserva el historial de evaluaciones de desempeño | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L514 | decision | high |
| EVD-2026-0128 | La evaluación de desempeño es obligatoria para promover a un nuevo rol/nivel | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L513 | decision | high |
| EVD-2026-0130 | La evaluación considera las certificaciones y las evidencias validadas | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L515 | decision | high |
| EVD-2026-0173 | El ADMIN suple las seis capacidades exclusivas del Jefe de Ingeniería | /requirements/context-packs\RCP-001-portal-gestion-curricula-desarrollo.md:L572 | decision | high |

Evidencia compartida: `source_type: human`, `observed_at: 2026-10-10T23:00:00-05:00`, `freshness: current`, `owner: Jefe de Ingeniería`.

- **Upstream:** [BRC-001](../../business/rules/BRC-001-reglas-de-negocio-portal-curricula.md), [IMD-001](../../business/information-model/IMD-001-portal-curricula.md), [GLS-001](../../business/glossary/GLS-001-glosario-de-negocio.md) y [RCP-001](../context-packs/RCP-001-portal-gestion-curricula-desarrollo.md).
- **Downstream (pendiente):** UXR → FLW → SCR → CMP → AC

## 14. Evaluación INVEST

| Criterio | ¿Cumple? | Justificación |
|---|---|---|
| Independiente | Parcial | Necesita las evidencias (US-013, US-014). |
| Negociable | Sí | Datos, obligatoriedad e historial definidos. |
| Valiosa | Sí | Promociones decididas con evidencia. |
| Estimable | Sí | Alcance y actor definidos. |
| Pequeña (Small) | Sí | Cabe en una iteración. |
| Testeable | Sí | Los 7 criterios son verificables. |

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
- **Motivo:** Actor, valor y criterios sostenidos por BR-134, BR-083 a BR-086. RQ-28 quedó cerrada. US-026-Q1 no bloquea.
- **Bloqueos de entrega:** Ninguno
- **Propuesta de división (si no es pequeña):** No aplica
- **Siguiente rol o Skill:** `ux-requirements-analyzer`
- **Decisión humana requerida:** El Jefe de Ingeniería valida la historia.
- **Validación:** Pendiente · Responsable: Jefe de Ingeniería · Fecha: —
