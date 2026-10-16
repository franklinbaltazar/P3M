-- p3m_portafolio (CTX-06 Portafolio y asignación) | LDM-001 §2.6 | AGG-17..AGG-20
-- colaborador_ref, rol_nivel_ref y milestone_ref son referencias a otros contextos (sin FK).
-- actor (*_por_ref) = GUID de Keycloak (D-H20).

CREATE TABLE tb_producto (
  id                 BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  codigo             VARCHAR(30)     NOT NULL,
  nombre             VARCHAR(200)    NOT NULL,
  gitlab_project_id  BIGINT UNSIGNED NOT NULL,
  CONSTRAINT pk_producto PRIMARY KEY (id),
  CONSTRAINT uq_producto_codigo UNIQUE (codigo),
  KEY idx_producto_gitlab (gitlab_project_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- costo_estimado en soles peruanos (PEN) y esfuerzo_estimado en horas-persona (D-H26).
CREATE TABLE tb_proyecto (
  id                BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  producto_id       BIGINT UNSIGNED NOT NULL,
  codigo            VARCHAR(30)     NOT NULL,
  nombre            VARCHAR(200)    NOT NULL,
  fecha_inicio      DATE            NOT NULL,
  fecha_fin         DATE            NOT NULL,
  costo_estimado    DECIMAL(14,2)   NULL COMMENT 'PEN (soles peruanos)',
  esfuerzo_estimado DECIMAL(10,2)   NULL COMMENT 'horas-persona',
  CONSTRAINT pk_proyecto PRIMARY KEY (id),
  CONSTRAINT uq_proyecto_codigo UNIQUE (codigo),
  CONSTRAINT fk_proyecto_producto FOREIGN KEY (producto_id) REFERENCES tb_producto (id),
  CONSTRAINT ck_proyecto_fechas CHECK (fecha_fin >= fecha_inicio),
  CONSTRAINT ck_proyecto_montos CHECK ((costo_estimado IS NULL OR costo_estimado >= 0)
                                   AND (esfuerzo_estimado IS NULL OR esfuerzo_estimado >= 0)),
  KEY idx_proyecto_producto (producto_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- K-30: un milestone pertenece a un solo proyecto.
CREATE TABLE tb_proyecto_milestone (
  proyecto_id    BIGINT UNSIGNED NOT NULL,
  milestone_ref  BIGINT UNSIGNED NOT NULL,   -- id global del milestone en GitLab (CTX-07)
  CONSTRAINT pk_proyecto_milestone PRIMARY KEY (proyecto_id, milestone_ref),
  CONSTRAINT uq_proyecto_milestone_milestone UNIQUE (milestone_ref),
  CONSTRAINT fk_proyecto_milestone_proyecto FOREIGN KEY (proyecto_id) REFERENCES tb_proyecto (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE tb_proyecto_rol_nivel_requerido (
  proyecto_id    BIGINT UNSIGNED NOT NULL,
  rol_nivel_ref  BIGINT UNSIGNED NOT NULL,
  cantidad       SMALLINT UNSIGNED NOT NULL,
  CONSTRAINT pk_proyecto_rol_nivel_requerido PRIMARY KEY (proyecto_id, rol_nivel_ref),
  CONSTRAINT fk_requerido_proyecto FOREIGN KEY (proyecto_id) REFERENCES tb_proyecto (id),
  CONSTRAINT ck_requerido_cantidad CHECK (cantidad > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- K-29: un solo jefe de proyecto vigente por proyecto (D-H2, D-H10).
CREATE TABLE tb_jefatura_de_proyecto (
  id               BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  proyecto_id      BIGINT UNSIGNED NOT NULL,
  colaborador_ref  BIGINT UNSIGNED NOT NULL,
  vigente_desde    DATETIME(3)     NOT NULL,
  vigente_hasta    DATETIME(3)     NULL,
  vigente_proyecto BIGINT UNSIGNED GENERATED ALWAYS AS (IF(vigente_hasta IS NULL, proyecto_id, NULL)) VIRTUAL,
  CONSTRAINT pk_jefatura_de_proyecto PRIMARY KEY (id),
  CONSTRAINT uq_jefatura_vigente UNIQUE (vigente_proyecto),
  CONSTRAINT fk_jefatura_proyecto FOREIGN KEY (proyecto_id) REFERENCES tb_proyecto (id),
  CONSTRAINT ck_jefatura_vigencia CHECK (vigente_hasta IS NULL OR vigente_hasta > vigente_desde),
  KEY idx_jefatura_colaborador (colaborador_ref, vigente_hasta)   -- CON-09
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE tb_motivo_de_excepcion (
  id           BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  codigo       VARCHAR(30)     NOT NULL,
  descripcion  VARCHAR(300)    NOT NULL,
  CONSTRAINT pk_motivo_de_excepcion PRIMARY KEY (id),
  CONSTRAINT uq_motivo_codigo UNIQUE (codigo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- K-47: fila de bloqueo por colaborador. Protocolo obligatorio de K-31 (suma de dedicación <= 100 %), RPT-DDR-001 R-02:
--   1) INSERT IGNORE INTO tb_colaborador_carga (colaborador_ref) VALUES (?);
--   2) SELECT colaborador_ref FROM tb_colaborador_carga WHERE colaborador_ref = ? FOR UPDATE;
--   3) sumar el porcentaje de las asignaciones vigentes y, si cabe, insertar; confirmar.
-- Serializa a los escritores del mismo colaborador con cualquier nivel de aislamiento y sin interbloqueos.
-- Probado: con READ COMMITTED y solo SELECT ... FOR UPDATE sobre tb_asignacion, dos primeras asignaciones sumaban 120 %.
CREATE TABLE tb_colaborador_carga (
  colaborador_ref  BIGINT UNSIGNED NOT NULL,   -- CTX-01 (sin FK)
  CONSTRAINT pk_colaborador_carga PRIMARY KEY (colaborador_ref)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- K-28 (rol/nivel requerido por el proyecto), K-32 (porcentaje). K-31 (suma <= 100) lo garantiza el servicio con el
-- protocolo de tb_colaborador_carga (K-47); el índice idx_asignacion_colaborador sirve a la suma.
CREATE TABLE tb_asignacion (
  id                    BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  colaborador_ref       BIGINT UNSIGNED NOT NULL,
  proyecto_id           BIGINT UNSIGNED NOT NULL,
  rol_nivel_ref         BIGINT UNSIGNED NOT NULL,
  porcentaje_dedicacion DECIMAL(5,2)    NOT NULL,
  vigente_desde         DATETIME(3)     NOT NULL,
  vigente_hasta         DATETIME(3)     NULL,
  estado                VARCHAR(10)     NOT NULL,
  realizada_por_ref     CHAR(36) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  CONSTRAINT pk_asignacion PRIMARY KEY (id),
  CONSTRAINT fk_asignacion_requerido FOREIGN KEY (proyecto_id, rol_nivel_ref)
    REFERENCES tb_proyecto_rol_nivel_requerido (proyecto_id, rol_nivel_ref),
  CONSTRAINT ck_asignacion_porcentaje CHECK (porcentaje_dedicacion > 0 AND porcentaje_dedicacion <= 100),
  CONSTRAINT ck_asignacion_estado CHECK (estado IN ('PENDIENTE', 'VIGENTE', 'FINALIZADA')),
  CONSTRAINT ck_asignacion_vigencia CHECK (vigente_hasta IS NULL OR vigente_hasta > vigente_desde),
  KEY idx_asignacion_colaborador (colaborador_ref, vigente_hasta),
  KEY idx_asignacion_proyecto (proyecto_id, estado)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE tb_excepcion_de_asignacion (
  asignacion_id      BIGINT UNSIGNED NOT NULL,
  motivo_id          BIGINT UNSIGNED NOT NULL,
  aprobada_por_ref   CHAR(36) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  CONSTRAINT pk_excepcion_de_asignacion PRIMARY KEY (asignacion_id),
  CONSTRAINT fk_excepcion_asignacion FOREIGN KEY (asignacion_id) REFERENCES tb_asignacion (id),
  CONSTRAINT fk_excepcion_motivo FOREIGN KEY (motivo_id) REFERENCES tb_motivo_de_excepcion (id),   -- BR-067: RESTRICT
  KEY idx_excepcion_motivo (motivo_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
