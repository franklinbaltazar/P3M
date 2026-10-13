---
type: User Story
title: "US-020 — Cargar automáticamente los datos de GitLab y consultar el registro de cargas"
description: "Como Jefe de Ingeniería o ADMIN, quiero que el portal cargue de forma automática solo lo nuevo de GitLab y ver una consola de logs de cada carga con opción de reintento, para confiar en que la información de proyectos está al día."
tags: [user-story, gitlab, carga-automatica]
status: approved
generated:
  by: "af-user-story-refiner/2.0"
  at: "2026-10-10T18:00:00-05:00"
verified:
  by: "ianache (Functional Analysis)"
  at: "2026-10-10T23:30:00-05:00"
sources:
  - id: brc-001
    resource: /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md
  - id: rcp-001
    resource: /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md
  - id: gls-001
    resource: /business/glossary/GLS-001-glosario-de-negocio.md
  - id: imd-001
    resource: /business/information-model/IMD-001-portal-curricula.md
gitlab_issue_id: 52931
gitlab_issue_iid: 21
gitlab_issue_url: https://project.comsatel.com.pe/comsatel/development/training/dev-juniors/p3m/collaboration/-/issues/21
---

# US-020 — Cargar automáticamente los datos de GitLab y consultar el registro de cargas

## 1. Ficha

| Campo | Valor |
|---|---|
| ID | US-020 |
| Épica / capacidad | Portafolio y asignación (IMD-001, bloque 4) |
| Horizonte / release | Por definir |
| Actor | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) o [ADMIN](../../business/glossary/terms/TRM-0028-admin.md) (BR-066) |
| Responsable de negocio (PO) | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) (responsable funcional del portal, /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L109) |
| Prioridad | Should: alimenta la visibilidad de la ejecución y las evidencias, pero no bloquea la asignación. La decide el PO. |
| Dependencias | US-018, US-019 |
| Preparación | READY |

## 2. Historia

**Como** Jefe de Ingeniería o ADMIN, **quiero** que el portal cargue de forma automática, con una programación, solo la información nueva o actualizada de GitLab, y ver una consola con el registro de cada carga y poder reintentarla, **para** confiar en que los datos de milestones e issues están al día sin sobrecargar la transferencia entre GitLab y el portal.

## 3. Contexto y valor

- **Problema que resuelve:** Las funcionalidades no consultan GitLab directamente (BR-039). Una carga programada trae solo el delta de cambio para reducir la transferencia (BR-065) y su resultado debe ser visible y reintentable (BR-066).
- **Valor esperado:** Datos de GitLab actualizados con bajo costo de transferencia y con trazabilidad de cada carga.
- **Métrica o KPI que impacta:** Sin métrica asociada

## 4. Alcance

- **Incluye:**
  - Carga automática programada, por defecto cada 30 segundos, de issues (Task, UserStory, Proyecto) y milestones.
  - Cargar solo lo creado o actualizado desde la ejecución más reciente.
  - Consola de logs con fecha y hora de ejecución y estado (exitosa o fallida).
  - Reintentar una carga.
- **Excluye:**
  - Mostrar milestones e issues a los usuarios (US-024).
  - Crear o modificar datos en GitLab (solo lectura, BR-036, BR-037).

## 5. Criterios de aceptación

### AC-1 — Carga programada

```gherkin
Escenario: Carga automática programada
  Dado que llega la hora programada de la carga (cada 30 segundos por defecto)
  Cuando el portal ejecuta la carga desde GitLab
  Entonces la ejecución queda registrada con su fecha y hora y su estado
```

- **Regla / fuente:** BR-039, BR-065

### AC-2 — Solo el delta de cambio

```gherkin
Escenario: Solo el delta de cambio
  Dado issues y milestones creados o actualizados en GitLab desde la ejecución más reciente
  Cuando el portal ejecuta la carga
  Entonces trae solo esos issues y milestones y no vuelve a traer lo que no cambió
```

- **Regla / fuente:** BR-065

### AC-3 — Consola de logs

```gherkin
Escenario: Consultar la consola de cargas
  Dado un Jefe de Ingeniería o un ADMIN
  Cuando abre la consola de cargas
  Entonces ve cada ejecución con su fecha y hora y su estado, exitosa o fallida
```

- **Regla / fuente:** BR-066

### AC-4 — Reintento

```gherkin
Escenario: Reintentar una carga
  Dado una carga con estado fallida
  Cuando el Jefe de Ingeniería o el ADMIN solicita reintentarla
  Entonces el portal ejecuta la carga de nuevo y registra la nueva ejecución
```

- **Regla / fuente:** BR-066

### AC-5 — Solo lectura

```gherkin
Escenario: Solo lectura
  Dado la carga desde GitLab
  Cuando el portal accede a GitLab
  Entonces solo lee y no modifica nada en GitLab
```

- **Regla / fuente:** BR-036, BR-037

### AC-6 — Reintentos automáticos con circuit breaker

```gherkin
Escenario: Reintentar una carga fallida sin saturar a GitLab
  Dado una carga que falla
  Cuando el portal la reintenta automáticamente
  Entonces hace hasta 3 reintentos con esperas cada vez mayores y usa un circuit breaker para no saturar a GitLab si GitLab sigue fallando
```

- **Regla / fuente:** BR-082

### AC-7 — Logs que se retienen siempre

```gherkin
Escenario: Conservar los logs
  Dado las ejecuciones de carga registradas
  Cuando pasa el tiempo
  Entonces los logs de las cargas se conservan por siempre
```

- **Regla / fuente:** BR-090

### AC-8 — Primera carga completa

```gherkin
Escenario: Primera carga completa
  Dado que no existe una carga previa
  Cuando el portal ejecuta la primera carga
  Entonces carga la información completa y la registra
```

- **Regla / fuente:** BR-094

### AC-9 — Sin cambios desde la carga previa

```gherkin
Escenario: Sin cambios desde la carga previa
  Dado una carga previa y ningún cambio en GitLab desde entonces
  Cuando el portal ejecuta la carga
  Entonces registra la situación «sin cambios desde carga previa»
```

- **Regla / fuente:** BR-094

### AC-10 — Aviso si GitLab no responde

```gherkin
Escenario: Aviso de datos desactualizados
  Dado que GitLab no responde
  Cuando un usuario consulta datos cargados de GitLab
  Entonces el portal muestra «datos al <fecha y hora de la última carga exitosa>» en formato UTC-05
```

- **Regla / fuente:** BR-092

## 6. Casos negativos y límite

| Caso | Comportamiento esperado | Fuente o pregunta |
|---|---|---|
| Usuario que no es Jefe de Ingeniería ni ADMIN | No ve la consola ni reintenta | BR-066 |
| GitLab no responde | Se reintenta 3 veces con esperas incrementales y, si sigue sin responder, la ejecución queda fallida y el circuit breaker evita saturar a GitLab. El portal muestra «datos al <fecha y hora de la última carga exitosa>» (UTC-05) | BR-066, BR-082, BR-092 |
| Sin cambios desde la última ejecución | Se registra «sin cambios desde carga previa» | BR-094 |
| Retención de los logs | Se retienen por siempre | BR-090 |
| Parámetros del circuit breaker | Según las buenas prácticas del anexo B del pack | BR-082 |
| Primera ejecución, sin ejecución previa | La carga es completa | BR-094 |

## 7. Reglas de negocio aplicables

| ID | Regla | Fuente |
|---|---|---|
| BR-036 | El portal no crea user stories ni sprints: solo visualiza lo que existe en GitLab a nivel de issue y milestone. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L76 |
| BR-037 | La integración con GitLab es de solo lectura, con credenciales de servicio de solo lectura. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L77 |
| BR-039 | El portal consulta GitLab de forma automática, cada 30 segundos por defecto, para obtener issues y milestones. Las funcionalidades no consultan GitLab directamente. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L79 |
| BR-065 | La carga desde GitLab es un proceso automático programado que trae solo la información creada o actualizada desde la ejecución más reciente (delta de cambio). | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L105 |
| BR-066 | El Jefe de Ingeniería y los usuarios con rol ADMIN ven una consola de logs de las cargas, con fecha y hora de ejecución y estado (exitosa o fallida), y pueden reintentar una carga. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L106 |
| BR-082 | Una carga fallida de GitLab se reintenta 3 veces con esperas incrementales, y se usa un circuit breaker como patrón para no saturar a GitLab ante fallas, con las mejores prácticas de reintentos (anexo B del pack). | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L122 |
| BR-090 | Los logs de las cargas de GitLab se retienen por siempre. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L130 |
| BR-092 | Si GitLab no responde, el portal muestra el aviso «datos al <fecha y hora de la última carga exitosa>», en formato UTC-05. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L132 |
| BR-094 | La primera carga de GitLab es completa, porque no hay fecha de carga previa. Si no hay cambios desde la carga previa, se registra «sin cambios desde carga previa». | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L134 |

## 8. Datos y términos

| Término | Uso en esta historia | Glosario |
|---|---|---|
| Carga automática de GitLab | Proceso que se ejecuta y se registra | [Carga automática de GitLab](../../business/glossary/terms/TRM-0047-carga-automatica-de-gitlab.md) |
| GitLab | Origen de los datos | [GitLab](../../business/glossary/terms/TRM-0036-gitlab.md) |
| Jefe de Ingeniería | Actor | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) |
| ADMIN | Actor | [ADMIN](../../business/glossary/terms/TRM-0028-admin.md) |

## 9. Requisitos no funcionales

- **Accesibilidad:** WCAG 2.2 AA (estándar del repositorio).
- **Privacidad y datos personales:** No aplica: la historia no toca datos personales.
- **Otros:** Reducir la transferencia entre GitLab y el portal cargando solo el delta de cambio (BR-065). Intervalo por defecto de 30 segundos (BR-039).

## 10. Consideraciones de UX

- **Flujo esperado:** El actor abre la consola, ve las ejecuciones ordenadas por fecha y reintenta una fallida.
- **Estados de la interfaz:** Sin ejecuciones, sin permisos, ejecución fallida, reintento en curso, éxito.
- **Contenido clave:** Fecha y hora, estado de cada ejecución y acción de reintento.

## 11. Dependencias, supuestos e hipótesis

- **Depende de:** US-018 y US-019 (productos y proyectos vinculados a GitLab) y el acceso de solo lectura a GitLab.
- **Es prerrequisito de:** US-024, US-013, US-014
- **Supuestos:** Ninguno
- **Hipótesis del agente:** Ninguna

## 12. Preguntas abiertas

| ID | Pregunta | Responsable | Prioridad | Bloquea | Estado |
|---|---|---|---|---|---|
| US-020-Q1 | ¿Quién consulta la ejecución y cómo se carga? | Jefe de Ingeniería | Alta | No | Cerrada: carga automática programada; consola para el Jefe de Ingeniería y ADMIN (EVD-2026-0094, EVD-2026-0095) |
| US-020-Q2 | ¿Cómo se registra una carga sin cambios o la primera carga? | Arquitectura | Baja | No | Cerrada: la primera es completa y sin cambios se registra «sin cambios desde carga previa» (EVD-2026-0136, BR-094) |

## 13. Evidencia y trazabilidad

| ID | Hallazgo | Fuente | Clasificación | Confianza |
|---|---|---|---|---|
| EVD-2026-0094 | La carga desde GitLab es un proceso automático programado. El Jefe de Ingeniería y los ADMIN ven una consola de logs (fecha y hora, estado exitosa o fallida) y pueden reintentar | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L189 | decision | high |
| EVD-2026-0095 | La carga trae solo lo creado o actualizado desde la ejecución más reciente (delta de cambio) | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L190 | decision | high |
| EVD-2026-0093 | El portal consulta GitLab de forma automática, cada 30 segundos por defecto. Las funcionalidades no consultan GitLab directamente | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L188 | decision | high |
| EVD-2026-0038 | La integración con GitLab es de solo lectura | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L134 | decision | high |
| EVD-2026-0122 | Una carga fallida se reintenta 3 veces con esperas incrementales y un circuit breaker | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L507 | decision | high |
| EVD-2026-0132 | Los logs de carga de GitLab se retienen por siempre | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L517 | decision | high |
| EVD-2026-0133 | Circuit breaker como patrón ante fallas de GitLab, con mejores prácticas de reintentos | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L518 | decision | high |
| EVD-2026-0134 | Si GitLab no responde, el portal muestra «datos al <fecha y hora de la última carga exitosa>» en UTC-05 | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L519 | decision | high |
| EVD-2026-0136 | La primera carga es completa; sin cambios se registra «sin cambios desde carga previa» | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L521 | decision | high |

Evidencia compartida: `source_type: human`, `observed_at: 2026-10-10T18:00:00-05:00`, `freshness: current`, `owner: Jefe de Ingeniería`.

- **Upstream:** [BRC-001](../../business/rules/BRC-001-reglas-de-negocio-portal-curricula.md), [IMD-001](../../business/information-model/IMD-001-portal-curricula.md), [GLS-001](../../business/glossary/GLS-001-glosario-de-negocio.md) y [RCP-001](../context-packs/RCP-001-portal-gestion-curricula-desarrollo.md), todos en estado `draft`.
- **Downstream (pendiente):** UXR → FLW → SCR → CMP → AC

## 14. Evaluación INVEST

| Criterio | ¿Cumple? | Justificación |
|---|---|---|
| Independiente | Parcial | Necesita US-018 y US-019. |
| Negociable | Sí | Reintentos, logs, primera carga y aviso definidos. |
| Valiosa | Sí | Datos al día con trazabilidad de cada carga. |
| Estimable | Sí | Alcance y actor definidos. |
| Pequeña (Small) | Parcial | Carga con delta y consola con reintento podrían separarse. |
| Testeable | Sí | Los 10 criterios son verificables. |

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
- **Motivo:** Actor, valor y criterios sostenidos por BR-039, BR-065 y BR-066. US-020-Q1 quedó cerrada. US-020-Q2 no bloquea.
- **Bloqueos de entrega:** Ninguno
- **Propuesta de división (si no es pequeña):** Si crece, separar la carga con delta (AC-1, AC-2) de la consola con reintento (AC-3, AC-4).
- **Siguiente rol o Skill:** `ux-requirements-analyzer`
- **Decisión humana requerida:** El Jefe de Ingeniería valida la historia.
- **Validación:** Pendiente · Responsable: Jefe de Ingeniería · Fecha: —
