-- p3m_curricula (CTX-03 Currícula) | LDM-001 §2.3 | AGG-07..AGG-09

CREATE TABLE seniority (
  id      BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  nombre  VARCHAR(20)     NOT NULL,
  CONSTRAINT pk_seniority PRIMARY KEY (id),
  CONSTRAINT uq_seniority_nombre UNIQUE (nombre),
  CONSTRAINT ck_seniority_nombre CHECK (nombre IN ('JUNIOR', 'SEMISENIOR', 'SENIOR'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- S-02: el nivel de desarrollo es una posición dentro de cada seniority.
CREATE TABLE nivel_de_desarrollo (
  id            BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  seniority_id  BIGINT UNSIGNED NOT NULL,
  nivel         CHAR(2)         NOT NULL,
  CONSTRAINT pk_nivel_de_desarrollo PRIMARY KEY (id),
  CONSTRAINT uq_nivel_de_desarrollo UNIQUE (seniority_id, nivel),
  CONSTRAINT fk_nivel_de_desarrollo_seniority FOREIGN KEY (seniority_id) REFERENCES seniority (id),
  CONSTRAINT ck_nivel_de_desarrollo_nivel CHECK (nivel IN ('L1', 'L2', 'L3', 'L4'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- K-16 (una competencia específica en un solo rol) lo garantiza el servicio (POL).
CREATE TABLE competencia (
  id          BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  codigo      VARCHAR(30)     NOT NULL,
  nombre      VARCHAR(150)    NOT NULL,
  tipo        VARCHAR(12)     NOT NULL,
  es_general  TINYINT         NOT NULL,
  CONSTRAINT pk_competencia PRIMARY KEY (id),
  CONSTRAINT uq_competencia_codigo UNIQUE (codigo),
  CONSTRAINT ck_competencia_tipo CHECK (tipo IN ('CONOCIMIENTO', 'HABILIDAD', 'ACTITUD')),
  CONSTRAINT ck_competencia_general CHECK (es_general IN (0, 1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- K-12: exactamente tres niveles de logro por competencia lo garantiza el agregado (AGG).
CREATE TABLE competencia_nivel_de_logro (
  competencia_id  BIGINT UNSIGNED NOT NULL,
  nivel_de_logro  CHAR(2)         NOT NULL,
  definicion      TEXT            NOT NULL,
  CONSTRAINT pk_competencia_nivel_de_logro PRIMARY KEY (competencia_id, nivel_de_logro),
  CONSTRAINT fk_competencia_nivel_competencia FOREIGN KEY (competencia_id) REFERENCES competencia (id),
  CONSTRAINT ck_competencia_nivel_logro CHECK (nivel_de_logro IN ('N1', 'N2', 'N3'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE rol (
  id      BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  nombre  VARCHAR(100)    NOT NULL,
  CONSTRAINT pk_rol PRIMARY KEY (id),
  CONSTRAINT uq_rol_nombre UNIQUE (nombre)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Perfil de competencias (S-01: un perfil por rol).
CREATE TABLE rol_competencia (
  rol_id          BIGINT UNSIGNED NOT NULL,
  competencia_id  BIGINT UNSIGNED NOT NULL,
  CONSTRAINT pk_rol_competencia PRIMARY KEY (rol_id, competencia_id),
  CONSTRAINT fk_rol_competencia_rol FOREIGN KEY (rol_id) REFERENCES rol (id),
  CONSTRAINT fk_rol_competencia_competencia FOREIGN KEY (competencia_id) REFERENCES competencia (id),
  KEY ix_rol_competencia_competencia (competencia_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE rol_nivel (
  id                      BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  rol_id                  BIGINT UNSIGNED NOT NULL,
  nivel_de_desarrollo_id  BIGINT UNSIGNED NOT NULL,
  CONSTRAINT pk_rol_nivel PRIMARY KEY (id),
  CONSTRAINT uq_rol_nivel UNIQUE (rol_id, nivel_de_desarrollo_id),
  CONSTRAINT uq_rol_nivel_id_rol UNIQUE (id, rol_id),            -- destino de K-15
  CONSTRAINT fk_rol_nivel_rol FOREIGN KEY (rol_id) REFERENCES rol (id),
  CONSTRAINT fk_rol_nivel_nivel_desarrollo FOREIGN KEY (nivel_de_desarrollo_id) REFERENCES nivel_de_desarrollo (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- K-14: el mínimo solo existe para competencias del perfil del rol. K-15: rol_id coincide con el del rol/nivel.
CREATE TABLE rol_nivel_competencia_minimo (
  rol_nivel_id    BIGINT UNSIGNED NOT NULL,
  rol_id          BIGINT UNSIGNED NOT NULL,
  competencia_id  BIGINT UNSIGNED NOT NULL,
  nivel_minimo    CHAR(2)         NOT NULL,
  CONSTRAINT pk_rol_nivel_competencia_minimo PRIMARY KEY (rol_nivel_id, competencia_id),
  CONSTRAINT fk_minimo_rol_nivel FOREIGN KEY (rol_nivel_id, rol_id) REFERENCES rol_nivel (id, rol_id),
  CONSTRAINT fk_minimo_perfil FOREIGN KEY (rol_id, competencia_id) REFERENCES rol_competencia (rol_id, competencia_id),
  CONSTRAINT ck_minimo_nivel CHECK (nivel_minimo IN ('N1', 'N2', 'N3'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
