#!/bin/bash
# Ciclo completo en un MySQL 8.4 NUEVO y desechable (Docker): cuentas -> Flyway real -> permisos por tabla -> postflight -> pruebas.
# Requisitos: Docker en marcha, imágenes mysql:8.4 y flyway/flyway:10. Usa solo contraseñas de prueba y 127.0.0.1:33307.
# Elimina y recrea el contenedor p3m-ddl-test. No usar contra una instancia real.
export MSYS_NO_PATHCONV=1
HERE="$(cd "$(dirname "$0")" && pwd)"
FW="$(cd "$HERE/.." && pwd)"
cd "$FW"; W="$(pwd -W)"
SCR="$HERE"
R="docker exec -i p3m-ddl-test mysql -uroot -ptest-only-pw"
fails=0
chk() { if [ "$2" = "$3" ]; then echo "  OK    $1 = $3"; else echo "  FALLA $1: esperado $3, obtenido $2"; fails=$((fails+1)); fi; }

echo "== contenedor nuevo"
docker rm -f p3m-ddl-test >/dev/null 2>&1
docker run -d --name p3m-ddl-test -e MYSQL_ROOT_PASSWORD=test-only-pw -e TZ=UTC -p 127.0.0.1:33307:3306 mysql:8.4 --default-time-zone=+00:00 --character-set-server=utf8mb4 --collation-server=utf8mb4_0900_ai_ci >/dev/null
for i in $(seq 1 60); do docker exec p3m-ddl-test mysqladmin -uroot -ptest-only-pw ping 2>/dev/null | grep -q alive && break; sleep 3; done
sleep 5
$R -N -e "select version()" 2>/dev/null

echo "== PASO 1: esquemas y cuentas"
out=$(sed -E "s/<<VAULT [^>]*>>/Test#Only1pw/" provision/00_esquemas_y_cuentas.sql | $R 2>&1 | grep -v "Using a password"); [ -n "$out" ] && { echo "$out"; fails=$((fails+1)); } || echo "  OK"

echo "== Flyway migrate (cuentas flyway_<ctx>, SSL)"
for s in p3m_curricula p3m_partes p3m_identidad p3m_formacion p3m_progresion p3m_portafolio p3m_gitlab; do
  short=${s#p3m_}
  o=$(docker run --rm --network container:p3m-ddl-test -v "$W/$s:/flyway/sql/$s:ro" flyway/flyway:10 -url="jdbc:mariadb://127.0.0.1:3306/$s?useSsl=true&trustServerCertificate=true" -user=flyway_$short -password='Test#Only1pw' -schemas=$s -defaultSchema=$s -locations=filesystem:/flyway/sql/$s -cleanDisabled=true -validateOnMigrate=true -outOfOrder=false -baselineOnMigrate=false -connectRetries=2 migrate 2>&1)
  echo "$o" | grep -E "Successfully applied|^ERROR|WARNING: DB" | sed 's/^/  /'
  echo "$o" | grep -q "Successfully applied" || fails=$((fails+1))
done

echo "== PASO 2: permisos por tabla"
out=$(sed -E "s/<<VAULT [^>]*>>/Test#Only1pw/" provision/01_permisos_por_tabla.sql | $R 2>&1 | grep -v "Using a password"); [ -n "$out" ] && { echo "$out"; fails=$((fails+1)); } || echo "  OK"
echo "== PASO 2 es idempotente (segunda ejecución)"
out=$(sed -E "s/<<VAULT [^>]*>>/Test#Only1pw/" provision/01_permisos_por_tabla.sql | $R 2>&1 | grep -v "Using a password"); [ -n "$out" ] && { echo "$out"; fails=$((fails+1)); } || echo "  OK"

echo "== Postflight"
Q="docker exec -i p3m-ddl-test mysql -uroot -ptest-only-pw -N"
declare -A TAB=( [p3m_partes]=9 [p3m_identidad]=3 [p3m_curricula]=8 [p3m_formacion]=7 [p3m_progresion]=12 [p3m_portafolio]=9 [p3m_gitlab]=3 )
declare -A CK=( [p3m_partes]=13 [p3m_identidad]=2 [p3m_curricula]=6 [p3m_formacion]=8 [p3m_progresion]=8 [p3m_portafolio]=7 [p3m_gitlab]=4 )
for s in p3m_partes p3m_identidad p3m_curricula p3m_formacion p3m_progresion p3m_portafolio p3m_gitlab; do
  t=$($Q -e "select count(*) from information_schema.tables where table_schema='$s' and table_type='BASE TABLE' and table_name<>'flyway_schema_history'" 2>/dev/null)
  bad=$($Q -e "select count(*) from information_schema.tables where table_schema='$s' and table_type='BASE TABLE' and table_name<>'flyway_schema_history' and (engine<>'InnoDB' or table_collation<>'utf8mb4_0900_ai_ci')" 2>/dev/null)
  cross=$($Q -e "select count(*) from information_schema.referential_constraints where constraint_schema='$s' and unique_constraint_schema<>constraint_schema" 2>/dev/null)
  nr=$($Q -e "select count(*) from information_schema.referential_constraints where constraint_schema='$s' and (delete_rule not in ('RESTRICT','NO ACTION') or update_rule not in ('RESTRICT','NO ACTION'))" 2>/dev/null)
  ck=$($Q -e "select count(*) from information_schema.table_constraints where constraint_schema='$s' and constraint_type='CHECK'" 2>/dev/null)
  ok=$($Q -e "select count(*) from $s.flyway_schema_history where success=0" 2>/dev/null)
  chk "$s tablas" "$t" "${TAB[$s]}"; chk "$s tablas no InnoDB/utf8mb4" "$bad" 0; chk "$s FK entre esquemas" "$cross" 0; chk "$s FK no RESTRICT" "$nr" 0; chk "$s CHECK" "$ck" "${CK[$s]}"; chk "$s migraciones fallidas" "$ok" 0
done
chk "semillas seniority/niveles" "$($Q -e "select concat(count(*),'/',(select count(*) from p3m_curricula.nivel_de_desarrollo)) from p3m_curricula.seniority" 2>/dev/null)" "3/12"
chk "únicos de una sola vigente (7)" "$($Q -e "select count(*) from (select 1 from information_schema.statistics where table_schema like 'p3m\_%' and non_unique=0 and column_name in ('vigente_clave','vigente_plaza','vigente_persona','vigente_proyecto','activo_colaborador','correo_unico') group by table_schema, table_name, index_name) x" 2>/dev/null)" 7
chk "Q9 permisos fuera de política" "$($Q -e "select count(*) from information_schema.table_privileges where table_schema like 'p3m\_%' and grantee like '''svc\_%' and ((privilege_type='DELETE' and table_name not in ('rol_competencia','rol_nivel_competencia_minimo','proyecto_milestone','proyecto_rol_nivel_requerido','usuario_rol_de_usuario')) or (privilege_type in ('UPDATE','DELETE') and table_name in ('valoracion_registro','evaluacion_de_desempeno','evaluacion_evidencia','evaluacion_certificacion','correccion_de_vinculo')))" 2>/dev/null)" 0
chk "svc_identidad sin UPDATE sobre usuario.persona_ref (vínculo inmutable)" "$($Q -e "select count(*) from information_schema.column_privileges where table_schema='p3m_identidad' and table_name='usuario' and column_name='persona_ref' and privilege_type='UPDATE' and grantee=\"'svc_identidad'@'%'\"" 2>/dev/null)" 0
chk "svc_identidad_correccion con UPDATE sobre usuario.persona_ref" "$($Q -e "select count(*) from information_schema.column_privileges where table_schema='p3m_identidad' and table_name='usuario' and column_name='persona_ref' and privilege_type='UPDATE' and grantee=\"'svc_identidad_correccion'@'%'\"" 2>/dev/null)" 1
chk "tablas sin permiso de servicio" "$($Q -e "select count(*) from information_schema.tables t where t.table_schema like 'p3m\_%' and t.table_name<>'flyway_schema_history' and not exists (select 1 from information_schema.table_privileges p where p.table_schema=t.table_schema and p.table_name=t.table_name and p.grantee like '''svc\_%')" 2>/dev/null)" 0
echo "  checksums de Flyway:"; for s in p3m_curricula p3m_partes p3m_identidad p3m_formacion p3m_progresion p3m_portafolio p3m_gitlab; do $Q -e "select '$s', script, checksum from $s.flyway_schema_history where script like 'V%' order by installed_rank" 2>/dev/null; done | sed 's/^/    /'

echo "== Pruebas de restricciones"
res=$(bash "$SCR/pruebas_restricciones.sh" 2>&1); echo "$res" | grep -E "FAIL|RESULTADO" ; echo "$res" | grep -q "0 fallidas" || fails=$((fails+1))

echo "== Pruebas de permisos y SSL"
c() { u=$1; shift; docker exec -i p3m-ddl-test mysql -u$u -pTest#Only1pw -h127.0.0.1 --ssl-mode=REQUIRED -N -e "$*" 2>&1 | grep -v "Using a password" | head -1; }
perm() { if echo "$3" | grep -q "$2"; then echo "  OK    $1"; else echo "  FALLA $1 -> $3"; fails=$((fails+1)); fi; }
perm "svc_progresion inserta valoracion_registro" "ok" "$(c svc_progresion "INSERT INTO p3m_progresion.valoracion_registro(valoracion_id,nivel_de_logro,registrada_por_ref,registrada_en) VALUES (1,'N3','11111111-1111-1111-1111-111111111111','2026-04-01 00:00:00'); select 'ok'")"
perm "svc_progresion no actualiza valoracion_registro" "1142" "$(c svc_progresion "UPDATE p3m_progresion.valoracion_registro SET nivel_de_logro='N1' WHERE id=1")"
perm "svc_progresion no borra evaluacion_de_desempeno" "1142" "$(c svc_progresion "DELETE FROM p3m_progresion.evaluacion_de_desempeno WHERE id=1")"
perm "svc_progresion no lee p3m_partes" "1142" "$(c svc_progresion "SELECT * FROM p3m_partes.persona")"
perm "svc_partes no borra persona" "1142" "$(c svc_partes "DELETE FROM p3m_partes.persona WHERE parte_id=3")"
perm "svc_portafolio borra en proyecto_milestone (permitido)" "ok" "$(c svc_portafolio "DELETE FROM p3m_portafolio.proyecto_milestone WHERE milestone_ref=-1; select 'ok'")"
perm "svc_gitlab no inserta réplicas" "1142" "$(c svc_gitlab "INSERT INTO p3m_gitlab.replica_issue(gitlab_issue_id,gitlab_project_id,tipo,estado,web_url,titulo,actualizado_en) VALUES (60,77,'TASK','OPENED','https://gitlab.x/g/p/-/issues/60','t','2026-01-01')")"
perm "svc_gitlab inserta carga (reintento)" "ok" "$(c svc_gitlab "INSERT INTO p3m_gitlab.carga_de_gitlab(iniciada_en,estado) VALUES ('2026-02-01','PROGRAMADA'); select 'ok'")"
perm "svc_gitlab_carga inserta réplicas" "ok" "$(c svc_gitlab_carga "INSERT INTO p3m_gitlab.replica_issue(gitlab_issue_id,gitlab_project_id,tipo,estado,web_url,titulo,actualizado_en) VALUES (61,77,'TASK','OPENED','https://gitlab.x/g/p/-/issues/61','t','2026-01-01'); select 'ok'")"
perm "svc_gitlab_carga no borra carga_de_gitlab" "1142" "$(c svc_gitlab_carga "DELETE FROM p3m_gitlab.carga_de_gitlab")"
perm "svc_identidad actualiza usuario.correo" "ok" "$(c svc_identidad "UPDATE p3m_identidad.usuario SET correo='ana@comsatel.com' WHERE keycloak_guid='11111111-1111-1111-1111-111111111111'; select 'ok'")"
perm "svc_identidad no actualiza usuario.persona_ref (K-45)" "1143" "$(c svc_identidad "UPDATE p3m_identidad.usuario SET persona_ref=3 WHERE keycloak_guid='11111111-1111-1111-1111-111111111111'")"
perm "svc_identidad no inserta correcciones de vínculo" "1142" "$(c svc_identidad "INSERT INTO p3m_identidad.correccion_de_vinculo(usuario_id,persona_ref_anterior,persona_ref_nueva,corregida_por_ref,corregida_en) VALUES (1,1,3,'44444444-4444-4444-4444-444444444444','2026-08-01 00:00:00')")"
perm "svc_identidad_correccion actualiza usuario.persona_ref" "ok" "$(c svc_identidad_correccion "UPDATE p3m_identidad.usuario SET persona_ref=2 WHERE keycloak_guid='11111111-1111-1111-1111-111111111111'; select 'ok'")"
perm "svc_identidad_correccion no actualiza usuario.correo" "1143" "$(c svc_identidad_correccion "UPDATE p3m_identidad.usuario SET correo='x@x.com' WHERE keycloak_guid='11111111-1111-1111-1111-111111111111'")"
perm "svc_identidad_correccion registra la corrección" "ok" "$(c svc_identidad_correccion "INSERT INTO p3m_identidad.correccion_de_vinculo(usuario_id,persona_ref_anterior,persona_ref_nueva,corregida_por_ref,corregida_en) SELECT id,1,2,'44444444-4444-4444-4444-444444444444','2026-08-01 00:00:00' FROM p3m_identidad.usuario WHERE keycloak_guid='11111111-1111-1111-1111-111111111111'; select 'ok'")"
perm "svc_identidad_correccion no actualiza correcciones (solo inserción)" "1142" "$(c svc_identidad_correccion "UPDATE p3m_identidad.correccion_de_vinculo SET persona_ref_nueva=9")"
perm "svc_identidad_correccion no borra usuarios" "1142" "$(c svc_identidad_correccion "DELETE FROM p3m_identidad.usuario")"

echo "== K-31 con la cuenta real svc_portafolio: dos primeras asignaciones simultáneas de 60 %, protocolo K-47"
k31() { # $1 aislamiento $2 colaborador $3 proyecto
  docker exec -i p3m-ddl-test mysql -usvc_portafolio -pTest#Only1pw -h127.0.0.1 --ssl-mode=REQUIRED -N --init-command="SET SESSION TRANSACTION ISOLATION LEVEL $1" p3m_portafolio -e "
   START TRANSACTION;
   INSERT IGNORE INTO colaborador_carga(colaborador_ref) VALUES ($2);
   SELECT colaborador_ref FROM colaborador_carga WHERE colaborador_ref=$2 FOR UPDATE;
   SELECT COALESCE(SUM(porcentaje_dedicacion),0) INTO @s FROM asignacion WHERE colaborador_ref=$2 AND vigente_hasta IS NULL;
   DO SLEEP(2);
   INSERT INTO asignacion(colaborador_ref,proyecto_id,rol_nivel_ref,porcentaje_dedicacion,vigente_desde,estado,realizada_por_ref)
     SELECT $2,$3,10,60,'2026-01-01','VIGENTE','44444444-4444-4444-4444-444444444444' FROM DUAL WHERE @s+60<=100;
   SELECT ROW_COUNT(); COMMIT;" 2>&1 | grep -v "Using a password" | tr '\n' ' '
}
# Los dos proyectos del experimento necesitan el rol/nivel requerido; sin esto, la sesión que gana el bloqueo sobre el proyecto sin requerimiento falla por clave foránea (no por interbloqueo) y el resultado es intermitente.
$Q -e "INSERT IGNORE INTO p3m_portafolio.proyecto_rol_nivel_requerido(proyecto_id,rol_nivel_ref,cantidad) VALUES (1,10,5),(2,10,5)" 2>/dev/null
for pair in "READ COMMITTED:301" "REPEATABLE READ:302"; do
  iso=${pair%%:*}; col=${pair##*:}
  oa=$(mktemp); ob=$(mktemp)
  ( k31 "$iso" $col 1 > $oa ) & ( k31 "$iso" $col 2 > $ob ) & wait
  total=$($Q -e "select coalesce(sum(porcentaje_dedicacion),0) from p3m_portafolio.asignacion where colaborador_ref=$col" 2>/dev/null)
  errs=$(cat $oa $ob | grep -c "ERROR")
  [ "$errs" -gt 0 ] && { echo "  salida de las sesiones ($iso):"; cat $oa $ob | sed "s/^/    /"; echo; }
  chk "K-31 $iso: suma final" "${total%.*}" 60
  chk "K-31 $iso: errores (interbloqueos)" "$errs" 0
done

perm "conexión sin SSL rechazada" "1045" "$(docker exec -i p3m-ddl-test mysql -usvc_partes -pTest#Only1pw -h127.0.0.1 --ssl-mode=DISABLED -N -e 'select 1' 2>&1 | grep -v 'Using a password' | head -1)"

echo
[ $fails -eq 0 ] && echo "CICLO COMPLETO: SIN FALLAS" || echo "CICLO COMPLETO: $fails FALLA(S)"
