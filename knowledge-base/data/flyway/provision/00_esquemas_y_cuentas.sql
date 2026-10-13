-- PASO 1 de 2 — antes de migrar. Crea esquemas y cuentas (instancia MySQL 8.x). Lo ejecuta una persona con privilegio de
-- administración, NO Flyway: los usuarios son de la instancia. Generado a partir de los DDL de flyway/<esquema>/.
-- Contraseñas: se obtienen de Vault (secret/p3m/*, ADR-12) y se sustituyen al ejecutar. No se escriben en este archivo.
-- Conexión cifrada obligatoria (REQUIRE SSL). Restringir el host '%' a la red de los servicios al desplegar.
-- Los permisos por tabla no van aquí: MySQL exige que la tabla exista. Van en el PASO 2 (01_permisos_por_tabla.sql).


-- ===== p3m_curricula =====
CREATE DATABASE IF NOT EXISTS p3m_curricula CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
CREATE USER IF NOT EXISTS 'flyway_curricula'@'%' IDENTIFIED BY '<<VAULT secret/p3m/mysql/flyway_curricula>>' REQUIRE SSL;
GRANT CREATE, ALTER, DROP, INDEX, REFERENCES, SELECT, INSERT, UPDATE, DELETE ON p3m_curricula.* TO 'flyway_curricula'@'%';  -- solo migraciones; flyway.cleanDisabled=true
CREATE USER IF NOT EXISTS 'svc_curricula'@'%' IDENTIFIED BY '<<VAULT secret/p3m/mysql/svc_curricula>>' REQUIRE SSL;

-- ===== p3m_formacion =====
CREATE DATABASE IF NOT EXISTS p3m_formacion CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
CREATE USER IF NOT EXISTS 'flyway_formacion'@'%' IDENTIFIED BY '<<VAULT secret/p3m/mysql/flyway_formacion>>' REQUIRE SSL;
GRANT CREATE, ALTER, DROP, INDEX, REFERENCES, SELECT, INSERT, UPDATE, DELETE ON p3m_formacion.* TO 'flyway_formacion'@'%';  -- solo migraciones; flyway.cleanDisabled=true
CREATE USER IF NOT EXISTS 'svc_formacion'@'%' IDENTIFIED BY '<<VAULT secret/p3m/mysql/svc_formacion>>' REQUIRE SSL;

-- ===== p3m_gitlab =====
CREATE DATABASE IF NOT EXISTS p3m_gitlab CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
CREATE USER IF NOT EXISTS 'flyway_gitlab'@'%' IDENTIFIED BY '<<VAULT secret/p3m/mysql/flyway_gitlab>>' REQUIRE SSL;
GRANT CREATE, ALTER, DROP, INDEX, REFERENCES, SELECT, INSERT, UPDATE, DELETE ON p3m_gitlab.* TO 'flyway_gitlab'@'%';  -- solo migraciones; flyway.cleanDisabled=true
CREATE USER IF NOT EXISTS 'svc_gitlab'@'%' IDENTIFIED BY '<<VAULT secret/p3m/mysql/svc_gitlab>>' REQUIRE SSL;
CREATE USER IF NOT EXISTS 'svc_gitlab_carga'@'%' IDENTIFIED BY '<<VAULT secret/p3m/mysql/svc_gitlab_carga>>' REQUIRE SSL;

-- ===== p3m_identidad =====
CREATE DATABASE IF NOT EXISTS p3m_identidad CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
CREATE USER IF NOT EXISTS 'flyway_identidad'@'%' IDENTIFIED BY '<<VAULT secret/p3m/mysql/flyway_identidad>>' REQUIRE SSL;
GRANT CREATE, ALTER, DROP, INDEX, REFERENCES, SELECT, INSERT, UPDATE, DELETE ON p3m_identidad.* TO 'flyway_identidad'@'%';  -- solo migraciones; flyway.cleanDisabled=true
CREATE USER IF NOT EXISTS 'svc_identidad'@'%' IDENTIFIED BY '<<VAULT secret/p3m/mysql/svc_identidad>>' REQUIRE SSL;
CREATE USER IF NOT EXISTS 'svc_identidad_correccion'@'%' IDENTIFIED BY '<<VAULT secret/p3m/mysql/svc_identidad_correccion>>' REQUIRE SSL;

-- ===== p3m_partes =====
CREATE DATABASE IF NOT EXISTS p3m_partes CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
CREATE USER IF NOT EXISTS 'flyway_partes'@'%' IDENTIFIED BY '<<VAULT secret/p3m/mysql/flyway_partes>>' REQUIRE SSL;
GRANT CREATE, ALTER, DROP, INDEX, REFERENCES, SELECT, INSERT, UPDATE, DELETE ON p3m_partes.* TO 'flyway_partes'@'%';  -- solo migraciones; flyway.cleanDisabled=true
CREATE USER IF NOT EXISTS 'svc_partes'@'%' IDENTIFIED BY '<<VAULT secret/p3m/mysql/svc_partes>>' REQUIRE SSL;

-- ===== p3m_portafolio =====
CREATE DATABASE IF NOT EXISTS p3m_portafolio CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
CREATE USER IF NOT EXISTS 'flyway_portafolio'@'%' IDENTIFIED BY '<<VAULT secret/p3m/mysql/flyway_portafolio>>' REQUIRE SSL;
GRANT CREATE, ALTER, DROP, INDEX, REFERENCES, SELECT, INSERT, UPDATE, DELETE ON p3m_portafolio.* TO 'flyway_portafolio'@'%';  -- solo migraciones; flyway.cleanDisabled=true
CREATE USER IF NOT EXISTS 'svc_portafolio'@'%' IDENTIFIED BY '<<VAULT secret/p3m/mysql/svc_portafolio>>' REQUIRE SSL;

-- ===== p3m_progresion =====
CREATE DATABASE IF NOT EXISTS p3m_progresion CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
CREATE USER IF NOT EXISTS 'flyway_progresion'@'%' IDENTIFIED BY '<<VAULT secret/p3m/mysql/flyway_progresion>>' REQUIRE SSL;
GRANT CREATE, ALTER, DROP, INDEX, REFERENCES, SELECT, INSERT, UPDATE, DELETE ON p3m_progresion.* TO 'flyway_progresion'@'%';  -- solo migraciones; flyway.cleanDisabled=true
CREATE USER IF NOT EXISTS 'svc_progresion'@'%' IDENTIFIED BY '<<VAULT secret/p3m/mysql/svc_progresion>>' REQUIRE SSL;
