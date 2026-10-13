---
type: User Story
title: "US-003 — Definir el nivel mínimo de cada competencia para un rol/nivel"
description: "Como Jefe de Ingeniería, quiero definir, para cada rol/nivel, el nivel de logro mínimo exigido de cada competencia de su perfil, para poder verificar el cumplimiento al asignar colaboradores a proyectos y al decidir promociones."
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
gitlab_issue_id: 52914
gitlab_issue_iid: 4
gitlab_issue_url: https://project.comsatel.com.pe/comsatel/development/training/dev-juniors/p3m/collaboration/-/issues/4
---

# US-003 — Definir el nivel mínimo de cada competencia para un rol/nivel

## 1. Ficha

| Campo | Valor |
|---|---|
| ID | US-003 |
| Épica / capacidad | Roles y competencias (IMD-001, bloque 1) |
| Horizonte / release | Por definir |
| Actor | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) o [ADMIN](../../business/glossary/terms/TRM-0028-admin.md) |
| Responsable de negocio (PO) | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) (responsable funcional del portal, /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L109) |
| Prioridad | Must: la asignación y la promoción dependen del nivel mínimo. La decide el PO. |
| Dependencias | US-001, US-002 |
| Preparación | READY |

## 2. Historia

**Como** Jefe de Ingeniería o usuario con perfil ADMIN, **quiero** definir, para cada rol/nivel, el nivel de logro mínimo exigido de cada competencia de su perfil, **para** poder verificar el cumplimiento al asignar colaboradores a proyectos y al decidir promociones.

## 3. Contexto y valor

- **Problema que resuelve:** El rol/nivel selecciona de cada competencia de su perfil el nivel mínimo (BR-014). El N2 que se citó antes era solo un ejemplo.
- **Valor esperado:** Cada rol/nivel tiene definido qué nivel de logro se espera de cada competencia.
- **Métrica o KPI que impacta:** Sin métrica asociada

## 4. Alcance

- **Incluye:**
  - Definir el nivel mínimo (N1, N2 o N3) de cada competencia del perfil, por cada rol/nivel.
  - Modificar un nivel mínimo ya definido.
- **Excluye:**
  - Definir el perfil y sus competencias (US-002).
  - Verificar el nivel mínimo al asignar (historia de asignación, por redactar).

## 5. Criterios de aceptación

### AC-1 — Definir el nivel mínimo de una competencia

```gherkin
Escenario: Definir el nivel mínimo de una competencia
  Dado el rol/nivel "Analista Junior L2" y su perfil con la competencia "Comunicación"
  Cuando se define N2 como nivel mínimo de "Comunicación"
  Entonces el rol/nivel "Analista Junior L2" exige como mínimo N2 en "Comunicación"
```

- **Regla / fuente:** BR-014

### AC-2 — Un rol/nivel puede tener un mínimo distinto de otro

```gherkin
Escenario: Un rol/nivel puede tener un mínimo distinto de otro
  Dado los rol/nivel "Analista Junior L1" y "Analista Junior L2"
  Cuando se define el nivel mínimo de la misma competencia en cada uno
  Entonces cada rol/nivel conserva su propio nivel mínimo
```

- **Regla / fuente:** BR-014

### AC-3 — El mínimo es un nivel de logro válido

```gherkin
Escenario: El mínimo es un nivel de logro válido
  Dado un rol/nivel y una competencia de su perfil
  Cuando se define el nivel mínimo
  Entonces solo se acepta N1, N2 o N3
```

- **Regla / fuente:** BR-013, BR-014

### AC-4 — Solo el Jefe de Ingeniería o el ADMIN lo define

```gherkin
Escenario: Solo el Jefe de Ingeniería o el ADMIN lo define
  Dado que el usuario está autenticado y no es el Jefe de Ingeniería ni un ADMIN
  Cuando intenta definir el nivel mínimo de una competencia
  Entonces el portal no permite la acción
```

- **Regla / fuente:** BR-055, BR-134

## 6. Casos negativos y límite

| Caso | Comportamiento esperado | Fuente o pregunta |
|---|---|---|
| Nivel mínimo distinto de N1, N2 o N3 | No es válido | BR-013 |
| Competencia que no pertenece al perfil del rol | No lleva nivel mínimo: el rol solo tiene mínimo para las competencias asociadas a su perfil | BR-014 |
| Rol/nivel sin nivel mínimo definido para alguna competencia | Sin regla | US-003-Q1 |
| Significado de "nivel de desarrollo" (escala L1–L4 común o posición dentro de cada seniority) | Sin regla | IM-Q6 |
| Usuario que no es el Jefe de Ingeniería ni un ADMIN | No puede definir el nivel mínimo | BR-055, BR-134 |

## 7. Reglas de negocio aplicables

| ID | Regla | Fuente |
|---|---|---|
| BR-011 | Cada seniority (Junior, Semisenior, Senior) contiene los niveles de desarrollo L1, L2, L3 y L4. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L51 |
| BR-013 | La escala de logro de una competencia es: N1 no desarrollada, N2 en desarrollo, N3 desarrollada. No equivale a los niveles L1–L4. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L53 |
| BR-014 | El rol/nivel selecciona de cada competencia de su perfil el nivel mínimo exigido, y solo de las competencias asociadas a su perfil. El N2 citado antes era solo un ejemplo. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L54 |
| BR-055 | Solo el Jefe de Ingeniería define los perfiles de competencias, el nivel mínimo, los cursos con sus objetivos y evidencias esperadas, y las ediciones. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L95 |
| BR-134 | El ADMIN puede hacer también las seis capacidades que eran exclusivas del Jefe de Ingeniería (BR-005, BR-006, BR-007, BR-055, BR-083, BR-129). | /business/rules\BRC-001-reglas-de-negocio-portal-curricula.md:L174 |

## 8. Datos y términos

| Término | Uso en esta historia | Glosario |
|---|---|---|
| Rol/nivel | Combinación que recibe el nivel mínimo | [Rol/nivel](../../business/glossary/terms/TRM-0006-rol-nivel.md) |
| Nivel mínimo de competencia | Dato que se define | [Nivel mínimo de competencia](../../business/glossary/terms/TRM-0009-nivel-minimo-de-competencia.md) |
| Competencia | Elemento del perfil | [Competencia](../../business/glossary/terms/TRM-0007-competencia.md) |
| Nivel de logro (N1–N3) | Valores posibles | [Nivel de logro (N1–N3)](../../business/glossary/terms/TRM-0008-nivel-de-logro-n1-n3.md) |
| Nivel de desarrollo (L1–L4) | Parte del rol/nivel | [Nivel de desarrollo (L1–L4)](../../business/glossary/terms/TRM-0005-nivel-de-desarrollo-l1-l4.md) |

## 9. Requisitos no funcionales

- **Accesibilidad:** WCAG 2.2 AA (estándar del repositorio).
- **Privacidad y datos personales:** No aplica: la historia no toca datos personales.
- **Otros:** Sin requisito identificado

## 10. Consideraciones de UX

- **Flujo esperado:** El actor elige un rol/nivel y, para cada competencia de su perfil, selecciona el nivel mínimo.
- **Estados de la interfaz:** Vacío (sin mínimos definidos), sin permisos, error de validación, éxito.
- **Contenido clave:** Competencias del perfil y nivel mínimo vigente de cada una.

## 11. Dependencias, supuestos e hipótesis

- **Depende de:** US-001 y US-002.
- **Es prerrequisito de:** Asignación y valoración (historias por redactar)
- **Supuestos:** Ninguno
- **Hipótesis del agente:** Ninguna

## 12. Preguntas abiertas

| ID | Pregunta | Responsable | Prioridad | Bloquea | Estado |
|---|---|---|---|---|---|
| US-002-Q1 | Cerrada: los perfiles de competencias, los cursos y las ediciones los define el Jefe de Ingeniería (EVD-2026-0078, BR-055). | Jefe de Ingeniería | Alta | No | Cerrada |
| US-003-Q1 | Cerrada: el rol tiene el nivel mínimo esperado de las competencias asociadas a su perfil (EVD-2026-0083). Duda menor: la respuesta dice «rol» y no «rol/nivel». | Jefe de Ingeniería | Baja | No | Cerrada |
| IM-Q6 | ¿«Nivel de desarrollo» es una escala común L1–L4 o una posición dentro de cada seniority? | Jefe de Ingeniería | Baja | No | Abierta |

## 13. Evidencia y trazabilidad

| ID | Hallazgo | Fuente | Clasificación | Confianza |
|---|---|---|---|---|
| EVD-2026-0007 | Cada seniority contiene niveles L1–L4, que expresan niveles de desarrollo de competencias | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L102 | decision | high |
| EVD-2026-0026 | La asignación a un proyecto requiere tener las competencias según el nivel de desarrollo: N1 no desarrollada, N2 en desarrollo, N3 desarrollada | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L121 | decision | high |
| EVD-2026-0041 | Un rol se vincula a un perfil de competencias con niveles de logro N1, N2 y N3. En la práctica, el rol/nivel selecciona de cada competencia el nivel mínimo | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L136 | decision | high |
| EVD-2026-0063 | El nivel mínimo N2 era solo un ejemplo. El nivel mínimo lo define el rol/nivel por competencia | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L158 | decision | high |
| EVD-2026-0078 | El Jefe de Ingeniería define los perfiles de competencias, los cursos y las ediciones | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L173 | decision | high |
| EVD-2026-0079 | El Jefe de Ingeniería define también el nivel mínimo, las evidencias requeridas y los objetivos | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L174 | decision | high |
| EVD-2026-0083 | Un rol tiene, para las competencias asociadas a su perfil, el nivel mínimo esperado de la competencia | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L178 | decision | medium |
| EVD-2026-0173 | El ADMIN suple las seis capacidades exclusivas del Jefe de Ingeniería | /requirements/context-packs\RCP-001-portal-gestion-curricula-desarrollo.md:L572 | decision | high |

Evidencia compartida: `source_type: human`, `observed_at: 2026-10-10T12:00:00-05:00`, `freshness: current`, `owner: Jefe de Ingeniería`.

- **Upstream:** [BRC-001](../../business/rules/BRC-001-reglas-de-negocio-portal-curricula.md), [IMD-001](../../business/information-model/IMD-001-portal-curricula.md), [GLS-001](../../business/glossary/GLS-001-glosario-de-negocio.md) y [RCP-001](../context-packs/RCP-001-portal-gestion-curricula-desarrollo.md), todos en estado `draft`.
- **Downstream (pendiente):** UXR → FLW → SCR → CMP → AC

## 14. Evaluación INVEST

| Criterio | ¿Cumple? | Justificación |
|---|---|---|
| Independiente | Parcial | Depende de US-001 y US-002. |
| Negociable | Parcial | El alcance exacto del mínimo por rol/nivel queda abierto (US-003-Q1). |
| Valiosa | Sí | Cada rol/nivel tiene definido qué nivel de logro se espera de cada competencia. |
| Estimable | Parcial | Depende de cómo se modele el rol/nivel (IM-Q6). |
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
- **Motivo:** El actor (Jefe de Ingeniería o ADMIN, BR-055 y BR-134), el valor y los criterios están sostenidos por las reglas citadas. Las preguntas abiertas no bloquean los criterios.
- **Bloqueos de entrega:** Ninguno
- **Propuesta de división (si no es pequeña):** No aplica
- **Siguiente rol o Skill:** `ux-requirements-analyzer`
- **Decisión humana requerida:** El Jefe de Ingeniería valida la historia y confirma si el nivel mínimo es por rol o por rol/nivel.
- **Validación:** Pendiente · Responsable: Jefe de Ingeniería · Fecha: —
