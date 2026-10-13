# Lista de verificación de api-refiner

Marcar cada punto con evidencia (archivo e ID). Un punto sin evidencia no cuenta.

## Entrada
- [ ] El análisis tiene `type: API Requirements Analysis`; se anotó su versión y fecha.
- [ ] Los hallazgos abiertos del análisis están reflejados como bloqueo o supuesto.
- [ ] Hay decisiones humanas de agrupación registradas, o la agrupación se marca como recomendación.

## Cobertura
- [ ] Cada recurso F1 del análisis está en una sola API.
- [ ] Cada CON, EVT y ACL está asignado a una sola API proveedora, con sus consumidores.
- [ ] Cada historia aparece en la trazabilidad de una API (o se explica por qué no genera API de dominio).
- [ ] Ningún elemento nuevo carece de fuente; los inferidos están marcados (I).

## Agrupación
- [ ] Cada fusión o separación cita un criterio de `grouping-criteria.md` (S-n o G-n).
- [ ] Se registró la alternativa descartada y su costo.
- [ ] No hay dependencia síncrona circular sin justificar; se revisó el número de dependencias salientes por API.
- [ ] Los contextos agrupados mantienen esquema y puertos separados.

## Cada API
- [ ] Propietario de datos (esquemas) y contextos alojados.
- [ ] Recursos y operaciones con historia, actor y tipo de permiso (R o R+D).
- [ ] Contratos internos servidos y consumidos; eventos; ACL.
- [ ] Invariantes que protege y cómo (A, P, E).
- [ ] Seguridad: autenticación entre servicios, autorización, datos expuestos.
- [ ] Fallos, idempotencia, concurrencia, observabilidad.
- [ ] Pruebas de contrato y de consumidor.
- [ ] Preguntas abiertas con dueño e impacto.

## Refinamiento
- [ ] Cada cambio clasificado (`additive`, `compatible`, `breaking`, `unknown`) y versión actualizada.
- [ ] IDs preservados; los retirados marcados `RETIRED`.
- [ ] Se verificó la cobertura de las APIs consumidoras.
- [ ] Registrado en «Historial de refinamiento».

## Salida
- [ ] Frontmatter OKF: `status: draft`, `gate_status`, `generated.by`, `generated.at` con `-05:00`, `sources` resolubles, `human-reviewed: false`.
- [ ] Sin `verified` inventado.
- [ ] `index.md` y `changelog.md` actualizados.
- [ ] `gate_status` es exactamente `READY_FOR_CONTRACT`, `REQUIRES_REVIEW` o `BLOCKED`.
