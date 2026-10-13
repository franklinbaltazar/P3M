-- PASO 2 de 2 — después de cada `flyway migrate`. Permisos por tabla (mínimo privilegio, INF-DEC-15).
-- Es idempotente: se vuelve a ejecutar tras cualquier migración que añada tablas. Lo ejecuta la persona administradora.
-- Cada servicio accede solo a su esquema; ningún esquema se lee desde otro.
-- Sin DELETE salvo en cinco tablas de configuración o copia (D-H1, P-3). Tablas de solo inserción: sin UPDATE ni DELETE (K-25).
-- Una tabla nueva sin permiso explícito queda inaccesible para el servicio: hay que añadirla a esta lista.


-- ===== p3m_curricula =====
GRANT SELECT, INSERT, UPDATE ON p3m_curricula.seniority TO 'svc_curricula'@'%';
GRANT SELECT, INSERT, UPDATE ON p3m_curricula.nivel_de_desarrollo TO 'svc_curricula'@'%';
GRANT SELECT, INSERT, UPDATE ON p3m_curricula.competencia TO 'svc_curricula'@'%';
GRANT SELECT, INSERT, UPDATE ON p3m_curricula.competencia_nivel_de_logro TO 'svc_curricula'@'%';
GRANT SELECT, INSERT, UPDATE ON p3m_curricula.rol TO 'svc_curricula'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON p3m_curricula.rol_competencia TO 'svc_curricula'@'%';  -- tabla de configuración o copia
GRANT SELECT, INSERT, UPDATE ON p3m_curricula.rol_nivel TO 'svc_curricula'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON p3m_curricula.rol_nivel_competencia_minimo TO 'svc_curricula'@'%';  -- tabla de configuración o copia

-- ===== p3m_formacion =====
GRANT SELECT, INSERT, UPDATE ON p3m_formacion.curso TO 'svc_formacion'@'%';
GRANT SELECT, INSERT, UPDATE ON p3m_formacion.objetivo_de_curso TO 'svc_formacion'@'%';
GRANT SELECT, INSERT, UPDATE ON p3m_formacion.rubrica_nivel TO 'svc_formacion'@'%';
GRANT SELECT, INSERT, UPDATE ON p3m_formacion.evidencia_esperada TO 'svc_formacion'@'%';
GRANT SELECT, INSERT, UPDATE ON p3m_formacion.edicion_de_curso TO 'svc_formacion'@'%';
GRANT SELECT, INSERT, UPDATE ON p3m_formacion.enrolamiento TO 'svc_formacion'@'%';
GRANT SELECT, INSERT, UPDATE ON p3m_formacion.certificacion_de_curso TO 'svc_formacion'@'%';

-- ===== p3m_gitlab =====
GRANT SELECT, INSERT ON p3m_gitlab.carga_de_gitlab TO 'svc_gitlab'@'%';  -- reintentar una carga inserta una PROGRAMADA (BR-066)
GRANT SELECT, INSERT, UPDATE ON p3m_gitlab.carga_de_gitlab TO 'svc_gitlab_carga'@'%';
GRANT SELECT ON p3m_gitlab.replica_milestone TO 'svc_gitlab'@'%';  -- réplica de solo lectura (K-37)
GRANT SELECT, INSERT, UPDATE ON p3m_gitlab.replica_milestone TO 'svc_gitlab_carga'@'%';
GRANT SELECT ON p3m_gitlab.replica_issue TO 'svc_gitlab'@'%';  -- réplica de solo lectura (K-37)
GRANT SELECT, INSERT, UPDATE ON p3m_gitlab.replica_issue TO 'svc_gitlab_carga'@'%';

-- ===== p3m_identidad =====
GRANT SELECT, INSERT ON p3m_identidad.usuario TO 'svc_identidad'@'%';
GRANT UPDATE (username, correo) ON p3m_identidad.usuario TO 'svc_identidad'@'%';  -- persona_ref NO se actualiza: vínculo inmutable (K-45)
GRANT SELECT ON p3m_identidad.usuario TO 'svc_identidad_correccion'@'%';
GRANT UPDATE (persona_ref) ON p3m_identidad.usuario TO 'svc_identidad_correccion'@'%';  -- solo la corrección manual del Jefe de Ingeniería (K-45)
GRANT SELECT, INSERT, UPDATE, DELETE ON p3m_identidad.usuario_rol_de_usuario TO 'svc_identidad'@'%';  -- tabla de configuración o copia
GRANT SELECT ON p3m_identidad.correccion_de_vinculo TO 'svc_identidad'@'%';
GRANT SELECT, INSERT ON p3m_identidad.correccion_de_vinculo TO 'svc_identidad_correccion'@'%';  -- solo inserción (K-45)

-- ===== p3m_partes =====
GRANT SELECT, INSERT, UPDATE ON p3m_partes.parte TO 'svc_partes'@'%';
GRANT SELECT, INSERT, UPDATE ON p3m_partes.persona TO 'svc_partes'@'%';
GRANT SELECT, INSERT, UPDATE ON p3m_partes.organizacion TO 'svc_partes'@'%';
GRANT SELECT, INSERT, UPDATE ON p3m_partes.dato_de_contacto TO 'svc_partes'@'%';
GRANT SELECT, INSERT, UPDATE ON p3m_partes.rol_de_la_parte TO 'svc_partes'@'%';
GRANT SELECT, INSERT, UPDATE ON p3m_partes.relacion_entre_partes TO 'svc_partes'@'%';
GRANT SELECT, INSERT, UPDATE ON p3m_partes.plaza TO 'svc_partes'@'%';
GRANT SELECT, INSERT, UPDATE ON p3m_partes.plaza_rol_nivel TO 'svc_partes'@'%';
GRANT SELECT, INSERT, UPDATE ON p3m_partes.ocupacion_de_plaza TO 'svc_partes'@'%';

-- ===== p3m_portafolio =====
GRANT SELECT, INSERT, UPDATE ON p3m_portafolio.producto TO 'svc_portafolio'@'%';
GRANT SELECT, INSERT, UPDATE ON p3m_portafolio.proyecto TO 'svc_portafolio'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON p3m_portafolio.proyecto_milestone TO 'svc_portafolio'@'%';  -- tabla de configuración o copia
GRANT SELECT, INSERT, UPDATE, DELETE ON p3m_portafolio.proyecto_rol_nivel_requerido TO 'svc_portafolio'@'%';  -- tabla de configuración o copia
GRANT SELECT, INSERT, UPDATE ON p3m_portafolio.jefatura_de_proyecto TO 'svc_portafolio'@'%';
GRANT SELECT, INSERT, UPDATE ON p3m_portafolio.motivo_de_excepcion TO 'svc_portafolio'@'%';
GRANT SELECT, INSERT, UPDATE ON p3m_portafolio.colaborador_carga TO 'svc_portafolio'@'%';
GRANT SELECT, INSERT, UPDATE ON p3m_portafolio.asignacion TO 'svc_portafolio'@'%';
GRANT SELECT, INSERT, UPDATE ON p3m_portafolio.excepcion_de_asignacion TO 'svc_portafolio'@'%';

-- ===== p3m_progresion =====
GRANT SELECT, INSERT, UPDATE ON p3m_progresion.solicitud_de_promocion TO 'svc_progresion'@'%';
GRANT SELECT, INSERT, UPDATE ON p3m_progresion.evidencia_aportada TO 'svc_progresion'@'%';
GRANT SELECT, INSERT, UPDATE ON p3m_progresion.valoracion_de_competencia TO 'svc_progresion'@'%';
GRANT SELECT, INSERT ON p3m_progresion.valoracion_registro TO 'svc_progresion'@'%';  -- solo inserción (K-25)
GRANT SELECT, INSERT ON p3m_progresion.evaluacion_de_desempeno TO 'svc_progresion'@'%';  -- solo inserción (K-25)
GRANT SELECT, INSERT ON p3m_progresion.evaluacion_evidencia TO 'svc_progresion'@'%';  -- solo inserción (K-25)
GRANT SELECT, INSERT ON p3m_progresion.evaluacion_certificacion TO 'svc_progresion'@'%';  -- solo inserción (K-25)
GRANT SELECT, INSERT, UPDATE ON p3m_progresion.promocion_de_nivel TO 'svc_progresion'@'%';
GRANT SELECT, INSERT, UPDATE ON p3m_progresion.promocion_certificacion TO 'svc_progresion'@'%';
GRANT SELECT, INSERT, UPDATE ON p3m_progresion.promocion_evidencia_proyecto TO 'svc_progresion'@'%';
GRANT SELECT, INSERT, UPDATE ON p3m_progresion.promocion_valoracion TO 'svc_progresion'@'%';
GRANT SELECT, INSERT, UPDATE ON p3m_progresion.outbox_evento TO 'svc_progresion'@'%';
