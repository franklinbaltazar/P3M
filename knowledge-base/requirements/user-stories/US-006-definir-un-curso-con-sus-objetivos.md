---
type: User Story
title: "US-006 — Definir un curso con sus objetivos"
description: "Como Jefe de Ingeniería, quiero definir un curso interno con sus objetivos, cada uno vinculado a una competencia y a un nivel de logro objetivo, para que el entrenamiento desarrolle las competencias que exige cada rol."
tags: [user-story, por-definir, cursos]
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
gitlab_issue_id: 52917
gitlab_issue_iid: 7
gitlab_issue_url: https://project.comsatel.com.pe/comsatel/development/training/dev-juniors/p3m/collaboration/-/issues/7
---

# US-006 — Definir un curso con sus objetivos

## 1. Ficha

| Campo | Valor |
|---|---|
| ID | US-006 |
| Épica / capacidad | Cursos y evidencias (IMD-001, bloque 2) |
| Horizonte / release | Por definir |
| Actor | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) o [ADMIN](../../business/glossary/terms/TRM-0028-admin.md) |
| Responsable de negocio (PO) | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) (responsable funcional del portal, /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L109) |
| Prioridad | Must: sin cursos no hay entrenamiento. La decide el PO. |
| Dependencias | US-002 |
| Preparación | READY |

## 2. Historia

**Como** Jefe de Ingeniería o usuario con perfil ADMIN, **quiero** definir un curso interno con sus objetivos, cada uno vinculado a una competencia y a un nivel de logro objetivo, **para** que el entrenamiento desarrolle las competencias que exige cada rol.

## 3. Contexto y valor

- **Problema que resuelve:** Cada curso tiene objetivos, y cada objetivo se vincula a una competencia y al nivel objetivo que se desarrolla. Un curso puede desarrollar varias competencias (BR-017).
- **Valor esperado:** Cursos que desarrollan competencias concretas hasta un nivel de logro conocido.
- **Métrica o KPI que impacta:** Sin métrica asociada

## 4. Alcance

- **Incluye:**
  - Crear un curso interno con código, nombre y sumilla (texto que resume el curso), y modificarlo.
  - Definir objetivos del curso, cada uno con su competencia y nivel objetivo.
- **Excluye:**
  - Definir la rúbrica y las evidencias esperadas de cada objetivo (US-007).
  - Crear ediciones (US-008).

## 5. Criterios de aceptación

### AC-1 — Crear un curso

```gherkin
Escenario: Crear un curso
  Dado que el actor está autorizado a definir cursos
  Cuando crea el curso con código "CUR-01", nombre "Análisis de requisitos", sumilla y modalidad virtual
  Entonces el curso queda registrado como curso interno con esos datos
```

- **Regla / fuente:** BR-016, BR-057

### AC-2 — Definir un objetivo del curso

```gherkin
Escenario: Definir un objetivo del curso
  Dado el curso "Análisis de requisitos"
  Cuando agrega un objetivo vinculado a la competencia "Comunicación" con nivel objetivo N2
  Entonces el curso tiene ese objetivo con esa competencia y ese nivel objetivo
```

- **Regla / fuente:** BR-017

### AC-3 — Un curso desarrolla varias competencias

```gherkin
Escenario: Un curso desarrolla varias competencias
  Dado el curso "Análisis de requisitos"
  Cuando agrega objetivos vinculados a dos competencias distintas
  Entonces el curso desarrolla ambas competencias
```

- **Regla / fuente:** BR-017

### AC-4 — La modalidad no cambia el tratamiento

```gherkin
Escenario: La modalidad no cambia el tratamiento
  Dado un curso virtual, otro presencial y otro híbrido
  Cuando se definen sus objetivos
  Entonces los tres se tratan igual
```

- **Regla / fuente:** BR-016

### AC-5 — Solo el Jefe de Ingeniería o el ADMIN lo define

```gherkin
Escenario: Solo el Jefe de Ingeniería o el ADMIN lo define
  Dado que el usuario está autenticado y no es el Jefe de Ingeniería ni un ADMIN
  Cuando intenta definir un curso
  Entonces el portal no permite la acción
```

- **Regla / fuente:** BR-055, BR-134

## 6. Casos negativos y límite

| Caso | Comportamiento esperado | Fuente o pregunta |
|---|---|---|
| Nivel objetivo distinto de N1, N2 o N3 | No es un nivel de logro válido | BR-013 |
| Objetivo sin competencia o sin nivel objetivo | No es válido: cada objetivo se vincula a una competencia y a un nivel objetivo | BR-017 |
| Curso sin código, nombre, sumilla o sin objetivos de aprendizaje | No cumple los datos mínimos del curso | BR-057 |
| Curso de proveedores externos | Fuera de alcance: los cursos son internos | BR-016 |
| Usuario que no es el Jefe de Ingeniería ni un ADMIN | No puede definir cursos | BR-055, BR-134 |

## 7. Reglas de negocio aplicables

| ID | Regla | Fuente |
|---|---|---|
| BR-016 | Los cursos son internos. La modalidad (virtual, presencial o híbrida) no cambia su tratamiento. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L56 |
| BR-017 | Cada curso tiene objetivos de aprendizaje, y cada objetivo se vincula a una competencia y al nivel objetivo que se desarrolla. Un curso puede desarrollar más de una competencia. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L57 |
| BR-057 | Un curso tiene código, nombre, sumilla y el listado de objetivos de aprendizaje. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L97 |
| BR-013 | La escala de logro de una competencia es: N1 no desarrollada, N2 en desarrollo, N3 desarrollada. No equivale a los niveles L1–L4. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L53 |
| BR-055 | Solo el Jefe de Ingeniería define los perfiles de competencias, el nivel mínimo, los cursos con sus objetivos y evidencias esperadas, y las ediciones. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L95 |
| BR-134 | El ADMIN puede hacer también las seis capacidades que eran exclusivas del Jefe de Ingeniería (BR-005, BR-006, BR-007, BR-055, BR-083, BR-129). | /business/rules\BRC-001-reglas-de-negocio-portal-curricula.md:L174 |

## 8. Datos y términos

| Término | Uso en esta historia | Glosario |
|---|---|---|
| Curso | Elemento que se define | [Curso](../../business/glossary/terms/TRM-0011-curso.md) |
| Objetivo de curso | Meta con competencia y nivel objetivo | [Objetivo de curso](../../business/glossary/terms/TRM-0012-objetivo-de-curso.md) |
| Competencia | Vinculada al objetivo | [Competencia](../../business/glossary/terms/TRM-0007-competencia.md) |
| Nivel de logro (N1–N3) | Nivel objetivo | [Nivel de logro (N1–N3)](../../business/glossary/terms/TRM-0008-nivel-de-logro-n1-n3.md) |

## 9. Requisitos no funcionales

- **Accesibilidad:** WCAG 2.2 AA (estándar del repositorio).
- **Privacidad y datos personales:** No aplica: la historia no toca datos personales.
- **Otros:** Sin requisito identificado

## 10. Consideraciones de UX

- **Flujo esperado:** El actor crea el curso, agrega objetivos y vincula cada uno con una competencia y un nivel objetivo.
- **Estados de la interfaz:** Vacío (curso sin objetivos), sin permisos, error de validación, éxito.
- **Contenido clave:** Objetivos del curso, su competencia y su nivel objetivo.

## 11. Dependencias, supuestos e hipótesis

- **Depende de:** US-002 (competencias del perfil).
- **Es prerrequisito de:** US-007, US-008
- **Supuestos:** Ninguno
- **Hipótesis del agente:** Ninguna

## 12. Preguntas abiertas

| ID | Pregunta | Responsable | Prioridad | Bloquea | Estado |
|---|---|---|---|---|---|
| US-002-Q1 | Cerrada: los perfiles de competencias, los cursos y las ediciones los define el Jefe de Ingeniería (EVD-2026-0078, BR-055). | Jefe de Ingeniería | Alta | No | Cerrada |
| US-006-Q1 | Cerrada: los datos mínimos son código, nombre, sumilla y objetivos de aprendizaje (EVD-2026-0084, BR-057). | Jefe de Ingeniería | Baja | No | Cerrada |
| G-37 | ¿Qué es la «sumilla» de un curso? | Jefe de Ingeniería | Baja | No | Abierta |

## 13. Evidencia y trazabilidad

| ID | Hallazgo | Fuente | Clasificación | Confianza |
|---|---|---|---|---|
| EVD-2026-0009 | Los cursos son internos | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L104 | decision | high |
| EVD-2026-0021 | Los cursos son virtuales, presenciales o híbridos. La modalidad no cambia el tratamiento | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L116 | decision | high |
| EVD-2026-0050 | Un curso tiene objetivos. Cada objetivo se vincula a la competencia y al nivel objetivo que se desarrolla en el curso | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L145 | decision | high |
| EVD-2026-0065 | Un curso puede desarrollar más de una competencia | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L160 | decision | high |
| EVD-2026-0078 | El Jefe de Ingeniería define los perfiles de competencias, los cursos y las ediciones | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L173 | decision | high |
| EVD-2026-0079 | El Jefe de Ingeniería define también el nivel mínimo, las evidencias requeridas y los objetivos | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L174 | decision | high |
| EVD-2026-0084 | Los datos mínimos de un curso son código, nombre, sumilla y el listado de objetivos de aprendizaje | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L179 | decision | high |
| EVD-2026-0173 | El ADMIN suple las seis capacidades exclusivas del Jefe de Ingeniería | /requirements/context-packs\RCP-001-portal-gestion-curricula-desarrollo.md:L572 | decision | high |

Evidencia compartida: `source_type: human`, `observed_at: 2026-10-10T12:00:00-05:00`, `freshness: current`, `owner: Jefe de Ingeniería`.

- **Upstream:** [BRC-001](../../business/rules/BRC-001-reglas-de-negocio-portal-curricula.md), [IMD-001](../../business/information-model/IMD-001-portal-curricula.md), [GLS-001](../../business/glossary/GLS-001-glosario-de-negocio.md) y [RCP-001](../context-packs/RCP-001-portal-gestion-curricula-desarrollo.md), todos en estado `draft`.
- **Downstream (pendiente):** UXR → FLW → SCR → CMP → AC

## 14. Evaluación INVEST

| Criterio | ¿Cumple? | Justificación |
|---|---|---|
| Independiente | Parcial | Depende de US-002. |
| Negociable | Sí | Los datos mínimos del curso se pueden conversar. |
| Valiosa | Sí | Cursos que desarrollan competencias concretas hasta un nivel de logro conocido. |
| Estimable | Parcial | Faltan los datos mínimos del curso (US-006-Q1). |
| Pequeña (Small) | Sí | Cabe en una iteración. |
| Testeable | Sí | Los 4 criterios son verificables. |

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
- **Decisión humana requerida:** El Jefe de Ingeniería valida la historia y define qué es la sumilla (G-37).
- **Validación:** Pendiente · Responsable: Jefe de Ingeniería · Fecha: —
