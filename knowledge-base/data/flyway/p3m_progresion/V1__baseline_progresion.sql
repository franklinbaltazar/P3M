-- p3m_progresion (CTX-05 Progresión) | LDM-001 §2.5 | AGG-12..AGG-16
-- *_por_ref (actor) guarda el GUID de Keycloak (D-H20). Los demás *_ref son referencias a otros contextos (sin FK).

CREATE TABLE solicitud_de_promocion (
  id                     BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  colaborador_ref        BIGINT UNSIGNED NOT NULL,
  rol_nivel_destino_ref  BIGINT UNSIGNED NOT NULL,
  estado                 VARCHAR(12)     NOT NULL,
  CONSTRAINT pk_solicitud_de_promocion PRIMARY KEY (id),
  CONSTRAINT ck_solicitud_estado CHECK (estado IN ('REGISTRADA', 'EVALUADA', 'DECIDIDA')),
  KEY ix_solicitud_colaborador (colaborador_ref, estado)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- K-22 (una evidencia por esperada y enrolamiento; la de curso exige ambos), K-24 (VALIDADA exige validador y fecha).
-- K-23 (issue Closed Task/UserStory) lo valida el servicio con CON-10. issue_url distingue mayúsculas (utf8mb4_bin).
CREATE TABLE evidencia_aportada (
  id                        BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  tipo                      VARCHAR(10)     NOT NULL,
  colaborador_ref           BIGINT UNSIGNED NOT NULL,
  issue_url                 VARCHAR(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  enrolamiento_ref          BIGINT UNSIGNED NULL,
  evidencia_esperada_ref    BIGINT UNSIGNED NULL,
  solicitud_de_promocion_id BIGINT UNSIGNED NULL,
  estado                    VARCHAR(10)     NOT NULL,
  validada_por_ref          BIGINT UNSIGNED NULL,
  validada_en               DATETIME(3)     NULL,
  CONSTRAINT pk_evidencia_aportada PRIMARY KEY (id),
  CONSTRAINT uq_evidencia_esperada_enrolamiento UNIQUE (enrolamiento_ref, evidencia_esperada_ref),
  CONSTRAINT fk_evidencia_solicitud FOREIGN KEY (solicitud_de_promocion_id) REFERENCES solicitud_de_promocion (id),
  CONSTRAINT ck_evidencia_tipo CHECK (tipo IN ('CURSO', 'PROYECTO')),
  CONSTRAINT ck_evidencia_estado CHECK (estado IN ('PENDIENTE', 'VALIDADA')),
  CONSTRAINT ck_evidencia_curso CHECK (tipo <> 'CURSO' OR (enrolamiento_ref IS NOT NULL AND evidencia_esperada_ref IS NOT NULL)),
  CONSTRAINT ck_evidencia_validada CHECK (estado <> 'VALIDADA' OR (validada_por_ref IS NOT NULL AND validada_en IS NOT NULL)),
  KEY ix_evidencia_colaborador (colaborador_ref, tipo, estado)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE valoracion_de_competencia (
  id               BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  colaborador_ref  BIGINT UNSIGNED NOT NULL,
  competencia_ref  BIGINT UNSIGNED NOT NULL,
  CONSTRAINT pk_valoracion_de_competencia PRIMARY KEY (id),
  CONSTRAINT uq_valoracion_colaborador_competencia UNIQUE (colaborador_ref, competencia_ref)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- K-25: solo inserción (se refuerza con los permisos: sin UPDATE ni DELETE).
CREATE TABLE valoracion_registro (
  id                 BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  valoracion_id      BIGINT UNSIGNED NOT NULL,
  nivel_de_logro     CHAR(2)         NOT NULL,
  registrada_por_ref CHAR(36) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  registrada_en      DATETIME(3)     NOT NULL,
  CONSTRAINT pk_valoracion_registro PRIMARY KEY (id),
  CONSTRAINT fk_valoracion_registro_valoracion FOREIGN KEY (valoracion_id) REFERENCES valoracion_de_competencia (id),
  CONSTRAINT ck_valoracion_registro_nivel CHECK (nivel_de_logro IN ('N1', 'N2', 'N3')),
  KEY ix_valoracion_registro_reciente (valoracion_id, registrada_en)   -- CON-07 (la más reciente)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- K-25 (solo inserción) y K-27 (periodo coherente).
CREATE TABLE evaluacion_de_desempeno (
  id                 BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  colaborador_ref    BIGINT UNSIGNED NOT NULL,
  periodo_desde      DATE            NOT NULL,
  periodo_hasta      DATE            NOT NULL,
  resultado          VARCHAR(10)     NOT NULL,
  comentarios        TEXT            NULL,
  registrada_en      DATETIME(3)     NOT NULL,
  registrada_por_ref CHAR(36) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  CONSTRAINT pk_evaluacion_de_desempeno PRIMARY KEY (id),
  CONSTRAINT ck_evaluacion_resultado CHECK (resultado IN ('SUPERA', 'CUMPLE', 'PARCIAL', 'NO_CUMPLE')),
  CONSTRAINT ck_evaluacion_periodo CHECK (periodo_hasta >= periodo_desde),
  KEY ix_evaluacion_colaborador (colaborador_ref, periodo_hasta)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE evaluacion_evidencia (
  evaluacion_id          BIGINT UNSIGNED NOT NULL,
  evidencia_aportada_id  BIGINT UNSIGNED NOT NULL,
  CONSTRAINT pk_evaluacion_evidencia PRIMARY KEY (evaluacion_id, evidencia_aportada_id),
  CONSTRAINT fk_evaluacion_evidencia_evaluacion FOREIGN KEY (evaluacion_id) REFERENCES evaluacion_de_desempeno (id),
  CONSTRAINT fk_evaluacion_evidencia_evidencia FOREIGN KEY (evidencia_aportada_id) REFERENCES evidencia_aportada (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE evaluacion_certificacion (
  evaluacion_id      BIGINT UNSIGNED NOT NULL,
  certificacion_ref  BIGINT UNSIGNED NOT NULL,   -- CTX-04 (sin FK)
  CONSTRAINT pk_evaluacion_certificacion PRIMARY KEY (evaluacion_id, certificacion_ref),
  CONSTRAINT fk_evaluacion_certificacion_evaluacion FOREIGN KEY (evaluacion_id) REFERENCES evaluacion_de_desempeno (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- K-26 (evaluación obligatoria), K-41 (una promoción por solicitud).
-- decidida_en se añade en S5: ICP-001 EVT-01 ordena y firma el evento con ese dato.
CREATE TABLE promocion_de_nivel (
  id                         BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  colaborador_ref            BIGINT UNSIGNED NOT NULL,
  rol_nivel_destino_ref      BIGINT UNSIGNED NOT NULL,
  decidida_por_ref           CHAR(36) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  decidida_en                DATETIME(3)     NOT NULL,
  evaluacion_de_desempeno_id BIGINT UNSIGNED NOT NULL,
  solicitud_de_promocion_id  BIGINT UNSIGNED NULL,
  CONSTRAINT pk_promocion_de_nivel PRIMARY KEY (id),
  CONSTRAINT uq_promocion_solicitud UNIQUE (solicitud_de_promocion_id),
  CONSTRAINT fk_promocion_evaluacion FOREIGN KEY (evaluacion_de_desempeno_id) REFERENCES evaluacion_de_desempeno (id),
  CONSTRAINT fk_promocion_solicitud FOREIGN KEY (solicitud_de_promocion_id) REFERENCES solicitud_de_promocion (id),
  KEY ix_promocion_colaborador (colaborador_ref, decidida_en)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE promocion_certificacion (
  promocion_id       BIGINT UNSIGNED NOT NULL,
  certificacion_ref  BIGINT UNSIGNED NOT NULL,   -- CTX-04 (sin FK)
  CONSTRAINT pk_promocion_certificacion PRIMARY KEY (promocion_id, certificacion_ref),
  CONSTRAINT fk_promocion_certificacion_promocion FOREIGN KEY (promocion_id) REFERENCES promocion_de_nivel (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE promocion_evidencia_proyecto (
  promocion_id           BIGINT UNSIGNED NOT NULL,
  evidencia_aportada_id  BIGINT UNSIGNED NOT NULL,
  CONSTRAINT pk_promocion_evidencia_proyecto PRIMARY KEY (promocion_id, evidencia_aportada_id),
  CONSTRAINT fk_promocion_evidencia_promocion FOREIGN KEY (promocion_id) REFERENCES promocion_de_nivel (id),
  CONSTRAINT fk_promocion_evidencia_evidencia FOREIGN KEY (evidencia_aportada_id) REFERENCES evidencia_aportada (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE promocion_valoracion (
  promocion_id           BIGINT UNSIGNED NOT NULL,
  valoracion_registro_id BIGINT UNSIGNED NOT NULL,
  CONSTRAINT pk_promocion_valoracion PRIMARY KEY (promocion_id, valoracion_registro_id),
  CONSTRAINT fk_promocion_valoracion_promocion FOREIGN KEY (promocion_id) REFERENCES promocion_de_nivel (id),
  CONSTRAINT fk_promocion_valoracion_registro FOREIGN KEY (valoracion_registro_id) REFERENCES valoracion_registro (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Tabla técnica (no es del modelo lógico): outbox transaccional de EVT-01 (ICP-001 P-7).
-- Se inserta en la misma transacción que promocion_de_nivel. No se borra (P-3): permite republicar.
CREATE TABLE outbox_evento (
  id              BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  evento_id       CHAR(36) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  tipo            VARCHAR(60)     NOT NULL,
  schema_version  SMALLINT UNSIGNED NOT NULL,
  clave_orden     BIGINT UNSIGNED NOT NULL,       -- persona_ref: orden por persona
  payload         JSON            NOT NULL,       -- solo identificadores y fecha, sin datos personales
  creado_en       DATETIME(3)     NOT NULL,
  publicado_en    DATETIME(3)     NULL,
  CONSTRAINT pk_outbox_evento PRIMARY KEY (id),
  CONSTRAINT uq_outbox_evento_id UNIQUE (evento_id),
  KEY ix_outbox_pendientes (publicado_en, id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
