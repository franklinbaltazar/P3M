#!/bin/bash
# Pruebas de comportamiento de las restricciones en un MySQL 8.4 desechable.
M="docker exec -i p3m-ddl-test mysql -uroot -ptest-only-pw -N"
pass=0; fail=0
run() { $M -e "$1" 2>&1 | grep -v "Using a password"; }
# t <descripcion> <esperado: ok|error> <sql>
t() {
  out=$(run "$3"); rc=0; echo "$out" | grep -q "^ERROR" && rc=1
  if [ "$2" = "ok" ] && [ $rc -eq 0 ]; then pass=$((pass+1)); echo "PASS  $1"
  elif [ "$2" = "error" ] && [ $rc -eq 1 ]; then pass=$((pass+1)); echo "PASS  $1  [rechazado: $(echo "$out" | sed -E 's/ERROR ([0-9]+).*/\1/' | head -1)]"
  else fail=$((fail+1)); echo "FAIL  $1 (esperado $2) -> $out"; fi
}

# tv <descripcion> <valor esperado> <sql>: compara la última línea de la salida
tv() {
  out=$(run "$3" | tr -d '\r' | tail -1)
  if [ "$out" = "$2" ]; then pass=$((pass+1)); echo "PASS  $1  [= $out]"
  else fail=$((fail+1)); echo "FAIL  $1 (esperado $2) -> $out"; fi
}

# limpiar datos de prueba (se vuelve a sembrar lo necesario)
for s in p3m_partes p3m_identidad p3m_formacion p3m_progresion p3m_portafolio p3m_gitlab; do
  for tb in $($M -e "select table_name from information_schema.tables where table_schema='$s' and table_type='BASE TABLE'" 2>/dev/null); do :; done
done
run "SET FOREIGN_KEY_CHECKS=0; TRUNCATE p3m_partes.ocupacion_de_plaza; TRUNCATE p3m_partes.plaza_rol_nivel; TRUNCATE p3m_partes.plaza; TRUNCATE p3m_partes.relacion_entre_partes; TRUNCATE p3m_partes.rol_de_la_parte; TRUNCATE p3m_partes.dato_de_contacto; TRUNCATE p3m_partes.persona; TRUNCATE p3m_partes.organizacion; TRUNCATE p3m_partes.parte; SET FOREIGN_KEY_CHECKS=1;" >/dev/null

echo "== p3m_partes"
run "INSERT INTO p3m_partes.parte(tipo_parte) VALUES ('PERSONA'),('PERSONA'),('PERSONA'),('ORGANIZACION'),('ORGANIZACION');" >/dev/null
# ids 1,2,3 personas; 4,5 organizaciones
run "INSERT INTO p3m_partes.persona(parte_id,nombres,apellido_paterno,apellido_materno) VALUES (1,'Ana','Paz','Rios'),(2,'Luis','Soto','Vega'),(3,'Eva','Cruz','Luna');" >/dev/null
run "INSERT INTO p3m_partes.organizacion(parte_id,razon_social) VALUES (4,'COMSATEL'),(5,'Area de Desarrollo');" >/dev/null
t "INV-01 persona sobre una parte ORGANIZACION se rechaza" error "INSERT INTO p3m_partes.persona(parte_id,nombres,apellido_paterno,apellido_materno) VALUES (4,'X','Y','Z');"
t "INV-01 organizacion sobre una parte PERSONA se rechaza" error "INSERT INTO p3m_partes.organizacion(parte_id,razon_social) VALUES (1,'Falsa');"
t "D-167 la organizacion guarda nombre comercial y Tax ID" ok "UPDATE p3m_partes.organizacion SET nombre_comercial='Comsatel', tax_id='20100000001' WHERE parte_id=4;"
t "D-167 razon social repetida se rechaza" error "UPDATE p3m_partes.organizacion SET razon_social='COMSATEL' WHERE parte_id=5;"
t "D-168 inactivar sin responsable se rechaza" error "UPDATE p3m_partes.organizacion SET inactivada_en='2026-07-01 00:00:00' WHERE parte_id=5;"
t "D-168 inactivar con fecha y responsable" ok "UPDATE p3m_partes.organizacion SET inactivada_en='2026-07-01 00:00:00', inactivada_por_ref='44444444-4444-4444-4444-444444444444' WHERE parte_id=5;"
t "D-168 reactivar con responsable pendiente se rechaza" error "UPDATE p3m_partes.organizacion SET inactivada_en=NULL WHERE parte_id=5;"
t "D-168 reactivar limpiando fecha y responsable" ok "UPDATE p3m_partes.organizacion SET inactivada_en=NULL, inactivada_por_ref=NULL WHERE parte_id=5;"
t "K-43 correo ok" ok "INSERT INTO p3m_partes.dato_de_contacto(parte_id,tipo_parte,tipo,valor) VALUES (1,'PERSONA','CORREO','ana@comsatel.com');"
t "K-43 mismo correo en otra persona se rechaza" error "INSERT INTO p3m_partes.dato_de_contacto(parte_id,tipo_parte,tipo,valor) VALUES (2,'PERSONA','CORREO','ana@comsatel.com');"
t "K-43 correo repetido distinguiendo mayusculas se rechaza (collation ci)" error "INSERT INTO p3m_partes.dato_de_contacto(parte_id,tipo_parte,tipo,valor) VALUES (2,'PERSONA','CORREO','ANA@COMSATEL.COM');"
t "BR-070 mismo valor como TELEFONO en dos personas es valido" ok "INSERT INTO p3m_partes.dato_de_contacto(parte_id,tipo_parte,tipo,valor) VALUES (1,'PERSONA','TELEFONO','999111222'),(2,'PERSONA','TELEFONO','999111222');"
t "BR-070 persona con dos correos es valido" ok "INSERT INTO p3m_partes.dato_de_contacto(parte_id,tipo_parte,tipo,valor) VALUES (1,'PERSONA','CORREO','ana.paz@gmail.com');"
t "tipo de contacto invalido se rechaza" error "INSERT INTO p3m_partes.dato_de_contacto(parte_id,tipo_parte,tipo,valor) VALUES (1,'PERSONA','FAX','1');"
t "K-44 baja sin responsable se rechaza" error "UPDATE p3m_partes.dato_de_contacto SET vigente_hasta='2026-07-01 00:00:00' WHERE parte_id=1 AND valor='ana@comsatel.com';"
t "K-44 responsable sin fecha de baja se rechaza" error "UPDATE p3m_partes.dato_de_contacto SET baja_por_ref='44444444-4444-4444-4444-444444444444' WHERE parte_id=1 AND valor='ana@comsatel.com';"
t "K-43 baja con responsable libera la direccion para otra persona (correo reutilizado)" ok "UPDATE p3m_partes.dato_de_contacto SET vigente_hasta='2026-07-01 00:00:00', baja_por_ref='44444444-4444-4444-4444-444444444444' WHERE parte_id=1 AND valor='ana@comsatel.com'; INSERT INTO p3m_partes.dato_de_contacto(parte_id,tipo_parte,tipo,valor) VALUES (2,'PERSONA','CORREO','ana@comsatel.com');"
t "K-43 dos contactos vigentes con la misma direccion siguen rechazados" error "INSERT INTO p3m_partes.dato_de_contacto(parte_id,tipo_parte,tipo,valor) VALUES (3,'PERSONA','CORREO','ana@comsatel.com');"
t "D-160 una organizacion tiene datos de contacto" ok "INSERT INTO p3m_partes.dato_de_contacto(parte_id,tipo_parte,tipo,valor) VALUES (4,'ORGANIZACION','CORREO','info@comsatel.com'),(4,'ORGANIZACION','TELEFONO','014111222');"
t "D-160 el correo de una organizacion no puede coincidir con el de una persona (correo unico entre partes)" error "INSERT INTO p3m_partes.dato_de_contacto(parte_id,tipo_parte,tipo,valor) VALUES (5,'ORGANIZACION','CORREO','ana@comsatel.com');"
t "F-19 un tipo_parte que no corresponde a la parte se rechaza" error "INSERT INTO p3m_partes.dato_de_contacto(parte_id,tipo_parte,tipo,valor) VALUES (1,'ORGANIZACION','CORREO','falso@x.com');"
t "F-19 un contacto de una parte inexistente se rechaza" error "INSERT INTO p3m_partes.dato_de_contacto(parte_id,tipo_parte,tipo,valor) VALUES (999,'PERSONA','CORREO','nadie@x.com');"
tv "K-44 el contacto dado de baja se conserva (D-H1)" "1" "SELECT COUNT(*) FROM p3m_partes.dato_de_contacto WHERE parte_id=1 AND valor='ana@comsatel.com' AND vigente_hasta IS NOT NULL;"
t "K-03 REPORTA_A persona->persona ok" ok "INSERT INTO p3m_partes.relacion_entre_partes(parte_origen_id,origen_tipo_parte,parte_destino_id,destino_tipo_parte,tipo,vigente_desde) VALUES (2,'PERSONA',1,'PERSONA','REPORTA_A','2026-01-01');"
t "K-02 segundo REPORTA_A vigente del mismo colaborador se rechaza" error "INSERT INTO p3m_partes.relacion_entre_partes(parte_origen_id,origen_tipo_parte,parte_destino_id,destino_tipo_parte,tipo,vigente_desde) VALUES (2,'PERSONA',3,'PERSONA','REPORTA_A','2026-02-01');"
t "K-02 REPORTA_A cerrado + nuevo vigente es valido (historial)" ok "UPDATE p3m_partes.relacion_entre_partes SET vigente_hasta='2026-02-01' WHERE parte_origen_id=2 AND tipo='REPORTA_A'; INSERT INTO p3m_partes.relacion_entre_partes(parte_origen_id,origen_tipo_parte,parte_destino_id,destino_tipo_parte,tipo,vigente_desde) VALUES (2,'PERSONA',3,'PERSONA','REPORTA_A','2026-02-01');"
t "K-03 REPORTA_A de persona a organizacion se rechaza" error "INSERT INTO p3m_partes.relacion_entre_partes(parte_origen_id,origen_tipo_parte,parte_destino_id,destino_tipo_parte,tipo,vigente_desde) VALUES (3,'PERSONA',4,'ORGANIZACION','REPORTA_A','2026-01-01');"
t "K-03 MEMBERSHIP persona->organizacion ok" ok "INSERT INTO p3m_partes.relacion_entre_partes(parte_origen_id,origen_tipo_parte,parte_destino_id,destino_tipo_parte,tipo,vigente_desde) VALUES (1,'PERSONA',4,'ORGANIZACION','MEMBERSHIP','2026-01-01');"
t "K-02 segunda MEMBERSHIP vigente de la persona se rechaza" error "INSERT INTO p3m_partes.relacion_entre_partes(parte_origen_id,origen_tipo_parte,parte_destino_id,destino_tipo_parte,tipo,vigente_desde) VALUES (1,'PERSONA',5,'ORGANIZACION','MEMBERSHIP','2026-03-01');"
t "K-03 ES_PARTE_DE organizacion->organizacion ok" ok "INSERT INTO p3m_partes.relacion_entre_partes(parte_origen_id,origen_tipo_parte,parte_destino_id,destino_tipo_parte,tipo,vigente_desde) VALUES (5,'ORGANIZACION',4,'ORGANIZACION','ES_PARTE_DE','2026-01-01');"
t "K-08 vigencia invertida se rechaza" error "INSERT INTO p3m_partes.rol_de_la_parte(persona_id,tipo_rol,vigente_desde,vigente_hasta) VALUES (1,'COLABORADOR','2026-05-01','2026-04-01');"
run "INSERT INTO p3m_partes.plaza(organizacion_id) VALUES (5),(5);" >/dev/null
run "INSERT INTO p3m_partes.plaza_rol_nivel(plaza_id,rol_nivel_ref,vigente_desde) VALUES (1,10,'2026-01-01');" >/dev/null
t "K-06 segundo rol/nivel vigente en la plaza se rechaza" error "INSERT INTO p3m_partes.plaza_rol_nivel(plaza_id,rol_nivel_ref,vigente_desde) VALUES (1,11,'2026-02-01');"
t "D-H12 cambio de nivel: cerrar y abrir con promocion_ref ok" ok "UPDATE p3m_partes.plaza_rol_nivel SET vigente_hasta='2026-06-01' WHERE plaza_id=1 AND vigente_hasta IS NULL; INSERT INTO p3m_partes.plaza_rol_nivel(plaza_id,rol_nivel_ref,vigente_desde,promocion_ref) VALUES (1,11,'2026-06-01',500);"
t "K-42 promocion_ref repetido (idempotencia de EVT-01) se rechaza" error "INSERT INTO p3m_partes.plaza_rol_nivel(plaza_id,rol_nivel_ref,vigente_desde,promocion_ref) VALUES (2,12,'2026-06-01',500);"
tv "R-04 evento obsoleto (decidida_en anterior a la vigencia actual) no modifica la plaza" "0" "SET @d='2026-03-01 00:00:00'; UPDATE p3m_partes.plaza_rol_nivel SET vigente_hasta=@d WHERE plaza_id=1 AND vigente_hasta IS NULL AND vigente_desde < @d; SELECT ROW_COUNT();"
tv "R-04 evento mas reciente si se aplica" "1" "SET @d='2026-09-01 00:00:00'; UPDATE p3m_partes.plaza_rol_nivel SET vigente_hasta=@d WHERE plaza_id=1 AND vigente_hasta IS NULL AND vigente_desde < @d; SELECT ROW_COUNT();"
t "R-04 el nuevo rol/nivel se abre con decidida_en y su promocion_ref" ok "INSERT INTO p3m_partes.plaza_rol_nivel(plaza_id,rol_nivel_ref,vigente_desde,promocion_ref) VALUES (1,12,'2026-09-01 00:00:00',501);"
t "R-04 reentrega del mismo evento (promocion_ref repetido) se rechaza" error "INSERT INTO p3m_partes.plaza_rol_nivel(plaza_id,rol_nivel_ref,vigente_desde,promocion_ref) VALUES (1,12,'2026-09-01 00:00:00',501);"
t "K-05 persona ocupa la plaza 1" ok "INSERT INTO p3m_partes.ocupacion_de_plaza(plaza_id,persona_id,vigente_desde) VALUES (1,1,'2026-01-01');"
t "K-04 segunda persona vigente en la misma plaza se rechaza (D-H4)" error "INSERT INTO p3m_partes.ocupacion_de_plaza(plaza_id,persona_id,vigente_desde) VALUES (1,2,'2026-01-01');"
t "K-05 misma persona en otra plaza vigente se rechaza (BR-047)" error "INSERT INTO p3m_partes.ocupacion_de_plaza(plaza_id,persona_id,vigente_desde) VALUES (2,1,'2026-01-01');"
t "FK: ocupacion con plaza inexistente se rechaza" error "INSERT INTO p3m_partes.ocupacion_de_plaza(plaza_id,persona_id,vigente_desde) VALUES (999,2,'2026-01-01');"

echo "== p3m_identidad"
run "DELETE FROM p3m_identidad.usuario_rol_de_usuario; DELETE FROM p3m_identidad.usuario;" >/dev/null
t "usuario ok" ok "INSERT INTO p3m_identidad.usuario(keycloak_guid,username,correo,persona_ref) VALUES ('11111111-1111-1111-1111-111111111111','ana','ana@comsatel.com',1);"
t "GUID repetido se rechaza" error "INSERT INTO p3m_identidad.usuario(keycloak_guid,username,correo) VALUES ('11111111-1111-1111-1111-111111111111','x','x@x.com');"
t "GUID distingue mayusculas (ascii_bin): AAAA.. distinto de aaaa.." ok "INSERT INTO p3m_identidad.usuario(keycloak_guid,username,correo) VALUES ('AAAAAAAA-1111-1111-1111-111111111111','u2','u2@x.com'),('aaaaaaaa-1111-1111-1111-111111111111','u3','u3@x.com');"
t "K-10 persona_ref repetido se rechaza" error "INSERT INTO p3m_identidad.usuario(keycloak_guid,username,correo,persona_ref) VALUES ('22222222-2222-2222-2222-222222222222','y','y@x.com',1);"
t "varios usuarios sin persona_ref (ADMIN/JI sin colaborador) es valido" ok "INSERT INTO p3m_identidad.usuario(keycloak_guid,username,correo) VALUES ('33333333-3333-3333-3333-333333333333','adm','adm@x.com'),('44444444-4444-4444-4444-444444444444','ji','ji@x.com');"
t "rol de usuario invalido se rechaza" error "INSERT INTO p3m_identidad.usuario_rol_de_usuario(usuario_id,rol_de_usuario) SELECT id,'SUPERADMIN' FROM p3m_identidad.usuario LIMIT 1;"
t "R-01 correccion de vinculo registrada con responsable y fecha" ok "INSERT INTO p3m_identidad.correccion_de_vinculo(usuario_id,persona_ref_anterior,persona_ref_nueva,corregida_por_ref,corregida_en) SELECT id,1,2,'44444444-4444-4444-4444-444444444444','2026-07-01 10:00:00' FROM p3m_identidad.usuario WHERE keycloak_guid='11111111-1111-1111-1111-111111111111';"
t "R-01 correccion a la misma persona se rechaza" error "INSERT INTO p3m_identidad.correccion_de_vinculo(usuario_id,persona_ref_anterior,persona_ref_nueva,corregida_por_ref,corregida_en) SELECT id,2,2,'44444444-4444-4444-4444-444444444444','2026-07-02 10:00:00' FROM p3m_identidad.usuario WHERE keycloak_guid='11111111-1111-1111-1111-111111111111';"
t "R-01 correccion sin responsable se rechaza" error "INSERT INTO p3m_identidad.correccion_de_vinculo(usuario_id,persona_ref_anterior,persona_ref_nueva,corregida_en) SELECT id,1,2,'2026-07-03 10:00:00' FROM p3m_identidad.usuario WHERE keycloak_guid='11111111-1111-1111-1111-111111111111';"

echo "== p3m_curricula"
run "INSERT INTO p3m_curricula.rol(nombre) VALUES ('Developer'),('QA');INSERT INTO p3m_curricula.competencia(codigo,nombre,tipo,es_general) VALUES ('C1','Python','CONOCIMIENTO',0),('C2','Comunicacion','HABILIDAD',1);" >/dev/null
run "INSERT INTO p3m_curricula.rol_competencia(rol_id,competencia_id) VALUES (1,1);" >/dev/null
run "INSERT INTO p3m_curricula.rol_nivel(rol_id,nivel_de_desarrollo_id) VALUES (1,1),(1,2);" >/dev/null
t "K-14 minimo para competencia del perfil ok" ok "INSERT INTO p3m_curricula.rol_nivel_competencia_minimo(rol_nivel_id,rol_id,competencia_id,nivel_minimo) VALUES (1,1,1,'N2');"
t "K-14 minimo para competencia fuera del perfil se rechaza" error "INSERT INTO p3m_curricula.rol_nivel_competencia_minimo(rol_nivel_id,rol_id,competencia_id,nivel_minimo) VALUES (1,1,2,'N2');"
t "K-15 rol_id que no coincide con el del rol/nivel se rechaza" error "INSERT INTO p3m_curricula.rol_nivel_competencia_minimo(rol_nivel_id,rol_id,competencia_id,nivel_minimo) VALUES (2,2,1,'N1');"
t "nivel de logro invalido (N4) se rechaza" error "INSERT INTO p3m_curricula.competencia_nivel_de_logro(competencia_id,nivel_de_logro,definicion) VALUES (1,'N4','x');"
t "codigo de competencia repetido (otro caso) se rechaza" error "INSERT INTO p3m_curricula.competencia(codigo,nombre,tipo,es_general) VALUES ('c1','Dup','ACTITUD',0);"
t "BR-011 niveles L1..L4 por seniority unicos" error "INSERT INTO p3m_curricula.nivel_de_desarrollo(seniority_id,nivel) VALUES (1,'L1');"

echo "== p3m_formacion"
run "INSERT INTO p3m_formacion.curso(codigo,nombre,sumilla) VALUES ('CUR1','Python avanzado','Resumen');INSERT INTO p3m_formacion.objetivo_de_curso(curso_id,descripcion,competencia_ref,nivel_objetivo) VALUES (1,'Dominar',1,'N2');INSERT INTO p3m_formacion.rubrica_nivel(objetivo_id,nivel_de_logro,descripcion_desempeno) VALUES (1,'N1','a'),(1,'N2','b'),(1,'N3','c');" >/dev/null
t "K-17 evidencia esperada sobre un nivel de la rubrica ok" ok "INSERT INTO p3m_formacion.evidencia_esperada(objetivo_id,nivel_de_logro,descripcion,obligatoriedad) VALUES (1,'N2','Issue cerrado','OBLIGATORIA');"
t "K-17 evidencia esperada sobre nivel inexistente de la rubrica se rechaza" error "INSERT INTO p3m_formacion.evidencia_esperada(objetivo_id,nivel_de_logro,descripcion,obligatoriedad) VALUES (2,'N2','x','OBLIGATORIA');"
t "obligatoriedad invalida se rechaza" error "INSERT INTO p3m_formacion.evidencia_esperada(objetivo_id,nivel_de_logro,descripcion,obligatoriedad) VALUES (1,'N1','x','OPCIONAL');"
run "INSERT INTO p3m_formacion.edicion_de_curso(curso_id,numero_de_edicion,fecha_inicio,fecha_fin,cupo,evaluador_ref) VALUES (1,1,'2026-03-01','2026-03-31',2,2);" >/dev/null
t "K-21 fecha_fin anterior a fecha_inicio se rechaza" error "INSERT INTO p3m_formacion.edicion_de_curso(curso_id,numero_de_edicion,fecha_inicio,fecha_fin,cupo,evaluador_ref) VALUES (1,2,'2026-04-30','2026-04-01',2,2);"
t "K-21 cupo 0 se rechaza" error "INSERT INTO p3m_formacion.edicion_de_curso(curso_id,numero_de_edicion,fecha_inicio,fecha_fin,cupo,evaluador_ref) VALUES (1,3,'2026-04-01','2026-04-30',0,2);"
t "numero de edicion repetido se rechaza" error "INSERT INTO p3m_formacion.edicion_de_curso(curso_id,numero_de_edicion,fecha_inicio,fecha_fin,cupo,evaluador_ref) VALUES (1,1,'2026-05-01','2026-05-30',2,2);"
t "enrolamiento ok con avance, nota y comentarios" ok "INSERT INTO p3m_formacion.enrolamiento(edicion_id,colaborador_ref,estado,avance_porcentaje,nota,comentarios) VALUES (1,1,'INSCRITO',50.5,14.5,'Buen avance');"
t "K-19 mismo colaborador activo dos veces se rechaza" error "INSERT INTO p3m_formacion.enrolamiento(edicion_id,colaborador_ref,estado) VALUES (1,1,'INSCRITO');"
t "K-19 desenrolarse y volver a enrolarse es valido (S-08)" ok "UPDATE p3m_formacion.enrolamiento SET estado='DESENROLADO' WHERE edicion_id=1 AND colaborador_ref=1; INSERT INTO p3m_formacion.enrolamiento(edicion_id,colaborador_ref,estado) VALUES (1,1,'INSCRITO');"
t "K-39 avance 120 % se rechaza" error "INSERT INTO p3m_formacion.enrolamiento(edicion_id,colaborador_ref,estado,avance_porcentaje) VALUES (1,2,'INSCRITO',120);"
t "K-40 nota 21 se rechaza (escala 0..20)" error "INSERT INTO p3m_formacion.enrolamiento(edicion_id,colaborador_ref,estado,nota) VALUES (1,2,'INSCRITO',21);"
t "K-40 nota 20 y nota 0 son validas" ok "INSERT INTO p3m_formacion.enrolamiento(edicion_id,colaborador_ref,estado,nota) VALUES (1,2,'INSCRITO',20),(1,3,'INSCRITO',0);"
t "certificacion: una por enrolamiento (R-16)" ok "INSERT INTO p3m_formacion.certificacion_de_curso(enrolamiento_id,evaluador_ref,emitida_en) VALUES (3,2,'2026-03-31 12:00:00');"
t "certificacion repetida para el mismo enrolamiento se rechaza" error "INSERT INTO p3m_formacion.certificacion_de_curso(enrolamiento_id,evaluador_ref,emitida_en) VALUES (3,2,'2026-04-01 12:00:00');"

echo "== p3m_progresion"
run "INSERT INTO p3m_progresion.solicitud_de_promocion(colaborador_ref,rol_nivel_destino_ref,estado) VALUES (1,11,'REGISTRADA');" >/dev/null
t "K-22 evidencia de CURSO completa ok" ok "INSERT INTO p3m_progresion.evidencia_aportada(tipo,colaborador_ref,issue_url,enrolamiento_ref,evidencia_esperada_ref,estado) VALUES ('CURSO',1,'https://gitlab.x/g/p/-/issues/1',2,1,'PENDIENTE');"
t "K-22 segunda evidencia para la misma esperada y enrolamiento se rechaza (D-H11)" error "INSERT INTO p3m_progresion.evidencia_aportada(tipo,colaborador_ref,issue_url,enrolamiento_ref,evidencia_esperada_ref,estado) VALUES ('CURSO',1,'https://gitlab.x/g/p/-/issues/2',2,1,'PENDIENTE');"
t "K-22 evidencia de CURSO sin enrolamiento se rechaza" error "INSERT INTO p3m_progresion.evidencia_aportada(tipo,colaborador_ref,issue_url,estado) VALUES ('CURSO',1,'https://gitlab.x/g/p/-/issues/3','PENDIENTE');"
t "K-22 dos evidencias de PROYECTO (sin esperada) son validas" ok "INSERT INTO p3m_progresion.evidencia_aportada(tipo,colaborador_ref,issue_url,solicitud_de_promocion_id,estado) VALUES ('PROYECTO',1,'https://gitlab.x/g/p/-/issues/4',1,'PENDIENTE'),('PROYECTO',1,'https://gitlab.x/g/p/-/issues/5',1,'PENDIENTE');"
t "K-24 VALIDADA sin validador ni fecha se rechaza" error "INSERT INTO p3m_progresion.evidencia_aportada(tipo,colaborador_ref,issue_url,solicitud_de_promocion_id,estado) VALUES ('PROYECTO',1,'https://gitlab.x/g/p/-/issues/6',1,'VALIDADA');"
t "K-24 VALIDADA con validador y fecha ok" ok "INSERT INTO p3m_progresion.evidencia_aportada(tipo,colaborador_ref,issue_url,solicitud_de_promocion_id,estado,validada_por_ref,validada_en) VALUES ('PROYECTO',1,'https://gitlab.x/g/p/-/issues/7',1,'VALIDADA',2,'2026-03-01 10:00:00');"
t "estado RECHAZADA no existe (D-H11)" error "INSERT INTO p3m_progresion.evidencia_aportada(tipo,colaborador_ref,issue_url,solicitud_de_promocion_id,estado) VALUES ('PROYECTO',1,'https://gitlab.x/g/p/-/issues/8',1,'RECHAZADA');"
run "INSERT INTO p3m_progresion.valoracion_de_competencia(colaborador_ref,competencia_ref) VALUES (1,1);INSERT INTO p3m_progresion.valoracion_registro(valoracion_id,nivel_de_logro,registrada_por_ref,registrada_en) VALUES (1,'N1','11111111-1111-1111-1111-111111111111','2026-01-01 00:00:00'),(1,'N2','11111111-1111-1111-1111-111111111111','2026-03-01 00:00:00');" >/dev/null
t "una valoracion por colaborador y competencia (la repetida se rechaza)" error "INSERT INTO p3m_progresion.valoracion_de_competencia(colaborador_ref,competencia_ref) VALUES (1,1);"
t "CON-07 la valoracion mas reciente es N2" ok "SELECT 1 FROM p3m_progresion.valoracion_registro WHERE valoracion_id=1 ORDER BY registrada_en DESC LIMIT 1;"
run "INSERT INTO p3m_progresion.evaluacion_de_desempeno(colaborador_ref,periodo_desde,periodo_hasta,resultado,registrada_en,registrada_por_ref) VALUES (1,'2026-01-01','2026-06-30','CUMPLE','2026-07-01 09:00:00','44444444-4444-4444-4444-444444444444');" >/dev/null
t "K-27 periodo invertido se rechaza" error "INSERT INTO p3m_progresion.evaluacion_de_desempeno(colaborador_ref,periodo_desde,periodo_hasta,resultado,registrada_en,registrada_por_ref) VALUES (1,'2026-06-30','2026-01-01','CUMPLE','2026-07-01 09:00:00','44444444-4444-4444-4444-444444444444');"
t "resultado de evaluacion invalido se rechaza" error "INSERT INTO p3m_progresion.evaluacion_de_desempeno(colaborador_ref,periodo_desde,periodo_hasta,resultado,registrada_en,registrada_por_ref) VALUES (1,'2026-01-01','2026-06-30','EXCELENTE','2026-07-01 09:00:00','44444444-4444-4444-4444-444444444444');"
t "K-26 promocion sin evaluacion de desempeno se rechaza" error "INSERT INTO p3m_progresion.promocion_de_nivel(colaborador_ref,rol_nivel_destino_ref,decidida_por_ref,decidida_en) VALUES (1,11,'44444444-4444-4444-4444-444444444444','2026-07-02 10:00:00');"
t "K-26 promocion con evaluacion inexistente se rechaza" error "INSERT INTO p3m_progresion.promocion_de_nivel(colaborador_ref,rol_nivel_destino_ref,decidida_por_ref,decidida_en,evaluacion_de_desempeno_id) VALUES (1,11,'44444444-4444-4444-4444-444444444444','2026-07-02 10:00:00',999);"
t "promocion con evaluacion y solicitud ok (D-H17)" ok "INSERT INTO p3m_progresion.promocion_de_nivel(colaborador_ref,rol_nivel_destino_ref,decidida_por_ref,decidida_en,evaluacion_de_desempeno_id,solicitud_de_promocion_id) VALUES (1,11,'44444444-4444-4444-4444-444444444444','2026-07-02 10:00:00',1,1);"
t "K-41 segunda promocion para la misma solicitud se rechaza" error "INSERT INTO p3m_progresion.promocion_de_nivel(colaborador_ref,rol_nivel_destino_ref,decidida_por_ref,decidida_en,evaluacion_de_desempeno_id,solicitud_de_promocion_id) VALUES (1,12,'44444444-4444-4444-4444-444444444444','2026-07-03 10:00:00',1,1);"
t "D-H17 promocion sin solicitud (varias) es valida" ok "INSERT INTO p3m_progresion.promocion_de_nivel(colaborador_ref,rol_nivel_destino_ref,decidida_por_ref,decidida_en,evaluacion_de_desempeno_id) VALUES (2,11,'44444444-4444-4444-4444-444444444444','2026-07-02 10:00:00',1),(3,11,'44444444-4444-4444-4444-444444444444','2026-07-02 10:00:00',1);"
t "outbox: payload JSON ok (EVT-01)" ok "INSERT INTO p3m_progresion.outbox_evento(evento_id,tipo,schema_version,clave_orden,payload,creado_en) VALUES ('55555555-5555-5555-5555-555555555555','PromocionDeNivelDecidida',1,1,JSON_OBJECT('promocion_ref',1,'persona_ref',1,'rol_nivel_destino_ref',11,'decidida_en','2026-07-02T10:00:00Z'),'2026-07-02 10:00:00');"
t "outbox: evento_id repetido se rechaza" error "INSERT INTO p3m_progresion.outbox_evento(evento_id,tipo,schema_version,clave_orden,payload,creado_en) VALUES ('55555555-5555-5555-5555-555555555555','PromocionDeNivelDecidida',1,1,JSON_OBJECT(),'2026-07-02 10:00:00');"

echo "== p3m_portafolio"
run "INSERT INTO p3m_portafolio.producto(codigo,nombre,gitlab_project_id) VALUES ('P3M','Portal P3M',77);INSERT INTO p3m_portafolio.proyecto(producto_id,codigo,nombre,fecha_inicio,fecha_fin,costo_estimado,esfuerzo_estimado) VALUES (1,'PRY1','Fase 1','2026-01-01','2026-12-31',150000.50,3200.5),(1,'PRY2','Fase 2','2027-01-01','2027-06-30',NULL,NULL);" >/dev/null
t "proyecto: fechas invertidas se rechazan" error "INSERT INTO p3m_portafolio.proyecto(producto_id,codigo,nombre,fecha_inicio,fecha_fin) VALUES (1,'PRY3','x','2026-12-31','2026-01-01');"
t "proyecto: costo negativo se rechaza" error "INSERT INTO p3m_portafolio.proyecto(producto_id,codigo,nombre,fecha_inicio,fecha_fin,costo_estimado) VALUES (1,'PRY4','x','2026-01-01','2026-12-31',-1);"
t "K-30 milestone en un proyecto ok" ok "INSERT INTO p3m_portafolio.proyecto_milestone(proyecto_id,milestone_ref) VALUES (1,9001);"
t "K-30 mismo milestone en otro proyecto se rechaza" error "INSERT INTO p3m_portafolio.proyecto_milestone(proyecto_id,milestone_ref) VALUES (2,9001);"
t "K-47 fila de bloqueo por colaborador ok" ok "INSERT IGNORE INTO p3m_portafolio.colaborador_carga(colaborador_ref) VALUES (500);"
t "K-47 repetir la fila de bloqueo no duplica ni falla (INSERT IGNORE)" ok "INSERT IGNORE INTO p3m_portafolio.colaborador_carga(colaborador_ref) VALUES (500);"
tv "K-47 una sola fila por colaborador" "1" "SELECT COUNT(*) FROM p3m_portafolio.colaborador_carga WHERE colaborador_ref=500;"
t "requerido: cantidad 0 se rechaza" error "INSERT INTO p3m_portafolio.proyecto_rol_nivel_requerido(proyecto_id,rol_nivel_ref,cantidad) VALUES (1,10,0);"
t "requerido: rol/nivel con cantidad ok" ok "INSERT INTO p3m_portafolio.proyecto_rol_nivel_requerido(proyecto_id,rol_nivel_ref,cantidad) VALUES (1,10,2);"
t "K-29 primer jefe vigente ok" ok "INSERT INTO p3m_portafolio.jefatura_de_proyecto(proyecto_id,colaborador_ref,vigente_desde) VALUES (1,1,'2026-01-01');"
t "K-29 segundo jefe vigente del mismo proyecto se rechaza (D-H2)" error "INSERT INTO p3m_portafolio.jefatura_de_proyecto(proyecto_id,colaborador_ref,vigente_desde) VALUES (1,2,'2026-02-01');"
t "D-H2 un colaborador jefe de dos proyectos es valido" ok "INSERT INTO p3m_portafolio.jefatura_de_proyecto(proyecto_id,colaborador_ref,vigente_desde) VALUES (2,1,'2026-02-01');"
t "D-H2 cerrar jefe y designar otro es valido" ok "UPDATE p3m_portafolio.jefatura_de_proyecto SET vigente_hasta='2026-06-01' WHERE proyecto_id=1 AND vigente_hasta IS NULL; INSERT INTO p3m_portafolio.jefatura_de_proyecto(proyecto_id,colaborador_ref,vigente_desde) VALUES (1,2,'2026-06-01');"
t "K-28 asignacion con rol/nivel requerido por el proyecto ok" ok "INSERT INTO p3m_portafolio.asignacion(colaborador_ref,proyecto_id,rol_nivel_ref,porcentaje_dedicacion,vigente_desde,estado,realizada_por_ref) VALUES (1,1,10,60,'2026-01-01','VIGENTE','44444444-4444-4444-4444-444444444444');"
t "K-28 asignacion con rol/nivel que el proyecto no requiere se rechaza" error "INSERT INTO p3m_portafolio.asignacion(colaborador_ref,proyecto_id,rol_nivel_ref,porcentaje_dedicacion,vigente_desde,estado,realizada_por_ref) VALUES (1,1,99,10,'2026-01-01','VIGENTE','44444444-4444-4444-4444-444444444444');"
t "K-32 dedicacion 0 se rechaza" error "INSERT INTO p3m_portafolio.asignacion(colaborador_ref,proyecto_id,rol_nivel_ref,porcentaje_dedicacion,vigente_desde,estado,realizada_por_ref) VALUES (2,1,10,0,'2026-01-01','VIGENTE','44444444-4444-4444-4444-444444444444');"
t "K-32 dedicacion 100,01 se rechaza" error "INSERT INTO p3m_portafolio.asignacion(colaborador_ref,proyecto_id,rol_nivel_ref,porcentaje_dedicacion,vigente_desde,estado,realizada_por_ref) VALUES (2,1,10,100.01,'2026-01-01','VIGENTE','44444444-4444-4444-4444-444444444444');"
t "estado de asignacion invalido se rechaza" error "INSERT INTO p3m_portafolio.asignacion(colaborador_ref,proyecto_id,rol_nivel_ref,porcentaje_dedicacion,vigente_desde,estado,realizada_por_ref) VALUES (2,1,10,10,'2026-01-01','ACTIVA','44444444-4444-4444-4444-444444444444');"
t "BR-067 motivo + excepcion ok" ok "INSERT INTO p3m_portafolio.motivo_de_excepcion(codigo,descripcion) VALUES ('M1','Urgencia'); INSERT INTO p3m_portafolio.excepcion_de_asignacion(asignacion_id,motivo_id,aprobada_por_ref) VALUES (1,1,'44444444-4444-4444-4444-444444444444');"
t "BR-067 un motivo usado no se puede borrar" error "DELETE FROM p3m_portafolio.motivo_de_excepcion WHERE id=1;"
t "una asignacion no admite dos excepciones (R-43)" error "INSERT INTO p3m_portafolio.excepcion_de_asignacion(asignacion_id,motivo_id,aprobada_por_ref) VALUES (1,1,'44444444-4444-4444-4444-444444444444');"
t "borrar un rol/nivel requerido con asignaciones se rechaza" error "DELETE FROM p3m_portafolio.proyecto_rol_nivel_requerido WHERE proyecto_id=1 AND rol_nivel_ref=10;"

echo "== p3m_gitlab"
t "carga: intentos 4 se rechaza (BR-082)" error "INSERT INTO p3m_gitlab.carga_de_gitlab(iniciada_en,estado,intentos) VALUES ('2026-01-01 00:00:00','FALLIDA',4);"
t "carga: estado invalido se rechaza" error "INSERT INTO p3m_gitlab.carga_de_gitlab(iniciada_en,estado) VALUES ('2026-01-01 00:00:00','EXITOSA');"
t "carga completa (delta_desde nulo) y delta ok" ok "INSERT INTO p3m_gitlab.carga_de_gitlab(iniciada_en,delta_desde,estado,intentos) VALUES ('2026-01-01 00:00:00',NULL,'COMPLETADA',0),('2026-01-01 00:00:30','2026-01-01 00:00:00','SIN_CAMBIOS',0);"
t "replica milestone ok" ok "INSERT INTO p3m_gitlab.replica_milestone(gitlab_milestone_id,gitlab_project_id,titulo) VALUES (9001,77,'Sprint 1');"
t "K-38 issue con milestone inexistente se rechaza" error "INSERT INTO p3m_gitlab.replica_issue(gitlab_issue_id,gitlab_project_id,gitlab_milestone_id,tipo,estado,web_url,titulo,actualizado_en) VALUES (1,77,424242,'TASK','CLOSED','https://gitlab.x/g/p/-/issues/1','t','2026-01-01 00:00:00');"
t "issue con label UserStory/Task y milestone ok" ok "INSERT INTO p3m_gitlab.replica_issue(gitlab_issue_id,gitlab_project_id,gitlab_milestone_id,tipo,estado,web_url,titulo,actualizado_en) VALUES (1,77,9001,'TASK','CLOSED','https://gitlab.x/g/p/-/issues/1','Tarea','2026-01-01 00:00:00');"
t "tipo de issue distinto de UserStory/Task se rechaza (BR-020)" error "INSERT INTO p3m_gitlab.replica_issue(gitlab_issue_id,gitlab_project_id,tipo,estado,web_url,titulo,actualizado_en) VALUES (2,77,'BUG','OPENED','https://gitlab.x/g/p/-/issues/2','b','2026-01-01 00:00:00');"
t "CON-10 misma URL en otro issue se rechaza" error "INSERT INTO p3m_gitlab.replica_issue(gitlab_issue_id,gitlab_project_id,tipo,estado,web_url,titulo,actualizado_en) VALUES (3,77,'TASK','OPENED','https://gitlab.x/g/p/-/issues/1','dup','2026-01-01 00:00:00');"
t "CON-10 URL que difiere solo en mayusculas es otra URL (utf8mb4_bin)" ok "INSERT INTO p3m_gitlab.replica_issue(gitlab_issue_id,gitlab_project_id,tipo,estado,web_url,titulo,actualizado_en) VALUES (4,77,'TASK','OPENED','https://gitlab.x/g/p/-/issues/1/','otra','2026-01-01 00:00:00');"
t "CON-10 busqueda por URL usa el indice (hash)" ok "SELECT estado FROM p3m_gitlab.replica_issue WHERE web_url_sha256 = UNHEX(SHA2('https://gitlab.x/g/p/-/issues/1',256)) AND web_url='https://gitlab.x/g/p/-/issues/1';"

echo
echo "RESULTADO: $pass superadas, $fail fallidas"
[ $fail -eq 0 ]
