---
type: Logical Data Model
title: "LDM-001 — Modelo lógico de datos del P3M"
description: "Modelo lógico relacional, neutral en tecnología, por contexto: entidades, atributos, identificadores, cardinalidades, restricciones candidatas, reglas temporales, propiedad, referencias entre contextos y linaje bidireccional con DDM-001."
tags: [database, logical-model, ddd]
status: draft
gate: LOGICAL_MODEL_READY
gate-result: PASSED
human-reviewed: true
reviewed-by: "ianache (responsable funcional), 2026-10-11, en sesión: D-H14..D-H17"
generated:
  by: "logical-data-modeler"
  at: "2026-10-11T20:00:00-05:00"
plan-step: S3 (WP-DB-001)
predecessor: DDM-001 (DDD_MODEL_READY = PASSED, ianache 2026-10-11)
sources:
  - id: ddm-001
    resource: /data/DDM-001-modelo-ddd.md
  - id: ddp-001
    resource: /data/DDP-001-descubrimiento-de-dominio.md
  - id: imd-001
    resource: /business/information-model/IMD-001-portal-curricula.md
    trust: draft (actualizado con D-H1..D-H13; pendiente de nueva verificación)
  - id: brc-001
    resource: /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md
    trust: draft (113 reglas)
  - id: gls-001
    resource: /business/glossary/GLS-001-glosario-de-negocio.md
  - id: adr-db-001-002-003
    resource: /architecture/adr/ADR-DB-001.md, ADR-DB-002.md, ADR-DB-003.md
  - id: adr-p6
    resource: /architecture/adr/ADR-P6-historial-con-vigencia-y-restricciones-en-mys.md
    trust: draft
---

# LDM-001 — Modelo lógico de datos del P3M

> **Alcance:** modelo lógico relacional, **neutral en tecnología**. Los tipos son lógicos (texto, entero, decimal, fecha, fecha-hora, lógico, enumeración, identificador). Tipos de MySQL, charset, índices y Flyway son de S5 (ADR-DB-003).
> **Atributos:** solo los que una fuente nombra (glosario, BR, IMD). Las marcas de auditoría técnica (creación, modificación) son decisión física. Lo que no tiene fuente se marca **SUPUESTO** y está en la sección 10.

## 1. Convenciones

| Convención | Regla |
|---|---|
| Identificador | Cada entidad tiene un identificador **opaco y sin significado de negocio**, generado por el contexto propietario (clave sustituta). Los códigos y el GUID de Keycloak son **claves alternas únicas**: son datos de negocio y podrían cambiar. Las tablas puramente asociativas usan clave compuesta. El tipo físico se decide en S5 |
| `*_por_ref` (actor) | Guarda el `keycloak_guid` del usuario que ejecutó la acción (claim `sub` del token), no el id de `usuario` (D-H20) |
| `*_ref` | Identificador de un agregado de **otro contexto**. **No es clave foránea**: la integridad la garantiza el contrato (ADR-DB-002, S4) |
| FK | Solo dentro de un contexto, nombrada `<entidad>_id` |
| Vigencia | `vigente_desde` (obligatorio) y `vigente_hasta` (nulo = vigente). Intervalo cerrado en el inicio y abierto en el fin; el mecanismo de «una sola vigente» es el de ADR-P6 |
| Borrado | No hay borrado físico de historiales, logs ni datos personales (D-H1, BR-090). Las FK usan `RESTRICT`, salvo que se indique |
| Mecanismo de restricción | **DB** (la base la garantiza), **AGG** (el agregado, dentro de una transacción) o **POL** (política entre agregados con bloqueo de filas, ADR-P6) |
| Dominios | `NIVEL_LOGRO` = N1, N2, N3 (ordenados). `NIVEL_DESARROLLO` = L1..L4 |

## 2. Subáreas y entidades

Cada subárea es un contexto de DDM-001. **No hay FK entre subáreas.**

### 2.1 CTX-01 Partes y organización

| Entidad | Agg | Atributos (T = tipo, N = nulo permitido) | Identificador / únicos | Fuente |
|---|---|---|---|---|
| **parte** | AGG-01 | `tipo_parte` {PERSONA, ORGANIZACION} | id | D-129, R-76/77 |
| **persona** | AGG-01 | `parte_id` (FK 1:1, PK), `nombres`, `apellido_paterno`, `apellido_materno` | PK = parte_id | TRM-0060 |
| **organizacion** | AGG-01 | `parte_id` (FK 1:1, PK), `nombre` | PK = parte_id; `nombre` único | TRM-0050, BR-072 |
| **dato_de_contacto** | AGG-01 | `parte_id` (FK compuesta con `tipo_parte`), `tipo_parte` {PERSONA, ORGANIZACION}, `tipo` {CORREO, TELEFONO, DIRECCION}, `valor`, `vigente_hasta` (N), `baja_por_ref` (N, GUID de Keycloak) | id | BR-070, BR-131, D-H1, D-H34, D-160 |
| **rol_de_la_parte** | AGG-02 | `persona_id` (FK), `tipo_rol` {COLABORADOR, EVALUADOR}, `vigente_desde`, `vigente_hasta` (N) | id | D-H7, D-H10 |
| **relacion_entre_partes** | AGG-03 | `parte_origen_id` (FK), `parte_destino_id` (FK), `tipo` {REPORTA_A, MEMBERSHIP, ES_PARTE_DE}, `vigente_desde`, `vigente_hasta` (N) | id | BR-071, BR-072, BR-076 |
| **plaza** | AGG-04 | `organizacion_id` (FK) | id | BR-097, D-H9 |
| **plaza_rol_nivel** | AGG-04 | `plaza_id` (FK), `rol_nivel_ref` (CTX-03), `vigente_desde`, `vigente_hasta` (N), `promocion_ref` (CTX-05, N) | id; `promocion_ref` único si no es nulo | D-H12, BR-079, D-H18 |
| **ocupacion_de_plaza** | AGG-05 | `plaza_id` (FK), `persona_id` (FK), `vigente_desde`, `vigente_hasta` (N) | id | BR-047, BR-097, D-H4 |

La fecha de ingreso del colaborador es el `vigente_desde` de su `rol_de_la_parte` COLABORADOR (IMD-001 §5.1).

**Relaciones y cardinalidades**

| Relación | Cardinalidad | Acción referencial | Justificación |
|---|---|---|---|
| parte → persona / organizacion | 1 : 0..1 cada una; solo una de las dos (INFERENCE) | RESTRICT | R-76, R-77 |
| parte → dato_de_contacto | 1 : N | RESTRICT | R-82, BR-131 |
| persona → rol_de_la_parte | 1 : N | RESTRICT | R-78 |
| parte → relacion_entre_partes (origen y destino) | 1 : N cada una | RESTRICT | R-80, R-81 |
| organizacion → plaza | 1 : N | RESTRICT | R-84 |
| plaza → plaza_rol_nivel | 1 : N en el tiempo, 1 vigente | RESTRICT | R-85, D-H12 |
| plaza → ocupacion_de_plaza | 1 : N en el tiempo, 0..1 vigente | RESTRICT | R-86, D-H4 |
| persona → ocupacion_de_plaza | 1 : N en el tiempo, 0..1 vigente | RESTRICT | R-87 |

**Restricciones candidatas**

| ID | Restricción | Mec. | Origen (INV) |
|---|---|---|---|
| K-01 | `dato_de_contacto`: toda persona tiene al menos un CORREO y un TELEFONO **vigentes**; las organizaciones también: correo, teléfono y dirección, con correo y teléfono obligatorios (BR-132) | AGG | INV-02, BR-070 |
| K-02 | `relacion_entre_partes`: una sola vigente por (`parte_origen_id`, `tipo`) cuando `tipo` ∈ {REPORTA_A, MEMBERSHIP} | POL | INV-03, INV-04 |
| K-03 | `relacion_entre_partes`: REPORTA_A entre personas; MEMBERSHIP de persona a organización; ES_PARTE_DE entre organizaciones | AGG | BR-071, BR-072, BR-076 |
| K-04 | `ocupacion_de_plaza`: una sola vigente por `plaza_id` | POL | INV-06, BR-106 |
| K-05 | `ocupacion_de_plaza`: una sola vigente por `persona_id` | POL | INV-05, BR-047 |
| K-06 | `plaza_rol_nivel`: una sola vigente por `plaza_id` | POL | INV-27 |
| K-42 | `plaza_rol_nivel.promocion_ref` único cuando no es nulo: hace idempotente el evento `PromocionDeNivelDecidida` | DB | D-H18, ICP-001 EVT-01 |
| K-43 | El correo **vigente** (`tipo` = CORREO y `vigente_hasta` nulo) es **único entre **todas las partes**, personas y organizaciones (BR-125, BR-133, D-162)**: es la clave de vinculación con el usuario de Keycloak | DB | D-H19, ICP-001 DEC-I02 |
| K-44 | Un contacto no se borra (D-H1): se da de baja con `vigente_hasta` y `baja_por_ref` (quién y cuándo); ambos van juntos o ninguno. La baja libera la dirección cuando un correo cambia o se reutiliza | DB (CHECK) | D-H34, RPT-DDR-001 R-01 |
| K-46 | `PromocionDeNivelDecidida` solo se aplica a la plaza si `decidida_en` es **posterior** al `vigente_desde` del rol/nivel vigente; el nuevo rol/nivel se abre con `vigente_desde` = `decidida_en` y su `promocion_ref`. Un evento obsoleto se descarta y se registra | POL | D-H34, RPT-DDR-001 R-04, INV-27 |
| K-07 | `rol_de_la_parte`: sin vigencias solapadas para el mismo (`persona_id`, `tipo_rol`) (SUPUESTO S-06) | POL | A-04, BR-079, BR-108, BR-120 |
| K-08 | Todas las vigencias: `vigente_hasta` nulo o mayor que `vigente_desde` | DB | INV-07 |
| K-09 | Toda ocupación se registra para una persona con rol COLABORADOR vigente | AGG | R-79, BR-047 |

### 2.2 CTX-02 Identidad de acceso

| Entidad | Agg | Atributos | Identificador / únicos | Fuente |
|---|---|---|---|---|
| **usuario** | AGG-06 | `keycloak_guid`, `username`, `correo`, `persona_ref` (CTX-01, N) | id; `keycloak_guid` único | BR-073, BR-074, TRM-0052 |
| **usuario_rol_de_usuario** | AGG-06 | `usuario_id` (FK), `rol_de_usuario` {COLABORADOR, INSTRUCTOR, JEFE_INGENIERIA, ADMIN} | PK compuesta | BR-074, BR-075 |
| **correccion_de_vinculo** | AGG-06 | `usuario_id` (FK), `persona_ref_anterior` (CTX-01, N), `persona_ref_nueva` (CTX-01), `corregida_por_ref` (GUID de Keycloak), `corregida_en` | id | D-H34, RPT-DDR-001 R-01 |

`usuario_rol_de_usuario` es una **copia no autoritativa** de los roles de Keycloak al último inicio de sesión (BR-074, BR-075). La autorización usa el token y no esta tabla (ADR-11, ADR-P5). Un usuario → rol es 1 : N.

| ID | Restricción | Mec. | Origen |
|---|---|---|---|
| K-10 | `persona_ref` único cuando no es nulo (un usuario por persona) (INFERENCE sobre «un usuario, una persona») | POL | R-83 |
| K-45 | `usuario.persona_ref` es **inmutable** para el servicio de identidad: se fija al insertar y solo la cuenta de corrección del Jefe de Ingeniería puede cambiarlo, dejando un registro en `correccion_de_vinculo` (solo inserción) | DB (permisos por columna) | D-H34, RPT-DDR-001 R-01 |
| K-11 | Todo colaborador tiene usuario; un usuario sin colaborador ni rol JI/ADMIN/INSTRUCTOR vuelve al login | AGG + evento | INV-08, BR-077, BR-107 |

### 2.3 CTX-03 Currícula

| Entidad | Agg | Atributos | Identificador / únicos | Fuente |
|---|---|---|---|---|
| **seniority** | AGG-07 | `nombre` {JUNIOR, SEMISENIOR, SENIOR} | id; `nombre` único | BR-011 |
| **nivel_de_desarrollo** | AGG-07 | `seniority_id` (FK), `nivel` {L1..L4} | id; único (`seniority_id`, `nivel`) | BR-011 (S-02) |
| **competencia** | AGG-08 | `codigo`, `nombre`, `tipo` {CONOCIMIENTO, HABILIDAD, ACTITUD}, `es_general` (lógico) | id; `codigo` único | BR-056, BR-060 |
| **competencia_nivel_de_logro** | AGG-08 | `competencia_id` (FK), `nivel_de_logro`, `definicion` | PK (`competencia_id`, `nivel_de_logro`) | BR-056 |
| **rol** | AGG-09 | `nombre` | id; `nombre` único | BR-001, BR-012 |
| **rol_competencia** (perfil) | AGG-09 | `rol_id` (FK), `competencia_id` (FK) | PK (`rol_id`, `competencia_id`) | BR-012 (S-01) |
| **rol_nivel** | AGG-09 | `rol_id` (FK), `nivel_de_desarrollo_id` (FK) | id; único (`rol_id`, `nivel_de_desarrollo_id`); único (`id`, `rol_id`) | BR-014 |
| **rol_nivel_competencia_minimo** | AGG-09 | `rol_nivel_id`, `rol_id`, `competencia_id`, `nivel_minimo` {N1, N2, N3} | PK (`rol_nivel_id`, `competencia_id`) | BR-014, R-07 |

El **perfil de competencias** no es entidad propia: con un perfil por rol (S-01) es el conjunto de filas de `rol_competencia`.

| Relación | Cardinalidad | Justificación |
|---|---|---|
| seniority → nivel_de_desarrollo | 1 : 4 | R-04 |
| competencia → competencia_nivel_de_logro | 1 : 3 | BR-056 |
| rol → rol_competencia ← competencia | N : M | R-02 |
| rol → rol_nivel | 1 : N | R-05 |
| nivel_de_desarrollo → rol_nivel | 1 : N | R-06 |
| rol_nivel → rol_nivel_competencia_minimo | 1 : N | R-07 |

| ID | Restricción | Mec. | Origen |
|---|---|---|---|
| K-12 | `competencia_nivel_de_logro`: exactamente tres filas por competencia (N1, N2, N3) | AGG | INV-09 |
| K-13 | `nivel_de_desarrollo`: exactamente L1..L4 por seniority | AGG | INV-10 |
| K-14 | **FK compuesta** de `rol_nivel_competencia_minimo` (`rol_id`, `competencia_id`) → `rol_competencia`: el mínimo solo existe para competencias del perfil del rol | DB | INV-11, R-07 |
| K-15 | **FK compuesta** (`rol_nivel_id`, `rol_id`) → `rol_nivel`: el `rol_id` coincide con el del rol/nivel | DB | INV-11 |
| K-16 | Una competencia con `es_general` = falso aparece en un solo rol | POL | INV-09, BR-060 |

### 2.4 CTX-04 Formación

| Entidad | Agg | Atributos | Identificador / únicos | Fuente |
|---|---|---|---|---|
| **curso** | AGG-10 | `codigo`, `nombre`, `sumilla` | id; `codigo` único | BR-057, TRM-0046 |
| **objetivo_de_curso** | AGG-10 | `curso_id` (FK), `descripcion`, `competencia_ref` (CTX-03), `nivel_objetivo` {N1..N3} | id | BR-017 |
| **rubrica_nivel** | AGG-10 | `objetivo_id` (FK), `nivel_de_logro`, `descripcion_desempeno` | PK (`objetivo_id`, `nivel_de_logro`) | BR-058 |
| **evidencia_esperada** | AGG-10 | `objetivo_id`, `nivel_de_logro`, `descripcion` (S-05), `obligatoriedad` {OBLIGATORIA, DESEABLE} | id | BR-018, BR-058 |
| **edicion_de_curso** | AGG-11 | `curso_id` (FK), `numero_de_edicion`, `fecha_inicio`, `fecha_fin`, `cupo`, `evaluador_ref` (CTX-01, persona con rol EVALUADOR) | id; único (`curso_id`, `numero_de_edicion`) | BR-024 |
| **enrolamiento** | AGG-11 | `edicion_id` (FK), `colaborador_ref` (CTX-01), `estado` {INSCRITO, CERTIFICADO, DESENROLADO}, `avance_porcentaje` (decimal 0..100, N), `nota` (decimal, N, 0..20), `comentarios` (texto, N) | id | BR-023, BR-025, BR-027 |
| **certificacion_de_curso** | AGG-11 | `enrolamiento_id` (FK, único), `evaluador_ref` (CTX-01), `emitida_en` (fecha-hora) | id; `enrolamiento_id` único | BR-021, BR-022, D-H3 |

`rubrica` no es entidad aparte: es el conjunto de `rubrica_nivel` de un objetivo (1 : 1 con el objetivo, R-56).

| Relación | Cardinalidad | Justificación |
|---|---|---|
| curso → objetivo_de_curso | 1 : N (mínimo UNKNOWN) | R-09 |
| objetivo_de_curso → rubrica_nivel | 1 : 3 | R-56, BR-058 |
| rubrica_nivel → evidencia_esperada | 1 : N | R-21 |
| curso → edicion_de_curso | 1 : N | R-12 |
| edicion_de_curso → enrolamiento | 1 : N hasta el cupo | R-15 |
| enrolamiento → certificacion_de_curso | 1 : 0..1 | R-16 |

| ID | Restricción | Mec. | Origen |
|---|---|---|---|
| K-17 | **FK compuesta** de `evidencia_esperada` (`objetivo_id`, `nivel_de_logro`) → `rubrica_nivel` | DB | R-21 |
| K-18 | `enrolamiento`: no más enrolamientos activos (no DESENROLADO) que el `cupo`, con bloqueo de la edición | AGG | INV-13, BR-026 |
| K-19 | `enrolamiento`: único (`edicion_id`, `colaborador_ref`) mientras no esté DESENROLADO (S-08) | POL | BR-025 |
| K-20 | `certificacion_de_curso` solo si el 100 % de las evidencias esperadas OBLIGATORIAS del enrolamiento están validadas. Requiere una proyección de CTX-05 | AGG + evento | INV-14, BR-021 (S4) |
| K-21 | `fecha_fin` ≥ `fecha_inicio`; `cupo` > 0 | DB | BR-024 |
| K-39 | `enrolamiento.avance_porcentaje` entre 0 y 100 | DB (CHECK) | D-H16 |
| K-40 | `enrolamiento.nota` entre 0 y 20. Una nota mayor o igual que 12 es **solo informativa** y no condiciona la certificación (D-H25). No se guarda como dato | DB (CHECK) | D-H23, D-H25 |

### 2.5 CTX-05 Progresión

| Entidad | Agg | Atributos | Identificador / únicos | Fuente |
|---|---|---|---|---|
| **evidencia_aportada** | AGG-12 | `tipo` {CURSO, PROYECTO}, `colaborador_ref`, `issue_url`, `enrolamiento_ref` (CTX-04, N), `evidencia_esperada_ref` (CTX-04, N), `solicitud_de_promocion_id` (FK, N), `estado` {PENDIENTE, VALIDADA}, `validada_por_ref` (CTX-01, N), `validada_en` (N) | id | BR-019, BR-020, D-H3, D-H11 |
| **valoracion_de_competencia** | AGG-13 | `colaborador_ref`, `competencia_ref` (CTX-03) | id; único (`colaborador_ref`, `competencia_ref`) | BR-004 |
| **valoracion_registro** | AGG-13 | `valoracion_id` (FK), `nivel_de_logro`, `registrada_por_ref` (CTX-02), `registrada_en` | id | BR-004, BR-051 |
| **evaluacion_de_desempeno** | AGG-14 | `colaborador_ref`, `periodo_desde`, `periodo_hasta`, `resultado` {SUPERA, CUMPLE, PARCIAL, NO_CUMPLE}, `comentarios`, `registrada_en`, `registrada_por_ref` (CTX-02) | id | BR-083..BR-089 |
| **evaluacion_evidencia** | AGG-14 | `evaluacion_id` (FK), `evidencia_aportada_id` (FK) | PK compuesta | R-72 |
| **evaluacion_certificacion** | AGG-14 | `evaluacion_id` (FK), `certificacion_ref` (CTX-04) | PK compuesta | R-73 |
| **solicitud_de_promocion** | AGG-15 | `colaborador_ref`, `rol_nivel_destino_ref` (CTX-03), `estado` {REGISTRADA, EVALUADA, DECIDIDA} | id | BR-064, BR-068, D-H13 |
| **promocion_de_nivel** | AGG-16 | `colaborador_ref`, `rol_nivel_destino_ref` (CTX-03), `decidida_por_ref` (CTX-02), `evaluacion_de_desempeno_id` (FK, obligatoria), `solicitud_de_promocion_id` (FK, N, única) | id | BR-007, BR-029, BR-088 |
| **promocion_certificacion** | AGG-16 | `promocion_id` (FK), `certificacion_ref` (CTX-04) | PK compuesta | R-31 |
| **promocion_evidencia_proyecto** | AGG-16 | `promocion_id` (FK), `evidencia_aportada_id` (FK) | PK compuesta | R-33 |
| **promocion_valoracion** | AGG-16 | `promocion_id` (FK), `valoracion_registro_id` (FK) | PK compuesta | R-34 |

Una solicitud de promoción termina en 0 o 1 promoción de nivel, y el Jefe de Ingeniería puede promover sin solicitud (D-H17). Una solicitud decidida sin promoción equivale a una solicitud no atendida.

| Relación | Cardinalidad | Justificación |
|---|---|---|
| solicitud_de_promocion → evidencia_aportada | 1 : N | R-60 |
| valoracion_de_competencia → valoracion_registro | 1 : N, solo se agregan | R-48, BR-051 |
| evaluacion_de_desempeno ↔ evidencia_aportada | N : M | R-72 |
| promocion_de_nivel → evaluacion_de_desempeno | N : 1 | R-74 |
| solicitud_de_promocion → promocion_de_nivel | 1 : 0..1; la promoción puede no tener solicitud | D-H17 |
| promocion_de_nivel ↔ evidencia / certificación / valoración | N : M | R-31, R-33, R-34 |

| ID | Restricción | Mec. | Origen |
|---|---|---|---|
| K-22 | `evidencia_aportada`: si `tipo` = CURSO, `enrolamiento_ref` y `evidencia_esperada_ref` obligatorios y único (`enrolamiento_ref`, `evidencia_esperada_ref`); reemplazable mientras PENDIENTE | DB (CHECK + único) | INV-15, D-H11 |
| K-23 | `evidencia_aportada`: `issue_url` apunta a un issue Closed de tipo Task o UserStory en la réplica de CTX-07 | AGG + contrato | INV-15, BR-020 (S4) |
| K-24 | `evidencia_aportada`: `estado` VALIDADA exige `validada_por_ref` y `validada_en` | DB (CHECK) | BR-019 |
| K-25 | `valoracion_registro` y `evaluacion_de_desempeno`: solo inserciones (sin UPDATE ni DELETE) | DB (permiso) + AGG | INV-16, INV-17 |
| K-26 | `promocion_de_nivel.evaluacion_de_desempeno_id` NOT NULL | DB | INV-18, BR-088 |
| K-27 | `periodo_hasta` ≥ `periodo_desde` | DB | BR-087 |
| K-41 | `promocion_de_nivel.solicitud_de_promocion_id` único cuando no es nulo | DB | D-H17 |

### 2.6 CTX-06 Portafolio y asignación

| Entidad | Agg | Atributos | Identificador / únicos | Fuente |
|---|---|---|---|---|
| **producto** | AGG-17 | `codigo`, `nombre`, `gitlab_project_id` | id; `codigo` único | TRM-0029, BR-032 |
| **proyecto** | AGG-18 | `producto_id` (FK), `codigo`, `nombre`, `fecha_inicio`, `fecha_fin`, `costo_estimado` (soles peruanos, PEN), `esfuerzo_estimado` (horas-persona) | id; `codigo` único | TRM-0030, BR-048 |
| **proyecto_milestone** | AGG-18 | `proyecto_id` (FK), `milestone_ref` (CTX-07) | PK (`proyecto_id`, `milestone_ref`); `milestone_ref` único | BR-034, BR-091 |
| **proyecto_rol_nivel_requerido** | AGG-18 | `proyecto_id` (FK), `rol_nivel_ref` (CTX-03), `cantidad` | PK (`proyecto_id`, `rol_nivel_ref`) | BR-040, BR-046, BR-109 |
| **jefatura_de_proyecto** | AGG-18 | `proyecto_id` (FK), `colaborador_ref` (CTX-01), `vigente_desde`, `vigente_hasta` (N) | id | BR-063, D-H2, D-H10 |
| **asignacion** | AGG-19 | `colaborador_ref`, `proyecto_id`, `rol_nivel_ref`, `porcentaje_dedicacion`, `vigente_desde`, `vigente_hasta` (N), `estado` {PENDIENTE, VIGENTE, FINALIZADA}, `realizada_por_ref` (CTX-02) | id | BR-040, BR-078, BR-080, D-H13 |
| **excepcion_de_asignacion** | AGG-19 | `asignacion_id` (FK, PK), `motivo_id` (FK), `aprobada_por_ref` (CTX-02) | PK = asignacion_id | BR-042, BR-043 |
| **colaborador_carga** | AGG-19 | `colaborador_ref` (CTX-01) | PK = colaborador_ref | D-H34, RPT-DDR-001 R-02 |
| **motivo_de_excepcion** | AGG-20 | `codigo`, `descripcion` | id; `codigo` único | BR-043, BR-053 |

| Relación | Cardinalidad | Acción | Justificación |
|---|---|---|---|
| producto → proyecto | 1 : N | RESTRICT | R-35 |
| proyecto → proyecto_milestone | 1 : N | RESTRICT | R-36 |
| proyecto → proyecto_rol_nivel_requerido | 1 : N | RESTRICT | R-39 |
| proyecto → jefatura_de_proyecto | 1 : N en el tiempo, 0..1 vigente | RESTRICT | R-55 |
| proyecto → asignacion | 1 : N | RESTRICT | R-41 |
| asignacion → excepcion_de_asignacion | 1 : 0..1 | RESTRICT | R-43 |
| motivo_de_excepcion → excepcion_de_asignacion | 1 : N | **RESTRICT** (un motivo usado no se retira) | BR-067 |

| ID | Restricción | Mec. | Origen |
|---|---|---|---|
| K-28 | **FK compuesta** de `asignacion` (`proyecto_id`, `rol_nivel_ref`) → `proyecto_rol_nivel_requerido`: se asigna según un rol/nivel que el proyecto requiere | DB | BR-040 |
| K-29 | `jefatura_de_proyecto`: una sola vigente por `proyecto_id` | POL | INV-20, BR-102, D-H2 |
| K-30 | `proyecto_milestone.milestone_ref` único: un milestone en un solo proyecto | DB | INV-19, BR-091 |
| K-31 | `asignacion`: suma de `porcentaje_dedicacion` de asignaciones vigentes por `colaborador_ref` ≤ 100, **con el protocolo de K-47** | POL | INV-21, BR-093, ADR-P6 |
| K-47 | Protocolo de bloqueo: dentro de la transacción, `INSERT IGNORE` y `SELECT … FOR UPDATE` sobre la fila del colaborador en `colaborador_carga` **antes** de sumar. Es obligatorio con cualquier nivel de aislamiento. Reintentar ante el error 1213 | POL | D-H34, RPT-DDR-001 R-02 |
| K-32 | `porcentaje_dedicacion` mayor que 0 y menor o igual que 100; `cantidad` > 0; `fecha_fin` ≥ `fecha_inicio`; vigencias coherentes | DB | BR-080 |
| K-33 | `asignacion` en PENDIENTE hasta que exista `excepcion_de_asignacion` cuando no se cumple el nivel mínimo | AGG | INV-22, BR-042 |
| K-34 | La definición de roles/niveles requeridos solo la hace un usuario con rol JEFE_INGENIERIA o ADMIN | AGG (permiso) | INV-23, BR-109 |

### 2.7 CTX-07 Integración GitLab

| Entidad | Agg | Atributos | Identificador / únicos | Fuente |
|---|---|---|---|---|
| **carga_de_gitlab** | AGG-21 | `iniciada_en`, `delta_desde` (N, nulo = carga completa), `estado` {PROGRAMADA, EJECUTANDO, COMPLETADA, FALLIDA, SIN_CAMBIOS}, `intentos` (0..3) | id | BR-065, BR-082, BR-094, D-H13 |
| **replica_milestone** | RPL-01 | `gitlab_milestone_id`, `gitlab_project_id`, `titulo` | PK (`gitlab_project_id`, `gitlab_milestone_id`) | BR-035, ADR-08 |
| **replica_issue** | RPL-01 | `gitlab_issue_id`, `gitlab_project_id`, `gitlab_milestone_id` (N), `tipo` {USER_STORY, TASK}, `estado` {OPENED, CLOSED}, `web_url`, `titulo`, `actualizado_en`, `user_story_gitlab_id` (N) | PK (`gitlab_project_id`, `gitlab_issue_id`) | BR-020, BR-049, BR-050 |

Las réplicas son **solo lectura** (BR-036) y GitLab es la autoridad. Sus atributos son el mínimo que usan las reglas; los demás campos del API de GitLab se deciden en S4. **Deuda técnica DT-03 (D-H32):** no se replican el esfuerzo estimado, el esfuerzo gastado ni la fecha de vencimiento que pide BR-038, ni los issues «Proyecto» de BR-039; el responsable aún no decidió su tratamiento.

| ID | Restricción | Mec. | Origen |
|---|---|---|---|
| K-35 | `carga_de_gitlab` no se borra: los logs se retienen por siempre | DB (permiso) | BR-090, INV-24 |
| K-36 | `intentos` entre 0 y 3 | DB (CHECK) | BR-082 |
| K-37 | Las réplicas solo las escribe el proceso de carga | AGG (permiso) | INV-25, BR-036 |
| K-38 | `replica_issue.gitlab_milestone_id` referencia un milestone de la misma subárea, nulo si no tiene | DB (FK compuesta) | BR-049 |

## 3. Referencias entre contextos (insumo de S4)

| Atributo `*_ref` | Origen | Destino | Contrato necesario |
|---|---|---|---|
| `plaza_rol_nivel.rol_nivel_ref` | CTX-01 | CTX-03 `rol_nivel` | Existencia del rol/nivel |
| `usuario.persona_ref`, `correccion_de_vinculo.persona_ref_*` | CTX-02 | CTX-01 `persona` | Una persona por usuario; vínculo por `PersonaPorCorreo` (CON-13) |
| `edicion_de_curso.evaluador_ref` | CTX-04 | CTX-01 persona con rol EVALUADOR vigente | Verificar el rol |
| `objetivo_de_curso.competencia_ref` | CTX-04 | CTX-03 `competencia` | Existencia |
| `enrolamiento.colaborador_ref` | CTX-04 | CTX-01 persona con rol COLABORADOR | Verificar el rol |
| `evidencia_aportada.*_ref` (colaborador, enrolamiento, evidencia esperada, validada por) | CTX-05 | CTX-01 / CTX-04 | Existencia; evento `EvidenciaValidada` |
| `evidencia_aportada.issue_url` | CTX-05 | CTX-07 `replica_issue` | Issue Closed Task/UserStory |
| `valoracion_de_competencia.competencia_ref`, `solicitud/promocion.rol_nivel_destino_ref` | CTX-05 | CTX-03 | Existencia |
| `evaluacion_certificacion.certificacion_ref`, `promocion_certificacion.certificacion_ref` | CTX-05 | CTX-04 `certificacion_de_curso` | Evento `CertificacionEmitida` |
| `*_por_ref`, `registrada_por_ref`, `realizada_por_ref` | CTX-05 / CTX-06 | Keycloak (GUID del token) | Se guarda el `keycloak_guid` del actor, sin consultar a CTX-02 (D-H20) |
| `proyecto_milestone.milestone_ref` | CTX-06 | CTX-07 `replica_milestone` | Existencia |
| `proyecto_rol_nivel_requerido.rol_nivel_ref`, `asignacion.rol_nivel_ref` | CTX-06 | CTX-03 `rol_nivel` | Existencia |
| `jefatura_de_proyecto.colaborador_ref`, `asignacion.colaborador_ref` | CTX-06 | CTX-01 persona con rol COLABORADOR | Verificar el rol |
| `PromocionDeNivelDecidida` → `plaza_rol_nivel` | CTX-05 → CTX-01 | evento | Cambia el rol/nivel de la plaza (D-H12) |

## 4. Datos sensibles (clasificación provisional, deuda técnica DT-01)

ADR-P4 está **pendiente** y el responsable decidió **ignorar esa política por ahora** y tratarla como **deuda técnica DT-01** (D-H24). La columna es una propuesta de trabajo, no una decisión. Sirve para que el tratamiento futuro (clasificación, cifrado, acceso y borrado) pueda aplicarse sin rediseñar: los datos personales quedan en columnas identificables.

| Entidad.atributo | Clase provisional | Motivo |
|---|---|---|
| persona.nombres, apellido_paterno, apellido_materno | Dato personal | TRM-0060 |
| dato_de_contacto.valor | Dato personal | BR-070 |
| usuario.username, correo, keycloak_guid | Dato personal / identificador | TRM-0052 |
| evaluacion_de_desempeno.* , valoracion_registro.nivel_de_logro | Dato de desempeño del colaborador | BR-083 |
| Resto | Interno | — |

**Retención:** todos se conservan por siempre, igual que los logs (D-H1, BR-101). No existe mecanismo de borrado ni de atención a solicitud del titular hasta que ADR-P4 lo decida.

## 5. Mapa de temporalidad y ciclo de vida

| Entidad | Regla temporal | Mecanismo |
|---|---|---|
| rol_de_la_parte, relacion_entre_partes, plaza_rol_nivel, ocupacion_de_plaza, jefatura_de_proyecto, asignacion | `vigente_desde` / `vigente_hasta`; nunca se borra. Cerrar la vigencia anterior y abrir la nueva en la misma transacción | AGG |
| valoracion_registro, evaluacion_de_desempeno | Solo inserción; la «vigente» es la más reciente por `registrada_en` | DB + AGG |
| evidencia_aportada | PENDIENTE → VALIDADA | AGG |
| asignacion | PENDIENTE → VIGENTE → FINALIZADA (BR-111) | AGG |
| enrolamiento | INSCRITO → CERTIFICADO, o DESENROLADO | AGG |
| solicitud_de_promocion | REGISTRADA → EVALUADA → DECIDIDA (BR-112) | AGG |
| carga_de_gitlab | PROGRAMADA → EJECUTANDO → COMPLETADA / FALLIDA / SIN_CAMBIOS (BR-113) | AGG |

## 6. Linaje DDM-001 → LDM-001

| Agregado (DDM-001) | Entidades lógicas |
|---|---|
| AGG-01 Parte | parte, persona, organizacion, dato_de_contacto |
| AGG-02 RolDeLaParte | rol_de_la_parte |
| AGG-03 RelaciónEntrePartes | relacion_entre_partes |
| AGG-04 Plaza | plaza, plaza_rol_nivel |
| AGG-05 OcupaciónDePlaza | ocupacion_de_plaza |
| AGG-06 Usuario | usuario, usuario_rol_de_usuario, correccion_de_vinculo |
| AGG-07 Seniority | seniority, nivel_de_desarrollo |
| AGG-08 Competencia | competencia, competencia_nivel_de_logro |
| AGG-09 Rol | rol, rol_competencia, rol_nivel, rol_nivel_competencia_minimo |
| AGG-10 Curso | curso, objetivo_de_curso, rubrica_nivel, evidencia_esperada |
| AGG-11 EdiciónDeCurso | edicion_de_curso, enrolamiento, certificacion_de_curso |
| AGG-12 EvidenciaAportada | evidencia_aportada |
| AGG-13 ValoraciónDeCompetencia | valoracion_de_competencia, valoracion_registro |
| AGG-14 EvaluaciónDeDesempeño | evaluacion_de_desempeno, evaluacion_evidencia, evaluacion_certificacion |
| AGG-15 SolicitudDePromoción | solicitud_de_promocion |
| AGG-16 PromociónDeNivel | promocion_de_nivel, promocion_certificacion, promocion_evidencia_proyecto, promocion_valoracion |
| AGG-17 Producto | producto |
| AGG-18 Proyecto | proyecto, proyecto_milestone, proyecto_rol_nivel_requerido, jefatura_de_proyecto |
| AGG-19 Asignación | asignacion, excepcion_de_asignacion, colaborador_carga |
| AGG-20 MotivoDeExcepción | motivo_de_excepcion |
| AGG-21 CargaDeGitLab | carga_de_gitlab |
| RPL-01 Réplica | replica_milestone, replica_issue |

**Cobertura inversa:** las 21 raíces y la réplica tienen entidades. No hay entidad huérfana. Todas las asociativas (`rol_competencia`, `evaluacion_*`, `promocion_*`, `proyecto_milestone`, `proyecto_rol_nivel_requerido`, `usuario_rol_de_usuario`) pertenecen a un agregado.

**Cobertura de invariantes:** INV-01 (parte, K de persona/organización), INV-02 (K-01), INV-03/04 (K-02), INV-05 (K-05), INV-06 (K-04), INV-07 (K-08 y §5), INV-08 (K-11), INV-09 (K-12, K-16), INV-10 (K-13), INV-11 (K-14, K-15), INV-12 (K-17), INV-13 (K-18), INV-14 (K-20), INV-15 (K-22, K-23), INV-16/17 (K-25), INV-18 (K-26), INV-19 (K-30), INV-20 (K-29), INV-21 (K-31), INV-22 (K-33), INV-23 (K-34), INV-24 (K-35, K-36), INV-25 (K-37), INV-26 (§4), INV-27 (K-06).

## 7. Desnormalización

Ninguna. No hay evidencia de carga de trabajo que la justifique. La vigencia de las asignaciones, la suma de dedicación y el «rol/nivel vigente de una persona» se **calculan**, no se almacenan.

## 8. Supuestos que el modelo adopta (aceptados por D-H15)

| ID | Supuesto | Origen |
|---|---|---|
| S-01 | Un perfil de competencias por rol: el perfil se modela como `rol_competencia` | IM-Q9 abierta |
| S-02 | El nivel de desarrollo es una posición dentro de cada seniority (único por `seniority_id`, `nivel`) | IM-Q6 abierta |
| S-03 | Una plaza no tiene más datos propios que su organización, su rol/nivel y su ocupación. Vacante = sin ocupación vigente | IM-Q28 abierta |
| S-04 | `ES_PARTE_DE`: una organización es parte de a lo sumo una vigente | R-67 retirada (INFERENCE) |
| S-05 | `evidencia_esperada.descripcion` es el único atributo descriptivo (la fuente no nombra atributos) | BR-058 |
| S-06 | Una persona no repite el mismo tipo de rol de la parte con vigencias solapadas | A-04, BR-079 |
| S-07 | ~~Los datos de contacto son solo de personas~~ **Reemplazado el 2026-10-12 (D-160, BR-131):** toda parte, persona u organización, tiene datos de contacto | IM-Q26 |
| S-08 | Quien se desenrola puede enrolarse de nuevo en la misma edición | BR-027, sin fuente |

## 9. Estado del gate

`LOGICAL_MODEL_READY` = **PASSED**, por decisión de ianache (2026-10-11).

| Requisito del gate | Estado |
|---|---|
| Cada elemento mapea a DDD | Cumplido (§6), sin huérfanos |
| Cardinalidades completas | Cumplido (D-H16, D-H17) |
| Racional de restricciones | Cumplido (K-01..K-43 con origen) |
| Referencias entre contextos | Listadas (§3); el mecanismo de consistencia es de S4 |
| Sin FK entre contextos | Cumplido |
| Datos sensibles | Clasificación provisional como **deuda técnica DT-01** (D-H24) |

No hay contradicción de propiedad, así que no es `BLOCKED`.

## 10. Decisiones y preguntas para el responsable

### Decisiones registradas (ianache, 2026-10-11, en sesión)

| ID | Decisión | Efecto |
|---|---|---|
| D-H14 | **U-L1:** la evidencia de proyecto se liga solo por la URL del issue; no se liga además a un proyecto | `evidencia_aportada` no lleva `proyecto_ref`. El proyecto se obtiene del milestone del issue en la réplica de CTX-07 |
| D-H15 | **U-L4:** se aceptan los supuestos S-01 a S-08 | S-01..S-08 pasan de supuesto a decisión. Cierran en la práctica IM-Q6, IM-Q9, IM-Q26 e IM-Q28 de IMD-001 |
| D-H16 | **U-L2:** el enrolamiento registra un porcentaje (avance), una nota (evaluación) y un texto (comentarios) | `avance_porcentaje`, `nota`, `comentarios`. Interpretación a confirmar (ver abajo) |
| D-H17 | **U-L3:** una solicitud de promoción termina en 0 o 1 promoción de nivel, y el Jefe de Ingeniería puede promover sin solicitud | `promocion_de_nivel.solicitud_de_promocion_id` nullable y único |
| D-H23 | **U-L5:** la nota usa una escala de 0 a 20 y el mínimo aprobatorio es 12 | K-40: CHECK 0..20; el 12 es solo informativo (D-H25) |
| D-H25 | **U-L6:** una nota mayor o igual que 12 es informativa; no es condición de la certificación | K-20 no cambia (BR-021 sigue siendo el 100 % de las evidencias obligatorias validadas). El 12 no se almacena |
| D-H24 | **RQ-34:** se ignora la política de ADR-P4 por ahora y se registra como **deuda técnica DT-01** para tratamiento futuro | S5 no implementa controles específicos de datos personales. Riesgo: ver DT-01 |
| D-H35 | **R-05 (revisión):** el responsable funcional confirma el aplazamiento de la política de datos personales como deuda técnica DT-01. Seguridad no lo ha aceptado | Sin cambio en el modelo. Riesgo residual en RPT-DDR-001 §6 |

**Interpretación de D-H16 por confirmar:** respondiste «Porcentaje, Nota y Texto». Entendí avance = porcentaje, evaluación = nota y un texto libre de comentarios. Si el texto era otra cosa, cambia solo ese atributo.

### Deuda técnica

| ID | Deuda | Riesgo asumido | Cómo se retoma |
|---|---|---|---|
| DT-01 | Política de datos personales (ADR-P4): clasificación, cifrado, control de acceso y borrado a solicitud del titular. Los datos personales se retienen por siempre (D-H1) | Datos personales (nombres, contactos, correo, username, desempeño) sin cifrado ni acceso restringido por clasificación, y sin mecanismo de borrado. Incumplimiento posible de la normativa de protección de datos | Decidir ADR-P4 y aplicarlo con una migración Flyway nueva. La lista de §4 identifica las columnas afectadas |

### Preguntas abiertas

Ninguna. La moneda del costo (soles peruanos) y la unidad del esfuerzo (horas-persona) quedaron fijadas en D-H26 (PDM-001).

### Equivalencias con las fuentes de negocio (registro, ADR-DB-001)

Las decisiones del responsable quedaron registradas en RCP-001 (decisiones D-xxx) y BRC-001 (reglas BR-xxx), y reflejadas en IMD-001. Los identificadores D-Hnn de los documentos de diseño equivalen a:

| Decisión de diseño | RCP-001 | BRC-001 |
|---|---|---|
| D-H1 | D-133 | BR-101 |
| D-H2 | D-134 | BR-102 |
| D-H3 | D-135 | BR-103, BR-104 |
| D-H4 | D-136 | BR-106 |
| D-H5 | D-137 | BR-107 |
| D-H7 | D-138 | BR-108 |
| D-H8 | D-139 | BR-109 |
| D-H11 | D-140 | BR-105 |
| D-H12 | D-141 | BR-110 |
| D-H13 | D-142 | BR-111, BR-112, BR-113 |
| D-H14 | D-143 | BR-114 |
| D-H15 (S-01 a S-08) | D-144 a D-151 | BR-115 a BR-122 |
| D-H16 | D-152 | BR-123 |
| D-H17 | D-153 | BR-124 |
| D-H19 | D-154 | BR-125 |
| D-H23, D-H25 | D-155 | BR-126 |
| D-H26 | D-156 | BR-127 |
| D-H30, D-H31, D-H33 | D-157 | BR-128 |
| D-H34 (vínculo fijo y corrección) | D-158 | BR-129 |
| D-H34 (baja de contactos) | D-159 | BR-130 |
| D-H44 (toda parte tiene contactos; reemplaza S-07 y D-150) | D-160 | BR-131 |
| D-H45 (contactos de organizaciones y correo único entre partes) | D-161, D-162 | BR-132, BR-133 |
| D-H46 (nombre de rol JEFE_INGENIERIA; ADMIN suple al Jefe de Ingeniería; quién mantiene las funcionalidades de las partes) | D-164 a D-166 | BR-134, BR-135 |

**Sin registro de negocio** (son decisiones de diseño o de gobierno, no reglas de negocio): D-H6, D-H9 y D-H10 (contextos y propiedad); D-H18, D-H20, D-H21 y D-H22 (contratos de integración); D-H27, D-H28 y D-H29 (diseño físico); D-H34 en lo relativo a la fila de bloqueo (R-02) y al evento de promoción obsoleto (R-04). D-H24 y D-H35 (confirmación del 2026-10-12) se registran como RQ-34 (deuda técnica DT-01) y D-H32 como RQ-35 (deuda técnica DT-03), porque son aplazamientos y no reglas.
