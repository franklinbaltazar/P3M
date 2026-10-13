---
type: User Story
title: "US-021 — Asignar un colaborador a un proyecto"
description: "Como Jefe de Ingeniería, quiero asignar a un colaborador a un proyecto según el rol/nivel que el proyecto requiere, verificando sus competencias, para armar equipos con las competencias esperadas."
tags: [user-story, por-definir, asignacion]
status: draft
generated:
  by: "af-user-story-refiner/2.0"
  at: "2026-10-12T01:30:00-05:00"
sources:
  - id: brc-001
    resource: /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md
  - id: rcp-001
    resource: /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md
  - id: gls-001
    resource: /business/glossary/GLS-001-glosario-de-negocio.md
  - id: imd-001
    resource: /business/information-model/IMD-001-portal-curricula.md
gitlab_issue_id: 52932
gitlab_issue_iid: 22
gitlab_issue_url: https://project.comsatel.com.pe/comsatel/development/training/dev-juniors/p3m/collaboration/-/issues/22
---

# US-021 — Asignar un colaborador a un proyecto

## 1. Ficha

| Campo | Valor |
|---|---|
| ID | US-021 |
| Épica / capacidad | Portafolio y asignación (IMD-001, bloque 4) |
| Horizonte / release | Por definir |
| Actor | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) o [ADMIN](../../business/glossary/terms/TRM-0028-admin.md) |
| Responsable de negocio (PO) | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) (responsable funcional del portal, /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L109) |
| Prioridad | Must: es la razón de ser del portafolio. La decide el PO. |
| Dependencias | US-016, US-019 |
| Preparación | READY |

## 2. Historia

**Como** Jefe de Ingeniería o usuario con perfil ADMIN, **quiero** asignar a un colaborador a un proyecto según el rol/nivel que el proyecto requiere, verificando sus competencias, **para** armar equipos con las competencias esperadas.

## 3. Contexto y valor

- **Problema que resuelve:** El Jefe de Ingeniería asigna colaboradores según el rol/nivel requerido y se verifica el nivel mínimo de las competencias. Si no se cumple, el portal advierte y la asignación queda Pendiente (BR-005, BR-040, BR-041, BR-042).
- **Valor esperado:** Asignaciones coherentes con las competencias requeridas.
- **Métrica o KPI que impacta:** Sin métrica asociada

## 4. Alcance

- **Incluye:**
  - Asignar un colaborador a un proyecto.
  - Verificar el nivel mínimo de las competencias del rol/nivel requerido.
  - Advertir y dejar Pendiente la asignación si no se cumple.
  - Registrar la vigencia, el porcentaje de dedicación y el historial de la asignación.
  - Estados de la asignación: pendiente, vigente y finalizada.
- **Excluye:**
  - Aprobar la excepción (US-022).

## 5. Criterios de aceptación

### AC-1 — Asignar a un colaborador que cumple

```gherkin
Escenario: Asignar a un colaborador que cumple
  Dado un proyecto que requiere un rol/nivel y un colaborador con las competencias a su nivel mínimo
  Cuando el Jefe de Ingeniería lo asigna al proyecto
  Entonces el colaborador queda asignado
```

- **Regla / fuente:** BR-040, BR-041

### AC-2 — Advertir si no cumple

```gherkin
Escenario: Advertir si no cumple
  Dado un colaborador cuyas competencias no alcanzan el nivel mínimo del rol/nivel requerido
  Cuando el Jefe de Ingeniería intenta asignarlo
  Entonces el portal advierte y la asignación queda Pendiente
```

- **Regla / fuente:** BR-041, BR-042

### AC-3 — Varias asignaciones a la vez

```gherkin
Escenario: Varias asignaciones a la vez
  Dado un colaborador asignado a un proyecto
  Cuando se le asigna a otro proyecto
  Entonces mantiene ambas asignaciones
```

- **Regla / fuente:** BR-045

### AC-4 — Solo el Jefe de Ingeniería o el ADMIN lo define

```gherkin
Escenario: Solo el Jefe de Ingeniería o el ADMIN lo define
  Dado que el usuario está autenticado y no es el Jefe de Ingeniería ni un ADMIN
  Cuando intenta asignar colaboradores a proyectos
  Entonces el portal no permite la acción
```

- **Regla / fuente:** BR-005, BR-134

### AC-5 — Vigencia de la asignación

```gherkin
Escenario: Registrar la vigencia de la asignación
  Dado un Jefe de Ingeniería que asigna un colaborador a un proyecto
  Cuando registra la asignación
  Entonces la asignación tiene una vigencia (desde y hasta)
```

- **Regla / fuente:** BR-078

### AC-6 — Porcentaje de dedicación e historial

```gherkin
Escenario: Registrar el porcentaje y conservar el historial
  Dado un Jefe de Ingeniería que asigna un colaborador a un proyecto
  Cuando registra la asignación con su porcentaje de dedicación
  Entonces la asignación guarda el porcentaje y queda en el historial de asignaciones del colaborador
```

- **Regla / fuente:** BR-080

### AC-7 — No sobreasignar

```gherkin
Escenario: No sobreasignar a un colaborador
  Dado un colaborador cuyas asignaciones vigentes suman 100 % de dedicación
  Cuando el Jefe de Ingeniería intenta asignarlo a otro proyecto con un porcentaje que supera el 100 % en total
  Entonces el portal no permite la asignación
```

- **Regla / fuente:** BR-093

### AC-8 — Estados de la asignación

```gherkin
Escenario: Estados de la asignación
  Dado una asignación registrada
  Cuando se consulta su estado
  Entonces está pendiente, vigente o finalizada
```

- **Regla / fuente:** BR-111, BR-042

## 6. Casos negativos y límite

| Caso | Comportamiento esperado | Fuente o pregunta |
|---|---|---|
| Usuario que no es el Jefe de Ingeniería ni un ADMIN | No asigna | BR-005, BR-134 |
| Suma de porcentajes de dedicación mayor que 100 % | No se permite la asignación | BR-093 |
| Colaborador sin valoraciones registradas | Sin regla | US-021-Q1 |
| Rol/nivel que el proyecto no requiere | Sin regla | G-28 |
| Cantidades requeridas ya cubiertas | Sin regla | US-021-Q1 |

## 7. Reglas de negocio aplicables

| ID | Regla | Fuente |
|---|---|---|
| BR-005 | Solo el Jefe de Ingeniería asigna colaboradores a los proyectos. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L45 |
| BR-040 | Un colaborador se asigna a un proyecto según el rol/nivel que el proyecto requiere. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L80 |
| BR-041 | Al asignar, el portal verifica que el colaborador tenga las competencias del rol/nivel requerido al nivel mínimo. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L81 |
| BR-042 | Si el colaborador no cumple el nivel mínimo, el portal advierte y la asignación queda Pendiente hasta que el Jefe de Ingeniería apruebe la excepción. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L82 |
| BR-045 | Un colaborador puede estar asignado a más de un proyecto a la vez. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L85 |
| BR-046 | Un proyecto puede requerir varios roles/niveles, con cantidades. Quién los define: BR-109 (antes los registraba el Jefe de Proyecto designado, EVD-2026-0121). | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L86 |
| BR-078 | La asignación de un colaborador a un proyecto tiene vigencia (desde y hasta), como la del jefe de proyecto. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L118 |
| BR-080 | La asignación a un proyecto incluye un porcentaje de dedicación y se mantiene el historial de asignaciones. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L120 |
| BR-093 | La suma de los porcentajes de dedicación de un colaborador tiene un tope máximo de 100 %. El portal no permite sobreasignar a un colaborador. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L133 |
| BR-111 | Una asignación está pendiente (hasta la excepción, BR-042), vigente o finalizada. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L151 |
| BR-134 | El ADMIN puede hacer también las seis capacidades que eran exclusivas del Jefe de Ingeniería (BR-005, BR-006, BR-007, BR-055, BR-083, BR-129). | /business/rules\BRC-001-reglas-de-negocio-portal-curricula.md:L174 |

## 8. Datos y términos

| Término | Uso en esta historia | Glosario |
|---|---|---|
| Asignación | Elemento que se crea | [Asignación](../../business/glossary/terms/TRM-0034-asignacion.md) |
| Rol/nivel | Requerido por el proyecto | [Rol/nivel](../../business/glossary/terms/TRM-0006-rol-nivel.md) |
| Nivel mínimo de competencia | Referencia de la verificación | [Nivel mínimo de competencia](../../business/glossary/terms/TRM-0009-nivel-minimo-de-competencia.md) |
| Valoración de cumplimiento | Nivel actual del colaborador | [Valoración de cumplimiento](../../business/glossary/terms/TRM-0025-valoracion-de-cumplimiento.md) |
| Proyecto | Destino | [Proyecto](../../business/glossary/terms/TRM-0030-proyecto.md) |

## 9. Requisitos no funcionales

- **Accesibilidad:** WCAG 2.2 AA (estándar del repositorio).
- **Privacidad y datos personales:** Toca la identidad de colaboradores. Restricción: BR-003 y la política pendiente G-12.
- **Otros:** Sin requisito identificado

## 10. Consideraciones de UX

- **Flujo esperado:** El Jefe de Ingeniería elige un proyecto, un rol/nivel requerido y un colaborador, y ve si cumple el nivel mínimo.
- **Estados de la interfaz:** Sin colaboradores aptos, advertencia, sin permisos, éxito.
- **Contenido clave:** Competencias del colaborador frente al nivel mínimo requerido.

## 11. Dependencias, supuestos e hipótesis

- **Depende de:** US-016 (valoración) y US-019 (proyecto con roles/niveles requeridos).
- **Es prerrequisito de:** US-022
- **Supuestos:** Ninguno
- **Hipótesis del agente:** Ninguna

## 12. Preguntas abiertas

| ID | Pregunta | Responsable | Prioridad | Bloquea | Estado |
|---|---|---|---|---|---|
| US-021-Q1 | ¿Qué se verifica si el colaborador no tiene valoraciones? ¿Se cuentan las cantidades requeridas por el proyecto? | Jefe de Ingeniería | Media | No | Abierta |
| G-08 | ¿La asignación tiene fechas, dedicación o historial? | Jefe de Ingeniería | Media | No | Cerrada: tiene vigencia, porcentaje de dedicación (la suma no supera 100 %) e historial (EVD-2026-0112, EVD-2026-0116, EVD-2026-0135, BR-078, BR-080, BR-093) |

## 13. Evidencia y trazabilidad

| ID | Hallazgo | Fuente | Clasificación | Confianza |
|---|---|---|---|---|
| EVD-2026-0006 | Los colaboradores se asignan a proyectos según el rol/nivel requerido por el proyecto | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L101 | fact | high |
| EVD-2026-0047 | El Jefe de Ingeniería asigna a los colaboradores a los proyectos | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L142 | decision | medium |
| EVD-2026-0026 | La asignación a un proyecto requiere tener las competencias según el nivel de desarrollo: N1 no desarrollada, N2 en desarrollo, N3 desarrollada | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L121 | decision | high |
| EVD-2026-0028 | El nivel mínimo de competencia para asignar es N2 (en desarrollo). Reemplaza el N1 de S-05. El N2 fue solo un ejemplo (E-63). Si no se cumple, el portal advierte, y la excepción consiste en que la aprueba el Jefe de Ingeniería, único que puede hacerlo | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L123 | decision | high |
| EVD-2026-0064 | Si el colaborador no cumple el nivel mínimo, la asignación queda pendiente hasta que el Jefe de Ingeniería apruebe la excepción. Se registra el motivo, tomado de un codificador prestablecido (código y descripción), y quién aprobó | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L159 | decision | high |
| EVD-2026-0067 | Un colaborador puede estar asignado a más de un proyecto a la vez | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L162 | decision | high |
| EVD-2026-0041 | Un rol se vincula a un perfil de competencias con niveles de logro N1, N2 y N3. En la práctica, el rol/nivel selecciona de cada competencia el nivel mínimo | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L136 | decision | high |
| EVD-2026-0063 | El nivel mínimo N2 era solo un ejemplo. El nivel mínimo lo define el rol/nivel por competencia | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L158 | decision | high |
| EVD-2026-0112 | La asignación a un proyecto tiene vigencia, como la del jefe de proyecto | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L493 | decision | high |
| EVD-2026-0116 | La asignación incluye porcentaje de dedicación y se mantiene el historial de asignaciones | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L500 | decision | high |
| EVD-2026-0135 | La suma de dedicación tiene tope de 100 %; no se permite sobreasignar | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L520 | decision | high |
| EVD-2026-0149 | Los roles/niveles requeridos los define el Jefe de Ingeniería o un ADMIN | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L546 | decision | high |
| EVD-2026-0152 | Se fijan los estados de la asignación, la solicitud de promoción y la carga de GitLab | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L549 | decision | high |
| EVD-2026-0173 | El ADMIN suple las seis capacidades exclusivas del Jefe de Ingeniería | /requirements/context-packs\RCP-001-portal-gestion-curricula-desarrollo.md:L572 | decision | high |

Evidencia compartida: `source_type: human`, `observed_at: 2026-10-10T12:00:00-05:00`, `freshness: current`, `owner: Jefe de Ingeniería`. Las evidencias EVD-2026-0143 a EVD-2026-0169 se observaron el 2026-10-11T00:00:00Z.

- **Upstream:** [BRC-001](../../business/rules/BRC-001-reglas-de-negocio-portal-curricula.md), [IMD-001](../../business/information-model/IMD-001-portal-curricula.md), [GLS-001](../../business/glossary/GLS-001-glosario-de-negocio.md) y [RCP-001](../context-packs/RCP-001-portal-gestion-curricula-desarrollo.md), todos en estado `draft`.
- **Downstream (pendiente):** UXR → FLW → SCR → CMP → AC

## 14. Evaluación INVEST

| Criterio | ¿Cumple? | Justificación |
|---|---|---|
| Independiente | Parcial | Necesita US-016 y US-019. |
| Negociable | Parcial | Las cantidades requeridas abiertas (US-021-Q1). |
| Valiosa | Sí | Asignaciones coherentes con las competencias requeridas. |
| Estimable | Sí | Los datos de la asignación están definidos (BR-078, BR-080, BR-093, BR-111). |
| Pequeña (Small) | Sí | Cabe en una iteración. |
| Testeable | Sí | Los 8 criterios son verificables. |

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
- **Motivo:** Actor, valor y criterios sostenidos por BR-134, BR-005, BR-041, BR-042 y BR-111. La pregunta abierta (US-021-Q1) no bloquea.
- **Bloqueos de entrega:** Ninguno
- **Propuesta de división (si no es pequeña):** No aplica
- **Siguiente rol o Skill:** `ux-requirements-analyzer`
- **Decisión humana requerida:** El Jefe de Ingeniería (validó la historia el 2026-10-12) responde US-021-Q1. G-08 quedó cerrada.
- **Actualización 2026-10-12:** se registran los estados de la asignación (BR-111) y se cierra G-08, que ya estaba respondida por BR-078, BR-080 y BR-093 pero seguía abierta y en el alcance como exclusión; BR-046 ya no atribuye el registro de los roles/niveles al jefe de proyecto (BR-109). Verificada de nuevo por ianache el 2026-10-12.
- **Validación:** Aprobada · Responsable: Jefe de Ingeniería (ianache) · Fecha: 2026-10-12
