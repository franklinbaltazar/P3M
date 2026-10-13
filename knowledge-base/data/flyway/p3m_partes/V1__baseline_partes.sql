-- p3m_partes (CTX-01 Partes y organización) | LDM-001 §2.1 | AGG-01..AGG-05
-- Baseline. Idempotencia: Flyway aplica una sola vez. No se edita tras aplicarse (checksum).
-- Tiempos: DATETIME(3) en UTC. Sin claves foráneas hacia otros esquemas (ADR-DB-002).

CREATE TABLE parte (
  id          BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  tipo_parte  VARCHAR(12)     NOT NULL,
  CONSTRAINT pk_parte PRIMARY KEY (id),
  CONSTRAINT uq_parte_id_tipo UNIQUE (id, tipo_parte),
  CONSTRAINT ck_parte_tipo CHECK (tipo_parte IN ('PERSONA', 'ORGANIZACION'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- INV-01: la parte es persona u organización; el tipo se fija con FK compuesta.
CREATE TABLE persona (
  parte_id          BIGINT UNSIGNED NOT NULL,
  tipo_parte        VARCHAR(12)     NOT NULL DEFAULT 'PERSONA',
  nombres           VARCHAR(150)    NOT NULL,
  apellido_paterno  VARCHAR(100)    NOT NULL,
  apellido_materno  VARCHAR(100)    NOT NULL,
  CONSTRAINT pk_persona PRIMARY KEY (parte_id),
  CONSTRAINT fk_persona_parte FOREIGN KEY (parte_id, tipo_parte) REFERENCES parte (id, tipo_parte),
  CONSTRAINT ck_persona_tipo CHECK (tipo_parte = 'PERSONA')
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE organizacion (
  parte_id    BIGINT UNSIGNED NOT NULL,
  tipo_parte  VARCHAR(12)     NOT NULL DEFAULT 'ORGANIZACION',
  razon_social      VARCHAR(200) NOT NULL,   -- Business Name (D-167)
  nombre_comercial  VARCHAR(200) NULL,       -- Commercial Name
  tax_id            VARCHAR(30)  NULL,       -- Tax ID; obligatoriedad y unicidad sin definir (US-035-Q2)
  inactivada_en     DATETIME(3)  NULL,       -- baja = inactivar, sin borrar (D-168)
  inactivada_por_ref CHAR(36) CHARACTER SET ascii COLLATE ascii_bin NULL,   -- GUID de Keycloak (D-H20)
  CONSTRAINT pk_organizacion PRIMARY KEY (parte_id),
  CONSTRAINT uq_organizacion_razon_social UNIQUE (razon_social),
  CONSTRAINT ck_organizacion_inactivacion CHECK ((inactivada_en IS NULL) = (inactivada_por_ref IS NULL)),
  CONSTRAINT fk_organizacion_parte FOREIGN KEY (parte_id, tipo_parte) REFERENCES parte (id, tipo_parte),
  CONSTRAINT ck_organizacion_tipo CHECK (tipo_parte = 'ORGANIZACION')
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Toda parte, persona u organización, tiene datos de contacto (D-160, BR-131). `tipo_parte` se fija con FK compuesta a parte(id, tipo_parte).
-- K-43: el correo vigente es único entre TODAS las partes, personas y organizaciones (BR-125, BR-131; clave de vinculación con Keycloak, D-H19).
-- K-44: un contacto no se borra (D-H1): se da de baja con fecha y responsable (quién y cuándo). La baja libera la dirección,
--       por ejemplo cuando un correo se reutiliza (RPT-DDR-001 R-01, acción c).
-- K-01 (al menos un correo y un teléfono vigentes por persona) lo garantiza el agregado (AGG).
CREATE TABLE dato_de_contacto (
  id            BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  parte_id      BIGINT UNSIGNED NOT NULL,
  tipo_parte    VARCHAR(12)     NOT NULL,
  tipo          VARCHAR(10)     NOT NULL,
  valor         VARCHAR(300)    NOT NULL,
  vigente_hasta DATETIME(3)     NULL,
  baja_por_ref  CHAR(36) CHARACTER SET ascii COLLATE ascii_bin NULL,   -- GUID de Keycloak (D-H20)
  correo_unico  VARCHAR(300) GENERATED ALWAYS AS
                  (IF(tipo = 'CORREO' AND vigente_hasta IS NULL, valor, NULL)) VIRTUAL,
  CONSTRAINT pk_dato_de_contacto PRIMARY KEY (id),
  CONSTRAINT uq_dato_de_contacto_correo UNIQUE (correo_unico),
  CONSTRAINT fk_dato_de_contacto_parte FOREIGN KEY (parte_id, tipo_parte) REFERENCES parte (id, tipo_parte),
  CONSTRAINT ck_dato_de_contacto_tipo CHECK (tipo IN ('CORREO', 'TELEFONO', 'DIRECCION')),
  CONSTRAINT ck_dato_de_contacto_baja CHECK ((vigente_hasta IS NULL) = (baja_por_ref IS NULL)),
  KEY ix_dato_de_contacto_parte (parte_id, tipo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- K-07 (sin vigencias solapadas por persona y tipo) lo garantiza el servicio (POL).
CREATE TABLE rol_de_la_parte (
  id             BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  persona_id     BIGINT UNSIGNED NOT NULL,
  tipo_rol       VARCHAR(12)     NOT NULL,
  vigente_desde  DATETIME(3)     NOT NULL,
  vigente_hasta  DATETIME(3)     NULL,
  CONSTRAINT pk_rol_de_la_parte PRIMARY KEY (id),
  CONSTRAINT fk_rol_de_la_parte_persona FOREIGN KEY (persona_id) REFERENCES persona (parte_id),
  CONSTRAINT ck_rol_de_la_parte_tipo CHECK (tipo_rol IN ('COLABORADOR', 'EVALUADOR')),
  CONSTRAINT ck_rol_de_la_parte_vigencia CHECK (vigente_hasta IS NULL OR vigente_hasta > vigente_desde),
  KEY ix_rol_de_la_parte_persona (persona_id, tipo_rol, vigente_hasta)   -- CON-01
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- K-02, K-03, S-04: una sola relación vigente por (origen, tipo); tipos de parte según la relación.
CREATE TABLE relacion_entre_partes (
  id                  BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  parte_origen_id     BIGINT UNSIGNED NOT NULL,
  origen_tipo_parte   VARCHAR(12)     NOT NULL,
  parte_destino_id    BIGINT UNSIGNED NOT NULL,
  destino_tipo_parte  VARCHAR(12)     NOT NULL,
  tipo                VARCHAR(12)     NOT NULL,
  vigente_desde       DATETIME(3)     NOT NULL,
  vigente_hasta       DATETIME(3)     NULL,
  vigente_clave       VARCHAR(40) GENERATED ALWAYS AS
                        (IF(vigente_hasta IS NULL, CONCAT(parte_origen_id, ':', tipo), NULL)) VIRTUAL,
  CONSTRAINT pk_relacion_entre_partes PRIMARY KEY (id),
  CONSTRAINT uq_relacion_vigente UNIQUE (vigente_clave),
  CONSTRAINT fk_relacion_origen FOREIGN KEY (parte_origen_id, origen_tipo_parte) REFERENCES parte (id, tipo_parte),
  CONSTRAINT fk_relacion_destino FOREIGN KEY (parte_destino_id, destino_tipo_parte) REFERENCES parte (id, tipo_parte),
  CONSTRAINT ck_relacion_tipo CHECK (tipo IN ('REPORTA_A', 'MEMBERSHIP', 'ES_PARTE_DE')),
  CONSTRAINT ck_relacion_partes CHECK (
       (tipo = 'REPORTA_A'   AND origen_tipo_parte = 'PERSONA'      AND destino_tipo_parte = 'PERSONA')
    OR (tipo = 'MEMBERSHIP'  AND origen_tipo_parte = 'PERSONA'      AND destino_tipo_parte = 'ORGANIZACION')
    OR (tipo = 'ES_PARTE_DE' AND origen_tipo_parte = 'ORGANIZACION' AND destino_tipo_parte = 'ORGANIZACION')),
  CONSTRAINT ck_relacion_vigencia CHECK (vigente_hasta IS NULL OR vigente_hasta > vigente_desde),
  KEY ix_relacion_destino (parte_destino_id, tipo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE plaza (
  id               BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  organizacion_id  BIGINT UNSIGNED NOT NULL,
  CONSTRAINT pk_plaza PRIMARY KEY (id),
  CONSTRAINT fk_plaza_organizacion FOREIGN KEY (organizacion_id) REFERENCES organizacion (parte_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- K-06 (un solo rol/nivel vigente por plaza), K-42 (promocion_ref único: idempotencia de EVT-01).
CREATE TABLE plaza_rol_nivel (
  id              BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  plaza_id        BIGINT UNSIGNED NOT NULL,
  rol_nivel_ref   BIGINT UNSIGNED NOT NULL,   -- CTX-03 (sin FK)
  vigente_desde   DATETIME(3)     NOT NULL,
  vigente_hasta   DATETIME(3)     NULL,
  promocion_ref   BIGINT UNSIGNED NULL,       -- CTX-05 (sin FK)
  vigente_plaza   BIGINT UNSIGNED GENERATED ALWAYS AS (IF(vigente_hasta IS NULL, plaza_id, NULL)) VIRTUAL,
  CONSTRAINT pk_plaza_rol_nivel PRIMARY KEY (id),
  CONSTRAINT uq_plaza_rol_nivel_vigente UNIQUE (vigente_plaza),
  CONSTRAINT uq_plaza_rol_nivel_promocion UNIQUE (promocion_ref),
  CONSTRAINT fk_plaza_rol_nivel_plaza FOREIGN KEY (plaza_id) REFERENCES plaza (id),
  CONSTRAINT ck_plaza_rol_nivel_vigencia CHECK (vigente_hasta IS NULL OR vigente_hasta > vigente_desde),
  KEY ix_plaza_rol_nivel_plaza (plaza_id, vigente_hasta),
  KEY ix_plaza_rol_nivel_rol_nivel (rol_nivel_ref)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- K-04 (una ocupación vigente por plaza), K-05 (una por persona). K-09 (rol COLABORADOR vigente) lo valida el agregado.
CREATE TABLE ocupacion_de_plaza (
  id               BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  plaza_id         BIGINT UNSIGNED NOT NULL,
  persona_id       BIGINT UNSIGNED NOT NULL,
  vigente_desde    DATETIME(3)     NOT NULL,
  vigente_hasta    DATETIME(3)     NULL,
  vigente_plaza    BIGINT UNSIGNED GENERATED ALWAYS AS (IF(vigente_hasta IS NULL, plaza_id, NULL)) VIRTUAL,
  vigente_persona  BIGINT UNSIGNED GENERATED ALWAYS AS (IF(vigente_hasta IS NULL, persona_id, NULL)) VIRTUAL,
  CONSTRAINT pk_ocupacion_de_plaza PRIMARY KEY (id),
  CONSTRAINT uq_ocupacion_vigente_plaza UNIQUE (vigente_plaza),
  CONSTRAINT uq_ocupacion_vigente_persona UNIQUE (vigente_persona),
  CONSTRAINT fk_ocupacion_plaza FOREIGN KEY (plaza_id) REFERENCES plaza (id),
  CONSTRAINT fk_ocupacion_persona FOREIGN KEY (persona_id) REFERENCES persona (parte_id),
  CONSTRAINT ck_ocupacion_vigencia CHECK (vigente_hasta IS NULL OR vigente_hasta > vigente_desde),
  KEY ix_ocupacion_persona (persona_id, vigente_hasta)   -- CON-02
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
