---
type: User Story
title: "US-025 — Registrar al usuario autenticado al iniciar sesión"
description: "Como Usuario, quiero que al iniciar sesión el portal registre mis datos básicos de Keycloak y mis roles de usuario, para que el portal me reconozca y me dé acceso según mi rol."
tags: [user-story, keycloak, usuario]
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
gitlab_issue_id: 52936
gitlab_issue_iid: 26
gitlab_issue_url: https://project.comsatel.com.pe/comsatel/development/training/dev-juniors/p3m/collaboration/-/issues/26
---

# US-025 — Registrar al usuario autenticado al iniciar sesión

## 1. Ficha

| Campo | Valor |
|---|---|
| ID | US-025 |
| Épica / capacidad | Roles y competencias (IMD-001, bloque 1) |
| Horizonte / release | Por definir |
| Actor | [Usuario](../../business/glossary/terms/TRM-0052-usuario.md) (colaborador, Instructor, Jefe de Ingeniería o ADMIN) |
| Responsable de negocio (PO) | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) (responsable funcional del portal, /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L109) |
| Prioridad | Must: sin usuario registrado no hay acceso por rol. La decide el PO. |
| Dependencias | — |
| Preparación | READY |

## 2. Historia

**Como** Usuario (colaborador, Instructor, Jefe de Ingeniería o ADMIN), **quiero** que al iniciar sesión el portal registre mis datos básicos (GUID de Keycloak, username y correo) y mis roles de usuario asignados en Keycloak, **para** que el portal me reconozca y me dé acceso según mi rol.

## 3. Contexto y valor

- **Problema que resuelve:** Los usuarios y sus roles se gestionan en Keycloak (BR-044). El portal necesita conocer a quien se autentica sin pedir un registro aparte (BR-074).
- **Valor esperado:** Usuarios reconocidos con sus roles desde el primer inicio de sesión.
- **Métrica o KPI que impacta:** Sin métrica asociada

## 4. Alcance

- **Incluye:**
  - Obtener la información del usuario autenticado al iniciar sesión.
  - Registrarlo como usuario con GUID de Keycloak, username, correo y roles de usuario.
  - Vincularlo con su persona por el correo, la primera vez que inicia sesión.
- **Excluye:**
  - Gestionar usuarios y roles (se hace en Keycloak, BR-044).
  - Registrar los datos del colaborador (nombres, contactos, rol/nivel).
  - Corregir un vínculo equivocado, o un correo que cambia o se reutiliza (lo hace el Jefe de Ingeniería, BR-129): historia por redactar.

## 5. Criterios de aceptación

### AC-1 — Registrar al usuario al iniciar sesión

```gherkin
Escenario: Registrar al usuario al iniciar sesión
  Dado un usuario autenticado en Keycloak que aún no está registrado en el portal
  Cuando inicia sesión en el portal
  Entonces el portal lo registra con su GUID de Keycloak, username, correo electrónico y los roles de usuario asignados en Keycloak
```

- **Regla / fuente:** BR-074

### AC-2 — Roles de usuario

```gherkin
Escenario: Roles de usuario registrados
  Dado un usuario con roles asignados en Keycloak
  Cuando el portal lo registra
  Entonces sus roles de usuario son los asignados en Keycloak: colaborador, Instructor, Jefe de Ingeniería o ADMIN
```

- **Regla / fuente:** BR-044, BR-075

### AC-3 — Vincular al usuario con su persona

```gherkin
Escenario: Vincular al usuario con su persona por el correo
  Dado un usuario autenticado que inicia sesión por primera vez y cuyo correo coincide con el correo vigente de una persona
  Cuando el portal lo registra
  Entonces queda vinculado a esa persona
```

- **Regla / fuente:** BR-125

### AC-4 — Sin persona ni rol, el usuario vuelve al login

```gherkin
Escenario: Usuario sin persona y sin rol de acceso
  Dado un usuario autenticado cuyo correo no coincide con ninguna persona y que no tiene el rol Jefe de Ingeniería, ADMIN ni Instructor
  Cuando inicia sesión en el portal
  Entonces el portal no lo deja ingresar y lo envía al login
```

- **Regla / fuente:** BR-107

### AC-5 — El vínculo se fija una sola vez

```gherkin
Escenario: El vínculo no cambia aunque cambie el correo
  Dado un usuario ya vinculado con una persona
  Cuando cambia el correo con el que se autentica
  Entonces sigue vinculado a la misma persona y solo el Jefe de Ingeniería puede corregir el vínculo
```

- **Regla / fuente:** BR-129

## 6. Casos negativos y límite

| Caso | Comportamiento esperado | Fuente o pregunta |
|---|---|---|
| Usuario que ya está registrado | Si se actualizan sus datos y roles en cada inicio: sin regla | RQ-22 |
| Usuario que no tiene colaborador registrado (un colaborador siempre tiene usuario) | No ingresa, salvo Instructor, ADMIN y Jefe de Ingeniería; vuelve al login (ver AC-4 y US-027, AC-4) | BR-107 |
| Correo que coincide con una persona ya vinculada a otro usuario | Sin regla | US-025-Q2 |
| Alta de cuentas por registro libre o auto-registro | No existe: las identidades vienen de Keycloak, conectado con Active Directory, y el correo es de solo lectura | BR-128 |
| Rol de Instructor (Evaluador) asignado en Keycloak | Se registra como rol de usuario | BR-075 |
| Keycloak no entrega la información | Sin regla | US-025-Q1 |

## 7. Reglas de negocio aplicables

| ID | Regla | Fuente |
|---|---|---|
| BR-044 | Los usuarios y sus roles (ADMIN, Jefe de Ingeniería, Evaluador y colaborador) se gestionan en Keycloak, donde se mantiene el IdM. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L84 |
| BR-074 | Cuando un usuario (colaborador, Instructor, Jefe de Ingeniería o ADMIN) inicia sesión, el portal obtiene la información del usuario autenticado y lo registra como usuario con su GUID de Keycloak, username, correo electrónico y los roles de usuario que tiene asignados en Keycloak. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L114 |
| BR-075 | Los roles de usuario que se registran al iniciar sesión son colaborador, Instructor, Jefe de Ingeniería y ADMIN. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L115 |
| BR-107 | Un usuario sin colaborador registrado y sin los roles de usuario Jefe de Ingeniería, ADMIN o Instructor que inicia sesión es enviado al login. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L147 |
| BR-125 | La primera vez que un usuario inicia sesión, el portal lo vincula con su persona por el correo que entrega Keycloak. El correo vigente es único entre las personas. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L165 |
| BR-128 | El portal no ofrece registro libre ni auto-registro de cuentas, ni en su login ni en el flujo de Keycloak. Las identidades vienen de Keycloak, conectado con Active Directory, que gestiona el equipo de infraestructura, y el correo es de solo lectura. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L168 |
| BR-129 | El vínculo entre un usuario y su persona se fija una sola vez. Un vínculo equivocado, o un correo que cambia o se reutiliza, lo corrige el Jefe de Ingeniería, y se registra quién y cuándo. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L169 |

## 8. Datos y términos

| Término | Uso en esta historia | Glosario |
|---|---|---|
| Usuario | Actor y registro que se crea | [Usuario](../../business/glossary/terms/TRM-0052-usuario.md) |
| Keycloak | Origen de los datos del usuario | [Keycloak](../../business/glossary/terms/TRM-0037-keycloak.md) |
| Colaborador | Rol de usuario (siempre vinculado a un usuario, BR-077) | [Colaborador](../../business/glossary/terms/TRM-0002-colaborador.md) |
| Evaluador | Rol de usuario (Instructor) | [Evaluador](../../business/glossary/terms/TRM-0016-evaluador.md) |
| ADMIN | Rol de usuario | [ADMIN](../../business/glossary/terms/TRM-0028-admin.md) |
| Jefe de Ingeniería | Rol de usuario | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) |

## 9. Requisitos no funcionales

- **Accesibilidad:** WCAG 2.2 AA (estándar del repositorio).
- **Privacidad y datos personales:** Toca username y correo electrónico, que se retienen por siempre (BR-101). Restricción: BR-003 y la política pendiente G-12, aplazada como deuda técnica DT-01 (RQ-34).
- **Otros:** Sin requisito identificado

## 10. Consideraciones de UX

- **Flujo esperado:** El usuario inicia sesión y el registro ocurre sin que tenga que hacer nada más.
- **Estados de la interfaz:** Primer inicio de sesión, error de autenticación, éxito.
- **Contenido clave:** Username, correo y roles del usuario autenticado.

## 11. Dependencias, supuestos e hipótesis

- **Depende de:** Keycloak como proveedor de identidad (BR-044), conectado con Active Directory y sin registro libre (BR-128), y US-027 (ingreso al portal). Y de que la persona esté registrada con su correo (historia por redactar).
- **Es prerrequisito de:** Las historias que dependen del rol del usuario (US-001 en adelante).
- **Supuestos:** Ninguno
- **Hipótesis del agente:** Ninguna

## 12. Preguntas abiertas

| ID | Pregunta | Responsable | Prioridad | Bloquea | Estado |
|---|---|---|---|---|---|
| RQ-22 | ¿Se actualizan los datos y roles del usuario en cada inicio de sesión? (La parte «sin colaborador registrado» quedó cerrada, BR-107, EVD-2026-0147.) | Jefe de Ingeniería | Media | No | Abierta |
| RQ-23 | ¿El Instructor (Evaluador) es un rol de usuario asignado en Keycloak? | Jefe de Ingeniería | Alta | No | Cerrada: sí, los roles de usuario son colaborador, Instructor, Jefe de Ingeniería y ADMIN (EVD-2026-0109, BR-075) |
| US-025-Q1 | ¿Qué hace el portal si Keycloak no entrega algún dato del usuario (correo, roles)? | Arquitectura | Baja | No | Abierta |
| US-025-Q2 | ¿Qué ocurre si el correo del usuario coincide con una persona que ya está vinculada a otro usuario? | Jefe de Ingeniería | Media | No | Abierta |

## 13. Evidencia y trazabilidad

| ID | Hallazgo | Fuente | Clasificación | Confianza |
|---|---|---|---|---|
| EVD-2026-0103 | Al iniciar sesión, el portal registra al usuario autenticado con GUID de Keycloak, username, correo y los roles de usuario asignados en Keycloak | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L484 | decision | medium |
| EVD-2026-0109 | El Instructor también es un rol de usuario: colaborador, Instructor, Jefe de Ingeniería y ADMIN | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L490 | decision | high |
| EVD-2026-0147 | Un usuario sin colaborador y sin rol Jefe de Ingeniería, ADMIN o Instructor vuelve al login | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L544 | decision | high |
| EVD-2026-0164 | El usuario de Keycloak se vincula con su persona por el correo que Keycloak entrega, la primera vez que inicia sesión; el correo vigente es único entre las personas | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L561 | decision | high |
| EVD-2026-0167 | Los usuarios no pueden crear cuentas ni hay registro libre ni auto-registro, ni en el login del portal ni en el flujo de login de Keycloak | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L564 | decision | high |
| EVD-2026-0168 | El vínculo entre el usuario y su persona se fija una sola vez | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L565 | decision | high |

Evidencia compartida: `source_type: human`, `observed_at: 2026-10-10T21:00:00-05:00`, `freshness: current`, `owner: Jefe de Ingeniería`. Las evidencias EVD-2026-0143 a EVD-2026-0169 se observaron el 2026-10-11T00:00:00Z.

- **Upstream:** [BRC-001](../../business/rules/BRC-001-reglas-de-negocio-portal-curricula.md), [IMD-001](../../business/information-model/IMD-001-portal-curricula.md), [GLS-001](../../business/glossary/GLS-001-glosario-de-negocio.md) y [RCP-001](../context-packs/RCP-001-portal-gestion-curricula-desarrollo.md), todos en estado `draft`.
- **Downstream (pendiente):** UXR → FLW → SCR → CMP → AC

## 14. Evaluación INVEST

| Criterio | ¿Cumple? | Justificación |
|---|---|---|
| Independiente | Sí | No depende de otra historia. |
| Negociable | Parcial | La actualización en cada inicio (RQ-22) y el caso de un correo ya vinculado (US-025-Q2) siguen abiertos. |
| Valiosa | Sí | Usuarios reconocidos con sus roles. |
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
- [x] El PO validó la historia

## 16. Definition of Done (funcional)

- [ ] Todos los criterios de aceptación pasan sus pruebas de aceptación
- [ ] Los casos negativos y límite están cubiertos por pruebas
- [ ] La accesibilidad WCAG 2.2 AA está revisada
- [ ] Los requisitos de privacidad se cumplen
- [ ] El PO aceptó la historia en la revisión

## 17. Preparación y validación

- **Estado:** READY
- **Motivo:** Actor, valor y criterio central sostenidos por BR-044, BR-074 y BR-125. RQ-23 quedó cerrada. RQ-22, US-025-Q1 y US-025-Q2 no bloquean el comportamiento central.
- **Bloqueos de entrega:** Ninguno
- **Propuesta de división (si no es pequeña):** Valorar separar el vínculo con la persona (AC-3 a AC-5) del registro del usuario (AC-1, AC-2), porque tiene otras reglas y otro dueño de datos (el registro de personas). Falta además la historia que corrige el vínculo (BR-129).
- **Siguiente rol o Skill:** `ux-requirements-analyzer`
- **Decisión humana requerida:** El Jefe de Ingeniería (validó la historia el 2026-10-12) responde US-025-Q2.
- **Actualización 2026-10-12:** se añade el vínculo del usuario con su persona por el correo (BR-125), el caso sin persona ni rol (BR-107), el vínculo fijo (BR-129) y la ausencia de registro libre (BR-128); se abre US-025-Q2. Verificada de nuevo por ianache el 2026-10-12.
- **Validación:** Aprobada · Responsable: Jefe de Ingeniería (ianache) · Fecha: 2026-10-12
