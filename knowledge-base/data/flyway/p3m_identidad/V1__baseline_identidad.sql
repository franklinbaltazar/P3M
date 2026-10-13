-- p3m_identidad (CTX-02 Identidad de acceso) | LDM-001 §2.2 | AGG-06
-- Los roles de usuario son una copia no autoritativa de Keycloak al último inicio de sesión (BR-074, BR-075).

CREATE TABLE usuario (
  id             BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  keycloak_guid  CHAR(36) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  username       VARCHAR(150)    NOT NULL,
  correo         VARCHAR(300)    NOT NULL,
  persona_ref    BIGINT UNSIGNED NULL,       -- CTX-01 (sin FK). K-10: una persona por usuario
  CONSTRAINT pk_usuario PRIMARY KEY (id),
  CONSTRAINT uq_usuario_guid UNIQUE (keycloak_guid),
  CONSTRAINT uq_usuario_persona UNIQUE (persona_ref),
  KEY ix_usuario_correo (correo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE usuario_rol_de_usuario (
  usuario_id       BIGINT UNSIGNED NOT NULL,
  rol_de_usuario   VARCHAR(20)     NOT NULL,
  CONSTRAINT pk_usuario_rol_de_usuario PRIMARY KEY (usuario_id, rol_de_usuario),
  CONSTRAINT fk_usuario_rol_usuario FOREIGN KEY (usuario_id) REFERENCES usuario (id),
  CONSTRAINT ck_usuario_rol CHECK (rol_de_usuario IN ('COLABORADOR', 'INSTRUCTOR', 'JEFE_INGENIERIA', 'ADMIN'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- K-45: persona_ref de usuario es inmutable para el servicio de identidad (solo se fija al insertar; sin permiso de UPDATE
-- sobre esa columna). Un vínculo equivocado lo corrige el Jefe de Ingeniería con una cuenta aparte (svc_identidad_correccion),
-- y cada corrección queda registrada con quién y cuándo (RPT-DDR-001 R-01, acciones b y c). Tabla de solo inserción.
CREATE TABLE correccion_de_vinculo (
  id                    BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  usuario_id            BIGINT UNSIGNED NOT NULL,
  persona_ref_anterior  BIGINT UNSIGNED NULL,       -- CTX-01 (sin FK)
  persona_ref_nueva     BIGINT UNSIGNED NOT NULL,   -- CTX-01 (sin FK)
  corregida_por_ref     CHAR(36) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,   -- GUID de Keycloak (D-H20)
  corregida_en          DATETIME(3)     NOT NULL,
  CONSTRAINT pk_correccion_de_vinculo PRIMARY KEY (id),
  CONSTRAINT fk_correccion_usuario FOREIGN KEY (usuario_id) REFERENCES usuario (id),
  CONSTRAINT ck_correccion_distinta CHECK (persona_ref_anterior IS NULL OR persona_ref_anterior <> persona_ref_nueva),
  KEY ix_correccion_usuario (usuario_id, corregida_en)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
