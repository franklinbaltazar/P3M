---
type: User Story
title: "US-028 — Cerrar la sesión a demanda o por vencimiento"
description: "Como Usuario, quiero cerrar mi sesión cuando lo decida y que se cierre al vencer el tiempo de sesión, para proteger mi cuenta."
tags: [user-story, keycloak, sesion]
status: approved
generated:
  by: "af-user-story-refiner/2.0"
  at: "2026-10-11T09:00:00-05:00"
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
gitlab_issue_id: 52939
gitlab_issue_iid: 29
gitlab_issue_url: https://project.comsatel.com.pe/comsatel/development/training/dev-juniors/p3m/collaboration/-/issues/29
---

# US-028 — Cerrar la sesión a demanda o por vencimiento

## 1. Ficha

| Campo | Valor |
|---|---|
| ID | US-028 |
| Épica / capacidad | Identidad y acceso (IMD-001, bloque 1) |
| Horizonte / release | Por definir |
| Actor | [Usuario](../../business/glossary/terms/TRM-0052-usuario.md) |
| Responsable de negocio (PO) | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) (responsable funcional del portal, /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L109) |
| Prioridad | Must: protege las cuentas y los datos. La decide el PO. |
| Dependencias | US-027 (ingresar al portal). |
| Preparación | READY |

## 2. Historia

**Como** Usuario, **quiero** cerrar mi sesión cuando lo decida, y que se cierre sola al vencer el tiempo de sesión controlado por Keycloak, **para** proteger mi cuenta y mis datos.

## 3. Contexto y valor

- **Problema que resuelve:** La sesión debe terminar a demanda o por vencimiento, con la sesión del portal y la de Keycloak alineadas (BR-096).
- **Valor esperado:** Cuentas protegidas y sesiones coherentes entre el portal y Keycloak.
- **Métrica o KPI que impacta:** Sin métrica asociada

## 4. Alcance

- **Incluye:**
  - Cerrar sesión a demanda.
  - Cerrar sesión por vencimiento del tiempo de sesión controlado por Keycloak.
  - Mantener alineadas la sesión del portal y la de Keycloak.
- **Excluye:**
  - Ingresar al portal (US-027).
  - Definir el tiempo de sesión (se controla en Keycloak).

## 5. Criterios de aceptación

### AC-1 — Cierre a demanda

```gherkin
Escenario: Cerrar sesión a demanda
  Dado un usuario con sesión iniciada
  Cuando decide cerrar sesión
  Entonces su sesión termina en el portal y en Keycloak y para volver a usar el portal debe autenticarse
```

- **Regla / fuente:** BR-096

### AC-2 — Cierre por vencimiento

```gherkin
Escenario: Cierre por vencimiento
  Dado un usuario con sesión iniciada
  Cuando vence el tiempo de sesión controlado por Keycloak
  Entonces la sesión del portal se cierra y debe autenticarse de nuevo
```

- **Regla / fuente:** BR-096

### AC-3 — Sesiones alineadas

```gherkin
Escenario: Sesiones alineadas
  Dado una sesión en el portal y una sesión en Keycloak
  Cuando una de las dos termina
  Entonces la otra también termina
```

- **Regla / fuente:** BR-096

### AC-4 — Aviso del vencimiento

```gherkin
Escenario: Mensaje emergente de vencimiento
  Dado un usuario con sesión iniciada
  Cuando se acerca o llega el vencimiento de su sesión
  Entonces el portal le muestra un mensaje emergente sobre el vencimiento
```

- **Regla / fuente:** BR-098

### AC-5 — Cierre de sesión global

```gherkin
Escenario: Cierre global
  Dado un usuario con sesión iniciada
  Cuando se cierra su sesión, a demanda o por vencimiento
  Entonces la sesión se cierra en todo el portal y en Keycloak
```

- **Regla / fuente:** BR-099

### AC-6 — El trabajo en curso se pierde

```gherkin
Escenario: Trabajo en curso al cerrar la sesión
  Dado un usuario con trabajo en curso sin guardar
  Cuando se cierra su sesión
  Entonces el trabajo en curso se pierde
```

- **Regla / fuente:** BR-100

## 6. Casos negativos y límite

| Caso | Comportamiento esperado | Fuente o pregunta |
|---|---|---|
| Usuario con trabajo sin guardar al vencer la sesión | El trabajo en curso se pierde | BR-100 |
| Aviso antes de que venza | Se muestra un mensaje emergente | BR-098 |
| Anticipación del aviso y renovación de la sesión | Sin regla | RQ-31 |
| Cierre en varias pestañas del portal | El cierre es global | BR-099 |
| Cierre en otras aplicaciones que usan el mismo Keycloak | Sin regla | RQ-31 |

## 7. Reglas de negocio aplicables

| ID | Regla | Fuente |
|---|---|---|
| BR-096 | El usuario puede cerrar sesión a demanda, y la sesión se cierra por vencimiento del tiempo de sesión controlado por Keycloak. La sesión del portal y la de Keycloak deben estar alineadas. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L136 |
| BR-098 | El portal muestra al usuario un mensaje emergente (popup) sobre el vencimiento de su sesión. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L138 |
| BR-099 | El cierre de sesión es global: cierra la sesión del usuario en todo el portal y en Keycloak. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L139 |
| BR-100 | El trabajo en curso se pierde con el cierre de la sesión. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L140 |

## 8. Datos y términos

| Término | Uso en esta historia | Glosario |
|---|---|---|
| Usuario | Actor | [Usuario](../../business/glossary/terms/TRM-0052-usuario.md) |
| Keycloak | Proveedor de identidad | [Keycloak](../../business/glossary/terms/TRM-0037-keycloak.md) |

## 9. Requisitos no funcionales

- **Accesibilidad:** WCAG 2.2 AA (estándar del repositorio).
- **Privacidad y datos personales:** Toca la identidad del usuario. Restricción: BR-003 y la política pendiente G-12.
- **Otros:** Restricciones de arquitectura declaradas: SPA en Angular con BFF en Next.js, autenticación con Keycloak mediante PKCE sin datos sensibles en el navegador (D-115, anexo C del pack), micro UI y catálogo de componentes basado en Atomic Design (D-117). La cookie que controla el BFF con el SPA y la sesión de Keycloak deben estar alineadas (D-116).

## 10. Consideraciones de UX

- **Flujo esperado:** El usuario cierra sesión desde el portal, o al vencer el tiempo vuelve a la pantalla de autenticación.
- **Estados de la interfaz:** Sesión activa, sesión cerrada, sesión vencida, error.
- **Contenido clave:** Mensaje de que la sesión terminó.

## 11. Dependencias, supuestos e hipótesis

- **Depende de:** US-027 (ingresar al portal).
- **Es prerrequisito de:** Ninguna
- **Supuestos:** Ninguno
- **Hipótesis del agente:** Ninguna

## 12. Preguntas abiertas

| ID | Pregunta | Responsable | Prioridad | Bloquea | Estado |
|---|---|---|---|---|---|
| RQ-31 | ¿Cuánto dura la sesión, con cuánta anticipación se avisa, se puede renovar y el cierre global alcanza a otras aplicaciones? (RQ-31 quedó cerrada en parte) | Arquitectura | Media | No | Abierta |

## 13. Evidencia y trazabilidad

| ID | Hallazgo | Fuente | Clasificación | Confianza |
|---|---|---|---|---|
| EVD-2026-0138 | Cierre de sesión a demanda o por vencimiento controlado por Keycloak, con la cookie del BFF y la sesión de Keycloak alineadas | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L523 | decision | high |
| EVD-2026-0142 | Se muestra un mensaje emergente sobre el vencimiento, el cierre es global y el trabajo en curso se pierde | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L539 | decision | high |

Evidencia compartida: `source_type: human`, `observed_at: 2026-10-11T09:00:00-05:00`, `freshness: current`, `owner: Jefe de Ingeniería`.

- **Upstream:** [BRC-001](../../business/rules/BRC-001-reglas-de-negocio-portal-curricula.md), [IMD-001](../../business/information-model/IMD-001-portal-curricula.md), [GLS-001](../../business/glossary/GLS-001-glosario-de-negocio.md) y [RCP-001](../context-packs/RCP-001-portal-gestion-curricula-desarrollo.md).
- **Downstream (pendiente):** UXR → FLW → SCR → CMP → AC

## 14. Evaluación INVEST

| Criterio | ¿Cumple? | Justificación |
|---|---|---|
| Independiente | Parcial | Necesita US-027. |
| Negociable | Parcial | Tiempo de sesión, anticipación y renovación abiertos (RQ-31). |
| Valiosa | Sí | Cuentas protegidas. |
| Estimable | Sí | Alcance definido. |
| Pequeña (Small) | Sí | Cabe en una iteración. |
| Testeable | Sí | Los 6 criterios son verificables. |

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
- **Motivo:** Actor, valor y criterios sostenidos por BR-096. RQ-31 quedó cerrada en parte. RQ-31 afecta los tiempos y la renovación, no el comportamiento central.
- **Bloqueos de entrega:** Ninguno
- **Propuesta de división (si no es pequeña):** No aplica
- **Siguiente rol o Skill:** `ux-requirements-analyzer`
- **Decisión humana requerida:** El Jefe de Ingeniería valida la historia.
- **Validación:** Pendiente · Responsable: Jefe de Ingeniería · Fecha: —
