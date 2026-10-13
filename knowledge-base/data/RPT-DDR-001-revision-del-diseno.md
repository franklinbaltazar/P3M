---
type: Database Design Review Report
title: "RPT-DDR-001 — Revisión del diseño de base de datos del P3M"
description: "Revisión de linaje, invariantes, consistencia, contratos, seguridad, concurrencia, migraciones y operación del diseño de base de datos (DDP-001 a PDM-001), con hallazgos por artefacto, decisión de gate y riesgo residual."
tags: [database, review, security, concurrency]
status: draft
gate: DATABASE_DESIGN_APPROVED
gate-result: PASSED
human-reviewed: true
reviewed-by: "ianache (responsable funcional), 2026-10-12: aprueba el diseño con condiciones (D-H36). El 2026-10-12 adopta la opción A de INF-P3M-001 y acepta R-10 como riesgo residual; el gate DATABASE_DESIGN_APPROVED pasa a PASSED (D-H38, D-H39)"
generated:
  by: "database-design-reviewer"
  at: "2026-10-11T23:30:00-05:00"
plan-step: S6 (WP-DB-001)
reviewed-artifacts: [DDP-001, DDM-001, LDM-001, ICP-001, PDM-001, flyway/*]
sources:
  - id: wp-db-001
    resource: /data/WP-DB-001-plan-de-trabajo-diseno-bd.md
  - id: ddp-001
    resource: /data/DDP-001-descubrimiento-de-dominio.md
  - id: ddm-001
    resource: /data/DDM-001-modelo-ddd.md
  - id: ldm-001
    resource: /data/LDM-001-modelo-logico.md
  - id: icp-001
    resource: /data/ICP-001-contratos-de-integracion.md
  - id: pdm-001
    resource: /data/PDM-001-modelo-fisico-mysql.md
  - id: brc-001
    resource: /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md
  - id: adr-db-001-003
    resource: /architecture/adr/ADR-DB-001.md, ADR-DB-002.md, ADR-DB-003.md
---

# RPT-DDR-001 — Revisión del diseño de base de datos

> **Limitación de independencia.** Esta revisión la hizo el mismo agente que produjo los artefactos. Las pruebas (§2) y el cotejo de reglas (§3) son objetivos y repetibles; el juicio sobre los hallazgos no es independiente. Se recomienda que un arquitecto de datos y un responsable de seguridad confirmen los hallazgos R-01 a R-06 antes de aprobar.

## 1. Decisión del gate

`DATABASE_DESIGN_APPROVED` = **PASSED**, con riesgos residuales aceptados (§6). Antes estaba en `REQUIRES_REVIEW`; pasó a `PASSED` el 2026-10-12 por D-H38 y D-H39.

*Segunda pasada tras D-H34 (2026-10-11): R-02, R-04 y R-07 quedan **corregidos y verificados**; R-01 queda **mitigado**. R-06 queda **corregido** (decisiones registradas en RCP-001, BRC-001 e IMD-001). R-05 queda **aceptado como deuda técnica DT-01** (D-H35, 2026-10-12). Tras la aprobación del diseño (D-H36, D-H37) y la aceptación de R-10 (D-H39), el gate pasó a `PASSED` el 2026-10-12.*

*Revisión actualizada tras D-H30 y D-H31 (2026-10-11): R-01 pasa de Bloqueante a Baja, y el estado de `BLOCKED` a `REQUIRES_REVIEW`.*

| Criterio del gate | Estado |
|---|---|
| Sin hallazgo bloqueante | **Sí**, tras D-H30 y D-H31. R-01 queda como Baja (depende de la configuración de Keycloak y Active Directory). Siguen abiertos R-02 a R-07 |
| Conflicto de ADR resuelto | Sin conflicto. ADR-05, ADR-DB-001/002/003 y ADR-P2/P6/P9 son coherentes con el diseño. Todos los ADR de arquitectura siguen en `draft`, sin arquitecto |
| Trazabilidad completa | **Sí en lo registrado** (R-06 corregido). Las fuentes de negocio siguen en `draft` y sin verificación humana |
| Evidencia de riesgos operativos y de migración | Migración: **sí** (Flyway real, §2). Operación: **parcial**: RPO 1 h, RTO 4 h y 99,9 % están definidos (INF-Q02) y repartidos en dos clases de falla (INF-DEC-23), pero la conmutación y la restauración no se han probado. **Aceptado como riesgo residual** (D-H39, R-10) |

**Aprobación humana (D-H36, ianache, 2026-10-12).** El responsable funcional **aprueba el diseño** (DDP-001, DDM-001, LDM-001, ICP-001, PDM-001 y los scripts de `flyway/`). Es un acto distinto de la decisión del gate: El gate se cerró después, con la decisión de más abajo (D-H38 y D-H39).

**La aprobación no cubre:**

1. La verificación humana de IMD-001, BRC-001, RCP-001 y de las historias, que seguían en `draft` (**ianache las verificó después, el 2026-10-12, D-H41**).
2. La aceptación de Seguridad sobre DT-01 (R-05) (**Seguridad la aceptó después, según ianache, D-H40**).
3. La verificación del diseño de recuperación contra 99,9 % de disponibilidad, RTO 4 h y RPO 1 h (R-10).

**Cierre del gate (D-H38 y D-H39, ianache, 2026-10-12).** Se adopta la opción A de INF-P3M-001 (dos clases de falla, INF-DEC-23) y el responsable **acepta R-10 como riesgo residual**. El gate pasa a `PASSED`. Esto **no significa que la recuperación esté verificada**: sigue sin ejecutarse una conmutación ni una restauración de prueba, y queda como deuda técnica DT-04.

**Decisiones posteriores (2026-10-12, ianache):** D-H40, Seguridad aceptó el aplazamiento de datos personales (DT-01), sin nombre del aceptante ni referencia; D-H41, verificación aprobada de IMD-001, BRC-001, RCP-001 y de las historias US-004, US-009, US-010, US-019, US-021 y US-025; D-H42, aprobación de ADR-P2, ADR-P3, ADR-P6, ADR-P7, ADR-P9 y ADR-DB-001 a ADR-DB-003 (**no** ADR-P5); D-H43, R-10 confirmado como deuda técnica DT-04; D-H44, toda parte tiene datos de contacto (cambio del esquema F-19, confirmado por ianache y con correo único entre todas las partes, D-H45; validado por las pruebas del ciclo completo pero **no revisado** por el revisor independiente).

**Riesgos residuales aceptados:** R-10 (DT-04), R-05 (DT-01, aceptado por Seguridad según ianache, D-H40), R-03 (DT-03) y el diseño con evidencia de carga parcial (DT-02). R-02, R-04, R-06 y R-07 están corregidos y R-01 está mitigado. Quedan los hallazgos medios y bajos.

## 2. Pruebas realizadas por el revisor

| Prueba | Resultado |
|---|---|
| Migraciones con Flyway real en MySQL 8.4.11 nuevo, postflight, 96 pruebas de restricciones y 11 de permisos (PDM-001 §9) | Pasan |
| **Concurrencia de K-31** (suma de dedicación ≤ 100 %), dos sesiones simultáneas, protocolo de ADR-P6 | **Falla**, ver tabla |
| Cotejo de las 113 reglas de BRC-001 con los artefactos de diseño | 76 citadas; 37 no citadas (§3) |

**Experimento K-31** (`flyway/verify/pruebas_concurrencia_k31.sh`; dos asignaciones de 60 % a proyectos distintos para el mismo colaborador):

| Situación | `REPEATABLE READ` | `READ COMMITTED` |
|---|---|---|
| Colaborador **sin asignación vigente** (primer registro, o solo tiene finalizadas) con `SELECT … FOR UPDATE` | Una sesión **muere por interbloqueo** (error 1213); suma final 60 % | **Ambas insertan: suma 120 %, viola la regla** |
| Colaborador con una asignación vigente de 30 % | Correcto: una inserta, la otra se rechaza (90 %) | Correcto (90 %) |
| **Alternativa:** fila de bloqueo por colaborador (`colaborador_carga`) | Correcto: una inserta, la otra se rechaza (60 %), sin interbloqueo | Correcto (60 %), sin interbloqueo |

## 3. Cotejo de reglas de negocio

De 113 reglas, 76 se citan por identificador en DDM/LDM/ICP/PDM. Las 37 restantes, clasificadas:

| Grupo | Reglas | Valoración |
|---|---|---|
| Permisos y roles (capa de aplicación, ADR-P5) | BR-002, 003, 005, 006, 008, 009, 044, 055, 061, 062, 066, 069, 081 | No son de la base. Falta el mapa rol-permiso (ADR-P5) |
| Sesión y acceso seguro (BFF, Keycloak) | BR-095, 096, 098, 099, 100 | No son de la base |
| Cubiertas por una decisión, pero no citadas por ID (se crearon después del diseño) | BR-102, 106, 108, 111, 112, 113 | Cubiertas (D-H2, D-H4, D-H7, D-H13); falta la cita |
| Cubiertas por la estructura | BR-015, 016, 028, 033, 045, 052, 054, 059, 085 | Cubiertas |
| No son datos | BR-037, BR-084 | Credenciales de solo lectura de GitLab; frecuencia de la evaluación |
| **Con brecha real** | **BR-038, BR-039** | **Ver R-03** |

## 3.1 Estado de los hallazgos tras las correcciones (D-H34)

| Hallazgo | Estado | Evidencia |
|---|---|---|
| R-01 | **Mitigado** (Baja). Vínculo inmutable por permisos de columna, corrección manual con registro de quién y cuándo, baja de contactos para reutilizar un correo, requisito de despliegue declarado (D-H30, D-H31, D-H33). Falta anotar el requisito en INF-P3M-001 y la confirmación de Seguridad | 18 pruebas de permisos; 15 pruebas nuevas de restricciones |
| R-02 | **Corregido y verificado.** Tabla `colaborador_carga` y protocolo K-47 | Con la cuenta real: suma 60 % y 0 interbloqueos con `READ COMMITTED` y con `REPEATABLE READ` (antes: 120 % y un interbloqueo) |
| R-03 | **Aceptado como deuda técnica DT-03** (D-H32). Riesgo vigente | — |
| R-04 | **Corregido y verificado en SQL.** Regla K-46: un evento obsoleto no modifica la plaza y la reentrega se rechaza | 4 pruebas nuevas. La lógica del consumidor sigue siendo del servicio (no existe todavía) |
| R-05 | **Aceptado como deuda técnica DT-01** (D-H35, 2026-10-12) por el responsable funcional. Riesgo vigente. **Aceptado por Seguridad** según declaración de ianache (2026-10-12, D-H40); no consta el nombre del aceptante ni una referencia | — |
| R-06 | **Corregido** (2026-10-12). Decisiones registradas en RCP-001 (D-143 a D-159), BRC-001 (BR-114 a BR-130) e IMD-001, con tabla de equivalencias en LDM-001 §10. Las fuentes siguen en `draft` sin verificación humana | RCP-001, BRC-001, IMD-001 (`check_model.py`: 0 errores, 91 relaciones) |
| R-07 | **Corregido.** Contrato CON-13 `PersonaPorCorreo` definido; CON-12 movido a la tabla de §2.1 | ICP-001 §2.1, §10 |
| R-08 a R-13 | Sin cambios | — |

**Resuelto tras esta revisión (2026-10-12):** las fuentes de negocio y las seis historias fueron verificadas (D-H41) y Seguridad aceptó el aplazamiento de datos personales según ianache (D-H40). F-14 a F-18 del modelo físico están aprobadas (D-H36, D-H37).

## 4. Hallazgos

Severidad: **Bloqueante** (seguridad o migración insegura, `BLOCKED`), **Alta** (defecto o brecha que impide aprobar), **Media**, **Baja**. Los hallazgos de «evidencia ausente» se distinguen de los defectos de diseño.

### R-01 — Baja (era Bloqueante) — Vinculación usuario ↔ persona por correo (ICP-001 DEC-I02, LDM-001 K-43, D-H19)

- **Hallazgo original:** el diseño vincula la cuenta con la persona por el correo del token sin exigir ninguna garantía sobre ese correo. Si un usuario pudiera crear una cuenta o editar su correo, tomaría la identidad de un colaborador aún no vinculado, y el titular quedaría sin acceso (K-10: gana el primero que reclama).
- **Actualizaciones (ianache, 2026-10-11):**
  - **D-H30:** Keycloak no permite registro libre ni edición del correo (solo lectura).
  - **D-H31:** los usuarios no pueden crear cuentas. Las identidades de Keycloak vienen de su conexión con **Active Directory**, que gestiona el equipo de infraestructura. No hay casos de correos duplicados.
  - **D-H33:** no se habilitará el registro libre ni el auto-registro de cuentas, ni en la pantalla de login del portal ni en el flujo de login de Keycloak.
- **Valoración:** el escenario original no es alcanzable por un usuario final. La identidad y el correo los controla un tercero con proceso propio (infraestructura, vía Active Directory). El hallazgo baja a **Baja**.
- **Riesgos residuales (por eso no se cierra):**
  1. **Dependencia de configuración.** La protección está en Keycloak y Active Directory, no en la base. Si se habilitara el registro libre o la edición del correo, el riesgo volvería a ser Alto. El diseño no lo declara como requisito. **Actualización (D-H33):** el responsable declara que el auto-registro no se habilitará ni en el login del portal ni en el flujo de Keycloak. Queda como requisito declarado; falta anotarlo en la documentación de despliegue (INF-P3M-001) y que Seguridad lo confirme.
  2. **Cambio o reutilización de correos.** Un cambio del atributo de correo en Active Directory, o la reasignación de la dirección de alguien que dejó la empresa a otra persona, **revincularía** la cuenta a la persona equivocada, porque el vínculo no es inmutable. Y registrar a la nueva persona con esa dirección fallaría por K-43 (el correo es único entre personas y los contactos no tienen vigencia).
  3. **Falta el contrato `PersonaPorCorreo`** (R-07).
  4. Seguridad no ha confirmado la configuración; es una declaración del responsable funcional.
- **Sobre `email_verified`:** la acción que propuse antes, exigir `email_verified = true`, **se retira**. En un Keycloak federado con Active Directory ese indicador suele no estar activado, y se rechazaría a todos los usuarios. Active Directory es la fuente autoritativa del correo.
- **Acción propuesta (pendiente de aceptación):**
  - (a) Declarar como **requisito de despliegue** que Keycloak siga federado con Active Directory, sin registro libre y con el correo en solo lectura. **Aceptada en lo declarativo (D-H30, D-H31, D-H33); falta anotarla en INF-P3M-001.**
  - (b) Hacer el vínculo **único e inmutable**: se establece una vez y un cambio de correo posterior no lo rehace.
  - (c) Definir qué ocurre cuando cambia o se reutiliza un correo: la corrección la hace el Jefe de Ingeniería de forma manual, con registro de quién y cuándo.
  - (d) Que Seguridad confirme la configuración.
- **Artefactos:** ICP-001 (§2.3, §10), LDM-001 (K-10, K-43), PDM-001.

### R-02 — Alta — K-31 no es seguro con el protocolo de ADR-P6 (PDM-001 §3, LDM-001 K-31, ADR-P6)

- **Evidencia:** experimento de §2: con `READ COMMITTED` y sin asignación vigente, **dos asignaciones simultáneas suman 120 %**; con `REPEATABLE READ` una muere por interbloqueo. Ningún artefacto fija el nivel de aislamiento. ASR-10 exige garantizar la regla.
- **Impacto:** sobreasignación de colaboradores (BR-093, ASR-10) según la configuración del marco de acceso a datos, sin aviso.
- **Acción:** añadir a LDM-001 y a `p3m_portafolio` una tabla `colaborador_carga (colaborador_ref PK)`; antes de sumar, `INSERT IGNORE` y `SELECT … FOR UPDATE` sobre esa fila. Fijar el protocolo en ICP/PDM y reintentar ante el error 1213. Incluir el experimento en el pipeline.
- **Artefactos:** LDM-001 (K-31), PDM-001 (§3, §4), ADR-P6.

### R-03 — Alta, aceptada como deuda técnica DT-03 (D-H32) — La réplica de GitLab no guarda lo que exige BR-038 y rechaza los issues «Proyecto» de BR-039 (LDM-001 §2.7, PDM-001 `p3m_gitlab`)

- **Decisión (ianache, 2026-10-11, D-H32):** se marca como **deuda técnica DT-03**. El responsable aún no ha decidido cómo se tratarán los issues «Proyecto». Una decisión nombrada cierra el hallazgo como aceptado, no como resuelto: el riesgo sigue vigente.
- **Qué queda sin resolver:** (1) el tratamiento de los issues «Proyecto» (BR-039 frente a BR-020); (2) las columnas que BR-038 exige mostrar y que la réplica no guarda. Se interpretó que el aplazamiento cubre ambos puntos.
- **Comportamiento provisional:** la réplica guarda solo issues con label `UserStory` o `Task` (PDM-001 F-02). El proceso de carga **debe ignorar y registrar** los demás issues, y **no fallar**: un fallo activaría los reintentos y el *circuit breaker* (BR-082) y detendría la carga completa.
- **Consecuencia aceptada:** mientras dure la deuda, el portal no puede mostrar el esfuerzo estimado, el esfuerzo gastado ni la fecha de vencimiento de un issue desde la copia local (BR-038), y no se mostrarán los issues «Proyecto».
- **Cómo se retoma:** `V2` de `p3m_gitlab` con las tres columnas (expansión, columnas nulas) y la decisión sobre el tipo «Proyecto» en el `CHECK`. No exige reconstruir tablas.

- **Evidencia:** BR-038 exige mostrar de cada issue: id, título, **esfuerzo estimado, esfuerzo gastado y fecha de vencimiento**. `replica_issue` no tiene esas columnas. BR-039 carga issues de tipo **Task, UserStory y Proyecto**; el `CHECK` solo admite `USER_STORY` y `TASK`. BR-039 prohíbe que las funcionalidades consulten GitLab directamente.
- **Impacto:** el portal no puede mostrar esos datos desde la copia local; un issue «Proyecto» haría fallar o descartaría la carga. BR-020 (solo Task o UserStory como evidencia) y BR-039 (también Proyecto) deben conciliarse.
- **Acción:** añadir `esfuerzo_estimado`, `esfuerzo_gastado` y `fecha_vencimiento` a `replica_issue`; decidir si se replican los issues «Proyecto» y con qué tipo; CON-10 sigue aceptando solo Task y UserStory.
- **Artefactos:** LDM-001 (§2.7), PDM-001, `p3m_gitlab/V1`.

### R-04 — Alta — EVT-01 sin protección contra eventos fuera de orden (ICP-001 §2.2)

- **Evidencia:** ICP-001 afirma que los eventos se procesan «en orden de `decidida_en`, uno a la vez por persona», pero no define el mecanismo. RabbitMQ no garantiza orden por clave con varios consumidores, reintentos o reentrega desde la cola de mensajes fallidos.
- **Impacto:** un evento antiguo aplicado después de uno nuevo **revierte el rol/nivel de la plaza** y falsea el historial (BR-079, INV-27).
- **Acción:** aplicar el evento solo si `decidida_en` es posterior al `vigente_desde` del rol/nivel vigente de la plaza; o un consumidor activo único por clave. Añadir la prueba al conjunto de verificación.
- **Artefactos:** ICP-001 (§2.2), LDM-001 (K-42).

### R-05 — Alta, aceptada como deuda técnica DT-01 (D-H35) — Aceptación del riesgo de datos personales sin responsable de seguridad (D-H24, DT-01, ADR-P4)

- **Decisión (ianache, 2026-10-12, D-H35):** el responsable funcional **confirma el aplazamiento** de la política de datos personales (ADR-P4) y lo mantiene como **deuda técnica DT-01**. Una decisión nombrada cierra el hallazgo como aceptado, no como resuelto.
- **Actualización (D-H40, 2026-10-12):** ianache declara que **Seguridad aceptó el aplazamiento**. No consta el nombre del aceptante ni una referencia; se recomienda adjuntarlos. ADR-P4 sigue pendiente y el riesgo sigue vigente (§6).
- **Consecuencia aceptada:** los datos personales (nombres, contactos, correo, nombre de usuario y desempeño) se retienen por siempre, sin clasificación, sin cifrado de columna y sin mecanismo de borrado a solicitud del titular. Solo existe el cifrado en reposo de almacenamiento (INF-DEC-09).
- **Cómo se retoma:** decidir ADR-P4 y aplicarlo con una migración nueva. LDM-001 §4 identifica las columnas afectadas.

- **Evidencia:** ADR-P4 indica «Quién decide: Responsable funcional y seguridad». El aplazamiento (D-H24) lo decidió solo el responsable funcional. D-H1 retiene los datos personales por siempre, sin mecanismo de borrado. Hay datos personales sin cifrado de columna ni clasificación (nombres, contactos, correo, desempeño). Hoy solo existe el cifrado en reposo de almacenamiento (INF-DEC-09).
- **Impacto:** exposición normativa y de privacidad sin aceptación del dueño del riesgo. Es una decisión humana válida, pero incompleta.
- **Acción:** que Seguridad registre la aceptación o una decisión provisional, con controles mínimos (acceso restringido, sin datos personales en los registros). El plan de retoma está en LDM-001 §4.
- **Artefactos:** LDM-001 (§4), PDM-001 (§5), ADR-P4.

### R-06 — Alta, corregido (2026-10-12) — Decisiones de negocio solo en documentos derivados (ADR-DB-001, IMD-001, RCP-001, BRC-001)

- **Corrección (2026-10-12):** las decisiones se registraron en RCP-001 (D-143 a D-159), BRC-001 (BR-114 a BR-130) e IMD-001 (R-91 nueva; IM-Q6, Q9 y Q26 cerradas). Las equivalencias con los identificadores de diseño están en LDM-001 §10. Las decisiones que no son reglas de negocio quedan solo en los documentos de diseño, y los aplazamientos como RQ-34 y RQ-35. El atributo nuevo de los contactos quedó como BR-130. IMD-001, BRC-001 y RCP-001 siguen en `draft` y sin nueva verificación humana.

- **Evidencia:** D-H1 a D-H13 sí están en RCP-001 (D-133 a D-142) y BRC-001, pero **D-H14 a D-H29 no**: nota 0 a 20 y mínimo informativo (D-H23, D-H25), costo en PEN y esfuerzo en horas-persona (D-H26), campos del enrolamiento (D-H16), solicitud ↔ promoción (D-H17), vínculo por correo (D-H19), cierre de IM-Q6, Q9, Q26 y Q28 (D-H15). IMD-001, RCP-001 y BRC-001 están en `draft` y sin nueva verificación.
- **Impacto:** el esquema contiene reglas de negocio que no tienen origen registrado, contra ADR-DB-001. No se debe aprobar un artefacto con el linaje roto.
- **Acción:** registrar las decisiones con `af-business-rule-extractor` y `af-conceptual-model-designer`, y citar BR-102, 106, 108, 111, 112 y 113 en el diseño. Después, que las fuentes recuperen la verificación humana.

### R-07 — Media — Contrato faltante para el vínculo y catálogo inconsistente (ICP-001)

- **Evidencia:** D-H19 e INV-08 exigen que CTX-02 busque a la persona por correo en CTX-01, pero **no hay un contrato** para esa búsqueda en §2.1. Además, CON-12 se añadió en §4 y no figura en la tabla de §2.1, que lista 11 contratos.
- **Impacto:** el vínculo no tiene proveedor ni consumidor definidos, y su exposición de datos (enumeración de correos) no se ha evaluado. El catálogo no es la fuente única de los contratos.
- **Acción:** definir `PersonaPorCorreo` (proveedor CTX-01, consumidor CTX-02) con límite de uso y respuesta mínima; mover CON-12 a §2.1.

### R-08 — Media — Dependencia mutua en tiempo de ejecución entre Formación y Progresión (ICP-001 §2.1, §6)

- **Evidencia:** CTX-04 consulta a CTX-05 (CON-06) y CTX-05 consulta a CTX-04 (CON-08, CON-12). Todas son de solo lectura y no hay ciclo de autoridad.
- **Impacto:** si un contexto cae, el otro no puede emitir certificaciones ni registrar evidencias. No hay modo degradado.
- **Acción:** documentar la aceptación de este acoplamiento de disponibilidad o definir un modo degradado. No bloquea.

### R-09 — Media — Migraciones multitabla sin recuperación parcial (PDM-001 §6)

- **Evidencia:** MySQL confirma implícitamente cada sentencia DDL. Una falla a mitad de `V1` (hasta 12 tablas en `p3m_progresion`) deja el esquema parcial. Reejecutar `V1` falla por tablas existentes; la salida prevista es `repair` más una migración correctiva manual.
- **Acción:** dividir los `V1` grandes en una migración por agregado, o definirlos reejecutables. Probar la recuperación (fallo forzado a mitad de migración). Además, las pruebas usaron el driver MariaDB 2.7 de la imagen oficial: el pipeline de producción debe probarse con su propio driver.

### R-10 — Media, aceptada como riesgo residual (D-H39) — Diseño de recuperación sin verificar contra los objetivos (PDM-001 §8 y §9, INF-P3M-001)

- **Decisión (ianache, 2026-10-12):** opción A de INF-P3M-001 (INF-DEC-23): el 99,9 % rige las fallas normales y el RTO 4 h y RPO 1 h rigen el desastre (D-H38). El responsable **acepta R-10 como riesgo residual** (D-H39). La contradicción de INF-P3M-001 quedó corregida en su versión 0.1.2. Falta probar la conmutación de MySQL en minutos, una restauración dentro de 4 h, la concurrencia de K-18 y el diseño con una réplica semisíncrona o de grupo (INF-DEC-11, aún sin decidir): DT-04.

- **Corrección de este informe (2026-10-12):** la versión anterior decía que RPO, RTO y volúmenes no existían. Era incorrecto. INF-Q02 (respondida el 2026-10-10) define **disponibilidad 99,9 %, RTO 4 h y RPO 1 h con respaldos horarios**, e INF-Q03 indica más de 50 colaboradores. INF-P3M-001 se contradice: varias secciones siguen diciendo `UNKNOWN`.
- **Evidencia:** INF-P3M-001 R-01 advierte que un incidente de 4 h excede el presupuesto mensual de 43,8 min del 99,9 %. No hay una restauración de prueba. K-18 (cupo) no se probó con concurrencia, ni otras versiones de MySQL, ni certificados TLS reales. D-H29 aceptó diseñar sin el resto de la evidencia de carga (usuarios concurrentes, volumen de issues, crecimiento, IOPS y modo de alta disponibilidad).
- **Acción:** que infraestructura verifique el diseño de recuperación contra 99,9 % / RTO 4 h / RPO 1 h (la conmutación a una réplica debe tardar minutos), corrija las contradicciones de INF-P3M-001, ejecute una restauración de prueba y pruebe K-18 antes de producción.

### R-11 — Baja — Cuentas de servicio (PDM-001 §5)

Host `%` y `REQUIRE SSL` sin verificación del certificado del servidor en el cliente; contraseñas estáticas en Vault sin rotación definida (ADR-P11 pendiente); la cuenta de migración conserva `DROP`. **Acción:** restringir el host, verificar el certificado y definir la rotación.

### R-12 — Baja — Observabilidad incompleta (PDM-001 §6)

Solo se vigila el historial de Flyway. Faltan métricas y alertas para el retraso del *outbox*, la cola de mensajes fallidos, los interbloqueos (error 1213) y las consultas lentas.

### R-13 — Baja — Tipos de identidad mezclados para «quién lo hizo» (LDM-001, PDM-001)

`validada_por_ref` guarda el id de persona mientras los demás actores guardan el GUID de Keycloak (D-H20). Es intencional (CON-01 y CON-09 comprueban roles de persona), pero complica la auditoría de BR-087. **Acción:** documentar la excepción o unificar.

## 5. Puntos que la revisión confirma como correctos

| Aspecto | Evidencia |
|---|---|
| Propiedad por contexto y ausencia de claves foráneas entre esquemas | 45 FK, 0 entre esquemas (postflight) |
| «Una sola vigente» con índice único sobre columna generada | Probado: 7 índices y sus casos (96 pruebas) |
| Historiales sin borrado ni actualización | Permisos probados (11 pruebas) |
| Migraciones deterministas | Checksums de Flyway = calculados, 8 de 8 |
| Mínimo privilegio por contexto y SSL | Probado |
| Idempotencia de EVT-01 (`promocion_ref` único) | Probado (K-42) |
| Linaje agregado → entidad sin huérfanos | LDM-001 §6 |

## 6. Riesgo residual (aunque se resuelvan los hallazgos)

| Riesgo | Origen |
|---|---|
| Datos personales retenidos por siempre, sin clasificación ni cifrado de columna ni mecanismo de borrado, y aceptado por Seguridad según ianache (D-H40) | D-H1, D-H24, D-H35, D-H40, DT-01 |
| Diseño con evidencia de carga parcial: faltan usuarios concurrentes, volumen de issues, crecimiento, IOPS y modo de alta disponibilidad | D-H29, DT-02 |
| Recuperación de MySQL sin probar: conmutación en minutos, restauración dentro de 4 h y concurrencia de K-18 | D-H39, DT-04 |
| El portal no muestra esfuerzo ni fecha de vencimiento de los issues y no replica los issues «Proyecto» | D-H32, DT-03 |
| Todos los ADR de arquitectura en `draft` sin revisión de arquitecto | CAT-ADR-001 |
| Las reglas que garantiza el servicio (K-01, K-07, K-09, K-12, K-13, K-16, K-20, K-23, K-33, K-34) no se han probado porque el servicio no existe | PDM-001 §9 |

## 7. Trazabilidad

| Hallazgo | Artefactos | Reglas y decisiones |
|---|---|---|
| R-01 | ICP-001, LDM-001, PDM-001 | BR-074, BR-077, BR-107, D-H5, D-H19 |
| R-02 | LDM-001 K-31, PDM-001, ADR-P6 | BR-093, ASR-10, INV-21 |
| R-03 | LDM-001 §2.7, `p3m_gitlab/V1` | BR-020, BR-038, BR-039, BR-049, D-H32 |
| R-04 | ICP-001 EVT-01, LDM-001 K-42 | BR-110, D-H12, INV-27 |
| R-05 | LDM-001 §4, PDM-001 §5 | D-H1, D-H24, D-H35, ADR-P4 |
| R-06 | IMD-001, RCP-001, BRC-001 | ADR-DB-001, D-H14..D-H29 |
| R-07 | ICP-001 | D-H19, INV-08 |

## 8. Próximos responsables

| Hallazgo | Responsable |
|---|---|
| R-01 | Responsable funcional (aceptar la acción propuesta) y Seguridad (confirmar la configuración de Keycloak y Active Directory) |
| R-02, R-04, R-07, R-09 | Diseño de datos (esta cadena de skills), con aprobación del responsable funcional |
| R-05 | Seguridad (la aceptación del aplazamiento sigue pendiente; el responsable funcional ya aceptó la deuda) |
| R-06 | Análisis funcional |
| R-08, R-10, R-11, R-12 | Arquitectura e infraestructura |
