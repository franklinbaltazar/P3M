---
type: User Story
title: "US-027 — Ingresar al portal de forma segura"
description: "Como Usuario, quiero ingresar al portal autenticándome en Keycloak de forma segura, para acceder a las funciones de mi rol sin comprometer mis datos sensibles."
tags: [user-story, keycloak, ingreso]
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
gitlab_issue_id: 52938
gitlab_issue_iid: 28
gitlab_issue_url: https://project.comsatel.com.pe/comsatel/development/training/dev-juniors/p3m/collaboration/-/issues/28
---

# US-027 — Ingresar al portal de forma segura

## 1. Ficha

| Campo | Valor |
|---|---|
| ID | US-027 |
| Épica / capacidad | Identidad y acceso (IMD-001, bloque 1) |
| Horizonte / release | Por definir |
| Actor | [Usuario](../../business/glossary/terms/TRM-0052-usuario.md) |
| Responsable de negocio (PO) | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) (responsable funcional del portal, /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L109) |
| Prioridad | Must: sin ingreso no hay acceso por rol. La decide el PO. |
| Dependencias | Keycloak como proveedor de identidad (BR-044). |
| Preparación | READY |

## 2. Historia

**Como** Usuario (colaborador, Instructor, Jefe de Ingeniería o ADMIN), **quiero** ingresar al portal autenticándome en Keycloak de forma segura, **para** acceder a las funciones de mi rol sin comprometer mis datos sensibles.

## 3. Contexto y valor

- **Problema que resuelve:** Los usuarios y sus roles se gestionan en Keycloak (BR-044) y el portal debe permitir un ingreso seguro (BR-095).
- **Valor esperado:** Ingreso seguro con la identidad corporativa de Keycloak.
- **Métrica o KPI que impacta:** Sin métrica asociada

## 4. Alcance

- **Incluye:**
  - Ingresar al portal autenticándose en Keycloak.
  - Impedir el acceso a quien no se autentica.
  - Impedir el acceso a un usuario sin colaborador registrado (salvo los roles Instructor, ADMIN y Jefe de Ingeniería) y cerrar su sesión.
  - Mostrar la página inicial del portal cuando Keycloak no está disponible.
- **Excluye:**
  - Registrar al usuario con sus datos y roles (US-025).
  - Cerrar la sesión (US-028).
  - Gestionar usuarios y roles (se hace en Keycloak, BR-044).

## 5. Criterios de aceptación

### AC-1 — Ingresar autenticándose

```gherkin
Escenario: Ingresar autenticándose en Keycloak
  Dado un usuario con una cuenta en Keycloak
  Cuando intenta ingresar al portal y se autentica
  Entonces accede al portal con los roles que tiene asignados en Keycloak
```

- **Regla / fuente:** BR-095, BR-044

### AC-2 — Acceso sin autenticación

```gherkin
Escenario: Acceso sin autenticación
  Dado una persona que no está autenticada
  Cuando intenta abrir una función del portal
  Entonces el portal le pide autenticarse en Keycloak y no le muestra datos
```

- **Regla / fuente:** BR-095

### AC-3 — Datos sensibles fuera del navegador

```gherkin
Escenario: Sin datos sensibles en el navegador
  Dado un usuario que ingresó al portal
  Cuando el navegador mantiene su sesión
  Entonces no quedan datos sensibles de la autenticación accesibles desde el navegador
```

- **Regla / fuente:** BR-095

### AC-4 — Usuario sin colaborador registrado

```gherkin
Escenario: Usuario sin colaborador registrado
  Dado un usuario autenticado en Keycloak que no tiene colaborador registrado
  Y que no tiene el rol Instructor, ADMIN ni Jefe de Ingeniería
  Cuando intenta ingresar al portal
  Entonces no se le permite el ingreso y es derivado a la página de login
  Y su sesión en Keycloak y en el BFF se cierra automáticamente
```

- **Regla / fuente:** Decisión del Jefe de Ingeniería del 2026-10-11 (respuesta a RQ-22)

### AC-5 — Keycloak no disponible

```gherkin
Escenario: Keycloak no disponible
  Dado que Keycloak no está disponible
  Cuando un usuario intenta ingresar al portal
  Entonces el usuario ve la página inicial del portal
```

- **Regla / fuente:** Decisión del Jefe de Ingeniería del 2026-10-11 (respuesta a US-027-Q1)

## 6. Casos negativos y límite

| Caso | Comportamiento esperado | Fuente o pregunta |
|---|---|---|
| Credenciales inválidas o cuenta deshabilitada | No se ingresa. Lo valida Keycloak | BR-095 |
| Usuario sin colaborador registrado, sin rol Instructor, ADMIN ni Jefe de Ingeniería | Se le impide el ingreso, se le deriva a la página de login y se cierra su sesión en Keycloak y en el BFF (AC-4) | RQ-22 (resuelta) |
| Usuario sin colaborador registrado con rol Instructor, ADMIN o Jefe de Ingeniería | Ingresa con normalidad | RQ-22 (resuelta) |
| Keycloak no disponible | El usuario ve la página inicial del portal (AC-5) | US-027-Q1 (resuelta) |

## 7. Reglas de negocio aplicables

| ID | Regla | Fuente |
|---|---|---|
| BR-095 | Los usuarios ingresan al portal de forma segura, autenticándose en Keycloak, sin que se comprometan datos sensibles en el navegador. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L135 |
| BR-044 | Los usuarios y sus roles (ADMIN, Jefe de Ingeniería, Evaluador y colaborador) se gestionan en Keycloak, donde se mantiene el IdM. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L84 |

## 8. Datos y términos

| Término | Uso en esta historia | Glosario |
|---|---|---|
| Usuario | Actor | [Usuario](../../business/glossary/terms/TRM-0052-usuario.md) |
| Keycloak | Proveedor de identidad | [Keycloak](../../business/glossary/terms/TRM-0037-keycloak.md) |
| BFF y PKCE | Mecanismo del ingreso (restricción de arquitectura) | [BFF](../../business/glossary/terms/TRM-0054-bff.md), [PKCE](../../business/glossary/terms/TRM-0055-pkce.md) |

## 9. Requisitos no funcionales

- **Accesibilidad:** WCAG 2.2 AA (estándar del repositorio).
- **Privacidad y datos personales:** Toca la identidad del usuario. Restricción: BR-003 y la política pendiente G-12.
- **Otros:** Restricciones de arquitectura declaradas: SPA en Angular con BFF en Next.js, autenticación con Keycloak mediante PKCE sin datos sensibles en el navegador (D-115, anexo C del pack), micro UI y catálogo de componentes basado en Atomic Design (D-117).

## 10. Consideraciones de UX

- **Flujo esperado:** El usuario abre el portal y, si no tiene sesión, se autentica y vuelve a la función que quería usar.
- **Estados de la interfaz:** Sin sesión, autenticando, error de autenticación, éxito.
- **Contenido clave:** Mensaje claro de que debe autenticarse.

## 11. Dependencias, supuestos e hipótesis

- **Depende de:** Keycloak como proveedor de identidad (BR-044) y, para el AC-4, del registro de colaboradores (US-004).
- **Es prerrequisito de:** US-025, US-028 y las historias que dependen del rol del usuario
- **Supuestos:** Ninguno
- **Hipótesis del agente:** Ninguna

## 12. Preguntas abiertas

| ID | Pregunta | Responsable | Prioridad | Bloquea | Estado |
|---|---|---|---|---|---|
| US-027-Q1 | ¿Qué ve el usuario si Keycloak no está disponible? | Arquitectura | Baja | No | Resuelta 2026-10-11: ve la página inicial del portal |
| RQ-22 | ¿Qué pasa si el usuario no tiene colaborador registrado? | Jefe de Ingeniería | Media | No | Resuelta 2026-10-11: no ingresa (salvo Instructor, ADMIN y Jefe de Ingeniería), se deriva al login y se cierra su sesión |

## 13. Evidencia y trazabilidad

| ID | Hallazgo | Fuente | Clasificación | Confianza |
|---|---|---|---|---|
| EVD-2026-0137 | El ingreso al portal es seguro: Keycloak mediante BFF con PKCE, sin datos sensibles en el navegador | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L522 | decision | high |
| EVD-2026-0139 | La arquitectura incluye micro UI en Angular y un catálogo de componentes basado en Atomic Design | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L524 | decision | high |

Evidencia compartida: `source_type: human`, `observed_at: 2026-10-11T09:00:00-05:00`, `freshness: current`, `owner: Jefe de Ingeniería`.

- **Upstream:** [BRC-001](../../business/rules/BRC-001-reglas-de-negocio-portal-curricula.md), [IMD-001](../../business/information-model/IMD-001-portal-curricula.md), [GLS-001](../../business/glossary/GLS-001-glosario-de-negocio.md) y [RCP-001](../context-packs/RCP-001-portal-gestion-curricula-desarrollo.md).
- **Downstream (pendiente):** UXR → FLW → SCR → CMP → AC

## 14. Evaluación INVEST

| Criterio | ¿Cumple? | Justificación |
|---|---|---|
| Independiente | Parcial | El AC-4 necesita el registro de colaboradores (US-004). |
| Negociable | Sí | Alcance y reglas definidos. |
| Valiosa | Sí | Ingreso seguro con la identidad corporativa. |
| Estimable | Sí | Alcance definido. |
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
- **Motivo:** Actor, valor y criterios sostenidos por BR-044, BR-095 y las respuestas del Jefe de Ingeniería del 2026-10-11 (US-027-Q1 y RQ-22). Los criterios AC-4 y AC-5 se agregaron con esas respuestas y no tienen todavía una regla BR en BRC-001.
- **Bloqueos de entrega:** Ninguno
- **Propuesta de división (si no es pequeña):** No aplica
- **Siguiente rol o Skill:** `ux-requirements-analyzer`
- **Decisión humana requerida:** El Jefe de Ingeniería valida la historia.
- **Validación:** Pendiente de revalidar (se agregaron AC-4 y AC-5 después de la aprobación) · Responsable: Jefe de Ingeniería · Fecha: —
