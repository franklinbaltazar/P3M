---
type: User Story
title: "US-009 — Enrolarse en una edición de un curso"
description: "Como Colaborador, quiero enrolarme por mi cuenta en una edición de un curso, para entrenarme en las competencias de mi rol/nivel."
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
gitlab_issue_id: 52920
gitlab_issue_iid: 10
gitlab_issue_url: https://project.comsatel.com.pe/comsatel/development/training/dev-juniors/p3m/collaboration/-/issues/10
---

# US-009 — Enrolarse en una edición de un curso

## 1. Ficha

| Campo | Valor |
|---|---|
| ID | US-009 |
| Épica / capacidad | Cursos y evidencias (IMD-001, bloque 2) |
| Horizonte / release | Por definir |
| Actor | [Colaborador](../../business/glossary/terms/TRM-0002-colaborador.md) |
| Responsable de negocio (PO) | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) (responsable funcional del portal, /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L109) |
| Prioridad | Must: es la entrada del colaborador al entrenamiento. La decide el PO. |
| Dependencias | US-004, US-008 |
| Preparación | READY |

## 2. Historia

**Como** Colaborador, **quiero** enrolarme por mi cuenta en una edición de un curso, **para** entrenarme en las competencias de mi rol/nivel.

## 3. Contexto y valor

- **Problema que resuelve:** El colaborador se auto-enrola en las ediciones y, al llegar al cupo, no se admite más enrolamiento (BR-025, BR-026).
- **Valor esperado:** El colaborador accede al entrenamiento sin intermediarios.
- **Métrica o KPI que impacta:** Sin métrica asociada

## 4. Alcance

- **Incluye:**
  - Auto-enrolarse en una edición con cupo disponible.
  - Rechazar el enrolamiento cuando se alcanzó el cupo.
  - Volver a enrolarse en una edición de la que el colaborador se desenroló.
- **Excluye:**
  - Desenrolarse (US-010).
  - Registrar avance, evaluación y certificado (US-011, US-012).

## 5. Criterios de aceptación

### AC-1 — Auto-enrolarse en una edición con cupo

```gherkin
Escenario: Auto-enrolarse en una edición con cupo
  Dado un colaborador registrado y una edición que no ha alcanzado su cupo
  Cuando el colaborador se enrola en la edición
  Entonces queda enrolado en esa edición
```

- **Regla / fuente:** BR-025

### AC-2 — No se admite enrolamiento al alcanzar el cupo

```gherkin
Escenario: No se admite enrolamiento al alcanzar el cupo
  Dado una edición que alcanzó su cupo
  Cuando otro colaborador intenta enrolarse
  Entonces el portal no admite el enrolamiento
```

- **Regla / fuente:** BR-026

### AC-3 — Cada enrolamiento pertenece a una edición

```gherkin
Escenario: Cada enrolamiento pertenece a una edición
  Dado un colaborador enrolado
  Cuando se consulta su enrolamiento
  Entonces el enrolamiento corresponde a una edición concreta del curso
```

- **Regla / fuente:** BR-023, BR-025

### AC-4 — Volver a enrolarse tras desenrolarse

```gherkin
Escenario: Volver a enrolarse tras desenrolarse
  Dado un colaborador que se desenroló de una edición
  Cuando se enrola de nuevo en esa misma edición
  Entonces queda enrolado en ella
```

- **Regla / fuente:** BR-122

## 6. Casos negativos y límite

| Caso | Comportamiento esperado | Fuente o pregunta |
|---|---|---|
| Edición con el cupo completo | No se admite más enrolamiento | BR-026 |
| Colaborador que ya está enrolado en la misma edición | Sin regla | US-009-Q1 |
| Colaborador que se desenroló antes de la misma edición | Puede volver a enrolarse | BR-122 |
| Edición ya iniciada o finalizada | Sin regla | US-009-Q1 |
| Condiciones de elegibilidad (nivel del colaborador, prerrequisitos del curso) | Sin regla | US-009-Q1 |
| Usuario sin colaborador registrado | No ingresa al portal: vuelve al login, salvo Instructor, ADMIN y Jefe de Ingeniería | BR-107 |

## 7. Reglas de negocio aplicables

| ID | Regla | Fuente |
|---|---|---|
| BR-025 | El colaborador se auto-enrola en una edición. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L65 |
| BR-026 | Al llegar al cupo de una edición no se admite más enrolamiento. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L66 |
| BR-023 | El avance, la evaluación y el certificado se registran por colaborador y por edición. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L63 |
| BR-122 | El colaborador que se desenrola de una edición puede volver a enrolarse en ella. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L162 |
| BR-123 | Sobre el enrolamiento se registran el avance (un porcentaje de 0 a 100), la nota y comentarios (un texto). | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L163 |

## 8. Datos y términos

| Término | Uso en esta historia | Glosario |
|---|---|---|
| Colaborador | Actor que se enrola | [Colaborador](../../business/glossary/terms/TRM-0002-colaborador.md) |
| Edición de curso | Edición elegida | [Edición de curso](../../business/glossary/terms/TRM-0013-edicion-de-curso.md) |
| Cupo | Límite que cierra el enrolamiento | [Cupo](../../business/glossary/terms/TRM-0014-cupo.md) |
| Enrolamiento | Registro que se crea. Sobre él se registran el avance (un porcentaje), la nota y comentarios (BR-123) | [Enrolamiento](../../business/glossary/terms/TRM-0015-enrolamiento.md) |

## 9. Requisitos no funcionales

- **Accesibilidad:** WCAG 2.2 AA (estándar del repositorio).
- **Privacidad y datos personales:** Toca la identidad del colaborador enrolado (nombres y apellidos). Restricción: BR-003 y la política pendiente G-12.
- **Otros:** Sin requisito identificado

## 10. Consideraciones de UX

- **Flujo esperado:** El colaborador consulta las ediciones disponibles y se enrola en una.
- **Estados de la interfaz:** Sin ediciones, edición con cupo completo, error, éxito.
- **Contenido clave:** Edición, fechas, cupo disponible e instructor.

## 11. Dependencias, supuestos e hipótesis

- **Depende de:** US-004 (colaborador registrado) y US-008 (edición).
- **Es prerrequisito de:** US-010, US-011, US-012
- **Supuestos:** Ninguno
- **Hipótesis del agente:** Ninguna

## 12. Preguntas abiertas

| ID | Pregunta | Responsable | Prioridad | Bloquea | Estado |
|---|---|---|---|---|---|
| US-009-Q1 | ¿Hay condiciones de elegibilidad para enrolarse (nivel del colaborador, prerrequisitos) y qué ocurre con una edición ya iniciada o con un enrolamiento repetido? | Jefe de Ingeniería | Media | No | Abierta |
| G-11 | ¿Cómo se vinculan los colaboradores registrados con los usuarios de Keycloak? | Arquitectura | Media | No | Cerrada en parte: el usuario sin colaborador vuelve al login (EVD-2026-0147, BR-107) y se vincula por el correo (EVD-2026-0164, BR-125) |

## 13. Evidencia y trazabilidad

| ID | Hallazgo | Fuente | Clasificación | Confianza |
|---|---|---|---|---|
| EVD-2026-0058 | El colaborador se auto-enrola en las ediciones de curso. Una edición tiene número de edición, fecha y cupo. El avance, la evaluación y el certificado se registran por edición | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L153 | decision | high |
| EVD-2026-0061 | El curso tiene fecha de inicio y fin. Al llegar al cupo no se admite más enrolamiento. El colaborador puede desenrolarse | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L156 | decision | medium |
| EVD-2026-0147 | Un usuario sin colaborador y sin rol Jefe de Ingeniería, ADMIN o Instructor vuelve al login | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L544 | decision | high |
| EVD-2026-0161 | Quien se desenrola de una edición puede volver a enrolarse en la misma edición | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L558 | decision | high |
| EVD-2026-0162 | En el enrolamiento se registran el avance del colaborador (un porcentaje), su nota y comentarios (un texto) | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L559 | decision | high |
| EVD-2026-0164 | El usuario de Keycloak se vincula con su persona por el correo que Keycloak entrega, la primera vez que inicia sesión; el correo vigente es único entre las personas | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L561 | decision | high |

Evidencia compartida: `source_type: human`, `observed_at: 2026-10-10T12:00:00-05:00`, `freshness: current`, `owner: Jefe de Ingeniería`. Las evidencias EVD-2026-0143 a EVD-2026-0169 se observaron el 2026-10-11T00:00:00Z.

- **Upstream:** [BRC-001](../../business/rules/BRC-001-reglas-de-negocio-portal-curricula.md), [IMD-001](../../business/information-model/IMD-001-portal-curricula.md), [GLS-001](../../business/glossary/GLS-001-glosario-de-negocio.md) y [RCP-001](../context-packs/RCP-001-portal-gestion-curricula-desarrollo.md), todos en estado `draft`.
- **Downstream (pendiente):** UXR → FLW → SCR → CMP → AC

## 14. Evaluación INVEST

| Criterio | ¿Cumple? | Justificación |
|---|---|---|
| Independiente | Parcial | Necesita colaboradores (US-004) y ediciones (US-008). |
| Negociable | Sí | La elegibilidad se puede conversar (US-009-Q1). |
| Valiosa | Sí | El colaborador accede al entrenamiento sin intermediarios. |
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
- [x] El PO validó la historia

## 16. Definition of Done (funcional)

- [ ] Todos los criterios de aceptación pasan sus pruebas de aceptación
- [ ] Los casos negativos y límite están cubiertos por pruebas
- [ ] La accesibilidad WCAG 2.2 AA está revisada
- [ ] Los requisitos de privacidad se cumplen
- [ ] El PO aceptó la historia en la revisión

## 17. Preparación y validación

- **Estado:** READY
- **Motivo:** Actor, valor y criterios están sostenidos por BR-025, BR-026 y BR-122. Las preguntas abiertas no bloquean los criterios.
- **Bloqueos de entrega:** Ninguno
- **Propuesta de división (si no es pequeña):** No aplica
- **Siguiente rol o Skill:** `ux-requirements-analyzer`
- **Decisión humana requerida:** El Jefe de Ingeniería (validó la historia el 2026-10-12) responde US-009-Q1.
- **Actualización 2026-10-12:** se añade volver a enrolarse tras desenrolarse (BR-122), el enrolamiento lleva avance, nota y comentarios (BR-123), y el usuario sin colaborador vuelve al login (BR-107); G-11 queda cerrada en parte. Verificada de nuevo por ianache el 2026-10-12.
- **Validación:** Aprobada · Responsable: Jefe de Ingeniería (ianache) · Fecha: 2026-10-12
