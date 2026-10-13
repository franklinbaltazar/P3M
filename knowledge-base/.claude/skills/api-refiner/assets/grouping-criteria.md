# Criterios para agrupar contextos en APIs (microservicios)

Un **contexto acotado** define el límite del modelo, no el del despliegue. Cada contexto es un **módulo** con sus agregados, su esquema y sus puertos. Una **API** es un servicio desplegable que aloja uno o más módulos. Decidir cuántos servicios hay es una recomendación con trade-offs, no una consecuencia automática de los contextos.

## Regla base
Empezar con **menos servicios** y separar cuando exista una razón medible. Separar después es barato si se respetan los límites; fusionar después, no.

## Separar en un servicio propio cuando
| ID | Criterio | Evidencia a citar |
|---|---|---|
| S-1 | **Perfil de fallo distinto:** depende de un sistema externo inestable y su caída no debe arrastrar al resto | ACL, circuit breaker, reintentos |
| S-2 | **Perfil de ejecución distinto:** workers, tareas programadas, carga por lotes | Planificador (Spring, cron), colas |
| S-3 | **Seguridad o credenciales distintas:** secretos propios, datos más sensibles, otra superficie | Vault, clasificación de datos |
| S-4 | **Carga o escalado distintos:** lectura intensiva frente a escritura, picos distintos | NFR, ASR, métricas |
| S-5 | **Ritmo de cambio o equipo distinto** | Equipo, backlog |
| S-6 | **Upstream estable consumido por casi todos** (catálogos, currícula) | Matriz de dependencias |

## Agrupar en un servicio cuando
| ID | Criterio | Evidencia a citar |
|---|---|---|
| G-1 | **Acoplamiento bidireccional síncrono** entre dos contextos (A consulta a B y B a A) | Matriz de dependencias |
| G-2 | **Invariante o transacción que cruza** los contextos y hoy exige coordinación | INV-xx, contratos con trabajo pendiente |
| G-3 | **Un contrato interno existe solo para vincular** dos contextos del mismo dominio de identidad | CON-xx con un único consumidor |
| G-4 | **Mismo propietario funcional y mismo ciclo de vida de datos** | Propiedad en el DDD |
| G-5 | **Equipo pequeño o carga baja:** el costo operativo de un servicio adicional supera su beneficio | Capacidad del equipo, NFR de carga |

## Reglas al agrupar
1. Cada contexto agrupado mantiene su **esquema, sus puertos de repositorio y sus agregados**. No hay claves foráneas ni lecturas de tablas entre contextos, aunque estén en el mismo servicio.
2. Los CON entre contextos agrupados pasan a **puertos internos en proceso** y conservan su contrato lógico. Solo los que cruzan servicios son HTTP (`/internal/v1/…`).
3. Los eventos entre servicios siguen por el mensajero con *outbox*. Entre módulos del mismo servicio pueden ser llamadas en proceso, pero no se elimina el evento si otro consumidor lo necesita.
4. Una dependencia síncrona circular entre servicios es una **alerta**: justificar que son lecturas sobre datos que cada proveedor posee, o fusionar.
5. Un servicio con más de unas 6 dependencias salientes síncronas es candidato a revisión (acoplamiento o fusión mal elegida).
6. Documentar siempre **la alternativa descartada** (más servicios o menos) y su costo.

## Alternativas a evaluar siempre
| Opción | Cuándo conviene | Costo |
|---|---|---|
| Un servicio por contexto | Equipos independientes, escalado distinto por contexto | Más contratos, más operación, dependencias circulares visibles |
| Agrupación por criterios (recomendada por defecto) | Equipo pequeño, carga moderada, límites claros | Exige disciplina para mantener los módulos separados |
| Monolito modular + workers aparte | Equipo muy pequeño, arranque rápido | Contradice una decisión de «microservicios» si existe |

## Qué no decide este skill
Capacidad del equipo, ADR, infraestructura y valores operativos (tiempos de espera, umbrales). Si faltan, la propuesta lo declara como supuesto y la agrupación como **recomendación pendiente de decisión**.
