---
type: Architecture Decision Record Annex
title: "ADR-P5 — Anexo: detalle y propuesta de mapa rol-permiso"
description: "Detalle de ADR-P5 (autorización por rol): qué decide hoy, qué falta, el mapa rol-permiso derivado de las reglas de negocio, las brechas y conflictos, y las opciones para resolverlos. Es una propuesta: no modifica ADR-P5."
tags: [architecture, adr, authorization]
status: approved
generated:
  by: "claude-code (detalle solicitado por ianache, OI-04)"
  at: "2026-10-12T10:30:00-05:00"
verified:
  by: "ianache (Functional Analysis)"
  at: "2026-10-12T17:00:00-05:00"
sources:
  - id: adr-p5
    resource: /architecture/adr/ADR-P5-estrategia-de-autorizacion-por-rol.md
  - id: adr-p9
    resource: /architecture/adr/ADR-P9-nombre-del-protocolo-de-consumo-seguro-bffmic.md
  - id: adr-11
    resource: /architecture/adr/ADR-11-identidad-y-roles-de-usuario-gestionados-en-k.md
  - id: brc-001
    resource: /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md
  - id: icp-001
    resource: /data/ICP-001-contratos-de-integracion.md
  - id: open-items
    resource: /architecture/handoffs/db-p3m/open-items.md
---

# ADR-P5 — Anexo: detalle y propuesta de mapa rol-permiso

> **Estado: resuelto el 2026-10-12.** ianache respondió P5-D1 a P5-D7 (sección 7) y aprobó ADR-P5. El mapa de la sección 3 vale con los cambios que recoge ADR-P5 (BR-134 y BR-135).

## 1. Qué decide hoy ADR-P5

Los guards de Angular activan o desactivan elementos de la interfaz según los roles de Keycloak. **Además**, el BFF y cada microservicio validan el rol en el servidor, porque los guards no son un control de seguridad.

Lo que **no** decide, y su propio texto lo reconoce: el **mapa rol-permiso**, es decir, qué rol puede hacer qué y dónde se comprueba. La validación en el servidor la añadió el equipo de gestión al registrar la decisión y estaba «por confirmar».

## 2. Roles que existen

| Rol | Tipo | Origen | Fuente |
|---|---|---|---|
| colaborador | Rol de usuario | Keycloak | BR-044, BR-062, BR-075 |
| Instructor (Evaluador) | Rol de usuario | Keycloak | BR-008, BR-062 |
| Jefe de Ingeniería | Rol de usuario | Keycloak (por defecto lo tiene ianache) | BR-081 |
| ADMIN | Rol de usuario | Keycloak | BR-044 |
| Jefe de proyecto | **Puesto de la organización, no es rol de usuario** | Datos del portal (vigencia en `jefatura_de_proyecto`) | BR-062, BR-102, BR-108 |
| Evaluador **de una edición** | Rol de la parte con vigencia, ligado a una edición concreta | Datos del portal (`edicion_de_curso.evaluador_ref`) | BR-008, BR-108 |

**Consecuencia:** hay dos tipos de permiso. Unos dependen solo del rol del token. Otros dependen además de **un dato del portal**: ser el evaluador de esa edición, el jefe vigente de ese proyecto o el dueño del registro.

## 3. Mapa rol-permiso derivado de las reglas

Solo lo que una regla dice. **R** = rol del token; **R + D** = rol más una condición sobre un dato del portal.

| Capacidad | Quién puede | Condición | Tipo | Fuente |
|---|---|---|---|---|
| Crear y mantener el catálogo de roles | Jefe de Ingeniería, ADMIN | — | R | BR-001 |
| Definir perfiles de competencias, nivel mínimo, cursos con objetivos y evidencias esperadas, y ediciones | **Solo** Jefe de Ingeniería | — | R | BR-055 |
| Registrar y modificar colaboradores | Jefe de Ingeniería, ADMIN | — | R | BR-002 |
| Consultar los datos personales de los colaboradores | **Cualquier usuario autenticado** | — | R | BR-003 |
| Enrolarse y desenrolarse | colaborador | Solo en su propio enrolamiento (derivado, ninguna regla lo dice) | R + D | BR-025, BR-027 |
| Registrar evidencias de curso | colaborador | En la edición en que está enrolado | R + D | BR-060 |
| Validar evidencias de curso, evaluar, certificar | Evaluador de la edición | Ser el evaluador de **esa** edición | R + D | BR-009, BR-022 |
| Aportar evidencias de proyecto | colaborador | — | R | BR-028 |
| Validar evidencias de proyecto | Jefe de proyecto | Ser el jefe **vigente** del proyecto del issue | R + D | BR-010, BR-102 |
| Registrar la valoración de cumplimiento | Jefe de Ingeniería, ADMIN | — | R | BR-004 |
| Registrar una solicitud de promoción | colaborador | La suya | R + D | BR-064, BR-068 |
| Evaluar la solicitud y decidir la promoción | **Solo** Jefe de Ingeniería | — | R | BR-007, BR-068 |
| Registrar la evaluación de desempeño | Jefe de Ingeniería | — | R | BR-083, BR-084 |
| Mantener productos, proyectos y el codificador de motivos | Jefe de Ingeniería, ADMIN | — | R | BR-061 |
| Definir los roles/niveles que requiere un proyecto | Jefe de Ingeniería, ADMIN | Se confirma si el jefe de proyecto conserva algún permiso (RQ-32) | R | BR-109 |
| Designar al jefe de proyecto | Jefe de Ingeniería, ADMIN | Al gestionar los proyectos | R | BR-063, BR-061 |
| Asignar colaboradores a proyectos | **Solo** Jefe de Ingeniería | — | R | BR-005 |
| Aprobar una excepción de asignación | **Solo** Jefe de Ingeniería | — | R | BR-006 |
| Ver la consola de cargas y reintentar una carga | Jefe de Ingeniería, ADMIN | — | R | BR-066 |
| Ver los milestones e issues de un proyecto | Jefe de Ingeniería, ADMIN | — | R | BR-069 |
| Corregir el vínculo usuario–persona | Jefe de Ingeniería | Con registro de quién y cuándo | R | BR-129 |
| Registrarse como usuario al iniciar sesión | Automático | Sin registro libre | — | BR-074, BR-128 |

**Diferencias entre Jefe de Ingeniería y ADMIN.** Solo el Jefe de Ingeniería: BR-005 (asignar), BR-006 (excepción), BR-007 (promoción), BR-055 (currícula y cursos), BR-083 (evaluación) y BR-129 (corregir el vínculo). Ambos: BR-001, BR-002, BR-004, BR-061, BR-066, BR-069 y BR-109.

## 4. Funcionalidades nuevas (OI-11) sin regla de permiso

Los datos de contacto, las plazas, las ocupaciones, los roles de la parte y las relaciones entre partes **no tienen ninguna regla que diga quién las mantiene**. En las historias US-029 a US-034 figura como hipótesis que lo hacen el Jefe de Ingeniería o ADMIN, por analogía con BR-002 (registrar colaboradores), y queda como pregunta abierta. Solo la corrección del vínculo tiene regla (BR-129).

## 5. Brechas y conflictos

### G-1 — La identidad del usuario no llega al microservicio (conflicto con ADR-P9)

- **Hecho:** ADR-P5 dice que **cada microservicio valida el rol del usuario**. ADR-P9 dice que el BFF llama a los microservicios con un **JWT de máquina** de Client Credentials, **no el del usuario**.
- **Consecuencia:** con solo el token de máquina, el microservicio **no sabe quién es el usuario ni qué rol tiene**. Tampoco puede registrar al actor (`*_por_ref` = claim `sub` del usuario), que es una regla del diseño de datos (ICP-001, ARCH-RULE-012). Con el token de máquina, el `sub` sería el cliente del BFF.
- **Es un conflicto real entre dos decisiones aprobadas o aceptadas** (ADR-P9 aprobado el 2026-10-12; ADR-P5 pendiente). Hay que decidirlo antes de implementar los servicios.

| Opción | Cómo funciona | Ventaja | Costo o riesgo |
|---|---|---|---|
| **A. El BFF reenvía el token del usuario además del de máquina** | El servicio autentica al BFF con el JWT de máquina y valida el token del usuario contra Keycloak (JWKS) para obtener `sub` y roles | Simple y estándar. El servicio decide con datos firmados por Keycloak | El BFF debe guardar y reenviar el token (ya lo guarda por PKCE). Caducidad del token |
| **B. Intercambio de token (RFC 8693)** | El BFF cambia el token del usuario por otro con audiencia del microservicio | Menor exposición del token original | Más configuración en Keycloak; más piezas |
| **C. El BFF envía el contexto del usuario en cabeceras** | `sub` y roles viajan en cabeceras que el servicio acepta porque confía en el BFF | Muy simple | **El servicio confía a ciegas en el BFF**: un BFF comprometido suplanta a cualquiera. Debilita la seguridad |

**Recomendación: A.** Es la opción que mejor encaja con ADR-P9 sin cambiarlo y mantiene la validación de roles «en el servidor» como ADR-P5 pretende. La **C no se recomienda** por debilitar la seguridad.

### G-2 — Permisos que dependen de datos (R + D)

Las filas «R + D» de la sección 3 (evaluador de la edición, jefe de proyecto, dueño del registro) no se pueden comprobar con el rol del token. Se resuelven con las consultas ya definidas: CON-01 (rol vigente de una persona), CON-09 (jefe vigente de un proyecto) y la propia edición (`evaluador_ref`). ADR-P5 no lo dice. **Propuesta:** la autorización es *rol del token* **más** *condición del recurso*, comprobada por el servicio dueño del dato.

### G-3 — BR-003 expone datos personales a cualquier usuario autenticado

BR-003 permite que **cualquier usuario autenticado** consulte los datos personales de los colaboradores (nombres, contactos, correo). Choca con ASR-14 y con la deuda técnica DT-01, y con la retención por siempre (BR-101). No se cambia aquí; se señala para que lo decidas con Seguridad: mantenerlo o restringirlo a Jefe de Ingeniería, ADMIN y al propio colaborador.

### G-4 — Vocabulario de roles

BR-044 lista tres roles de usuario y BR-075 cuatro (con colaborador). C-08 de BRC-001 lo resolvió: son cuatro. Falta confirmar los **nombres exactos de los roles en Keycloak** y cómo se mapean a `INSTRUCTOR`, `JEFE_DE_INGENIERIA` y los demás (ACL-01 de ICP-001 asume los nombres «colaborador», «Instructor», «Jefe de Ingeniería» y «ADMIN»).

### G-5 — ADMIN y Jefe de Ingeniería

Solo seis capacidades son exclusivas del Jefe de Ingeniería. Si un ADMIN debe poder suplirlo (por ejemplo en ausencia), ninguna regla lo dice.

### G-6 — Dónde se comprueba cada cosa

Ninguna decisión fija qué comprueba el BFF y qué comprueba cada servicio. **Propuesta:** el BFF comprueba el rol grueso y oculta lo que no corresponde (interfaz); **cada servicio comprueba el rol y la condición del recurso y es la fuente de verdad**. Eso es lo que ADR-P5 ya dice, expresado como regla.

## 6. Decisiones que necesito de ti

| ID | Pregunta | Recomendación |
|---|---|---|
| P5-D1 | ¿Cómo llega la identidad del usuario al microservicio (G-1)? | **A**: el BFF reenvía el token del usuario además del de máquina |
| P5-D2 | ¿Aceptas la regla «rol del token más condición del recurso» para las filas R + D (G-2)? | Aceptar |
| P5-D3 | BR-003: ¿se mantiene que cualquier usuario autenticado consulta datos personales, o se restringe (G-3)? | Restringir a Jefe de Ingeniería, ADMIN y el propio colaborador, y registrarlo en BRC-001 |
| P5-D4 | ¿Cuáles son los nombres exactos de los roles en Keycloak (G-4)? | Los que tengas configurados; los registro en ACL-01 |
| P5-D5 | ¿Puede un ADMIN suplir las capacidades exclusivas del Jefe de Ingeniería (G-5)? | No, hasta que una regla lo diga |
| P5-D6 | ¿Quién mantiene los contactos, plazas, ocupaciones, roles de la parte y relaciones (sección 4)? | Jefe de Ingeniería y ADMIN, como en BR-002 |
| P5-D7 | ¿Apruebas ADR-P5 con el mapa de la sección 3 y las decisiones anteriores? | Aprobar tras P5-D1 a P5-D6 |

Con tus respuestas actualizo ADR-P5, ICP-001 (la regla de actores), BRC-001 y las historias, y aprobamos ADR-P5.

## 7. Respuestas del responsable (2026-10-12)

| # | Decisión | Respuesta | Dónde quedó |
|---|---|---|---|
| P5-D1 | Identidad del usuario en los servicios | A: el BFF reenvía el token del usuario además del de máquina | ADR-P5 §3.2 |
| P5-D2 | Rol del token más condición del recurso | Conforme | ADR-P5 §3.1 y §3.3 |
| P5-D3 | BR-003 | Se mantiene; riesgo técnico dentro de DT-01 | RCP-001 D-163; BRC-001 BR-003 |
| P5-D4 | Nombres de rol en Keycloak | ADMIN, COLABORADOR, INSTRUCTOR, JEFE_INGENIERIA (definidos por el responsable) | RCP-001 D-164; ICP-001 ACL-01; DDL `ck_usuario_rol` |
| P5-D5 | ADMIN y capacidades exclusivas | El ADMIN las suple | RCP-001 D-165; BRC-001 BR-134 |
| P5-D6 | Quién mantiene las funcionalidades nuevas | Jefe de Ingeniería y ADMIN | RCP-001 D-166; BRC-001 BR-135 |
| P5-D7 | Aprobar ADR-P5 | Aprobada | ADR-P5 §1 |
