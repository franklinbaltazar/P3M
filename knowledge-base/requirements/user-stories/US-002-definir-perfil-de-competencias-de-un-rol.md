---
type: User Story
title: "US-002 — Definir el perfil de competencias de un rol"
description: "Como Jefe de Ingeniería, quiero definir el perfil de competencias de un rol, con sus competencias y los niveles de logro N1, N2 y N3, para poder exigir un nivel mínimo por rol/nivel y diseñar la currícula de entrenamiento."
tags: [user-story, por-definir, roles-competencias]
status: draft
generated:
  by: "af-user-story-refiner/2.0"
  at: "2026-10-10T12:00:00-05:00"
sources:
  - id: brc-001
    resource: /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md
  - id: rcp-001
    resource: /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md
  - id: gls-001
    resource: /business/glossary/GLS-001-glosario-de-negocio.md
  - id: imd-001
    resource: /business/information-model/IMD-001-portal-curricula.md
gitlab_issue_id: 52913
gitlab_issue_iid: 3
gitlab_issue_url: https://project.comsatel.com.pe/comsatel/development/training/dev-juniors/p3m/collaboration/-/issues/3
---

# US-002 — Definir el perfil de competencias de un rol

## 1. Ficha

| Campo | Valor |
|---|---|
| ID | US-002 |
| Épica / capacidad | Roles y competencias (IMD-001, bloque 1) |
| Horizonte / release | Por definir |
| Actor | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) o [ADMIN](../../business/glossary/terms/TRM-0028-admin.md) |
| Responsable de negocio (PO) | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) (responsable funcional del portal, /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L109) |
| Prioridad | Must: el perfil de competencias es la base del nivel mínimo, los cursos y la valoración. La decide el PO. |
| Dependencias | US-001 |
| Preparación | READY |

## 2. Historia

**Como** Jefe de Ingeniería o usuario con perfil ADMIN, **quiero** definir el perfil de competencias de un rol, con sus competencias y los niveles de logro N1, N2 y N3, **para** poder exigir un nivel mínimo por rol/nivel y diseñar la currícula de entrenamiento.

## 3. Contexto y valor

- **Problema que resuelve:** Cada rol se vincula a un perfil de competencias, y las competencias se definen por rol con niveles de logro (BR-012), pero ninguna fuente dice quién las define ni cómo se describen.
- **Valor esperado:** Cada rol tiene un perfil de competencias definido sobre el que se mide a los colaboradores.
- **Métrica o KPI que impacta:** Sin métrica asociada

## 4. Alcance

- **Incluye:**
  - Vincular un rol del catálogo con su perfil de competencias.
  - Agregar y modificar competencias del perfil.
  - Registrar el código, nombre, tipo y la definición de cada nivel de logro de cada competencia.
- **Excluye:**
  - Definir el nivel mínimo por rol/nivel (US-003).
  - Definir las evidencias esperadas, que se definen en la rúbrica de cada objetivo (US-007).

## 5. Criterios de aceptación

### AC-1 — Vincular un rol con su perfil

```gherkin
Escenario: Vincular un rol con su perfil
  Dado que existe el rol "Analista" en el catálogo
  Cuando se define su perfil de competencias
  Entonces el rol "Analista" queda vinculado a ese perfil
```

- **Regla / fuente:** BR-012

### AC-2 — Agregar una competencia al perfil

```gherkin
Escenario: Agregar una competencia al perfil
  Dado el perfil de competencias del rol "Analista"
  Cuando se agrega la competencia con código "C-01", nombre "Comunicación" y tipo habilidad, y la definición de cada nivel de logro
  Entonces el perfil incluye esa competencia con su código, nombre, tipo y la definición de los niveles N1, N2 y N3
```

- **Regla / fuente:** BR-012, BR-013, BR-056

### AC-3 — Las competencias se miden con N1, N2 y N3

```gherkin
Escenario: Las competencias se miden con N1, N2 y N3
  Dado el perfil de competencias de un rol
  Cuando se consultan los niveles de logro de una competencia
  Entonces se muestran N1 no desarrollada, N2 en desarrollo y N3 desarrollada
```

- **Regla / fuente:** BR-013

### AC-4 — Una competencia general en más de un perfil

```gherkin
Escenario: Una competencia general en más de un perfil
  Dado una competencia general "Comunicación" en el perfil del rol "Analista"
  Cuando se agrega la misma competencia al perfil del rol "Desarrollador"
  Entonces ambos perfiles incluyen la competencia "Comunicación"
```

- **Regla / fuente:** BR-060

### AC-5 — Solo el Jefe de Ingeniería o el ADMIN lo define

```gherkin
Escenario: Solo el Jefe de Ingeniería o el ADMIN lo define
  Dado que el usuario está autenticado y no es el Jefe de Ingeniería ni un ADMIN
  Cuando intenta definir perfiles de competencias
  Entonces el portal no permite la acción
```

- **Regla / fuente:** BR-055, BR-134

### AC-6 — Indicador de competencia general o específica

```gherkin
Escenario: Marcar la competencia como general o específica
  Dado un Jefe de Ingeniería o un ADMIN que define el perfil de un rol
  Cuando registra una competencia
  Entonces indica si es general o específica (exclusiva de un rol)
```

- **Regla / fuente:** BR-059

## 6. Casos negativos y límite

| Caso | Comportamiento esperado | Fuente o pregunta |
|---|---|---|
| Nivel de logro distinto de N1, N2 o N3 | No es un nivel válido de una competencia | BR-013 |
| Rol que no está en el catálogo | No tiene perfil: roles y perfiles siempre están en el catálogo | BR-012 |
| Competencia sin código, nombre, tipo o definición de sus niveles | Sin regla sobre cuáles datos son obligatorios | US-002-Q3 |
| Evidencias que muestran el logro de una competencia | Se definen en la rúbrica del objetivo y no en la competencia | BR-058 |
| Competencia general compartida por varios perfiles | Permitido para las competencias generales | BR-060 |
| Competencia exclusiva de un perfil usada en otro perfil | No es válido para las exclusivas | BR-060 |
| Usuario que no es el Jefe de Ingeniería ni un ADMIN | No puede definir perfiles de competencias | BR-055, BR-134 |

## 7. Reglas de negocio aplicables

| ID | Regla | Fuente |
|---|---|---|
| BR-012 | Cada rol se vincula a un perfil de competencias, y roles y perfiles se registran y mantienen en el catálogo del portal. Las competencias se definen por rol y tienen niveles de logro N1, N2 y N3. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L52 |
| BR-013 | La escala de logro de una competencia es: N1 no desarrollada, N2 en desarrollo, N3 desarrollada. No equivale a los niveles L1–L4. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L53 |
| BR-056 | Una competencia tiene código, nombre, un tipo único (conocimiento, habilidad o actitud) y la definición de cada nivel de logro. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L96 |
| BR-060 | El colaborador registra, en la edición de curso en que está enrolado y en el objetivo del curso, las referencias a issues cerrados (Task o UserStory) que evidencian el logro del objetivo. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L100 |
| BR-055 | Solo el Jefe de Ingeniería define los perfiles de competencias, el nivel mínimo, los cursos con sus objetivos y evidencias esperadas, y las ediciones. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L95 |
| BR-059 | La competencia tiene un indicador que define si es general o específica (exclusiva de un rol). Una competencia general puede estar en más de un perfil de competencias y una específica es exclusiva de un perfil. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L99 |
| BR-134 | El ADMIN puede hacer también las seis capacidades que eran exclusivas del Jefe de Ingeniería (BR-005, BR-006, BR-007, BR-055, BR-083, BR-129). | /business/rules\BRC-001-reglas-de-negocio-portal-curricula.md:L174 |

## 8. Datos y términos

| Término | Uso en esta historia | Glosario |
|---|---|---|
| Rol | Rol cuyo perfil se define | [Rol](../../business/glossary/terms/TRM-0003-rol.md) |
| Perfil de competencias | Conjunto de competencias del rol | [Perfil de competencias](../../business/glossary/terms/TRM-0010-perfil-de-competencias.md) |
| Competencia | Elemento del perfil | [Competencia](../../business/glossary/terms/TRM-0007-competencia.md) |
| Nivel de logro (N1–N3) | Escala de cada competencia | [Nivel de logro (N1–N3)](../../business/glossary/terms/TRM-0008-nivel-de-logro-n1-n3.md) |
| Evidencia esperada | Evidencia que sustenta una competencia | [Evidencia esperada](../../business/glossary/terms/TRM-0040-evidencia-esperada.md) |

## 9. Requisitos no funcionales

- **Accesibilidad:** WCAG 2.2 AA (estándar del repositorio).
- **Privacidad y datos personales:** No aplica: la historia no toca datos personales.
- **Otros:** Sin requisito identificado

## 10. Consideraciones de UX

- **Flujo esperado:** El actor elige un rol, agrega o modifica competencias de su perfil y define las evidencias esperadas de cada una.
- **Estados de la interfaz:** Vacío (rol sin perfil), sin permisos, error de validación, éxito.
- **Contenido clave:** Competencias del perfil, niveles de logro N1–N3 y evidencias esperadas.

## 11. Dependencias, supuestos e hipótesis

- **Depende de:** US-001 (catálogo de roles).
- **Es prerrequisito de:** US-003, US-006
- **Supuestos:** Ninguno
- **Hipótesis del agente:** Ninguna

## 12. Preguntas abiertas

| ID | Pregunta | Responsable | Prioridad | Bloquea | Estado |
|---|---|---|---|---|---|
| US-002-Q1 | Cerrada: los perfiles de competencias, los cursos y las ediciones los define el Jefe de Ingeniería (EVD-2026-0078, BR-055). | Jefe de Ingeniería | Alta | No | Cerrada |
| US-002-Q2 | Cerrada: los roles y los perfiles siempre están en el catálogo (EVD-2026-0081, BR-012). | Jefe de Ingeniería | Baja | No | Cerrada |
| US-002-Q3 | Cerrada: la competencia tiene un tipo único y una competencia general puede estar en más de un perfil, mientras que otras son exclusivas (EVD-2026-0086, EVD-2026-0089). | Jefe de Ingeniería | Media | No | Cerrada |
| US-002-Q4 | ¿Cómo se distingue una competencia general de una exclusiva de un perfil? | Jefe de Ingeniería | Baja | No | Abierta |

## 13. Evidencia y trazabilidad

| ID | Hallazgo | Fuente | Clasificación | Confianza |
|---|---|---|---|---|
| EVD-2026-0011 | Una competencia define lo esperado de un rol/nivel y combina conocimiento, habilidad y actitud | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L106 | decision | high |
| EVD-2026-0017 | Las competencias se definen por rol y tienen escala de logro | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L112 | decision | high |
| EVD-2026-0026 | La asignación a un proyecto requiere tener las competencias según el nivel de desarrollo: N1 no desarrollada, N2 en desarrollo, N3 desarrollada | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L121 | decision | high |
| EVD-2026-0041 | Un rol se vincula a un perfil de competencias con niveles de logro N1, N2 y N3. En la práctica, el rol/nivel selecciona de cada competencia el nivel mínimo | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L136 | decision | high |
| EVD-2026-0078 | El Jefe de Ingeniería define los perfiles de competencias, los cursos y las ediciones | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L173 | decision | high |
| EVD-2026-0081 | Los roles y los perfiles de competencias siempre están en el catálogo. Se registran y mantienen en el catálogo del portal | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L176 | decision | high |
| EVD-2026-0082 | Una competencia tiene código, nombre, tipo (conocimiento, habilidad o actitud) y la definición de cada nivel | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L177 | decision | high |
| EVD-2026-0086 | Las competencias tienen un tipo único: conocimiento, habilidad o actitud | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L181 | decision | high |
| EVD-2026-0089 | Una competencia general (por ejemplo, comunicación) puede estar en más de un perfil. Otras competencias son exclusivas de un perfil | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L184 | decision | high |
| EVD-2026-0120 | La competencia tiene un indicador que define si es general o específica | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L505 | decision | high |
| EVD-2026-0173 | El ADMIN suple las seis capacidades exclusivas del Jefe de Ingeniería | /requirements/context-packs\RCP-001-portal-gestion-curricula-desarrollo.md:L572 | decision | high |

Evidencia compartida: `source_type: human`, `observed_at: 2026-10-10T12:00:00-05:00`, `freshness: current`, `owner: Jefe de Ingeniería`.

- **Upstream:** [BRC-001](../../business/rules/BRC-001-reglas-de-negocio-portal-curricula.md), [IMD-001](../../business/information-model/IMD-001-portal-curricula.md), [GLS-001](../../business/glossary/GLS-001-glosario-de-negocio.md) y [RCP-001](../context-packs/RCP-001-portal-gestion-curricula-desarrollo.md), todos en estado `draft`.
- **Downstream (pendiente):** UXR → FLW → SCR → CMP → AC

## 14. Evaluación INVEST

| Criterio | ¿Cumple? | Justificación |
|---|---|---|
| Independiente | Parcial | Depende de US-001. |
| Negociable | Parcial | Descripción de competencias y niveles abierta (US-002-Q3). |
| Valiosa | Sí | Cada rol tiene un perfil de competencias definido sobre el que se mide a los colaboradores. |
| Estimable | Parcial | Sin saber cómo se describen competencias y niveles es difícil estimar. |
| Pequeña (Small) | Sí | Cabe en una iteración. |
| Testeable | Sí | Los 5 criterios son verificables. |

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
- **Motivo:** El actor (Jefe de Ingeniería o ADMIN, BR-055 y BR-134), el valor y los criterios están sostenidos por las reglas citadas. Las preguntas abiertas no bloquean los criterios.
- **Bloqueos de entrega:** Ninguno
- **Propuesta de división (si no es pequeña):** No aplica
- **Siguiente rol o Skill:** `ux-requirements-analyzer`
- **Decisión humana requerida:** El Jefe de Ingeniería valida la historia y responde US-002-Q4.
- **Validación:** Pendiente · Responsable: Jefe de Ingeniería · Fecha: —
