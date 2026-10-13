---
type: Physical Database Pack
title: "PDM-001 — Modelo físico MySQL 8.x y plan Flyway del P3M"
description: "Diseño físico en MySQL 8.x: un esquema por contexto, DDL InnoDB utf8mb4, claves, índices, restricciones, permisos, plan de migraciones Flyway, verificaciones previas y posteriores, y estrategia de despliegue."
tags: [database, mysql, flyway, physical-model]
status: draft
gate: PHYSICAL_MODEL_READY
gate-result: PASSED
human-reviewed: true
reviewed-by: "ianache (responsable funcional), 2026-10-11, en sesión: D-H26..D-H29; 2026-10-12: aprobó el diseño (D-H36)"
generated:
  by: "physical-database-designer"
  at: "2026-10-11T22:00:00-05:00"
plan-step: S5 (WP-DB-001)
predecessors: [LDM-001 (LOGICAL_MODEL_READY = PASSED), ICP-001 (INTEGRATION_CONTRACT_READY = PASSED)]
sources:
  - id: ldm-001
    resource: /data/LDM-001-modelo-logico.md
  - id: icp-001
    resource: /data/ICP-001-contratos-de-integracion.md
  - id: adr-db-003
    resource: /architecture/adr/ADR-DB-003.md
  - id: adr-05
    resource: /architecture/adr/ADR-05-mysql-8-x-como-base-de-datos.md
  - id: adr-p6
    resource: /architecture/adr/ADR-P6-historial-con-vigencia-y-restricciones-en-mys.md
  - id: inf-p3m-001
    resource: /deployment/INF-P3M-001-arquitectura-de-infraestructura.md
artifacts:
  - /data/flyway/p3m_partes/V1__baseline_partes.sql
  - /data/flyway/p3m_identidad/V1__baseline_identidad.sql
  - /data/flyway/p3m_curricula/V1__baseline_curricula.sql
  - /data/flyway/p3m_curricula/V2__seed_seniority_niveles.sql
  - /data/flyway/p3m_formacion/V1__baseline_formacion.sql
  - /data/flyway/p3m_progresion/V1__baseline_progresion.sql
  - /data/flyway/p3m_portafolio/V1__baseline_portafolio.sql
  - /data/flyway/p3m_gitlab/V1__baseline_gitlab.sql
  - /data/flyway/provision/00_esquemas_y_cuentas.sql
  - /data/flyway/provision/01_permisos_por_tabla.sql
  - /data/flyway/verify/preflight_postflight.sql
  - /data/flyway/verify/pruebas_restricciones.sh
  - /data/flyway/verify/ciclo_completo.sh
  - /data/flyway/verify/analisis_estatico_ddl.py
---

# PDM-001 — Modelo físico MySQL 8.x y plan Flyway

> **Objetivo físico:** MySQL 8.x con InnoDB (ADR-05, ADR-DB-003). **Validación:** los DDL se ejecutaron con Flyway real en un MySQL 8.4.11 nuevo y pasaron el postflight y las pruebas de restricciones, permisos y concurrencia (§9). Tras la revisión RPT-DDR-001 se aplicaron correcciones (D-H34) y se repitió todo desde un contenedor nuevo. **Lo que no se probó** (concurrencia, volumen, copias, alta disponibilidad) está listado en §9.

## 1. Esquemas (uno por contexto)

| Esquema | Contexto | Tablas | FK | CHECK | Migraciones |
|---|---|---|---|---|---|
| `p3m_partes` | CTX-01 | 9 | 10 | 12 | V1 |
| `p3m_identidad` | CTX-02 | 3 | 2 | 2 | V1 |
| `p3m_curricula` | CTX-03 | 8 | 8 | 6 | V1, V2 (semillas) |
| `p3m_formacion` | CTX-04 | 7 | 6 | 8 | V1 |
| `p3m_progresion` | CTX-05 | 12 | 12 | 8 | V1 |
| `p3m_portafolio` | CTX-06 | 9 | 7 | 7 | V1 |
| `p3m_gitlab` | CTX-07 | 3 | 1 | 4 | V1 |
| **Total** | | **51** | **46** | **47** | |

**Ninguna clave foránea cruza esquemas** (ADR-DB-002). Cada esquema tiene su propio historial de Flyway y puede migrarse de forma independiente. Esto permite que cada microservicio sea dueño de su persistencia (INF-DEC-15).

## 2. Decisiones de diseño físico

| ID | Decisión | Motivo |
|---|---|---|
| F-01 | Claves sustitutas `BIGINT UNSIGNED AUTO_INCREMENT` | Índice agrupado compacto y secuencial en InnoDB. Los identificadores no tienen significado de negocio (LDM-001 §1). **Alternativa:** UUID v7 en `BINARY(16)`, si se quisiera impedir la enumeración de identificadores desde el API Gateway |
| F-02 | Las réplicas de GitLab usan como clave el **id global de GitLab** (`gitlab_milestone_id`, `gitlab_issue_id`), no la clave compuesta (proyecto, id) de LDM-001 | El id global es único en la instancia. Permite que `milestone_ref` sea una sola columna y la FK `replica_issue → replica_milestone` simple. Solo se replican issues con label `UserStory` o `Task` |
| F-03 | Enumeraciones como `VARCHAR` + `CHECK`, no `ENUM` | Añadir un valor con `ENUM` obliga a reconstruir la tabla; un `CHECK` se cambia con una migración corta. No se usa comportamiento propio del motor para ocultar reglas |
| F-04 | Tiempos en `DATETIME(3)` y UTC; fechas de negocio en `DATE`. Sin columnas de auditoría técnica | `registrada_en`, `emitida_en` y similares ya son datos de negocio. La zona horaria del servidor debe ser `+00:00` (preflight P2). La auditoría puede añadirse después con una migración de expansión |
| F-05 | Charset y collation explícitos: tablas `utf8mb4` / `utf8mb4_0900_ai_ci`; `issue_url` y `web_url` con `utf8mb4_bin`; GUID de Keycloak en `ascii_bin` | ADR-DB-003. El GUID y las URL distinguen mayúsculas |
| F-06 | «Una sola vigente»: columna generada `VIRTUAL` (nula si hay `vigente_hasta`) + índice **único** | ADR-P6. MySQL ignora los nulos en un índice único, así que solo cuenta la fila vigente. Sin triggers |
| F-07 | Tipado de partes y relaciones con **FK compuesta** a `parte(id, tipo_parte)` y columnas `tipo_parte` / `origen_tipo_parte` / `destino_tipo_parte` | Hace cumplir INV-01 y K-03 en la base. Son columnas físicas que no están en LDM-001 |
| F-08 | `web_url_sha256` (columna generada `STORED`, `BINARY(32)`) con índice único | Permite que CON-10 busque por URL completa sin indexar 2048 caracteres |
| F-09 | Tabla técnica `outbox_evento` en `p3m_progresion` | La exige ICP-001 (EVT-01, P-7). No existe en LDM-001. Sin borrado: permite republicar |
| F-10 | Columna `promocion_de_nivel.decidida_en` | La necesita EVT-01 para ordenar y firmar el evento. No estaba en LDM-001 |
| F-11 | Sin particionado, sin réplicas de lectura, sin índices especulativos | El volumen estimado es pequeño (ver §8) |
| F-12 | `costo_estimado` `DECIMAL(14,2)` en **soles peruanos (PEN)** y `esfuerzo_estimado` `DECIMAL(10,2)` en **horas-persona** (D-H26), con `COMMENT` en la columna | Decisión del responsable (DEC-F03) |
| F-13 | La nota mínima 12 no se almacena (D-H25) | Es informativa |
| F-14 | `competencia.es_general` es `TINYINT` + `CHECK (0, 1)`, sin ancho de visualización | MySQL 8.4 avisa de que `TINYINT(1)` está obsoleto. Hallazgo de la ejecución real **Aprobada caso por caso el 2026-10-12 (D-H37).** |
| F-15 | Tabla `colaborador_carga` (fila de bloqueo por colaborador) en `p3m_portafolio` y protocolo K-47 | R-02: con solo `SELECT … FOR UPDATE` sobre `asignacion`, dos primeras asignaciones sumaban 120 % con `READ COMMITTED`. Con la fila de bloqueo la regla se cumple con ambos niveles de aislamiento y sin interbloqueos (probado con la cuenta real) **Aprobada caso por caso el 2026-10-12 (D-H37).** La base no obliga al protocolo: un único punto del servicio debe crear asignaciones y la prueba de concurrencia debe correr en el pipeline. |
| F-16 | Tabla `correccion_de_vinculo` (solo inserción) y permisos **por columna** sobre `usuario`: `svc_identidad` no puede actualizar `persona_ref`; solo `svc_identidad_correccion` | R-01 (acciones b y c): vínculo inmutable para el servicio y corrección manual con registro de quién y cuándo. Añade una cuenta de servicio **Aprobada caso por caso el 2026-10-12 (D-H37).** |
| F-17 | `dato_de_contacto` gana `vigente_hasta` y `baja_por_ref`; el correo único (K-43) se limita a los **vigentes** | R-01 (acción c): permite reutilizar una dirección sin borrar datos personales (D-H1). Registrado como regla de negocio **BR-130** (D-159) y reflejado en IMD-001 **Aprobada caso por caso el 2026-10-12 (D-H37).** K-01 (al menos un correo y un teléfono vigentes) lo garantiza el servicio. |
| F-18 | Los `V1` de `p3m_partes`, `p3m_identidad` y `p3m_portafolio` se modificaron en lugar de añadir `V2` | Ningún ambiente tiene aplicado el `V1` anterior (solo contenedores de prueba desechables). Una vez desplegado el primero, esto ya no puede hacerse (regla de inmutabilidad, §6) **Aprobada caso por caso el 2026-10-12 (D-H37).** La premisa «ningún ambiente aplicó el `V1` anterior» no fue confirmada expresamente; si algún ambiente lo aplicó, se añade una `V2` por esquema. |
| F-19 | `dato_de_contacto` pertenece a la **parte**: columnas `parte_id` y `tipo_parte`, con FK compuesta a `parte(id, tipo_parte)`. El correo único (K-43) se aplica solo a los contactos de personas | D-160 (BR-131): toda parte tiene contactos. `tipo_parte` permite que la base distinga personas de organizaciones sin tabla extra. Se modificó el `V1` de `p3m_partes` por la misma razón que en F-18. **Confirmada por ianache el 2026-10-12.** El correo vigente es único entre todas las partes (D-162, BR-133): se quitó la condición de persona de la columna `correo_unico` |
| F-20 | `ck_usuario_rol` acepta `JEFE_INGENIERIA` en lugar de `JEFE_DE_INGENIERIA` | D-164: el responsable fijó los nombres de rol de Keycloak. Se modificó el `V1` de `p3m_identidad` con la misma premisa de F-18 (ningún entorno aplicó la versión anterior). **Confirmada por ianache el 2026-10-12.** |

## 3. Cumplimiento de las restricciones lógicas (K-xx)

Garantizadas **en la base**: K-02/K-03 (relación, tipos), K-04, K-05, K-06, K-08 (vigencias), K-14, K-15, K-17, K-19, K-21, K-22, K-24, K-26, K-27, K-28, K-29, K-30, K-32, K-36, K-38, K-40, K-41, K-42, K-43 (correo vigente único), K-44 (baja de contacto con responsable), K-10 y los CHECK de dominio.
Garantizadas **por permisos**: K-25 (sin UPDATE ni DELETE en cinco tablas, incluida `correccion_de_vinculo`), K-35 (sin DELETE en `carga_de_gitlab`), K-45 (`persona_ref` solo lo cambia la cuenta de corrección, con permisos por columna).
Garantizadas **por el servicio** (el DDL solo da el soporte): K-01 (correo y teléfono), K-07 (sin solapes de rol), K-09, K-12, K-13, K-16, K-18 (cupo, con bloqueo de la edición), K-20 (CON-06), K-23 (CON-10), K-31 y K-47 (suma ≤ 100 con el protocolo de `colaborador_carga`), K-33, K-34, K-37.

## 4. Índices (basados en las consultas de ICP-001 y las restricciones)

| Consulta o restricción | Índice |
|---|---|
| CON-01 rol vigente de una persona | `ix_rol_de_la_parte_persona (persona_id, tipo_rol, vigente_hasta)` |
| CON-02 rol/nivel vigente de una persona | `ix_ocupacion_persona (persona_id, vigente_hasta)` + `uq_plaza_rol_nivel_vigente` |
| CON-07 nivel actual de una competencia | `ix_valoracion_registro_reciente (valoracion_id, registrada_en)` |
| CON-06 evidencias validadas de un enrolamiento | `uq_evidencia_esperada_enrolamiento (enrolamiento_ref, evidencia_esperada_ref)` |
| CON-09 jefe vigente | `ix_jefatura_colaborador (colaborador_ref, vigente_hasta)` y `uq_jefatura_vigente` |
| CON-10 issue por URL | `uq_replica_issue_url (web_url_sha256)` |
| K-18 cupo | `ix_enrolamiento_edicion_estado (edicion_id, estado)` |
| K-31 suma de dedicación | `ix_asignacion_colaborador (colaborador_ref, vigente_hasta)` |
| Carga «datos al …» (BR-092) | `ix_carga_estado (estado, iniciada_en)` |
| Claves foráneas | MySQL crea el índice de cada FK si falta |

Los demás índices de los DDL son de claves únicas o de FK. **No se añade ninguno por conjetura** hasta tener volumen y planes de ejecución reales.

## 5. Seguridad

| Aspecto | Diseño |
|---|---|
| Cuentas | `flyway_<ctx>` (solo migraciones, `cleanDisabled=true`) y `svc_<ctx>` (DML de su esquema). En `p3m_gitlab` hay además `svc_gitlab_carga` (único que escribe las réplicas, K-37). En `p3m_identidad` hay además `svc_identidad_correccion` (único que cambia `persona_ref` y registra correcciones, K-45); `svc_identidad` solo actualiza `username` y `correo` |
| Permisos | Por tabla. Sin `DELETE` salvo en `rol_competencia`, `rol_nivel_competencia_minimo`, `proyecto_milestone`, `proyecto_rol_nivel_requerido`, `usuario_rol_de_usuario`. Cuatro tablas de solo inserción (K-25). Ningún acceso entre esquemas |
| Cifrado en tránsito | `REQUIRE SSL` en todas las cuentas (INF-DEC-07) |
| Cifrado en reposo | De almacenamiento, por infraestructura (INF-DEC-09) |
| Secretos | Contraseñas en Vault (`secret/p3m/*`, ADR-12); los scripts de aprovisionamiento usan marcadores |
| Aprovisionamiento | **En dos pasos**: `00_esquemas_y_cuentas.sql` antes de migrar y `01_permisos_por_tabla.sql` después (MySQL exige que la tabla exista para darle permisos). El segundo es idempotente y se repite tras cada migración que añada tablas. Una tabla sin permiso explícito queda inaccesible para el servicio |
| Datos personales | **Deuda técnica DT-01** (D-H24, confirmada en D-H35; aceptada por Seguridad según ianache el 2026-10-12, D-H40): sin clasificación, cifrado de columna ni borrado. Las columnas afectadas están en LDM-001 §4 y se retoman con una migración nueva |

## 6. Plan de migraciones Flyway

**Configuración por esquema:** `locations=filesystem:flyway/<esquema>`, conexión cifrada (con el driver MariaDB 2.7 de la imagen oficial de Flyway: `useSsl=true`), `schemas=<esquema>`, `defaultSchema=<esquema>`, `validateOnMigrate=true`, `cleanDisabled=true`, `outOfOrder=false`, `baselineOnMigrate=false`, `table=flyway_schema_history`. El usuario es `flyway_<ctx>`.

**Secuencia de despliegue:** (1) `00_esquemas_y_cuentas.sql`; (2) `flyway migrate` por esquema con la cuenta `flyway_<ctx>`; (3) `01_permisos_por_tabla.sql`; (4) postflight. **Orden entre esquemas:** no dependen entre sí; puede migrarse en cualquier orden o en paralelo. Orden sugerido: `p3m_curricula`, `p3m_partes`, `p3m_identidad`, `p3m_formacion`, `p3m_progresion`, `p3m_portafolio`, `p3m_gitlab`. Dentro de un esquema, las versiones son consecutivas y deterministas.

**Checksums esperados** (CRC32 del contenido por líneas, el algoritmo de Flyway. **Confirmados contra `flyway_schema_history.checksum`** en la ejecución real de §9: los ocho coinciden):

| Migración | Checksum esperado |
|---|---|
| p3m_curricula `V1__baseline_curricula.sql` | 641202384 |
| p3m_curricula `V2__seed_seniority_niveles.sql` | -75542515 |
| p3m_formacion `V1__baseline_formacion.sql` | 1941176407 |
| p3m_gitlab `V1__baseline_gitlab.sql` | 1057650316 |
| p3m_identidad `V1__baseline_identidad.sql` | 1916221164 |
| p3m_partes `V1__baseline_partes.sql` | 1242511565 |
| p3m_portafolio `V1__baseline_portafolio.sql` | -1868510700 |
| p3m_progresion `V1__baseline_progresion.sql` | -1388612769 |

**Regla de inmutabilidad:** una migración aplicada no se edita; cualquier cambio es una versión nueva. `validateOnMigrate` detiene el despliegue si un checksum cambia.

**Verificaciones:** `flyway/verify/preflight_postflight.sql`. Preflight: versión 8.x (mínimo 8.0.16), modo estricto, charset del servidor, zona horaria UTC, usuario con SSL. Postflight: motor y collation, número de tablas, ausencia de FK entre esquemas, FK `RESTRICT`, CHECK aplicados, índices únicos de «una sola vigente», estado de las migraciones, semillas y permisos.

**Estrategia de despliegue y reversa**

| Situación | Estrategia |
|---|---|
| Primer despliegue (V1, sin datos) | Si falla, **MySQL no revierte el DDL** (confirma implícitamente cada sentencia). En ambientes no productivos: eliminar el esquema y repetir. En producción: **forward-fix** con una migración correctiva tras `flyway repair` |
| V2 de `p3m_curricula` (semillas) | Forward-fix: una migración nueva que corrija las filas |
| Cambios posteriores no destructivos | **Expand**: añadir columna o tabla nula y desplegar el código que la usa |
| Cambios destructivos (borrar o renombrar columnas o tablas) | **No se hacen sin una ruta aprobada**: expand → migrar datos → cambiar el código → **contract** en un despliegue posterior, con copia de seguridad verificada (ADR-DB-003) |
| Reversa de datos | **No se promete.** Los datos de negocio no se borran (D-H1); tras la primera carga de datos, la recuperación es desde copia (INF-DEC-10), no una migración inversa |

**Observabilidad:** `flyway_schema_history` por esquema (versión, duración, éxito, checksum); alertar si `success = 0`; exponer la versión del esquema en el estado de salud de cada servicio; ejecutar el postflight en el pipeline y registrar su resultado.

## 7. Resultados esperados del postflight

| Esquema | Tablas | CHECK |
|---|---|---|
| p3m_partes | 9 | 12 |
| p3m_identidad | 3 | 2 |
| p3m_curricula | 8 | 6 |
| p3m_formacion | 7 | 8 |
| p3m_progresion | 12 | 8 |
| p3m_portafolio | 9 | 7 |
| p3m_gitlab | 3 | 4 |

Semillas: 3 seniority y 12 niveles de desarrollo. FK entre esquemas: 0.

## 8. Evidencia de carga de trabajo (parcial)

**Corrección (2026-10-12).** La primera versión de este apartado decía que no había volúmenes, RPO ni RTO. Era incorrecto: INF-Q02 de INF-P3M-001 (respondida el 2026-10-10) fija **disponibilidad 99,9 %, RTO 4 horas y RPO 1 hora, con respaldos de MySQL cada hora**, e INF-Q03 (parcial) indica **más de 50 colaboradores**. Otras partes de INF-P3M-001 siguen diciendo `UNKNOWN` (secciones 4, 7.3, 7.4, 12 y 14), de modo que ese documento se contradecía. **Corregido el 2026-10-12 en INF-P3M-001 0.1.2** (INF-DEC-23, dos clases de falla).

| Dato | Valor | Fuente |
|---|---|---|
| Disponibilidad, RTO y RPO | 99,9 % (unos 43,8 min al mes), 4 h y 1 h con respaldos horarios | INF-Q02 |
| Colaboradores | Más de 50 | INF-Q03 (parcial) |
| Logs de carga de GitLab | **Estimación mía:** una carga cada 30 s por defecto (BR-039), cada ejecución deja un registro, incluidas las «sin cambios» (BR-094), y se retienen por siempre (BR-090). Son unas 2 880 filas al día, **alrededor de 1,05 millones al año**, del orden de 100 a 150 MB al año con sus índices. Es manejable sin particionado | BR-039, BR-090, BR-094 (cálculo) |
| Sigue `UNKNOWN` | Usuarios concurrentes, volumen de issues y su crecimiento, IOPS, modo de alta disponibilidad de MySQL (INF-DEC-11), plataforma de contenedores (ADR-P7) | INF-P3M-001 |

**Una inconsistencia que afecta a la base de datos.** INF-P3M-001 R-01 advierte que un solo incidente de 4 h excede el presupuesto mensual de 43,8 min de una disponibilidad del 99,9 %. Con un RTO de 4 h, restaurar desde una copia no cumple el 99,9 %: la conmutación a una réplica (INF-DEC-11) debe completarse en minutos. Los respaldos horarios cumplen el RPO de 1 h, pero **no se verificó el diseño de recuperación contra esos valores**.

Con este volumen el diseño no necesita particionado ni ajuste especial. Los índices siguen limitados a las restricciones y a las consultas de ICP-001.

## 9. Validación realizada

**Entorno:** contenedor desechable `mysql:8.4` (MySQL 8.4.11, `sql_mode` estricto, zona `+00:00`, `utf8mb4_0900_ai_ci`) y la imagen `flyway/flyway:10` en Docker Desktop, en tu máquina. Las pruebas finales se hicieron desde un contenedor **nuevo** y con los scripts finales (`flyway/verify/ciclo_completo.sh`). El contenedor se eliminó después.

| Comprobación | Resultado |
|---|---|
| Análisis estático (sintaxis con `sqlglot`, claves, tipos, esquemas) | Pasa: 51 tablas, 46 FK, 0 FK entre esquemas |
| Paso 1 (cuentas), 8 migraciones con Flyway real y cuentas `flyway_<ctx>` sobre SSL, paso 2 (permisos) | Pasan. El paso 2 es idempotente. Sin avisos |
| Postflight (tablas, motor y collation, FK `RESTRICT`, CHECK, únicos de «una sola vigente», semillas, migraciones fallidas, permisos fuera de política, permisos por columna de `persona_ref`, tablas sin permiso) | **48 de 48 comprobaciones correctas**, con los valores de §7 |
| Checksums de Flyway frente a los calculados | Los 8 coinciden |
| Pruebas de restricciones | **115 de 115** (96 originales y 15 nuevas: baja de contactos, reutilización de correo, evento obsoleto, corrección de vínculo, fila de bloqueo). Ningún rechazo fue por error de sintaxis |
| Pruebas de permisos y SSL | **18 de 18**: sin UPDATE ni DELETE donde no corresponde, sin acceso entre esquemas, la réplica solo la escribe `svc_gitlab_carga`, `persona_ref` solo lo cambia la cuenta de corrección, sin conexión sin SSL |
| Concurrencia de K-31 con la cuenta real `svc_portafolio` y el protocolo K-47 (dos primeras asignaciones de 60 % simultáneas) | **Correcta con `READ COMMITTED` y con `REPEATABLE READ`**: suma final 60 %, sin interbloqueos. Corrige el defecto R-02 |

**Defectos que la ejecución real encontró y se corrigieron**

| # | Defecto | Corrección |
|---|---|---|
| 1 | El script de permisos fallaba en una instalación nueva: MySQL exige que la tabla exista para darle permisos | Se dividió en `00_esquemas_y_cuentas` (antes) y `01_permisos_por_tabla` (después) |
| 2 | `TINYINT(1)` produce un aviso de ancho de visualización obsoleto | `TINYINT` + `CHECK` (F-14) |
| 3 | El checksum de portafolio estaba desfasado tras aplicar DEC-F03 | Recalculado |
| 4 | La revisión (RPT-DDR-001) probó que K-31 con solo `SELECT … FOR UPDATE` suma 120 % con `READ COMMITTED` | Fila de bloqueo por colaborador (F-15, K-47) |

**Lo que NO se probó**

| Aspecto | Motivo |
|---|---|
| Concurrencia: K-31 (suma ≤ 100 % con `SELECT … FOR UPDATE`) y K-18 (cupo) | Son lógica del servicio; no se probaron bloqueos con transacciones simultáneas |
| Rendimiento y planes de ejecución | No hay datos reales; el volumen estimado es pequeño (§8) |
| Copias de seguridad, restauración, alta disponibilidad y replicación | Son de infraestructura (INF-DEC-10, INF-DEC-11) |
| Versiones de MySQL distintas de 8.4.11 (por ejemplo el mínimo 8.0.16) | Solo se probó una versión |
| Certificados TLS reales | El contenedor usa el certificado autogenerado y el cliente no verifica el servidor |
| Las restricciones que garantiza el servicio (K-01, K-07, K-09, K-12, K-13, K-16, K-20, K-23, K-33, K-34) | No son de la base |
| Actualización desde una versión anterior (solo hay `V1`) | No existe una versión previa |

Docker Desktop quedó **en marcha** tras iniciarlo yo. Las imágenes `mysql:8.4` y `flyway/flyway:10` siguen descargadas.

## 10. Decisiones

### Registradas (ianache, 2026-10-11, en sesión)

| ID | Decisión | Efecto |
|---|---|---|
| D-H26 | **DEC-F03:** el costo del proyecto está en soles peruanos (PEN) y el esfuerzo en horas-persona | F-12, `COMMENT` en las columnas |
| D-H27 | **DEC-F01:** se aceptan las decisiones de diseño físico F-01 a F-13 | §2 queda fijado (F-14 es posterior y se informa aquí) |
| D-H28 | **DEC-F04:** se confirma la política de permisos de §5, con DELETE en cinco tablas | §5 |
| — | **DEC-F02:** autorización de ejecutar los DDL en un contenedor `mysql:8.4` desechable | Ejecutada en §9 |

| D-H29 | **DEC-F05:** se acepta diseñar sin evidencia de carga de trabajo, con dos condiciones de revisión: revisar los índices con el registro de consultas lentas tras las primeras semanas con datos reales, y definir volumen, RPO y RTO antes de producción | §8, DT-02 |
| D-H34 | **Correcciones de la revisión:** se aplican R-02, R-04, R-07 y R-01 (acciones b y c) | F-15 a F-18, K-44 a K-47, CON-13 (ICP-001) |
| D-H36 | **Aprobación del diseño** (ianache, 2026-10-12): aprueba DDP-001, DDM-001, LDM-001, ICP-001, PDM-001 y los scripts de `flyway/`, lo que confirma F-14 a F-18. No verifica IMD-001, BRC-001, RCP-001 ni las historias, ni sustituye la aceptación de Seguridad sobre DT-01 ni cierra R-10 | RPT-DDR-001 §1 |
| D-H37 | **Aprobación caso por caso de F-14 a F-18** (ianache, 2026-10-12), tras revisar el código y las consecuencias de cada una | §2 |
| D-H38 | **INF-P3M-001, opción A** (ianache, 2026-10-12): dos clases de falla. El 99,9 % rige las fallas normales y el RTO 4 h y RPO 1 h rigen el desastre. Exige una réplica de MySQL con conmutación automática y replicación semisíncrona o de grupo | INF-DEC-23, INF-DEC-11 |
| D-H39 | **R-10 aceptado como riesgo residual** (ianache, 2026-10-12): el diseño de recuperación no está verificado con una conmutación ni una restauración de prueba. Queda como deuda técnica DT-04 | RPT-DDR-001 R-10 |
| D-H40 | **Seguridad acepta el aplazamiento de DT-01** (declarado por ianache, 2026-10-12). No consta el nombre del aceptante ni una referencia; se recomienda adjuntarlos. ADR-P4 sigue pendiente | DT-01, RPT-DDR-001 R-05 |
| D-H41 | **Verificación aprobada por ianache** (2026-10-12) de IMD-001, BRC-001, RCP-001 y las historias US-004, US-009, US-010, US-019, US-021 y US-025 | RPT-DDR-001 |
| D-H42 | **ADR aprobados por ianache** (2026-10-12): ADR-P2, ADR-P3, ADR-P6, ADR-P7, ADR-P9, ADR-DB-001, ADR-DB-002 y ADR-DB-003. ADR-P5 queda en revisión; ADR-P4 sigue pendiente | CAT-ADR-001 |
| D-H43 | **R-10 (recuperación sin verificar) confirmado como deuda técnica DT-04** (ianache, 2026-10-12) | WP-DB-001 §4.1 |
| D-H44 | **Toda parte, persona u organización, tiene datos de contacto** (ianache, 2026-10-12). Reemplaza D-150 y la hipótesis S-07 | F-19, BR-131 |
| D-H45 | **F-19 confirmada. Correo, teléfono y dirección para las organizaciones, con correo y teléfono obligatorios, y correo único entre todas las partes** (ianache, 2026-10-12). Cambia K-43 | F-19, BR-132, BR-133 |
| D-H46 | **ADR-P5 aprobada** con D1 = A, D2 conforme, D3 = mantener BR-003 (riesgo en DT-01), nombres de rol ADMIN, COLABORADOR, INSTRUCTOR y JEFE_INGENIERIA, ADMIN suple las seis capacidades exclusivas del Jefe de Ingeniería y mantenimiento de las funcionalidades de las partes por Jefe de Ingeniería y ADMIN (ianache, 2026-10-12). Cambia F-20 | F-20, BR-134, BR-135 |
| D-H47 | **F-20 confirmada**; los nombres de rol de Keycloak (ADMIN, COLABORADOR, INSTRUCTOR, JEFE_INGENIERIA) ya están definidos; se actualizan las nueve historias desfasadas respecto de BR-134; se verifican RCP-001, BRC-001 e IMD-001 (ianache, 2026-10-12) | F-20, BR-134 |

### Pendiente

| ID | Pregunta | Recomendación |
|---|---|---|
**Confirmadas por la aprobación del diseño (D-H36, 2026-10-12), F-14 a F-18:** F-17 (baja de contactos) ya está registrado como BR-130 (D-159). F-14 a F-16 y F-18 son decisiones de diseño físico, confirmadas con la aprobación. Las dos condiciones de D-H29 quedan como deuda técnica DT-02.

**Deuda y pendientes:** DT-01 (datos personales, D-H24); DT-03 (réplica de GitLab sin esfuerzo ni fecha de vencimiento y sin issues «Proyecto», D-H32); volumen real y modo de alta disponibilidad (infraestructura); verificar el diseño de recuperación contra RPO 1 h, RTO 4 h y 99,9 % (DT-04, riesgo residual aceptado en D-H39); parámetros operativos de ICP-001 §6; US-025-Q1; probar la concurrencia de K-31 y K-18 cuando exista el servicio.

## 11. Estado del gate

`PHYSICAL_MODEL_READY` = **PASSED**, por decisión de ianache (2026-10-11).

| Requisito del gate | Estado |
|---|---|
| Ambos predecesores | Cumplido (LDM-001 y ICP-001 en PASSED) |
| Destino MySQL 8.x | Cumplido (ADR-DB-003), probado en 8.4.11 |
| Decisiones de DDL completas | Cumplido: 51 tablas; F-01 a F-13 aceptadas (D-H27); F-14 a F-18 posteriores, pendientes de tu confirmación (§10) |
| Seguridad y operabilidad | Cumplido en el diseño y probado (permisos, SSL); DT-01 diferida por decisión |
| Secuencia de migraciones | Cumplido y probada con Flyway real |
| Estrategia de despliegue segura | Cumplido (§6) |
| Evidencia de migración | Cumplido (§9) |
| Evidencia de carga de trabajo | **Parcial** (§8): RPO, RTO, disponibilidad y más de 50 colaboradores. La ausencia del resto fue aceptada por una persona (D-H29) con condiciones de revisión (DT-02) |
