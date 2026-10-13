---
type: User Story
title: "US-004 — Registrar y modificar colaboradores"
description: "Como Jefe de Ingeniería o usuario con perfil ADMIN, quiero registrar y modificar los colaboradores del Área de Desarrollo con sus datos y su rol/nivel, para contar con un registro único y vigente de las personas que se entrenan y se asignan a proyectos."
tags: [user-story, por-definir, colaboradores]
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
gitlab_issue_id: 52915
gitlab_issue_iid: 5
gitlab_issue_url: https://project.comsatel.com.pe/comsatel/development/training/dev-juniors/p3m/collaboration/-/issues/5
---

# US-004 — Registrar y modificar colaboradores

## 1. Ficha

| Campo | Valor |
|---|---|
| ID | US-004 |
| Épica / capacidad | Colaboradores (IMD-001, bloque 1) |
| Horizonte / release | Por definir |
| Actor | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) / [ADMIN](../../business/glossary/terms/TRM-0028-admin.md) |
| Responsable de negocio (PO) | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) (responsable funcional del portal, /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L109) |
| Prioridad | Must: sin colaboradores no hay enrolamientos, valoraciones ni asignaciones. La decide el PO. |
| Dependencias | US-001 |
| Preparación | READY |

## 2. Historia

**Como** Jefe de Ingeniería o usuario con perfil ADMIN, **quiero** registrar y modificar los colaboradores del Área de Desarrollo con sus datos y su rol/nivel, **para** contar con un registro único y vigente de las personas que se entrenan y se asignan a proyectos.

## 3. Contexto y valor

- **Problema que resuelve:** El portal mantiene el registro de colaboradores con nombres, apellido paterno, apellido materno, fecha de ingreso y rol/nivel (BR-002).
- **Valor esperado:** Un registro oficial de colaboradores con un único rol/nivel vigente cada uno.
- **Métrica o KPI que impacta:** Sin métrica asociada

## 4. Alcance

- **Incluye:**
  - Registrar un colaborador con nombres, apellido paterno, apellido materno, fecha de ingreso a Comsatel y rol/nivel.
  - Modificar los datos y el rol/nivel de un colaborador.
- **Excluye:**
  - Consultar colaboradores (US-005).
  - Promoción de nivel o seniority (historia por redactar).
  - Datos de contacto del colaborador, su baja y la unicidad del correo vigente (BR-070, BR-125, BR-130, BR-131): historia por redactar (ver sección 17).

## 5. Criterios de aceptación

### AC-1 — Registrar un colaborador

```gherkin
Escenario: Registrar un colaborador
  Dado que el usuario es el Jefe de Ingeniería o tiene perfil ADMIN
  Cuando registra a un colaborador con nombres, apellido paterno, apellido materno, fecha de ingreso y rol/nivel
  Entonces el colaborador queda registrado con esos datos
```

- **Regla / fuente:** BR-002

### AC-2 — Modificar un colaborador

```gherkin
Escenario: Modificar un colaborador
  Dado un colaborador registrado
  Cuando el Jefe de Ingeniería o un ADMIN modifica sus datos
  Entonces el registro conserva los datos modificados
```

- **Regla / fuente:** BR-002

### AC-3 — Un colaborador tiene un único rol/nivel vigente

```gherkin
Escenario: Un colaborador tiene un único rol/nivel vigente
  Dado un colaborador con el rol/nivel "Analista Junior L1"
  Cuando se le asigna el rol/nivel "Analista Junior L2"
  Entonces su único rol/nivel vigente es "Analista Junior L2"
```

- **Regla / fuente:** BR-047

### AC-4 — Un usuario sin permiso no registra colaboradores

```gherkin
Escenario: Un usuario sin permiso no registra colaboradores
  Dado que el usuario está autenticado y no es el Jefe de Ingeniería ni tiene perfil ADMIN
  Cuando intenta registrar o modificar un colaborador
  Entonces el portal no permite la acción
```

- **Regla / fuente:** BR-002

### AC-5 — Historial de nivel y seniority

```gherkin
Escenario: Conservar el historial de rol/nivel
  Dado un colaborador registrado con su rol/nivel
  Cuando se modifica su rol/nivel
  Entonces el portal conserva el historial de sus cambios de nivel y seniority
```

- **Regla / fuente:** BR-079, BR-110

## 6. Casos negativos y límite

| Caso | Comportamiento esperado | Fuente o pregunta |
|---|---|---|
| Usuario sin perfil de Jefe de Ingeniería ni ADMIN | No puede registrar ni modificar colaboradores | BR-002 |
| Colaborador con dos rol/nivel vigentes | No es válido: solo hay uno vigente | BR-047 |
| Datos obligatorios, identificador único y colaborador repetido | Sin regla | US-004-Q1 |
| Rol/nivel que no existe en el catálogo de roles | Sin regla | US-004-Q1 |
| Vincular al colaborador con su usuario de Keycloak | El usuario se vincula con la persona por el correo la primera vez que inicia sesión y el correo vigente es único entre las personas. Los datos de contacto se registran en otra historia | BR-125, BR-129 |
| Historial de cambios de rol/nivel | Se conserva: es el historial de rol/nivel de la plaza que ocupa | BR-079, BR-110 |

## 7. Reglas de negocio aplicables

| ID | Regla | Fuente |
|---|---|---|
| BR-002 | Solo el Jefe de Ingeniería o un usuario con perfil ADMIN registra y modifica colaboradores. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L42 |
| BR-047 | Un colaborador tiene un único rol/nivel vigente en cada momento: el del puesto de la plaza que ocupa. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L87 |
| BR-003 | Cualquier usuario autenticado puede consultar los datos personales de los colaboradores. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L43 |
| BR-079 | Se conserva el historial de cambios de nivel y seniority (rol/nivel) de cada colaborador: es el historial de rol/nivel de la plaza que ocupa, con vigencia (BR-110). | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L119 |
| BR-110 | Al promover de nivel, la plaza cambia de rol/nivel y el colaborador sigue en la misma plaza. La plaza conserva el historial de su rol/nivel con vigencia. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L150 |
| BR-101 | Los datos personales se retienen igual que los logs: por siempre. El tratamiento de clasificación, cifrado y acceso sigue pendiente (RQ-34). | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L141 |
| BR-125 | La primera vez que un usuario inicia sesión, el portal lo vincula con su persona por el correo que entrega Keycloak. El correo vigente es único entre las personas. | /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md:L165 |

## 8. Datos y términos

| Término | Uso en esta historia | Glosario |
|---|---|---|
| Colaborador | Registro que se crea y modifica | [Colaborador](../../business/glossary/terms/TRM-0002-colaborador.md) |
| Rol/nivel | Dato del colaborador | [Rol/nivel](../../business/glossary/terms/TRM-0006-rol-nivel.md) |
| Jefe de Ingeniería | Actor autorizado | [Jefe de Ingeniería](../../business/glossary/terms/TRM-0026-jefe-de-ingenieria.md) |
| ADMIN | Actor autorizado | [ADMIN](../../business/glossary/terms/TRM-0028-admin.md) |

## 9. Requisitos no funcionales

- **Accesibilidad:** WCAG 2.2 AA (estándar del repositorio).
- **Privacidad y datos personales:** Toca nombres, apellido paterno, apellido materno y fecha de ingreso. Cualquier usuario autenticado puede consultarlos (BR-003). Los datos personales se retienen por siempre (BR-101). La política de datos personales aplicable está pendiente (G-12): se aplazó como deuda técnica DT-01 (RQ-34).
- **Otros:** Sin requisito identificado

## 10. Consideraciones de UX

- **Flujo esperado:** El actor registra un colaborador completando sus datos y su rol/nivel, o abre uno existente y lo modifica.
- **Estados de la interfaz:** Vacío (sin colaboradores), sin permisos, error de validación, éxito.
- **Contenido clave:** Datos personales, fecha de ingreso y rol/nivel vigente.

## 11. Dependencias, supuestos e hipótesis

- **Depende de:** US-001 (catálogo de roles).
- **Es prerrequisito de:** US-005, US-009, asignación y valoración (historias por redactar)
- **Supuestos:** S-1: el rol/nivel del colaborador sale del catálogo de roles y de la escala de niveles. Origen: BR-001, BR-011. Lo confirmaría US-004-Q1.
- **Hipótesis del agente:** Ninguna

## 12. Preguntas abiertas

| ID | Pregunta | Responsable | Prioridad | Bloquea | Estado |
|---|---|---|---|---|---|
| US-004-Q1 | ¿Qué datos del colaborador son obligatorios, cómo se identifica de forma única y se valida que el rol/nivel exista? | Jefe de Ingeniería | Media | No | Abierta |
| G-11 | ¿Cómo se vinculan los colaboradores registrados con los usuarios de Keycloak? | Arquitectura | Media | No | Cerrada en parte: por el correo, la primera vez que inicia sesión (EVD-2026-0164, BR-125, BR-129). El registro de los contactos queda para otra historia |
| G-12 | ¿Qué política de datos personales aplica? | Jefe de Ingeniería | Media | No | Abierta: aplazada como deuda técnica DT-01; aceptada por Seguridad según el responsable funcional (RQ-34) |
| G-06 | ¿Se conserva el historial de cambios de nivel y seniority? | Jefe de Ingeniería | Media | No | Cerrada: sí, lo conserva la plaza (EVD-2026-0115, EVD-2026-0151, BR-079, BR-110) |

## 13. Evidencia y trazabilidad

| ID | Hallazgo | Fuente | Clasificación | Confianza |
|---|---|---|---|---|
| EVD-2026-0004 | Por colaborador se registra: nombres, apellido paterno, apellido materno, fecha de ingreso, rol/nivel | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L99 | fact | high |
| EVD-2026-0020 | Los colaboradores los registra y modifica el Jefe de Ingeniería o cualquier usuario con perfil ADMIN | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L115 | decision | high |
| EVD-2026-0027 | Cualquier usuario autenticado puede consultar los datos personales de los colaboradores | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L122 | decision | high |
| EVD-2026-0070 | Un colaborador tiene un único rol/nivel vigente en cada momento | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L165 | decision | high |
| EVD-2026-0115 | Se conserva el historial de cambios de nivel y seniority de cada colaborador | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L499 | decision | high |
| EVD-2026-0143 | Los datos personales se retienen igual que los logs | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L540 | decision | high |
| EVD-2026-0151 | La promoción cambia el rol/nivel de la plaza; la plaza conserva el historial | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L548 | decision | high |
| EVD-2026-0164 | El usuario de Keycloak se vincula con su persona por el correo que Keycloak entrega, la primera vez que inicia sesión; el correo vigente es único entre las personas | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L561 | decision | high |
| EVD-2026-0168 | El vínculo entre el usuario y su persona se fija una sola vez | /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L565 | decision | high |

Evidencia compartida: `source_type: human`, `observed_at: 2026-10-10T12:00:00-05:00`, `freshness: current`, `owner: Jefe de Ingeniería`. Las evidencias EVD-2026-0143 a EVD-2026-0169 se observaron el 2026-10-11T00:00:00Z.

- **Upstream:** [BRC-001](../../business/rules/BRC-001-reglas-de-negocio-portal-curricula.md), [IMD-001](../../business/information-model/IMD-001-portal-curricula.md), [GLS-001](../../business/glossary/GLS-001-glosario-de-negocio.md) y [RCP-001](../context-packs/RCP-001-portal-gestion-curricula-desarrollo.md), todos en estado `draft`.
- **Downstream (pendiente):** UXR → FLW → SCR → CMP → AC

## 14. Evaluación INVEST

| Criterio | ¿Cumple? | Justificación |
|---|---|---|
| Independiente | Sí | Solo necesita el catálogo de roles (US-001). |
| Negociable | Parcial | Datos obligatorios e identificación quedan abiertos (US-004-Q1). |
| Valiosa | Sí | Un registro oficial de colaboradores con un único rol/nivel vigente cada uno. |
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
- [x] El PO validó la historia

## 16. Definition of Done (funcional)

- [ ] Todos los criterios de aceptación pasan sus pruebas de aceptación
- [ ] Los casos negativos y límite están cubiertos por pruebas
- [ ] La accesibilidad WCAG 2.2 AA está revisada
- [ ] Los requisitos de privacidad se cumplen
- [ ] El PO aceptó la historia en la revisión

## 17. Preparación y validación

- **Estado:** READY
- **Motivo:** Actor, valor y criterios están sostenidos por BR-002, BR-047 y BR-079. Solo US-004-Q1 afecta a esta historia y G-12 sigue abierta como deuda técnica; ninguna bloquea los criterios.
- **Bloqueos de entrega:** Ninguno
- **Propuesta de división (si no es pequeña):** Redactar una historia aparte para los datos de contacto del colaborador (correo y teléfono obligatorios, baja con fecha y responsable, correo vigente único: BR-070, BR-125, BR-130, BR-131). Esta historia no los incluye.
- **Siguiente rol o Skill:** `ux-requirements-analyzer`
- **Decisión humana requerida:** El Jefe de Ingeniería (validó la historia el 2026-10-12) responde US-004-Q1. G-11 y G-06 quedaron cerradas; G-12 queda aplazada (DT-01).
- **Actualización 2026-10-12:** el historial de rol/nivel lo conserva la plaza (BR-110), el vínculo del usuario con la persona va por el correo (BR-125, BR-129), los datos personales se retienen por siempre (BR-101) y la política de datos personales quedó aplazada (RQ-34). Se cierran G-06 y G-11 (en parte). Verificada de nuevo por ianache el 2026-10-12.
- **Validación:** Aprobada · Responsable: Jefe de Ingeniería (ianache) · Fecha: 2026-10-12
