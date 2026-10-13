---
type: User Story
title: "US-033 — Corregir el vínculo entre un usuario y su persona"
description: "Como Jefe de Ingeniería, quiero corregir el vínculo entre un usuario y su persona cuando es equivocado o cuando su correo cambia o se reutiliza, para que cada usuario acceda como la persona correcta."
tags: [user-story, usuario, vinculo, keycloak]
status: draft
generated:
  by: "af-user-story-refiner/2.0"
  at: "2026-10-12T11:00:00-05:00"
sources:
  - id: brc-001
    resource: /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md
  - id: rcp-001
    resource: /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md
  - id: gls-001
    resource: /business/glossary/GLS-001-glosario-de-negocio.md
  - id: imd-001
    resource: /business/information-model/IMD-001-portal-curricula.md
gitlab_issue_id: 52944
gitlab_issue_iid: 34
gitlab_issue_url: https://project.comsatel.com.pe/comsatel/development/training/dev-juniors/p3m/collaboration/-/issues/34
---

# US-033 — Corregir el vínculo entre un usuario y su persona

## 1. Ficha

| Campo | Valor |
|---|---|
| ID | US-033 |
| Épica / capacidad | Roles y competencias (IMD-001, bloque 1) |
| Horizonte / release | Por definir |
| Actor | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) |
| Responsable de negocio (PO) | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) (responsable funcional del portal, /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L109) |
| Prioridad | Should: es la salida cuando el vínculo por correo falla (BR-129). La decide el PO. |
| Dependencias | US-025, US-029 |
| Preparación | READY |

## 2. Historia

**Como** Jefe de Ingeniería, **quiero** corregir el vínculo entre un usuario y su persona, con registro de quién y cuándo, **para** que cada usuario acceda como la persona correcta aunque su correo cambie o se reutilice.

## 3. Contexto y valor

- **Problema que resuelve:** El vínculo entre un usuario y su persona se fija una sola vez, la primera vez que inicia sesión, por el correo (BR-125, BR-129). Un vínculo equivocado, o un correo que cambia o se reutiliza, solo lo corrige el Jefe de Ingeniería, y se registra quién y cuándo (BR-129).
- **Valor esperado:** Una vía controlada y auditable para corregir vínculos, sin permitir cambios por otros caminos.
- **Métrica o KPI que impacta:** Sin métrica asociada

## 4. Alcance

- **Incluye:**
  - Corregir un vínculo equivocado entre un usuario y su persona.
  - Corregir el vínculo cuando el correo cambia o se reutiliza.
  - Registrar quién y cuándo corrigió.
- **Excluye:**
  - Establecer el vínculo la primera vez (US-025).
  - Mantener los datos de contacto (US-029).
  - Crear cuentas: no hay registro libre (BR-128).

## 5. Criterios de aceptación

### AC-1 — Corregir un vínculo equivocado

```gherkin
Escenario: Corregir un vínculo equivocado
  Dado un usuario vinculado a una persona equivocada
  Cuando el Jefe de Ingeniería lo vincula a la persona correcta
  Entonces el usuario queda vinculado a la persona correcta
```

- **Regla / fuente:** BR-129

### AC-2 — Corregir por un correo que cambia o se reutiliza

```gherkin
Escenario: Corregir por un correo que cambia o se reutiliza
  Dado un usuario cuyo correo cambió o se reutilizó y cuyo vínculo ya no es correcto
  Cuando el Jefe de Ingeniería corrige el vínculo
  Entonces el usuario queda vinculado a la persona correcta
```

- **Regla / fuente:** BR-129

### AC-3 — Registrar quién y cuándo

```gherkin
Escenario: Registrar quién y cuándo
  Dado una corrección de vínculo
  Cuando se registra
  Entonces queda guardado quién la hizo y cuándo, con la persona anterior y la nueva
```

- **Regla / fuente:** BR-129

### AC-4 — Solo el Jefe de Ingeniería corrige

```gherkin
Escenario: Solo el Jefe de Ingeniería corrige
  Dado un usuario que no es el Jefe de Ingeniería
  Cuando intenta corregir un vínculo
  Entonces el portal no lo permite
```

- **Regla / fuente:** BR-129

### AC-5 — El vínculo no cambia por otra vía

```gherkin
Escenario: El vínculo no cambia por otra vía
  Dado un usuario ya vinculado
  Cuando cambia el correo con el que se autentica
  Entonces el vínculo no cambia solo
```

- **Regla / fuente:** BR-129

## 6. Casos negativos y límite

| Caso | Comportamiento esperado | Fuente o pregunta |
|---|---|---|
| Un ADMIN corrige el vínculo | Puede: el ADMIN suple al Jefe de Ingeniería | BR-134 |
| Vincular a una persona que ya está vinculada a otro usuario | Sin regla | US-033-Q2 |
| Corregir el vínculo de un usuario sin persona (ADMIN o Instructor sin colaborador) | Sin regla | US-033-Q3 |
| Quitar el vínculo sin vincular a otra persona | Sin regla | US-033-Q3 |
| Crear una cuenta nueva desde el portal | No existe: no hay registro libre ni auto-registro | BR-128 |

## 7. Reglas de negocio aplicables

| ID | Regla | Fuente |
|---|---|---|
| BR-129 | El vínculo entre un usuario y su persona se fija una sola vez. Un vínculo equivocado, o un correo que cambia o se reutiliza, lo corrige el Jefe de Ingeniería, y se registra quién y cuándo. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L169 |
| BR-125 | La primera vez que un usuario inicia sesión, el portal lo vincula con su persona por el correo que entrega Keycloak. El correo vigente es único entre las personas. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L165 |
| BR-128 | El portal no ofrece registro libre ni auto-registro de cuentas, ni en su login ni en el flujo de Keycloak. Las identidades vienen de Keycloak, conectado con Active Directory, que gestiona el equipo de infraestructura, y el correo es de solo lectura. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L168 |
| BR-074 | Cuando un usuario (colaborador, Instructor, Jefe de Ingeniería o ADMIN) inicia sesión, el portal obtiene la información del usuario autenticado y lo registra como usuario con su GUID de Keycloak, username, correo electrónico y los roles de usuario que tiene asignados en Keycloak. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L114 |
| BR-077 | Un colaborador se vincula siempre a un usuario proveniente de Keycloak. El usuario es la identidad que le permite al colaborador ingresar al portal. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L117 |
| BR-107 | Un usuario sin colaborador registrado y sin los roles de usuario Jefe de Ingeniería, ADMIN o Instructor que inicia sesión es enviado al login. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L147 |

## 8. Datos y términos

| Término | Uso en esta historia | Glosario |
|---|---|---|
| Usuario | Cuenta cuyo vínculo se corrige | [Usuario](../../business/glossary/terms/TRM-0052-usuario.md) |
| Persona | Persona a la que se vincula | [Persona](../../business/glossary/terms/TRM-0060-persona.md) |
| Keycloak | Origen de la identidad | [Keycloak](../../business/glossary/terms/TRM-0037-keycloak.md) |
| Jefe de Ingeniería | Actor | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) |

## 9. Requisitos no funcionales

- **Accesibilidad:** WCAG 2.2 AA (estándar del repositorio).
- **Privacidad y datos personales:** Toca la identidad del usuario y de la persona y el correo, que se retienen por siempre (BR-101). Política aplazada como deuda técnica DT-01 (RQ-34). La corrección deja un registro de quién y cuándo.
- **Otros:** Sin requisito identificado

## 10. Consideraciones de UX

- **Flujo esperado:** El actor busca el usuario, elige la persona correcta y confirma la corrección.
- **Estados de la interfaz:** Sin resultados, sin permisos, persona ya vinculada, éxito.
- **Contenido clave:** Usuario, persona anterior, persona nueva, quién y cuándo.

## 11. Dependencias, supuestos e hipótesis

- **Depende de:** US-025 (el vínculo inicial) y US-029 (el correo vigente).
- **Es prerrequisito de:** Ninguno.
- **Supuestos:** Ninguno
- **Hipótesis del agente:** Ninguna

## 12. Preguntas abiertas

| ID | Pregunta | Responsable | Prioridad | Bloquea | Estado |
|---|---|---|---|---|---|
| US-033-Q1 | Cerrada el 2026-10-12: el ADMIN puede corregir el vínculo, porque suple las capacidades exclusivas del Jefe de Ingeniería (BR-134). | Jefe de Ingeniería | Media | No | Cerrada |
| US-033-Q2 | ¿Qué ocurre si la persona nueva ya está vinculada a otro usuario? (ver US-025-Q2) | Jefe de Ingeniería | Media | No | Abierta |
| US-033-Q3 | ¿Se puede vincular a un usuario que no tenía persona, o quitar el vínculo? | Jefe de Ingeniería | Baja | No | Abierta |

## 13. Evidencia y trazabilidad

| ID | Hallazgo | Fuente | Clasificación | Confianza |
|---|---|---|---|---|
| EVD-2026-0168 | El vínculo entre el usuario y su persona se fija una sola vez | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L565 | decision | high |
| EVD-2026-0164 | El usuario de Keycloak se vincula con su persona por el correo que Keycloak entrega, la primera vez que inicia sesión; el correo vigente es único entre las personas | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L561 | decision | high |
| EVD-2026-0167 | Los usuarios no pueden crear cuentas ni hay registro libre ni auto-registro, ni en el login del portal ni en el flujo de login de Keycloak | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L564 | decision | high |
| EVD-2026-0103 | Al iniciar sesión, el portal registra al usuario autenticado con GUID de Keycloak, username, correo y los roles de usuario asignados en Keycloak (colaborador, Jefe de Ingeniería o ADMIN) | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L484 | decision | high |

Evidencia compartida: `source_type: human`, `observed_at: 2026-10-11T00:00:00Z`, `freshness: current`, `owner: Jefe de Ingeniería`. La indicación del responsable del 2026-10-12 sobre las funcionalidades de mantenimiento de la parte se recoge en la sección 12.

- **Upstream:** [BRC-001](../../business/rules/BRC-001-reglas-de-negocio-portal-curricula.md), [IMD-001](../../business/information-model/IMD-001-portal-curricula.md), [GLS-001](../../business/glossary/GLS-001-glosario-de-negocio.md) y [RCP-001](../context-packs/RCP-001-portal-gestion-curricula-desarrollo.md).
- **Downstream (pendiente):** UXR → FLW → SCR → CMP → AC

## 14. Evaluación INVEST

| Criterio | ¿Cumple? | Justificación |
|---|---|---|
| Independiente | Parcial | Necesita US-025 y US-029. |
| Negociable | Parcial | Las reglas de borde están abiertas (US-033-Q1 a Q3). |
| Valiosa | Sí | Una vía controlada y auditable para corregir vínculos. |
| Estimable | Sí | Alcance acotado. |
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
- **Motivo:** Actor, valor y criterios están sostenidos por BR-129. Las preguntas abiertas no bloquean los criterios.
- **Bloqueos de entrega:** Ninguno. Falta que existan US-025 y US-029.
- **Propuesta de división (si no es pequeña):** No aplica
- **Siguiente rol o Skill:** `ux-requirements-analyzer`
- **Decisión humana requerida:** El Jefe de Ingeniería valida la historia y responde US-033-Q1 a Q3.
- **Origen:** historia nueva del 2026-10-12, pedida por el responsable funcional (OI-11 del handoff de base de datos): «debemos incorporar funcionalidades para mantener los contactos de las Party, plazas, ocupaciones, roles de la parte, corrección de vínculo y relaciones».
- **Validación:** Pendiente · Responsable: Jefe de Ingeniería · Fecha: —
