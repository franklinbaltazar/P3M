#!/bin/bash
# K-31: suma de dedicación <= 100 % con SELECT ... FOR UPDATE (ADR-P6). Dos sesiones simultáneas, MySQL 8.4.
# Resultado de la revisión (RPT-DDR-001 R-02): con READ COMMITTED y sin asignación vigente la regla se viola (120 %).
# Requisitos: Docker en marcha e imagen mysql:8.4. Usa el contenedor p3m-conc, solo contraseñas de prueba. No usar contra una instancia real.
export MSYS_NO_PATHCONV=1
HERE="$(cd "$(dirname "$0")" && pwd)"
FW="$(cd "$HERE/.." && pwd)"
R="docker exec -i p3m-conc mysql -uroot -ptest-only-pw"
docker rm -f p3m-conc >/dev/null 2>&1
docker run -d --name p3m-conc -e MYSQL_ROOT_PASSWORD=test-only-pw mysql:8.4 >/dev/null
for i in $(seq 1 60); do docker exec p3m-conc mysqladmin -uroot -ptest-only-pw ping 2>/dev/null | grep -q alive && break; sleep 3; done; sleep 5
$R -e "CREATE DATABASE p3m_portafolio CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci" 2>/dev/null
$R p3m_portafolio < "$FW/p3m_portafolio/V1__baseline_portafolio.sql" 2>&1 | grep -v "Using a password"
$R p3m_portafolio -e "
 INSERT INTO producto(codigo,nombre,gitlab_project_id) VALUES ('P','P',1);
 INSERT INTO proyecto(producto_id,codigo,nombre,fecha_inicio,fecha_fin) VALUES (1,'A','A','2026-01-01','2026-12-31'),(1,'B','B','2026-01-01','2026-12-31');
 INSERT INTO proyecto_rol_nivel_requerido(proyecto_id,rol_nivel_ref,cantidad) VALUES (1,10,5),(2,10,5);
" 2>&1 | grep -v "Using a password"

# sesión que aplica la regla K-31 en la aplicación: lee la suma bloqueando, espera y luego inserta si cabe
session() { # $1 isolation  $2 colaborador  $3 proyecto  $4 modo (rows|lockrow)
  lock="SELECT COALESCE(SUM(porcentaje_dedicacion),0) INTO @s FROM asignacion WHERE colaborador_ref=$2 AND vigente_hasta IS NULL FOR UPDATE;"
  if [ "$4" = "lockrow" ]; then lock="INSERT IGNORE INTO colaborador_carga VALUES ($2); SELECT colaborador_ref FROM colaborador_carga WHERE colaborador_ref=$2 FOR UPDATE; $lock"; fi
  docker exec -i p3m-conc mysql -uroot -ptest-only-pw p3m_portafolio -N --init-command="SET SESSION TRANSACTION ISOLATION LEVEL $1" -e "
   START TRANSACTION; $lock DO SLEEP(2);
   INSERT INTO asignacion(colaborador_ref,proyecto_id,rol_nivel_ref,porcentaje_dedicacion,vigente_desde,estado,realizada_por_ref)
     SELECT $2,$3,10,60,'2026-01-01','VIGENTE','44444444-4444-4444-4444-444444444444' FROM DUAL WHERE @s+60<=100;
   SELECT 'filas_insertadas', ROW_COUNT(); COMMIT;" 2>&1 | grep -v "Using a password" | tr '\n' ' '
}
run_case() { # $1 etiqueta $2 isolation $3 colaborador $4 modo
  $R p3m_portafolio -e "DELETE FROM asignacion WHERE colaborador_ref=$3" 2>/dev/null
  outA=$(mktemp); outB=$(mktemp)
  ( session "$2" $3 1 $4 > $outA ) & ( session "$2" $3 2 $4 > $outB ) & wait
  total=$($R p3m_portafolio -N -e "SELECT COALESCE(SUM(porcentaje_dedicacion),0) FROM asignacion WHERE colaborador_ref=$3" 2>/dev/null)
  verdict=$([ "${total%.*}" -le 100 ] && echo "OK (<=100)" || echo "VIOLA (>100)")
  echo "$1 | A: $(cat $outA) | B: $(cat $outB) | suma final = $total -> $verdict"
}
echo "== K-31 sin filas previas del colaborador (caso del primer registro)"
run_case "REPEATABLE READ, lectura bloqueante     " "REPEATABLE READ" 11 rows
run_case "READ COMMITTED, lectura bloqueante      " "READ COMMITTED" 12 rows
echo "== K-31 con una asignación previa de 30 %"
$R p3m_portafolio -e "INSERT INTO asignacion(colaborador_ref,proyecto_id,rol_nivel_ref,porcentaje_dedicacion,vigente_desde,estado,realizada_por_ref) VALUES (13,1,10,30,'2026-01-01','VIGENTE','44444444-4444-4444-4444-444444444444'),(14,1,10,30,'2026-01-01','VIGENTE','44444444-4444-4444-4444-444444444444')" 2>/dev/null
for pair in "REPEATABLE READ:13" "READ COMMITTED:14"; do
  iso=${pair%%:*}; col=${pair##*:}
  outA=$(mktemp); outB=$(mktemp)
  ( session "$iso" $col 1 rows > $outA ) & ( session "$iso" $col 2 rows > $outB ) & wait
  total=$($R p3m_portafolio -N -e "SELECT SUM(porcentaje_dedicacion) FROM asignacion WHERE colaborador_ref=$col" 2>/dev/null)
  verdict=$([ "${total%.*}" -le 100 ] && echo "OK (<=100)" || echo "VIOLA (>100)")
  echo "$iso con 30 % previo | A: $(cat $outA) | B: $(cat $outB) | suma final = $total -> $verdict"
done
echo "== Alternativa: fila de bloqueo por colaborador (tabla colaborador_carga)"
run_case "REPEATABLE READ, fila de bloqueo        " "REPEATABLE READ" 21 lockrow
run_case "READ COMMITTED, fila de bloqueo         " "READ COMMITTED" 22 lockrow
docker rm -f p3m-conc >/dev/null 2>&1
