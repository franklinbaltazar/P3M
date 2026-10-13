-- p3m_formacion (CTX-04 Formación) | LDM-001 §2.4 | AGG-10, AGG-11
-- competencia_ref, evaluador_ref y colaborador_ref son referencias a otros contextos (sin FK).

CREATE TABLE curso (
  id      BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  codigo  VARCHAR(30)     NOT NULL,
  nombre  VARCHAR(200)    NOT NULL,
  sumilla TEXT            NOT NULL,
  CONSTRAINT pk_curso PRIMARY KEY (id),
  CONSTRAINT uq_curso_codigo UNIQUE (codigo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE objetivo_de_curso (
  id              BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  curso_id        BIGINT UNSIGNED NOT NULL,
  descripcion     TEXT            NOT NULL,
  competencia_ref BIGINT UNSIGNED NOT NULL,
  nivel_objetivo  CHAR(2)         NOT NULL,
  CONSTRAINT pk_objetivo_de_curso PRIMARY KEY (id),
  CONSTRAINT fk_objetivo_curso FOREIGN KEY (curso_id) REFERENCES curso (id),
  CONSTRAINT ck_objetivo_nivel CHECK (nivel_objetivo IN ('N1', 'N2', 'N3')),
  KEY ix_objetivo_competencia (competencia_ref)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- La rúbrica es el conjunto de sus niveles (R-56). Tres filas por objetivo lo garantiza el agregado.
CREATE TABLE rubrica_nivel (
  objetivo_id            BIGINT UNSIGNED NOT NULL,
  nivel_de_logro         CHAR(2)         NOT NULL,
  descripcion_desempeno  TEXT            NOT NULL,
  CONSTRAINT pk_rubrica_nivel PRIMARY KEY (objetivo_id, nivel_de_logro),
  CONSTRAINT fk_rubrica_objetivo FOREIGN KEY (objetivo_id) REFERENCES objetivo_de_curso (id),
  CONSTRAINT ck_rubrica_nivel CHECK (nivel_de_logro IN ('N1', 'N2', 'N3'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- K-17: la evidencia esperada pertenece a un nivel de la rúbrica de su objetivo.
CREATE TABLE evidencia_esperada (
  id              BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  objetivo_id     BIGINT UNSIGNED NOT NULL,
  nivel_de_logro  CHAR(2)         NOT NULL,
  descripcion     TEXT            NOT NULL,
  obligatoriedad  VARCHAR(12)     NOT NULL,
  CONSTRAINT pk_evidencia_esperada PRIMARY KEY (id),
  CONSTRAINT fk_evidencia_esperada_rubrica FOREIGN KEY (objetivo_id, nivel_de_logro)
    REFERENCES rubrica_nivel (objetivo_id, nivel_de_logro),
  CONSTRAINT ck_evidencia_esperada_obligatoriedad CHECK (obligatoriedad IN ('OBLIGATORIA', 'DESEABLE')),
  KEY ix_evidencia_esperada_objetivo (objetivo_id, obligatoriedad)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE edicion_de_curso (
  id                 BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  curso_id           BIGINT UNSIGNED NOT NULL,
  numero_de_edicion  SMALLINT UNSIGNED NOT NULL,
  fecha_inicio       DATE            NOT NULL,
  fecha_fin          DATE            NOT NULL,
  cupo               SMALLINT UNSIGNED NOT NULL,
  evaluador_ref      BIGINT UNSIGNED NOT NULL,
  CONSTRAINT pk_edicion_de_curso PRIMARY KEY (id),
  CONSTRAINT uq_edicion_curso_numero UNIQUE (curso_id, numero_de_edicion),
  CONSTRAINT fk_edicion_curso FOREIGN KEY (curso_id) REFERENCES curso (id),
  CONSTRAINT ck_edicion_fechas CHECK (fecha_fin >= fecha_inicio),      -- K-21
  CONSTRAINT ck_edicion_cupo CHECK (cupo > 0),                          -- K-21
  KEY ix_edicion_evaluador (evaluador_ref)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- K-19: un solo enrolamiento activo por (edición, colaborador). K-18 (cupo) lo garantiza el agregado con bloqueo.
-- D-H16: avance en porcentaje, nota de 0 a 20 (K-40) y comentarios.
CREATE TABLE enrolamiento (
  id                  BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  edicion_id          BIGINT UNSIGNED NOT NULL,
  colaborador_ref     BIGINT UNSIGNED NOT NULL,
  estado              VARCHAR(12)     NOT NULL,
  avance_porcentaje   DECIMAL(5,2)    NULL,
  nota                DECIMAL(4,2)    NULL,
  comentarios         TEXT            NULL,
  activo_colaborador  BIGINT UNSIGNED GENERATED ALWAYS AS
                        (IF(estado <> 'DESENROLADO', colaborador_ref, NULL)) VIRTUAL,
  CONSTRAINT pk_enrolamiento PRIMARY KEY (id),
  CONSTRAINT uq_enrolamiento_activo UNIQUE (edicion_id, activo_colaborador),
  CONSTRAINT fk_enrolamiento_edicion FOREIGN KEY (edicion_id) REFERENCES edicion_de_curso (id),
  CONSTRAINT ck_enrolamiento_estado CHECK (estado IN ('INSCRITO', 'CERTIFICADO', 'DESENROLADO')),
  CONSTRAINT ck_enrolamiento_avance CHECK (avance_porcentaje IS NULL OR avance_porcentaje BETWEEN 0 AND 100),
  CONSTRAINT ck_enrolamiento_nota CHECK (nota IS NULL OR nota BETWEEN 0 AND 20),
  KEY ix_enrolamiento_edicion_estado (edicion_id, estado),    -- cupo (K-18)
  KEY ix_enrolamiento_colaborador (colaborador_ref)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- K-20 (100 % de evidencias obligatorias validadas) lo valida el servicio con CON-06 antes de insertar.
CREATE TABLE certificacion_de_curso (
  id              BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  enrolamiento_id BIGINT UNSIGNED NOT NULL,
  evaluador_ref   BIGINT UNSIGNED NOT NULL,
  emitida_en      DATETIME(3)     NOT NULL,
  CONSTRAINT pk_certificacion_de_curso PRIMARY KEY (id),
  CONSTRAINT uq_certificacion_enrolamiento UNIQUE (enrolamiento_id),
  CONSTRAINT fk_certificacion_enrolamiento FOREIGN KEY (enrolamiento_id) REFERENCES enrolamiento (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
