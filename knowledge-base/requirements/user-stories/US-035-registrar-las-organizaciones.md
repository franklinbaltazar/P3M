---
type: User Story
title: "US-035 — Registrar las organizaciones"
description: "Como Jefe de Ingeniería o usuario con perfil ADMIN, quiero registrar las organizaciones (COMSATEL, el Área de Desarrollo, proveedores) con sus datos de contacto, para que tengan plazas y colaboradores vinculados."
tags: [user-story, partes, organizaciones]
status: draft
generated:
  by: "af-user-story-refiner/2.0"
  at: "2026-10-12T16:00:00-05:00"
sources:
  - id: brc-001
    resource: /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md
  - id: rcp-001
    resource: /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md
  - id: gls-001
    resource: /business/glossary/GLS-001-glosario-de-negocio.md
  - id: imd-001
    resource: /business/information-model/IMD-001-portal-curricula.md
gitlab_issue_id: 52946
gitlab_issue_iid: 36
gitlab_issue_url: https://project.comsatel.com.pe/comsatel/development/training/dev-juniors/p3m/collaboration/-/issues/36
---

# US-035 — Registrar las organizaciones

## 1. Ficha

| Campo | Valor |
|---|---|
| ID | US-035 |
| Épica / capacidad | Roles y competencias (IMD-001, bloque 1) |
| Horizonte / release | Por definir |
| Actor | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) o [ADMIN](../../business/glossary/terms/TRM-0028-admin.md) |
| Responsable de negocio (PO) | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) (responsable funcional del portal, /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md) |
| Prioridad | Must: sin organizaciones no hay plazas ni vínculo del colaborador con su organización (BR-072, BR-097). La decide el PO. |
| Dependencias | US-029, US-034 |
| Preparación | READY |

## 2. Historia

**Como** Jefe de Ingeniería o usuario con perfil ADMIN, **quiero** registrar las organizaciones, como COMSATEL, el Área de Desarrollo y los proveedores, con sus datos de contacto, **para** que tengan plazas y los colaboradores se vinculen a ellas.

## 3. Contexto y valor

- **Problema que resuelve:** COMSATEL y el Área de Desarrollo se registran como organizaciones, y puede haber otras, como los proveedores que proporcionan colaboradores (BR-072). Ninguna historia las registraba (US-030-Q1).
- **Valor esperado:** Organizaciones registradas con su contacto, listas para recibir plazas (US-030) y relaciones entre partes (US-034).
- **Métrica o KPI que impacta:** Sin métrica asociada

## 4. Alcance

- **Incluye:**
  - Registrar una organización con su Tax ID, su razón social (Business Name) y su nombre comercial (Commercial Name).
  - Inactivar una organización (baja sin borrado).
  - Registrar sus datos de contacto al registrarla (correo y teléfono obligatorios).
  - Registrar COMSATEL y el Área de Desarrollo, y otras organizaciones como proveedores.
- **Excluye:**
  - Mantener los datos de contacto después del registro (US-029).
  - Relacionar el Área de Desarrollo con COMSATEL u otras relaciones entre partes (US-034).
  - Registrar las plazas de la organización (US-030).

## 5. Criterios de aceptación

### AC-1 — Registrar una organización

```gherkin
Escenario: Registrar una organización
  Dado una organización que no está registrada
  Cuando se registra con su Tax ID, su razón social, su nombre comercial y sus datos de contacto
  Entonces la organización queda registrada como parte
```

- **Regla / fuente:** BR-072, BR-131, BR-136

### AC-2 — Registrar COMSATEL, el Área de Desarrollo y otras organizaciones

```gherkin
Escenario: Registrar COMSATEL, el Área de Desarrollo y un proveedor
  Dado que ninguna está registrada
  Cuando se registran COMSATEL, el Área de Desarrollo y un proveedor como organizaciones
  Entonces las tres existen como organizaciones
```

- **Regla / fuente:** BR-072

### AC-3 — Correo y teléfono obligatorios

```gherkin
Escenario: Una organización sin correo o sin teléfono
  Dado una organización que se está registrando
  Cuando no se informa su correo o su teléfono
  Entonces el portal no la registra
```

- **Regla / fuente:** BR-132

### AC-4 — El correo es único

```gherkin
Escenario: Correo ya usado por otra parte
  Dado un correo vigente de una persona u otra organización
  Cuando se registra una organización con ese mismo correo
  Entonces el portal no lo permite
```

- **Regla / fuente:** BR-133

### AC-5 — Inactivar una organización

```gherkin
Escenario: Inactivar una organización
  Dado una organización registrada
  Cuando se inactiva
  Entonces la organización queda inactiva y no se borra
```

- **Regla / fuente:** BR-137

## 6. Casos negativos y límite

| Caso | Comportamiento esperado | Fuente o pregunta |
|---|---|---|
| Usuario sin permiso para registrar organizaciones | No puede: lo mantienen el Jefe de Ingeniería y el ADMIN | BR-135 |
| Otra organización con la misma razón social o el mismo Tax ID | Sin regla | US-035-Q2 |
| Tax ID, razón social o nombre comercial vacíos | Sin regla sobre cuáles son obligatorios | US-035-Q2 |
| Plazas y colaboradores de una organización inactiva | Sin regla | US-035-Q3 |
| Colaboradores de un proveedor: de qué organización ocupan plaza | Sin regla | RQ-30 (IM-Q29) |

## 7. Reglas de negocio aplicables

| ID | Regla | Fuente |
|---|---|---|
| BR-072 | COMSATEL y el Área de Desarrollo se registran como organizaciones, y el Área de Desarrollo es parte de COMSATEL. Pueden existir otras organizaciones, como los proveedores que proporcionan colaboradores. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L112 |
| BR-118 | Una organización es parte de, como máximo, una organización a la vez. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L158 |
| BR-131 | Toda parte, sea persona u organización, tiene datos de contacto. Reemplaza BR-121. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L171 |
| BR-132 | Los datos de contacto de una organización son correo, teléfono y dirección. Correo y teléfono son obligatorios. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L172 |
| BR-133 | El correo vigente es único entre todas las partes, sean personas u organizaciones. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L173 |
| BR-002 | Solo el Jefe de Ingeniería o un usuario con perfil ADMIN registra y modifica colaboradores. (Se cita por analogía para el actor.) | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L42 |
| BR-135 | El Jefe de Ingeniería y el ADMIN mantienen los datos de contacto, las plazas, las ocupaciones de plaza, los roles de la parte, las relaciones entre partes y las organizaciones. | /business/rules\BRC-001-reglas-de-negocio-portal-curricula.md:L175 |
| BR-136 | Una organización se registra con su Tax ID, su Business Name (razón social) y su Commercial Name (nombre comercial), además de sus datos de contacto. | /business/rules\BRC-001-reglas-de-negocio-portal-curricula.md:L176 |
| BR-137 | Una organización se puede dar de baja inactivándola; no se borra. | /business/rules\BRC-001-reglas-de-negocio-portal-curricula.md:L177 |

## 8. Datos y términos

| Término | Uso en esta historia | Glosario |
|---|---|---|
| Organización | Elemento que se registra y se inactiva | [Organización](../../business/glossary/terms/TRM-0050-organizacion.md) |
| Parte | La organización es una parte | [Parte](../../business/glossary/terms/TRM-0059-parte.md) |
| Dato de contacto | Correo, teléfono y dirección de la organización | [Dato de contacto](../../business/glossary/terms/TRM-0051-dato-de-contacto.md) |
| Jefe de Ingeniería | Actor | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) |

## 9. Requisitos no funcionales

- **Accesibilidad:** WCAG 2.2 AA (estándar del repositorio).
- **Privacidad y datos personales:** El correo o el teléfono de una organización pueden identificar a un individuo; la retención sigue BR-101 (por siempre).
- **Otros:** Sin requisito identificado

## 10. Consideraciones de UX

- **Flujo esperado:** El actor registra la organización, informa su correo y su teléfono (y, si quiere, su dirección) y la ve en la lista de organizaciones.
- **Estados de la interfaz:** Sin organizaciones, sin permisos, error de validación (falta correo o teléfono, correo repetido), éxito.
- **Contenido clave:** Tax ID, razón social, nombre comercial, correo, teléfono, dirección, estado (activa o inactiva).

## 11. Dependencias, supuestos e hipótesis

- **Depende de:** US-029 (datos de contacto de las partes) y US-034 (relaciones entre partes).
- **Es prerrequisito de:** US-030 y del vínculo del colaborador con su organización (BR-076).
- **Supuestos:** Ninguno
- **Hipótesis del agente:** Ninguna. El actor lo sostiene BR-135.

## 12. Preguntas abiertas

| ID | Pregunta | Responsable | Prioridad | Bloquea | Estado |
|---|---|---|---|---|---|
| US-035-Q1 | Cerrada el 2026-10-12: lo mantienen el Jefe de Ingeniería y el ADMIN (BR-135). | Jefe de Ingeniería | Media | No | Cerrada |
| US-035-Q2 | ¿Cuáles de Tax ID, razón social y nombre comercial son obligatorios, y deben ser únicos (por ejemplo, el Tax ID)? | Jefe de Ingeniería | Media | No | Abierta |
| US-035-Q3 | ¿Qué pasa con las plazas, los colaboradores y las relaciones de una organización inactiva? ¿Se puede reactivar? (la baja por inactivación está decidida: BR-137) | Jefe de Ingeniería | Baja | No | Abierta |
| US-035-Q4 | Para af-business-glossary-curator: Tax ID, Business Name y Commercial Name no tienen término en el glosario. | Jefe de Ingeniería | Baja | No | Abierta |

## 13. Evidencia y trazabilidad

| ID | Hallazgo | Fuente | Clasificación | Confianza |
|---|---|---|---|---|
| EVD-2026-0101 | COMSATEL y el Área de Desarrollo son organizaciones; el Área es parte de COMSATEL; habrá otras organizaciones, como proveedores | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L482 | decision | high |
| EVD-2026-0157 | Una organización es parte de, como máximo, una organización a la vez | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L554 | decision | high |
| EVD-2026-0170 | Toda parte (persona u organización) tiene datos de contacto | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L567 | decision | high |
| EVD-2026-0171 | Los datos de contacto de una organización son correo, teléfono y dirección; correo y teléfono son obligatorios | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L568 | decision | high |
| EVD-2026-0172 | El correo vigente es único entre todas las partes | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L569 | decision | high |
| EVD-2026-0174 | El Jefe de Ingeniería y el ADMIN mantienen contactos, plazas, ocupaciones, roles de la parte, relaciones y organizaciones | /requirements/context-packs\RCP-001-portal-gestion-curricula-desarrollo.md:L573 | decision | high |
| EVD-2026-0176 | Una organización se registra con Tax ID, Business Name y Commercial Name | /requirements/context-packs\RCP-001-portal-gestion-curricula-desarrollo.md:L574 | decision | high |
| EVD-2026-0177 | Una organización se puede dar de baja inactivándola | /requirements/context-packs\RCP-001-portal-gestion-curricula-desarrollo.md:L575 | decision | high |

Evidencia compartida: `source_type: human`, `observed_at: 2026-10-12T00:00:00Z` (EVD-2026-0101: 2026-10-10; EVD-2026-0157: 2026-10-11), `freshness: current`, `owner: Jefe de Ingeniería`.

- **Upstream:** [BRC-001](../../business/rules/BRC-001-reglas-de-negocio-portal-curricula.md), [IMD-001](../../business/information-model/IMD-001-portal-curricula.md), [GLS-001](../../business/glossary/GLS-001-glosario-de-negocio.md) y [RCP-001](../context-packs/RCP-001-portal-gestion-curricula-desarrollo.md).
- **Downstream (pendiente):** UXR → FLW → SCR → CMP → AC

## 14. Evaluación INVEST

| Criterio | ¿Cumple? | Justificación |
|---|---|---|
| Independiente | Parcial | Se apoya en US-029 para el contacto y en US-034 para las relaciones. |
| Negociable | Sí | Los datos propios de la organización están abiertos (US-035-Q2). |
| Valiosa | Sí | Sin organizaciones no hay plazas. |
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
- **Motivo:** Los criterios están sostenidos por BR-072 y BR-131 a BR-137. El actor está sostenido por BR-135 y las preguntas abiertas no bloquean los criterios.
- **Bloqueos de entrega:** Ninguno.
- **Propuesta de división (si no es pequeña):** No aplica
- **Siguiente rol o Skill:** `ux-requirements-analyzer`
- **Decisión humana requerida:** El Jefe de Ingeniería responde US-035-Q2 a Q4 y valida la historia.
- **Origen:** historia nueva del 2026-10-12, pedida por el responsable funcional: «Incluir la historia para registrar organizaciones».
- **Validación:** Pendiente · Responsable: Jefe de Ingeniería · Fecha: —
