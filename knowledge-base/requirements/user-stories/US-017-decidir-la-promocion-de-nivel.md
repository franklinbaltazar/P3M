---
type: User Story
title: "US-017 — Decidir la promoción de nivel o seniority de un colaborador"
description: "Como Jefe de Ingeniería, quiero ver la brecha de un colaborador frente al siguiente rol/nivel y decidir su promoción con las certificaciones, las evidencias de proyecto y las valoraciones, para promover con criterio y con sustento a quienes cumplen el nivel mínimo del siguiente rol/nivel."
tags: [user-story, por-definir, promocion, progresion]
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
gitlab_issue_id: 52928
gitlab_issue_iid: 18
gitlab_issue_url: https://project.comsatel.com.pe/comsatel/development/training/dev-juniors/p3m/collaboration/-/issues/18
---

# US-017 — Decidir la promoción de nivel o seniority de un colaborador

## 1. Ficha

| Campo | Valor |
|---|---|
| ID | US-017 |
| Épica / capacidad | Progresión (IMD-001, bloque 3) |
| Horizonte / release | Por definir |
| Actor | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) o [ADMIN](../../business/glossary/terms/TRM-0028-admin.md) |
| Responsable de negocio (PO) | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) (responsable funcional del portal, /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L109) |
| Prioridad | Must: es la finalidad de la progresión profesional. La decide el PO. |
| Dependencias | US-012, US-015, US-016 |
| Preparación | READY |

## 2. Historia

**Como** Jefe de Ingeniería o usuario con perfil ADMIN, **quiero** ver la brecha de un colaborador frente al siguiente rol/nivel y decidir su promoción con las certificaciones, las evidencias de proyecto y las valoraciones, **para** promover con criterio y con sustento a quienes cumplen el nivel mínimo del siguiente rol/nivel.

## 3. Contexto y valor

- **Problema que resuelve:** La promoción de nivel o seniority es un criterio libre del Jefe de Ingeniería, basado en la valoración del cumplimiento del siguiente rol/nivel en su nivel mínimo, con certificaciones y evidencias de proyecto (BR-007, BR-029, BR-030).
- **Valor esperado:** Promociones sustentadas y trazables.
- **Métrica o KPI que impacta:** Sin métrica asociada

## 4. Alcance

- **Incluye:**
  - Mostrar la brecha entre el nivel actual y el nivel mínimo del siguiente rol/nivel.
  - Mostrar certificaciones, evidencias de proyecto y valoraciones del colaborador.
  - Decidir la promoción al siguiente rol/nivel.
- **Excluye:**
  - Registrar valoraciones (US-016).
  - Historial de cambios de nivel (G-06).

## 5. Criterios de aceptación

### AC-1 — Ver la brecha frente al siguiente rol/nivel

```gherkin
Escenario: Ver la brecha frente al siguiente rol/nivel
  Dado un colaborador con valoraciones registradas
  Cuando el Jefe de Ingeniería consulta su situación
  Entonces ve la diferencia entre el nivel actual de cada competencia y el nivel mínimo del siguiente rol/nivel
```

- **Regla / fuente:** BR-052, BR-029

### AC-2 — Ver los sustentos

```gherkin
Escenario: Ver los sustentos
  Dado un colaborador
  Cuando el Jefe de Ingeniería evalúa su promoción
  Entonces ve sus certificaciones de curso, sus evidencias de proyecto y sus valoraciones
```

- **Regla / fuente:** BR-030

### AC-3 — Decidir la promoción

```gherkin
Escenario: Decidir la promoción
  Dado un colaborador en Junior L4
  Cuando el Jefe de Ingeniería decide su promoción
  Entonces el colaborador pasa a Semisenior L1
```

- **Regla / fuente:** BR-007, BR-029, BR-031

### AC-4 — Solo el Jefe de Ingeniería o el ADMIN lo define

```gherkin
Escenario: Solo el Jefe de Ingeniería o el ADMIN lo define
  Dado que el usuario está autenticado y no es el Jefe de Ingeniería ni un ADMIN
  Cuando intenta decidir una promoción de nivel
  Entonces el portal no permite la acción
```

- **Regla / fuente:** BR-007, BR-134

### AC-5 — Evaluación de desempeño obligatoria

```gherkin
Escenario: Promover exige evaluación de desempeño
  Dado un colaborador sin evaluación de desempeño registrada
  Cuando el Jefe de Ingeniería intenta promoverlo a un nuevo rol/nivel
  Entonces el portal no lo permite
```

- **Regla / fuente:** BR-088

## 6. Casos negativos y límite

| Caso | Comportamiento esperado | Fuente o pregunta |
|---|---|---|
| Colaborador en Senior L4 | Sin regla: no se declara una promoción posterior | BR-031 |
| Colaborador sin valoración registrada | Sin regla | US-017-Q1 |
| Promover aunque la brecha no esté cubierta | Permitido: el criterio es libre del Jefe de Ingeniería | BR-029 |
| Datos de la decisión (fecha, motivo) e historial | Sin regla | US-017-Q1 |

## 7. Reglas de negocio aplicables

| ID | Regla | Fuente |
|---|---|---|
| BR-007 | Solo el Jefe de Ingeniería decide la promoción de nivel o de seniority de un colaborador. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L47 |
| BR-029 | La promoción de nivel o seniority es un criterio libre del Jefe de Ingeniería, basado en la valoración del cumplimiento del siguiente rol/nivel en su nivel mínimo. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L69 |
| BR-030 | La promoción de nivel o seniority se basa en las certificaciones de cursos (resultados de promoción en el curso) y en las evidencias de proyecto que aporta el colaborador. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L70 |
| BR-031 | El paso de L4 de un seniority a L1 del siguiente es: de Junior L4 a Semisenior L1 y de Semisenior L4 a Senior L1. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L71 |
| BR-052 | El portal muestra la brecha entre el nivel actual de cada competencia del colaborador y el nivel mínimo del siguiente rol/nivel. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L92 |
| BR-088 | La evaluación de desempeño es obligatoria para promover al colaborador a un nuevo rol/nivel. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L128 |
| BR-134 | El ADMIN puede hacer también las seis capacidades que eran exclusivas del Jefe de Ingeniería (BR-005, BR-006, BR-007, BR-055, BR-083, BR-129). | /business/rules\BRC-001-reglas-de-negocio-portal-curricula.md:L174 |

## 8. Datos y términos

| Término | Uso en esta historia | Glosario |
|---|---|---|
| Promoción de nivel | Decisión que se registra | [Promoción de nivel](../../business/glossary/terms/TRM-0024-promocion-de-nivel.md) |
| Brecha de cumplimiento | Información que se muestra | [Brecha de cumplimiento](../../business/glossary/terms/TRM-0042-brecha-de-cumplimiento.md) |
| Valoración de cumplimiento | Sustento | [Valoración de cumplimiento](../../business/glossary/terms/TRM-0025-valoracion-de-cumplimiento.md) |
| Certificación de curso | Sustento | [Certificación de curso](../../business/glossary/terms/TRM-0022-certificacion-de-curso.md) |
| Evidencia de proyecto | Sustento | [Evidencia de proyecto](../../business/glossary/terms/TRM-0018-evidencia-de-proyecto.md) |
| Nivel mínimo de competencia | Referencia de la brecha | [Nivel mínimo de competencia](../../business/glossary/terms/TRM-0009-nivel-minimo-de-competencia.md) |

## 9. Requisitos no funcionales

- **Accesibilidad:** WCAG 2.2 AA (estándar del repositorio).
- **Privacidad y datos personales:** Toca la identidad de colaboradores. Restricción: BR-003 y la política pendiente G-12.
- **Otros:** Auditoría: la decisión debe poder justificarse con los sustentos mostrados.

## 10. Consideraciones de UX

- **Flujo esperado:** El actor abre a un colaborador, revisa la brecha y los sustentos y decide la promoción.
- **Estados de la interfaz:** Sin valoraciones, sin permisos, error, éxito.
- **Contenido clave:** Brecha por competencia, certificaciones, evidencias y valoraciones.

## 11. Dependencias, supuestos e hipótesis

- **Depende de:** US-026 (evaluación de desempeño, obligatoria para promover). US-012 (certificación), US-015 (evidencias validadas) y US-016 (valoración).
- **Es prerrequisito de:** —
- **Supuestos:** Ninguno
- **Hipótesis del agente:** Ninguna

## 12. Preguntas abiertas

| ID | Pregunta | Responsable | Prioridad | Bloquea | Estado |
|---|---|---|---|---|---|
| US-017-Q1 | ¿Qué se registra de la decisión (fecha, motivo) y qué pasa con un colaborador sin valoraciones? | Jefe de Ingeniería | Media | No | Abierta |
| G-06 | ¿Se conserva el historial de cambios de nivel y seniority? | Jefe de Ingeniería | Media | No | Abierta |

## 13. Evidencia y trazabilidad

| ID | Hallazgo | Fuente | Clasificación | Confianza |
|---|---|---|---|---|
| EVD-2026-0052 | El Jefe de Ingeniería toma los resultados de promoción del curso del colaborador y las evidencias que el propio colaborador aporta (tareas o user stories que sustentan el nivel de logro de las competencias de su rol/nivel). Con ellos decide la promoción de nivel | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L147 | decision | high |
| EVD-2026-0053 | La promoción de nivel o seniority es un criterio libre del Jefe de Ingeniería, basado en la valoración del cumplimiento del siguiente rol/nivel en su nivel mínimo | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L148 | decision | high |
| EVD-2026-0015 | El paso entre niveles y entre seniority (L4 Junior → L1 Semisenior, L4 Semisenior → L1 Senior) se basa en certificaciones de cursos y en evidencias de proyectos (tareas y entregables) | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L110 | decision | high |
| EVD-2026-0073 | La valoración registra el nivel actual de cada competencia del colaborador, con historial, y el portal muestra la brecha frente al siguiente nivel | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L168 | decision | high |
| EVD-2026-0128 | La evaluación de desempeño es obligatoria para promover a un nuevo rol/nivel | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L513 | decision | high |
| EVD-2026-0173 | El ADMIN suple las seis capacidades exclusivas del Jefe de Ingeniería | /requirements/context-packs\RCP-001-portal-gestion-curricula-desarrollo.md:L572 | decision | high |

Evidencia compartida: `source_type: human`, `observed_at: 2026-10-10T12:00:00-05:00`, `freshness: current`, `owner: Jefe de Ingeniería`.

- **Upstream:** [BRC-001](../../business/rules/BRC-001-reglas-de-negocio-portal-curricula.md), [IMD-001](../../business/information-model/IMD-001-portal-curricula.md), [GLS-001](../../business/glossary/GLS-001-glosario-de-negocio.md) y [RCP-001](../context-packs/RCP-001-portal-gestion-curricula-desarrollo.md), todos en estado `draft`.
- **Downstream (pendiente):** UXR → FLW → SCR → CMP → AC

## 14. Evaluación INVEST

| Criterio | ¿Cumple? | Justificación |
|---|---|---|
| Independiente | Parcial | Necesita US-012, US-015 y US-016. |
| Negociable | Parcial | Los datos de la decisión quedan abiertos. |
| Valiosa | Sí | Promociones sustentadas y trazables. |
| Estimable | Parcial | Depende de varias historias previas. |
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
- **Motivo:** Actor, valor y criterios sostenidos por BR-134, BR-007, BR-029, BR-030 y BR-052. Las preguntas abiertas no bloquean.
- **Bloqueos de entrega:** Ninguno
- **Propuesta de división (si no es pequeña):** Si resulta grande: separar «ver la brecha» de «decidir la promoción».
- **Siguiente rol o Skill:** `ux-requirements-analyzer`
- **Decisión humana requerida:** El Jefe de Ingeniería valida la historia y responde US-017-Q1 y G-06.
- **Validación:** Pendiente · Responsable: Jefe de Ingeniería · Fecha: —
