-- p3m_gitlab (CTX-07 Integración GitLab) | LDM-001 §2.7 | AGG-21, RPL-01
-- Las réplicas son de solo lectura para el resto del sistema (BR-036): solo las escribe el proceso de carga.
-- DEC-F02: las claves de las réplicas son los id globales de GitLab (únicos en la instancia).

-- K-35 (no se borra), K-36 (intentos de 0 a 3).
CREATE TABLE carga_de_gitlab (
  id           BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  iniciada_en  DATETIME(3)     NOT NULL,
  delta_desde  DATETIME(3)     NULL,        -- nulo = carga completa (BR-094)
  estado       VARCHAR(12)     NOT NULL,
  intentos     TINYINT UNSIGNED NOT NULL DEFAULT 0,
  CONSTRAINT pk_carga_de_gitlab PRIMARY KEY (id),
  CONSTRAINT ck_carga_estado CHECK (estado IN ('PROGRAMADA', 'EJECUTANDO', 'COMPLETADA', 'FALLIDA', 'SIN_CAMBIOS')),
  CONSTRAINT ck_carga_intentos CHECK (intentos <= 3),
  KEY ix_carga_iniciada (iniciada_en),
  KEY ix_carga_estado (estado, iniciada_en)    -- «datos al …» = última COMPLETADA (BR-092)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE replica_milestone (
  gitlab_milestone_id  BIGINT UNSIGNED NOT NULL,
  gitlab_project_id    BIGINT UNSIGNED NOT NULL,
  titulo               VARCHAR(255)    NOT NULL,
  CONSTRAINT pk_replica_milestone PRIMARY KEY (gitlab_milestone_id),
  KEY ix_replica_milestone_proyecto (gitlab_project_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Solo se replican issues con label UserStory o Task (BR-020, BR-049). K-38: el milestone es de esta réplica.
-- user_story_gitlab_id no lleva FK: una tarea puede cargarse antes que su user story en un delta.
-- web_url_sha256 permite buscar por URL completa (CON-10) sin indexar 2048 caracteres.
CREATE TABLE replica_issue (
  gitlab_issue_id      BIGINT UNSIGNED NOT NULL,
  gitlab_project_id    BIGINT UNSIGNED NOT NULL,
  gitlab_milestone_id  BIGINT UNSIGNED NULL,
  tipo                 VARCHAR(10)     NOT NULL,
  estado               VARCHAR(6)      NOT NULL,
  web_url              VARCHAR(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  titulo               VARCHAR(255)    NOT NULL,
  actualizado_en       DATETIME(3)     NOT NULL,
  user_story_gitlab_id BIGINT UNSIGNED NULL,
  web_url_sha256       BINARY(32) GENERATED ALWAYS AS (UNHEX(SHA2(web_url, 256))) STORED,
  CONSTRAINT pk_replica_issue PRIMARY KEY (gitlab_issue_id),
  CONSTRAINT uq_replica_issue_url UNIQUE (web_url_sha256),
  CONSTRAINT fk_replica_issue_milestone FOREIGN KEY (gitlab_milestone_id) REFERENCES replica_milestone (gitlab_milestone_id),
  CONSTRAINT ck_replica_issue_tipo CHECK (tipo IN ('USER_STORY', 'TASK')),
  CONSTRAINT ck_replica_issue_estado CHECK (estado IN ('OPENED', 'CLOSED')),
  KEY ix_replica_issue_proyecto (gitlab_project_id, estado),
  KEY ix_replica_issue_milestone (gitlab_milestone_id, estado),
  KEY ix_replica_issue_user_story (user_story_gitlab_id),
  KEY ix_replica_issue_actualizado (actualizado_en)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
