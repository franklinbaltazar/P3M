---
type: User Story
title: "US-029 — Mantener los datos de contacto de las partes"
description: "Como Jefe de Ingeniería o usuario con perfil ADMIN, quiero mantener los datos de contacto de las partes, para que cada persona tenga su correo y su teléfono vigentes y se pueda vincular con su usuario."
tags: [user-story, partes, contactos]
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
gitlab_issue_id: 52940
gitlab_issue_iid: 30
gitlab_issue_url: https://project.comsatel.com.pe/comsatel/development/training/dev-juniors/p3m/collaboration/-/issues/30
---

# US-029 — Mantener los datos de contacto de las partes

## 1. Ficha

| Campo | Valor |
|---|---|
| ID | US-029 |
| Épica / capacidad | Roles y competencias (IMD-001, bloque 1) |
| Horizonte / release | Por definir |
| Actor | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) o [ADMIN](../../business/glossary/terms/TRM-0028-admin.md) |
| Responsable de negocio (PO) | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) (responsable funcional del portal, /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L109) |
| Prioridad | Must: sin el correo vigente de la persona no se puede vincular al usuario que inicia sesión (BR-125). La decide el PO. |
| Dependencias | US-004 |
| Preparación | READY |

## 2. Historia

**Como** Jefe de Ingeniería o usuario con perfil ADMIN, **quiero** registrar, modificar y dar de baja los datos de contacto de una parte (persona u organización), **para** que cada persona tenga su correo y su teléfono vigentes y se pueda vincular con su usuario.

## 3. Contexto y valor

- **Problema que resuelve:** De una persona se registran correo, teléfono y dirección, con correo y teléfono obligatorios y más de un dato permitido (BR-070). Un contacto no se borra: se da de baja con fecha y responsable (BR-130). El correo vigente es único entre las personas porque con él se vincula al usuario (BR-125).
- **Valor esperado:** Contactos vigentes y con historial, sin dejar a una persona sin correo ni teléfono, y direcciones reutilizables.
- **Métrica o KPI que impacta:** Sin métrica asociada

## 4. Alcance

- **Incluye:**
  - Registrar los datos de contacto de una persona: correo, teléfono y dirección.
  - Dar de baja un contacto con fecha y responsable.
  - Impedir dos correos vigentes iguales entre partes, personas u organizaciones.
  - Registrar los datos de contacto de una organización.
- **Excluye:**
  - Registrar la persona y sus nombres (US-004).
  - Vincular al usuario con la persona al iniciar sesión (US-025) y corregir ese vínculo (US-033).

## 5. Criterios de aceptación

### AC-1 — Registrar los datos de contacto de una persona

```gherkin
Escenario: Registrar los datos de contacto de una persona
  Dado una persona registrada
  Cuando se registra su correo, su teléfono y, si lo tiene, su dirección
  Entonces la persona queda con esos datos de contacto
```

- **Regla / fuente:** BR-070

### AC-2 — Correo y teléfono obligatorios

```gherkin
Escenario: Correo y teléfono obligatorios
  Dado una persona
  Cuando se intenta dejarla sin correo vigente o sin teléfono vigente
  Entonces el portal no lo permite
```

- **Regla / fuente:** BR-070, BR-130

### AC-3 — Más de un dato de contacto

```gherkin
Escenario: Más de un dato de contacto
  Dado una persona con un correo vigente
  Cuando se registra un segundo correo
  Entonces la persona conserva ambos
```

- **Regla / fuente:** BR-070

### AC-4 — Dar de baja un contacto sin borrarlo

```gherkin
Escenario: Dar de baja un contacto sin borrarlo
  Dado un contacto vigente de una persona
  Cuando se da de baja, indicando quién y cuándo
  Entonces el contacto deja de estar vigente y se conserva en el historial
```

- **Regla / fuente:** BR-130, BR-101

### AC-5 — El correo vigente es único

```gherkin
Escenario: El correo vigente es único
  Dado un correo vigente de una parte, persona u organización
  Cuando se intenta registrar el mismo correo vigente en otra parte
  Entonces el portal no lo permite
```

- **Regla / fuente:** BR-125, BR-133

### AC-6 — La baja libera la dirección

```gherkin
Escenario: La baja libera la dirección
  Dado un correo dado de baja de una persona
  Cuando se registra esa misma dirección para otra persona
  Entonces el registro se permite y el contacto anterior se conserva
```

- **Regla / fuente:** BR-130, BR-125

### AC-7 — Datos de contacto de una organización

```gherkin
Escenario: Registrar los datos de contacto de una organización
  Dado una organización registrada
  Cuando se registran su correo, su teléfono y, si lo tiene, su dirección
  Entonces la organización queda con esos datos de contacto

Escenario: Una organización sin correo o sin teléfono
  Dado una organización registrada
  Cuando se intenta dejarla sin correo vigente o sin teléfono vigente
  Entonces el portal no lo permite
```

- **Regla / fuente:** BR-131, BR-132

## 6. Casos negativos y límite

| Caso | Comportamiento esperado | Fuente o pregunta |
|---|---|---|
| Usuario sin permiso para mantener contactos | No puede: lo mantienen el Jefe de Ingeniería y el ADMIN | BR-135 |
| Datos de contacto de una **organización** | Correo, teléfono y dirección; correo y teléfono obligatorios | BR-132 |
| Dar de baja el último correo o el último teléfono vigente de una organización | No es válido, igual que para una persona | BR-132 |
| Formato válido de correo, de teléfono y de dirección | Sin regla | US-029-Q3 |
| Dar de baja el último correo o el último teléfono vigente de una persona | No es válido: cada persona mantiene al menos uno de cada uno | BR-130 |

## 7. Reglas de negocio aplicables

| ID | Regla | Fuente |
|---|---|---|
| BR-070 | De un colaborador se registran datos de contacto de tipo correo, teléfono y dirección. El teléfono y el correo electrónico son obligatorios. Un colaborador puede tener más de un dato de contacto. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L110 |
| BR-125 | La primera vez que un usuario inicia sesión, el portal lo vincula con su persona por el correo que entrega Keycloak. El correo vigente es único entre todas las partes (BR-133). | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L165 |
| BR-130 | Un dato de contacto no se borra: se da de baja con fecha y responsable. La baja libera la dirección, por ejemplo cuando un correo se reutiliza. Cada persona mantiene al menos un correo y un teléfono vigentes. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L170 |
| BR-131 | Toda parte, sea persona u organización, tiene datos de contacto. Reemplaza BR-121. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L171 |
| BR-132 | Los datos de contacto de una organización son correo, teléfono y dirección. Correo y teléfono son obligatorios. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L172 |
| BR-133 | El correo vigente es único entre todas las partes, sean personas u organizaciones. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L173 |
| BR-101 | Los datos personales se retienen igual que los logs: por siempre. El tratamiento de clasificación, cifrado y acceso sigue pendiente (RQ-34). | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L141 |
| BR-002 | Solo el Jefe de Ingeniería o un usuario con perfil ADMIN registra y modifica colaboradores. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L42 |
| BR-135 | El Jefe de Ingeniería y el ADMIN mantienen los datos de contacto, las plazas, las ocupaciones de plaza, los roles de la parte, las relaciones entre partes y las organizaciones. | /business/rules\BRC-001-reglas-de-negocio-portal-curricula.md:L175 |

## 8. Datos y términos

| Término | Uso en esta historia | Glosario |
|---|---|---|
| Dato de contacto | Elemento que se mantiene | [Dato de contacto](../../business/glossary/terms/TRM-0051-dato-de-contacto.md) |
| Persona | Dueña del contacto | [Persona](../../business/glossary/terms/TRM-0060-persona.md) |
| Organización | Parte con datos de contacto (BR-131) | [Organización](../../business/glossary/terms/TRM-0050-organizacion.md) |
| Jefe de Ingeniería | Actor | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) |
| ADMIN | Actor | [ADMIN](../../business/glossary/terms/TRM-0028-admin.md) |

## 9. Requisitos no funcionales

- **Accesibilidad:** WCAG 2.2 AA (estándar del repositorio).
- **Privacidad y datos personales:** Toca correo, teléfono y dirección, que se retienen por siempre (BR-101). La política de datos personales está aplazada como deuda técnica DT-01 (RQ-34).
- **Otros:** Sin requisito identificado

## 10. Consideraciones de UX

- **Flujo esperado:** El actor abre una persona, agrega o da de baja sus contactos y ve los vigentes.
- **Estados de la interfaz:** Sin contactos, sin permisos, error de validación, correo repetido, éxito.
- **Contenido clave:** Contactos vigentes y dados de baja, con fecha y responsable.

## 11. Dependencias, supuestos e hipótesis

- **Depende de:** US-004 (la persona registrada).
- **Es prerrequisito de:** US-025 y US-033, que usan el correo vigente.
- **Supuestos:** Ninguno
- **Hipótesis del agente:** Ninguna. El actor lo sostiene BR-135.

## 12. Preguntas abiertas

| ID | Pregunta | Responsable | Prioridad | Bloquea | Estado |
|---|---|---|---|---|---|
| US-029-Q1 | Cerrada el 2026-10-12: tipos de contacto de una organización (correo, teléfono, dirección), obligatorios correo y teléfono, y correo único entre partes (RQ-36, BR-132, BR-133). | Jefe de Ingeniería | Media | No | Cerrada |
| US-029-Q2 | Cerrada el 2026-10-12: lo mantienen el Jefe de Ingeniería y el ADMIN (BR-135). | Jefe de Ingeniería | Media | No | Cerrada |
| US-029-Q3 | ¿Qué formato es válido para el correo, el teléfono y la dirección? | Jefe de Ingeniería | Baja | No | Abierta |

## 13. Evidencia y trazabilidad

| ID | Hallazgo | Fuente | Clasificación | Confianza |
|---|---|---|---|---|
| EVD-2026-0099 | De un colaborador se registran datos de contacto de tipo correo, teléfono y dirección | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L481 | decision | high |
| EVD-2026-0104 | Los datos de contacto obligatorios son teléfono y correo electrónico | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L485 | decision | high |
| EVD-2026-0110 | Un colaborador puede tener más de un dato de contacto | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L491 | decision | high |
| EVD-2026-0164 | El usuario de Keycloak se vincula con su persona por el correo que Keycloak entrega, la primera vez que inicia sesión; el correo vigente es único entre las personas | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L561 | decision | high |
| EVD-2026-0169 | Un dato de contacto no se borra: se da de baja con fecha y responsable | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L566 | decision | high |
| EVD-2026-0170 | Toda parte (persona u organización) tiene datos de contacto | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L567 | decision | high |
| EVD-2026-0171 | Los datos de contacto de una organización son correo, teléfono y dirección; correo y teléfono son obligatorios | /requirements/context-packs\RCP-001-portal-gestion-curricula-desarrollo.md:L568 | decision | high |
| EVD-2026-0172 | El correo vigente es único entre todas las partes | /requirements/context-packs\RCP-001-portal-gestion-curricula-desarrollo.md:L569 | decision | high |
| EVD-2026-0174 | El Jefe de Ingeniería y el ADMIN mantienen contactos, plazas, ocupaciones, roles de la parte, relaciones y organizaciones | /requirements/context-packs\RCP-001-portal-gestion-curricula-desarrollo.md:L573 | decision | high |

Evidencia compartida: `source_type: human`, `observed_at: 2026-10-11T00:00:00Z` (EVD-2026-0170: 2026-10-12), `freshness: current`, `owner: Jefe de Ingeniería`. La indicación del responsable del 2026-10-12 sobre las funcionalidades de mantenimiento de la parte se recoge en la sección 12.

- **Upstream:** [BRC-001](../../business/rules/BRC-001-reglas-de-negocio-portal-curricula.md), [IMD-001](../../business/information-model/IMD-001-portal-curricula.md), [GLS-001](../../business/glossary/GLS-001-glosario-de-negocio.md) y [RCP-001](../context-packs/RCP-001-portal-gestion-curricula-desarrollo.md).
- **Downstream (pendiente):** UXR → FLW → SCR → CMP → AC

## 14. Evaluación INVEST

| Criterio | ¿Cumple? | Justificación |
|---|---|---|
| Independiente | Parcial | Necesita la persona registrada (US-004). |
| Negociable | Parcial | El formato válido de los datos está abierto (US-029-Q3). |
| Valiosa | Sí | Sin esta funcionalidad el dato no se puede mantener desde el portal. |
| Estimable | Sí | Alcance acotado. |
| Pequeña (Small) | Sí | Cabe en una iteración. |
| Testeable | Sí | Los 7 criterios son verificables. |

## 15. Definition of Ready

- [x] El actor y el valor están sostenidos por una fuente
- [x] Los criterios de aceptación son verificables y citan su regla o fuente
- [x] Los casos negativos y límite tienen comportamiento o pregunta asignada
- [x] No hay preguntas abiertas que bloqueen (US-029-Q2 y Q3 no bloquean los criterios)
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
- **Motivo:** Los criterios están sostenidos por BR-070, BR-125, BR-130 a BR-133. El actor está sostenido por BR-135. El formato de los datos no está definido (US-029-Q3).
- **Bloqueos de entrega:** Ninguno.
- **Propuesta de división (si no es pequeña):** No aplica. 
- **Siguiente rol o Skill:** `ux-requirements-analyzer`
- **Decisión humana requerida:** El Jefe de Ingeniería responde las preguntas abiertas, y valida la historia.
- **Origen:** historia nueva del 2026-10-12, pedida por el responsable funcional (OI-11 del handoff de base de datos): «debemos incorporar funcionalidades para mantener los contactos de las Party, plazas, ocupaciones, roles de la parte, corrección de vínculo y relaciones».
- **Validación:** Pendiente · Responsable: Jefe de Ingeniería · Fecha: —
