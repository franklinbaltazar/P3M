-- Verificaciones de MySQL 8.x para cada esquema (se ejecutan antes y después de flyway migrate).
-- Sustituir :esquema por p3m_partes, p3m_identidad, p3m_curricula, p3m_formacion, p3m_progresion, p3m_portafolio o p3m_gitlab.
-- Resultado esperado: cada consulta devuelve las filas indicadas en PDM-001 §7. Una desviación detiene el despliegue.

-- ===== PREFLIGHT (instancia) =====
-- P1. Versión mínima 8.0.16 (desde ahí MySQL aplica las restricciones CHECK). Recomendado: LTS 8.4.
SELECT VERSION() AS version, (VERSION() REGEXP '^8\\.') AS es_8x;
-- P2. Modo estricto y juego de caracteres por defecto del servidor.
SELECT @@GLOBAL.sql_mode LIKE '%STRICT_TRANS_TABLES%' AS modo_estricto,
       @@GLOBAL.character_set_server AS charset_servidor,
       @@GLOBAL.collation_server AS collation_servidor,
       @@GLOBAL.default_storage_engine AS motor,
       @@GLOBAL.lower_case_table_names AS lower_case_table_names,
       @@GLOBAL.time_zone AS zona_horaria;          -- esperado: '+00:00' (los tiempos se guardan en UTC)
-- P3. El usuario de migración existe y exige SSL.
SELECT user, host, ssl_type FROM mysql.user WHERE user LIKE 'flyway\\_%';

-- ===== POSTFLIGHT (por esquema) =====
-- Q1. Todas las tablas son InnoDB y utf8mb4_0900_ai_ci (salvo la tabla de historial de Flyway).
SELECT table_name, engine, table_collation
FROM information_schema.tables
WHERE table_schema = :esquema AND table_type = 'BASE TABLE' AND table_name <> 'flyway_schema_history'
  AND (engine <> 'InnoDB' OR table_collation <> 'utf8mb4_0900_ai_ci');          -- esperado: 0 filas

-- Q2. Número de tablas por esquema (sin la de historial): partes 9, identidad 3, curricula 8, formacion 7,
--     progresion 12, portafolio 9, gitlab 3.
SELECT COUNT(*) AS tablas FROM information_schema.tables
WHERE table_schema = :esquema AND table_type = 'BASE TABLE' AND table_name <> 'flyway_schema_history';

-- Q3. Ninguna clave foránea cruza esquemas (ADR-DB-002).
SELECT constraint_schema, table_name, constraint_name, unique_constraint_schema
FROM information_schema.referential_constraints
WHERE constraint_schema LIKE 'p3m\\_%' AND unique_constraint_schema <> constraint_schema;   -- esperado: 0 filas

-- Q4. Todas las FK son RESTRICT (sin borrado ni actualización en cascada).
SELECT constraint_name, delete_rule, update_rule FROM information_schema.referential_constraints
WHERE constraint_schema = :esquema AND (delete_rule NOT IN ('RESTRICT', 'NO ACTION') OR update_rule NOT IN ('RESTRICT', 'NO ACTION'));   -- 0 filas

-- Q5. Las restricciones CHECK existen y están aplicadas (MySQL >= 8.0.16).
SELECT COUNT(*) AS checks_aplicados FROM information_schema.table_constraints tc
JOIN information_schema.check_constraints cc USING (constraint_schema, constraint_name)
WHERE tc.constraint_schema = :esquema AND tc.constraint_type = 'CHECK' AND cc.check_clause IS NOT NULL;
-- esperado: partes 13, identidad 2, curricula 6, formacion 8, progresion 8, portafolio 7, gitlab 4

-- Q6. Las restricciones de «una sola vigente» existen como índices únicos sobre columna generada.
SELECT table_name, index_name FROM information_schema.statistics
WHERE table_schema = :esquema AND non_unique = 0 AND column_name IN
  ('vigente_clave', 'vigente_plaza', 'vigente_persona', 'vigente_proyecto', 'activo_colaborador', 'correo_unico')
GROUP BY table_name, index_name;
-- esperado: relacion_entre_partes.uq_relacion_vigente, plaza_rol_nivel.uq_plaza_rol_nivel_vigente,
--           ocupacion_de_plaza.uq_ocupacion_vigente_plaza y uq_ocupacion_vigente_persona, jefatura_de_proyecto.uq_jefatura_vigente,
--           enrolamiento.uq_enrolamiento_activo, dato_de_contacto.uq_dato_de_contacto_correo

-- Q7. Estado de las migraciones: ninguna fallida y versión aplicada.
SELECT version, description, success, checksum FROM flyway_schema_history ORDER BY installed_rank;   -- success = 1 en todas

-- Q8. Semillas de p3m_curricula: 3 seniority y 12 niveles de desarrollo.
SELECT (SELECT COUNT(*) FROM seniority) AS seniority, (SELECT COUNT(*) FROM nivel_de_desarrollo) AS niveles;   -- 3 y 12

-- Q9. Permisos: ninguna cuenta de servicio tiene DELETE fuera de las cinco tablas permitidas, ni UPDATE en las de solo inserción.
SELECT grantee, table_name, privilege_type FROM information_schema.table_privileges
WHERE table_schema = :esquema AND grantee LIKE '''svc\\_%'
  AND ((privilege_type = 'DELETE' AND table_name NOT IN
        ('rol_competencia', 'rol_nivel_competencia_minimo', 'proyecto_milestone', 'proyecto_rol_nivel_requerido', 'usuario_rol_de_usuario'))
    OR (privilege_type IN ('UPDATE', 'DELETE') AND table_name IN
        ('valoracion_registro', 'evaluacion_de_desempeno', 'evaluacion_evidencia', 'evaluacion_certificacion', 'correccion_de_vinculo')));   -- 0 filas

-- Q10. El vínculo usuario-persona es inmutable para el servicio de identidad (K-45): solo la cuenta de corrección actualiza persona_ref.
SELECT grantee, privilege_type FROM information_schema.column_privileges
WHERE table_schema = 'p3m_identidad' AND table_name = 'usuario' AND column_name = 'persona_ref' AND privilege_type = 'UPDATE';
-- esperado: una sola fila, 'svc_identidad_correccion'@'%'
