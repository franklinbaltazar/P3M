---
okf_version: "0.2"
id: "MCP-DSP-001"
title: "Management Context Pack — Gobierno de DSP-001 antes de Sprint Selection"
status: "REQUIRES_REVIEW"
version: "0.4.0"
date: "2026-10-11"
generated: true
verified: false
human-reviewed: false
provenance:
  agent: "claude-code"
  method: "management-context-and-governance"
  sources:
    - /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md
    - /requirements/scope-packs/DSP-001-p3m-alcance-candidato.md
sources:
  - id: rcp-001
    resource: /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md
  - id: dsp-001
    resource: /requirements/scope-packs/DSP-001-p3m-alcance-candidato.md
---

# Management Context Pack — Gobierno de DSP-001

## 1. Pregunta de trabajo, alcance y cambios

**Pregunta:** ¿Está suficientemente gobernado DSP-001 para continuar hacia Sprint Selection y qué debe resolverse antes de preparar un SSP?

**Fuentes autorizadas:** [RCP-001](../../requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md) y [DSP-001](../../requirements/scope-packs/DSP-001-p3m-alcance-candidato.md). Las citas usan `archivo:Lnn`. Se añadió una comprobación de solo lectura en GitLab, autorizada por el usuario, que consta como evidencia de ejecución (MCP-F24 a MCP-F26). No se consultaron las historias ni los catálogos de arquitectura. El Pack no modificó ninguna fuente. En GitLab solo se creó el Project Issue #14, con aprobación del responsable.

**Cambio posterior (2026-10-12):** el responsable cambió el destino de GitLab del proyecto 605 al **633** (`comsatel/development/training/dev-juniors/p3m/collaboration`, vacío al comprobarlo en solo lectura). Se recrearon allí el Project Issue [#1](https://project.comsatel.com.pe/comsatel/development/training/dev-juniors/p3m/collaboration/-/issues/1) (`issue_id` 52911), el Milestone «Sprint 1 - P3M» (id 1755) y los 35 Issues de User Story. El proyecto 605 se conserva intacto. Los hechos MCP-F20 a MCP-F29, MCP-S02, MCP-G01, MCP-G02 y MCP-DH06 describen el proyecto 605 y son históricos; el `project_id` vigente es 633. Pendiente de revisión humana: este Pack no se regeneró.

**Cambios de la versión 0.4.0:** el responsable aprobó crear el Project Issue (Q-04) y confirmó que el proyecto 605 es el destino de las Issues y Milestones de P3M (Q-05). Se creó el Issue [#14](https://project.comsatel.com.pe/comsatel/development/training/dev-juniors/-/issues/14) (`issue_id` 52819, `issue_iid` 14) con label `Proyecto` y se registró en el DSP. Es la única mutación de GitLab realizada.

**Cambios de la versión 0.3.0 respecto de la 0.2.1:** el DSP volvió a editarse. Ahora tiene `verified: true` y `generated: 2026-10-10`, cita las decisiones hasta D-132, marca DSP-B1 a B5 como cerrados con sus excepciones, y registra `project_id: 605`. Se comprobó el proyecto 605 en GitLab. Esta versión sustituye a la anterior.

**Respuesta corta:** el DSP **está gobernado formalmente** y ya tiene su Project Issue y su `project_id`: el PO lo aprobó y cerró los cinco bloqueos con excepciones registradas. **La selección de Sprint puede continuar.** Para **preparar un SSP** faltan: la definición del equipo, la capacidad y las estimaciones, y la verificación o aceptación formal de cuatro cierres que no se pueden comprobar con estas fuentes. Veredicto de gobierno: `CONDITIONAL`.

## 2. Hechos (con evidencia)

| ID | Hecho | Evidencia |
|---|---|---|
| MCP-F01 | El DSP tiene `status` y `scope_state` en `READY_FOR_SPRINT_SELECTION` | DSP-001:L8, DSP-001:L48 |
| MCP-F02 | El DSP tiene `verified: true`, `human-reviewed: true`, `approved_by: ianache (Jefe de Ingeniería, PO)` y `approved_on: 2026-10-10` | DSP-001:L7, DSP-001:L44, DSP-001:L45, DSP-001:L46 |
| MCP-F03 | La nota de aprobación dice que B1 a B5 se cerraron por decisión del PO el 2026-10-10 con excepciones: fuentes como rutas relativas (B1) y decisiones de arquitectura sin revisión de un arquitecto (B3) | DSP-001:L47, DSP-001:L201 |
| MCP-F04 | El DSP no tiene Sprint asignado: `sprint.id` y `sprint.name` son `null` | DSP-001:L49 |
| MCP-F05 | Las `sources` del DSP son rutas relativas a ``, por decisión del responsable, sin URL HTTP(S) hasta que haya repositorio | DSP-001:L61 |
| MCP-F06 | El PO es el Jefe de Ingeniería (rol de usuario; por defecto, ianache) y el DSP lo da por validado | DSP-001:L71 |
| MCP-F07 | El alcance declarado es de 28 historias, 108 criterios de aceptación y 9 olas | DSP-001:L72 |
| MCP-F08 | La estimación está en blanco y la hace el equipo | DSP-001:L84 |
| MCP-F09 | El DSP declara exclusiones explícitas, entre ellas la exposición de API a terceros por gateway | DSP-001:L159, DSP-001:L170 |
| MCP-F10 | La tabla marca DSP-B1 a B5 como `CERRADO 2026-10-10`. B3 se cierra porque «el responsable decidió ADR-P1, P2, P3, P5, P6, P7, P9 e INF-Q01; sin revisión de un arquitecto». B4 se cierra con disponibilidad 99,9 %, RTO 4 h, RPO 1 h, respaldos cada hora y más de 50 colaboradores, sin datos de usuarios concurrentes ni de crecimiento (declarados no bloqueantes). B5 se cierra porque el PO aprobó las 28 historias | DSP-001:L207, DSP-001:L208, DSP-001:L209, DSP-001:L210, DSP-001:L211 |
| MCP-F11 | El DSP declara que no hay preguntas abiertas de las historias que bloqueen | DSP-001:L213 |
| MCP-F12 | La Definition of Ready acepta fuentes con ruta relativa y declara cumplidas las decisiones de arquitectura mínimas, por decisión del responsable y sin revisión de un arquitecto. Sigue exigiendo responsabilidades de desarrollo y QA claras | DSP-001:L217, DSP-001:L219, DSP-001:L221, DSP-001:L222 |
| MCP-F13 | El DSP cita las decisiones del RCP hasta D-132, igual que el RCP | DSP-001:L80, RCP-001:L539 |
| MCP-F14 | El RCP-001 está `APPROVED` y `verified` por ianache (Functional Analysis) el 2026-10-10, a solicitud expresa | RCP-001:L5, RCP-001:L10, RCP-001:L541 |
| MCP-F15 | El responsable funcional es el Jefe de Ingeniería (D-03), rol de usuario cuyo titular por defecto es ianache (D-95) | RCP-001:L30, RCP-001:L410, RCP-001:L502 |
| MCP-F16 | La integración con GitLab es de solo lectura y GitLab es una instancia privada de la empresa | RCP-001:L400, RCP-001:L436 |
| MCP-F17 | El RCP no contiene las decisiones de ADR-P1 a ADR-P9 ni los objetivos de disponibilidad, RTO, RPO o carga que cita el DSP | Búsqueda de esos términos en el RCP, sin resultados |
| MCP-F18 | El RCP decide que los microservicios queden preparados para otras aplicaciones vía API Gateway; el DSP no dice si esa preparación está en el alcance | RCP-001:L530, DSP-001:L159 |
| MCP-F19 | Ninguna de las dos fuentes menciona Project Issue, label `Proyecto`, `issue_id`, `issue_iid`, SSP ni Milestone de este proyecto | Búsqueda de esos términos en ambos archivos, sin resultados |
| MCP-F20 | El DSP declara `project_id: 605` y `gitlab_project: comsatel/development/training/dev-juniors/knowledge-base` | DSP-001:L52, DSP-001:L53, DSP-001:L68 |
| MCP-F21 | En el RCP, `project_id` es un atributo del producto; no hay un `project_id` de P3M | RCP-001:L373 |
| MCP-F22 | El DSP dice en el campo «Estado del alcance» que se aprobó «con bloqueos abiertos», mientras la tabla los marca cerrados | DSP-001:L67, DSP-001:L207 |
| MCP-F23 | La política de datos y el resto de preguntas generales siguen abiertas; el DSP las lista | DSP-001:L213 |
| MCP-F24 | Comprobación de solo lectura en GitLab (2026-10-11): el proyecto 605 existe y se llama `knowledge-base` (`comsatel/development/training/dev-juniors/knowledge-base`), es privado, no está archivado y su rama por defecto es `main` | Consulta GET `/projects/605` (evidencia de ejecución, fuera de las fuentes autorizadas) |
| MCP-F25 | En el proyecto 605 no hay Issues con label `Proyecto` (en ningún estado) ni Milestones | Consultas GET de issues y milestones, listas vacías |
| MCP-F26 | El repositorio contiene una base de conocimiento con otra estructura de documentos (por ejemplo `requirements/PRD-Gestion-Tenants.md`) y los archivos de P3M no están publicados: RCP-001 devuelve 404 en la raíz y bajo `` | Consultas GET del árbol y del archivo en la rama `main` |
| MCP-F27 | El responsable aprobó crear el Project Issue con label `Proyecto` y generó su título y descripción con este agente (Q-04), y confirmó que el proyecto 605 es el destino correcto (Q-05) | Mensajes del usuario (fuera de las fuentes autorizadas) |
| MCP-F28 | Se creó en GitLab el Issue #14 (`issue_id` 52819, `issue_iid` 14, estado `opened`, label `Proyecto`) en el proyecto 605. No había un Issue previo con ese label. La etiqueta `Proyecto` no existía y se creó con el Issue | Respuesta de la API (201) del 2026-10-11 |
| MCP-F29 | El DSP registra el Project Issue (`project_issue_id`, `project_issue_iid`, `project_issue_url`), y el Issue referencia el DSP por su ruta relativa. La relación bidireccional queda establecida | DSP-001:L55, DSP-001:L69. La descripción del Issue cita la ruta del DSP |

## 3. Supuestos

| ID | Supuesto | Por qué se usa | Cómo se confirma |
|---|---|---|---|
| MCP-S01 | El DSP-001 es un único incremento | Es un solo DSP de 28 historias (DSP-001:L72) | El PO confirma el alcance del primer Sprint |
| MCP-S02 | ~~El proyecto 605 es el destino correcto~~ **Confirmado** por el responsable (Q-05, MCP-F27) | — | — |
| MCP-S03 | Las decisiones y objetivos de B3 y B4 están registrados en otro lugar del conocimiento | El DSP los cita sin que figuren en el RCP (MCP-F17) | Se autoriza leer los catálogos de arquitectura e infraestructura |
| MCP-S04 | El PO aprobó las 28 historias, como declara el cierre de B5 | Solo lo afirma el DSP (DSP-001:L211) | Se revisa el estado de las historias |

## 4. Hipótesis (propuestas del agente, sin respaldo en las fuentes)

| ID | Hipótesis | Origen | Qué la confirmaría |
|---|---|---|---|
| MCP-H01 | Para un primer Sprint conviene acotar el alcance a las primeras olas | Las 9 olas del DSP (DSP-001:L72). El DSP no lo propone | Decisión del PO y capacidad del equipo |
| MCP-H02 | El DSP debería actualizar el número de criterios (108) si las historias cambiaron después de generarlo | La deriva es posible porque las historias se siguen editando | Verificar contra las historias actuales |

## 5. Vacíos

| ID | Vacío | Impacto | Responsable |
|---|---|---|---|
| MCP-G01 | ~~`project_id` de P3M~~ **Resuelto:** 605, registrado en el DSP y existente en GitLab (MCP-F20, MCP-F24) | — | — |
| MCP-G02 | ~~Project Issue con label `Proyecto`~~ **Resuelto:** Issue #14 creado y registrado en el DSP (MCP-F28, MCP-F29) | — | — |
| MCP-G03 | Evidencia, en las fuentes autorizadas, de las decisiones de B3 (ADR-P1, P2, P3, P5, P6, P7, P9 e INF-Q01), cerradas sin revisión de un arquitecto | El cierre no es verificable. Es una excepción aceptada por el PO | Arquitectura |
| MCP-G04 | Evidencia de los objetivos de B4 (99,9 %, RTO 4 h, RPO 1 h, más de 50 colaboradores). Faltan usuarios concurrentes y crecimiento | El cierre no es verificable y la carga está incompleta | Responsable funcional y arquitectura |
| MCP-G05 | Equipo o proveedor de desarrollo y QA, capacidad y duración del Sprint. La Definition of Ready los exige (DSP-001:L221) | No se puede seleccionar un Sprint sin capacidad | PO y gestión |
| MCP-G06 | Criterios de selección del Sprint, nombre del Milestone y responsable del SSP | Sin ellos no se prepara el SSP | PO y gestión |
| MCP-G07 | Estimaciones de las historias | Sin ellas no se compara con la capacidad | Equipo de desarrollo |
| MCP-G08 | No se puede verificar con las fuentes autorizadas que las 28 historias y los 108 criterios coincidan con las historias actuales, ni la aprobación de las 28 historias (B5) | Posible deriva y cierre no verificable | Gestión. Requiere autorizar la lectura de las historias |
| MCP-G09 | El DSP no dice si la preparación para consumo por otras aplicaciones (D-123) está en el alcance | Ambigüedad de alcance | PO |
| MCP-G10 | Los archivos de P3M no están publicados en el repositorio del proyecto 605 (MCP-F26), así que una URL completa por fuente no resolvería | B1 se cerró por decisión con rutas relativas | Gestión del conocimiento |

## 6. Decisiones humanas registradas en las fuentes

| ID | Decisión | Evidencia |
|---|---|---|
| MCP-DH01 | ianache, como Jefe de Ingeniería (PO), aprueba el DSP el 2026-10-10 y lo pasa a `READY_FOR_SPRINT_SELECTION` | DSP-001:L7, DSP-001:L44, DSP-001:L45, DSP-001:L46 |
| MCP-DH02 | El PO cierra DSP-B1 a B5 el 2026-10-10 con dos excepciones registradas: rutas relativas (B1) y decisiones de arquitectura sin revisión de un arquitecto (B3) | DSP-001:L47, DSP-001:L201 |
| MCP-DH03 | Se consideran decididas ADR-P1, P2, P3, P5, P6, P7, P9 e INF-Q01 | DSP-001:L209 |
| MCP-DH04 | Objetivos: disponibilidad 99,9 %, RTO 4 h, RPO 1 h, más de 50 colaboradores | DSP-001:L210 |
| MCP-DH05 | El PO aprueba las 28 historias | DSP-001:L211, DSP-001:L208 |
| MCP-DH06 | El proyecto de GitLab de P3M es el 605 | DSP-001:L52 |
| MCP-DH07 | El Jefe de Ingeniería es el responsable funcional y su titular por defecto es ianache | RCP-001:L410, RCP-001:L502 |
| MCP-DH08 | La integración con GitLab es de solo lectura y los microservicios quedan preparados para otras aplicaciones | RCP-001:L436, RCP-001:L530 |
| MCP-DH09 | El RCP-001 se aprueba el 2026-10-10 por ianache (Functional Analysis) | RCP-001:L541 |

**Decisiones que NO existen todavía:** el alcance del primer Sprint, la capacidad del equipo, la creación del Project Issue y la designación de quién prepara el SSP.

## 7. Bloqueos del DSP (IDs conservados)

| ID | Bloqueo | Declarado en el DSP | Verificable con las fuentes autorizadas | Estado según este Pack | Responsable |
|---|---|---|---|---|---|
| DSP-B1 | Falta la URL del repositorio, ref y ruta de las fuentes | Cerrado: rutas relativas (DSP-001:L207) | Sí, es una decisión humana documentada. El proyecto es el 605 en la rama `main`, pero los archivos de P3M no están publicados (MCP-F26, MCP-G10) | **Cerrado por decisión, con excepción al contrato** | Gestión del conocimiento |
| DSP-B2 | Nadie ha validado el alcance ni las historias | Cerrado: el PO aprobó el alcance y las 28 historias (DSP-001:L208) | El alcance sí (DSP-001:L45, `verified: true`). Las 28 historias no se pueden comprobar (MCP-G08) | **Cerrado** para el DSP, historias no verificables | Jefe de Ingeniería |
| DSP-B3 | Decisiones de arquitectura pendientes y modelo de despliegue sin decidir | Cerrado: decidido por el responsable (DSP-001:L209) | **No.** No figuran en el RCP y el DSP declara que no hubo revisión de un arquitecto | **Cerrado por decisión del PO, con excepción; no verificable** | Arquitectura |
| DSP-B4 | Objetivos de disponibilidad, RTO, RPO y carga sin definir | Cerrado con 99,9 %, RTO 4 h, RPO 1 h y más de 50 colaboradores (DSP-001:L210) | **No.** Las cifras no figuran en el RCP. Faltan concurrentes y crecimiento | **Cerrado por decisión del PO; no verificable. Carga incompleta** | Responsable funcional y arquitectura |
| DSP-B5 | Historias nuevas o editadas tras su aprobación sin revalidar | Cerrado: el PO aprobó las 28 historias (DSP-001:L211) | **No.** Las historias no son fuente autorizada | **Cerrado por decisión del PO; no verificable** | Jefe de Ingeniería |
| MCP-B6 (nuevo) | Falta el Project Issue con label `Proyecto` en el proyecto 605 y su relación con el DSP | No lo trata | Resuelto: Issue #14 y relación bidireccional (MCP-F28, MCP-F29) | **Resuelto** | Responsable funcional y gestión |
| MCP-B7 (nuevo) | Falta equipo, capacidad, duración de Sprint, criterios de selección y estimaciones | La Definition of Ready exige responsabilidades de desarrollo y QA claras (DSP-001:L221) | Confirmado: MCP-G05 a MCP-G07 | **Vigente** | PO y gestión |

## 8. Contradicciones y deriva

| ID | Contradicción o deriva | Evidencia A | Evidencia B | Estado |
|---|---|---|---|---|
| MCP-C01 | El campo «Estado del alcance» dice que se aprobó «con bloqueos abiertos» y la tabla los marca como cerrados | DSP-001:L67 | DSP-001:L207 a DSP-001:L211 | **Abierta**, menor: texto residual |
| MCP-C02 | El número de criterios (108) puede no coincidir con las historias actuales | DSP-001:L72 | No verificable con las fuentes autorizadas (MCP-G08) | **Sin verificar** |
| MCP-C03 | El DSP aprobado el 2026-10-10 incluye una anotación del 2026-10-11 sobre el `project_id` | DSP-001:L46 | DSP-001:L68 | **Observación** menor: no hay un registro de quién ni cuándo editó |

**Resueltas desde la versión 0.2.1** (el DSP las corrigió): decisiones citadas hasta D-132, `verified: true`, fecha de `generated`, B2 marcado como cerrado, cuerpo sin «validación pendiente» en el PO y Definition of Ready alineada con las excepciones.

## 9. Observaciones de provenance

| ID | Observación | Evidencia |
|---|---|---|
| MCP-P01 | El RCP dice que todas las decisiones son declaraciones del usuario, no contrastadas con documentación | RCP-001:L35, RCP-001:L541 |
| MCP-P02 | El RCP se aprobó «a solicitud expresa» de forma general, sin revisión de un segundo rol | RCP-001:L541 |
| MCP-P03 | El DSP lo generó un agente, sin el script determinista del skill (DSP-001:L41), y lo editó después una persona. El encabezado no registra el historial de ediciones | DSP-001:L41 |
| MCP-P04 | La misma persona (ianache) figura como autora y aprobadora del RCP y del DSP, y como titular por defecto del rol de PO. No hay evidencia de separación de funciones | RCP-001:L541, DSP-001:L45, RCP-001:L502 |
| MCP-P05 | B3, B4 y B5 se cierran por decisión del PO sin evidencia dentro de las fuentes autorizadas. B3 lo declara sin revisión de un arquitecto | DSP-001:L209, DSP-001:L210, DSP-001:L211 |
| MCP-P06 | La comprobación en GitLab es evidencia de ejecución del 2026-10-11, no una fuente autorizada | MCP-F24 a MCP-F26 |

## 10. Evaluación de gobierno

| Criterio del flujo de gobierno | Resultado | Evidencia |
|---|---|---|
| Leer DSP, alcance, exclusiones, riesgos y decisiones | Cumplido | MCP-F01 a MCP-F13 |
| Validar `project_id` | **Cumplido**: 605 registrado y existente | MCP-F20, MCP-F24 |
| Validar el Project Issue con label `Proyecto` | **Cumplido**: Issue #14 (`issue_id` 52819) existe con el label | MCP-F28 |
| Validar `issue_id`, `issue_iid` y relación bidireccional | **Cumplido**: `issue_id` 52819, `issue_iid` 14, y el DSP y el Issue se referencian | MCP-F28, MCP-F29 |
| Separar hechos, supuestos, preguntas y bloqueos | Cumplido en este Pack | Secciones 2 a 7 |
| Detectar deriva entre DSP, RCP, SSP, US-* e Issues | **Parcial**: DSP y RCP coinciden en las decisiones. No hay SSP ni Issues. Las historias no se leyeron | MCP-F13, MCP-C02, MCP-G08 |
| Coherencia interna del DSP | **Casi cumplido**: queda un texto residual | MCP-C01 |
| Aprobación humana del DSP | **Cumplida**, con excepciones registradas | MCP-F02, MCP-F03 |
| Cambios como propuesta, no aplicados | Cumplido: el Pack no aplicó ningún cambio | — |

**Veredicto:** `CONDITIONAL`.
- **Sprint Selection:** puede continuar. El PO aprobó el DSP y cerró sus bloqueos, con excepciones documentadas.
- **Preparación de un SSP:** falta el Project Issue (MCP-B6) y el equipo, la capacidad y las estimaciones (MCP-B7). Los cierres no verificables de B3, B4 y B5 son riesgos que el PO aceptó; conviene que Arquitectura los revise.

## 11. Qué debe resolverse antes de preparar un SSP

1. ~~**MCP-B6:** crear el Project Issue~~ **Hecho:** Issue #14 creado y registrado en el DSP.
2. ~~**Q-05:** confirmar el proyecto 605~~ **Hecho:** confirmado.
3. **MCP-B7:** definir el equipo de desarrollo y QA, la capacidad, la duración del Sprint, los criterios de selección y las estimaciones.
4. **Q-01 a Q-03:** hacer verificables los cierres de B3, B4 y B5 (enlazar la evidencia, completar usuarios concurrentes y crecimiento) y pedir la revisión de un arquitecto.
5. **MCP-C01 y MCP-C02:** limpiar el texto residual del DSP y actualizar el número de criterios si las historias cambiaron.
6. **MCP-G10:** publicar los archivos de P3M en el repositorio si se quieren URL completas.

## 12. Preguntas que requieren revisión humana

| ID | Pregunta | Responsable | Bloquea |
|---|---|---|---|
| Q-01 | ¿Dónde están registradas las decisiones de ADR-P1, P2, P3, P5, P6, P7, P9 e INF-Q01 y los objetivos de B4, para enlazarlos como evidencia? | Arquitectura y gestión | DSP-B3, DSP-B4 (verificación) |
| Q-02 | ¿Quién es el arquitecto que revisa las decisiones que se tomaron sin revisión? | Arquitectura | DSP-B3 |
| Q-03 | ¿Cuáles son los usuarios concurrentes y el crecimiento esperado? | Responsable funcional | DSP-B4 |
| Q-04 | ~~Crear el Project Issue~~ **Resuelta:** aprobado y creado, Issue #14 | — | — |
| Q-05 | ~~¿Es el proyecto 605 el destino correcto?~~ **Resuelta:** sí, confirmado por el responsable | — | — |
| Q-06 | ¿Quién es el equipo o proveedor de desarrollo y QA, con qué capacidad y duración de Sprint, y quién prepara el SSP? | PO y gestión | MCP-B7 |
| Q-07 | ¿Cuál es el alcance del primer Sprint: todo el DSP o parte por olas? | PO | MCP-S01 |
| Q-08 | ¿La preparación de los microservicios para otras aplicaciones (D-123) está dentro del alcance del DSP? | PO | MCP-G09 |
| Q-09 | ¿Se actualiza el DSP con el número actual de criterios y se limpia el texto de «Estado del alcance»? | Gestión | MCP-C01, MCP-C02 |
| Q-10 | ¿Se autoriza leer las historias y los catálogos de arquitectura para verificar B3, B4, B5 y el número de criterios? | Gestión | MCP-G08 |
| Q-11 | ¿Se publican los archivos de P3M en el repositorio del proyecto 605 y en qué ruta? | Gestión del conocimiento | MCP-G10 |

## 13. Preparación

- **Estado del Pack:** `REQUIRES_REVIEW`. Es una observación derivada de dos fuentes y una comprobación de solo lectura, sin revisión humana (`human-reviewed: false`).
- **Estado de gobierno de DSP-001:** `CONDITIONAL`.
- **Siguiente skill:** `sprint-scope-and-milestone` puede activarse cuando se defina el equipo, la capacidad y los criterios de selección (MCP-B7). El Project Issue y el `project_id` ya existen.
- **Mutaciones de GitLab ejecutadas con aprobación:** creación del Project Issue [#14](https://project.comsatel.com.pe/comsatel/development/training/dev-juniors/-/issues/14). No hay mutaciones pendientes.
