---
type: Handoff Report
title: "Architecture → Development Handoff Report — Base de datos del P3M"
description: "Informe de traspaso de arquitectura a desarrollo de la base de datos del P3M: alcance, restricciones, decisiones cerradas y abiertas, frontera de Superpowers y trazabilidad."
tags: [handoff, database, development-context-pack]
status: draft
generated:
  by: "architecture-development-handoff"
  at: "2026-10-12T04:00:00-05:00"
sources:
  - id: wp-db-001
    resource: /data/WP-DB-001-plan-de-trabajo-diseno-bd.md
  - id: ddp-001
    resource: /data/DDP-001-descubrimiento-de-dominio.md
  - id: ddm-001
    resource: /data/DDM-001-modelo-ddd.md
  - id: ldm-001
    resource: /data/LDM-001-modelo-logico.md
  - id: icp-001
    resource: /data/ICP-001-contratos-de-integracion.md
  - id: pdm-001
    resource: /data/PDM-001-modelo-fisico-mysql.md
  - id: rpt-ddr-001
    resource: /data/RPT-DDR-001-revision-del-diseno.md
  - id: inf-p3m-001
    resource: /deployment/INF-P3M-001-arquitectura-de-infraestructura.md
  - id: asr-catalog
    resource: /architecture/asr/asr-catalog.md
  - id: cat-adr-001
    resource: /architecture/CAT-ADR-001-decisiones-de-arquitectura.md
  - id: adr-db-001
    resource: /architecture/adr/ADR-DB-001.md
  - id: adr-db-002
    resource: /architecture/adr/ADR-DB-002.md
  - id: adr-db-003
    resource: /architecture/adr/ADR-DB-003.md
  - id: brc-001
    resource: /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md
  - id: imd-001
    resource: /business/information-model/IMD-001-portal-curricula.md
---

# Architecture → Development Handoff Report

## Executive Summary
El diseño de la base de datos del P3M (7 contextos, 51 tablas, 8 migraciones Flyway) está aprobado por el responsable funcional y su revisión cerró en `PASSED` con riesgos residuales aceptados. Este traspaso entrega la **capa de persistencia y los contratos entre contextos**. **Recomendación: READY_WITH_OBSERVATIONS.** El esquema se puede implementar; la capa de servicios depende de decisiones abiertas (OI-13 y OI-21).

Límite de lo afirmado: los ADR los aprobó ianache como responsable funcional, sin que conste la revisión de un arquitecto distinto, y la revisión del diseño la hizo el mismo agente que lo produjo. Este traspaso no sustituye la revisión de un arquitecto.

## Scope Transferred
- 33 historias (26 originales y 7 nuevas del 2026-10-12), solo en lo que persisten (sección 1 del pack).
- DDL y semillas, aprovisionamiento de cuentas y permisos, y scripts de verificación: `data/flyway/`.
- Contratos entre contextos (CON-01 a CON-13, EVT-01, ACL-01, ACL-02): ICP-001.
- Modelo lógico con 47 restricciones candidatas: LDM-001.

## Architecture Constraints Developers Must Respect
Las 16 reglas ARCH-RULE-001 a 016 del pack. Las más delicadas:
- **No hay claves foráneas ni lectura entre esquemas** (001, 008).
- **Un `V1` aplicado no se edita** (003).
- **Protocolo de `colaborador_carga` antes de sumar la dedicación** (005): sin él la regla del 100 % se rompe bajo `READ COMMITTED` (probado: 120 %).
- **Solo inserción** en las tablas de historial y de evaluación (006).
- **Nada de datos personales en contratos ni eventos** (013).
- **El vínculo usuario–persona es fijo** y solo lo corrige la cuenta de corrección (011).

## Decisions That Are Closed
Ver la sección 4 del pack y PDM-001 §10 (D-H26 a D-H39). Entre ellas: un esquema por contexto; claves sustitutas `BIGINT`; enumeraciones como `VARCHAR` más `CHECK`; fila de bloqueo por colaborador; baja de contactos con responsable; dos clases de falla en la recuperación (INF-DEC-23); nota de 0 a 20; costo en soles y esfuerzo en horas-persona.

## Decisions / Questions Still Open
| ID | Type | Description (resumen) | Blocking |
|---|---|---|---|
| OI-01 | OPEN_DECISION | **Resuelto en parte.** ianache aprobó el 2026-10-12 ADR-P2, P3, P6, P7, P9 y ADR-DB-001/002/003, en su rol de responsable funcional. | No |
| OI-02 | MISSING_EVIDENCE | Los 20 ASR tienen disposición humana PENDIENTE. | No |
| OI-03 | OPEN_DECISION | ADR-P4 (datos personales) fue **aprobada el 2026-10-12** y su decisión es aplazar la política (DT-01): sin clasificación, cifrado de columna, acceso ni borrado a solicitud del titular; los datos personales se retienen por siempre (BR-101). | No para el esquema. Sí antes de producción decidir ADR-P4 |
| OI-04 | FACT | **RESUELTO el 2026-10-12:** ianache respondió P5-D1 a P5-D7 y aprobó ADR-P5 (con su anexo). | No para el esquema. Sí para la capa de servicios |
| OI-05 | OPEN_DECISION | Alojamiento y modo de alta disponibilidad de MySQL: ¿servicio gestionado o contenedor?, ¿replicación semisíncrona o de grupo? (INF-DEC-11). | No para las migraciones. Sí antes de producción |
| OI-06 | MISSING_EVIDENCE | La recuperación de MySQL no está verificada: sin conmutación ni restauración de prueba contra 99,9 % / RTO 4 h / RPO 1 h. | No |
| OI-07 | UNKNOWN | Carga parcial: más de 50 colaboradores. | No |
| OI-08 | OPEN_DECISION | Issues de tipo «Proyecto» (BR-039) y campos que BR-038 manda mostrar (esfuerzo estimado, esfuerzo gastado, fecha de vencimiento): la réplica no los guarda (DT-03). | No |
| OI-09 | ASSUMPTION | Ningún ambiente aplicó los `V1` anteriores de `p3m_partes`, `p3m_identidad` y `p3m_portafolio`. | No |
| OI-10 | STALE_EVIDENCE | **Resuelto en parte.** IMD-001, BRC-001, RCP-001 y las seis historias actualizadas fueron **verificadas por ianache el 2026-10-12** (D-H41). | No |
| OI-11 | UNKNOWN | **Resuelto en parte.** Se redactaron el 2026-10-12 las historias US-029 (contactos), US-030 (plazas), US-031 (ocupaciones), US-032 (roles de la parte), US-033 (corrección de vínculo) y US-034 (relaciones). | No |
| OI-12 | ASSUMPTION | Se asume un servicio por contexto (7). | No |
| OI-13 | OPEN_DECISION | Parámetros operativos de los contratos internos (tiempos de espera, circuit breaker, reintentos). | No para el esquema. Sí para los servicios |
| OI-14 | UNKNOWN | Preguntas abiertas de las historias que afectan a la implementación: US-010-Q2 (el desenrolamiento y el registro), US-025-Q1 y US-025-Q2 (datos que no entrega Keycloak; correo ya vinculado), RQ-32 (permiso del jefe de proyecto), RQ-33 (roles de la parte simultáneos), RQ-22 (actualizar el usuario en cada inicio). | No |
| OI-15 | UNKNOWN | INF-Q17: cómo se federa Keycloak con Active Directory y qué pasa si no responde. | No |
| OI-16 | CONFLICT | INF-P3M-001 mantiene INF-DEC-02 como «PENDIENTE» (plataforma de contenedores) mientras ADR-P7 decide Docker local y Kubernetes en Oracle OKE. | No |
| OI-17 | OPEN_DECISION | Fuera de este alcance: US-027 y US-028 (ingreso y cierre de sesión) no usan la base de datos; los resuelven el BFF y Keycloak. | No |
| OI-18 | FACT | **RESUELTO el 2026-10-12 (P5-D1 = A):** el BFF reenvía el token del usuario además del JWT de máquina y cada servicio lo valida contra Keycloak; ADR-P9 no cambia. | No para el esquema. **Sí para implementar los servicios** |
| OI-19 | FACT | RESUELTO el 2026-10-12 (D-160, BR-131: toda parte tiene contactos; F-19). | Parcial: bloquea la parte de organizaciones de US-029 y un posible cambio del esquema |
| OI-20 | FACT | **RESUELTO el 2026-10-12 (D-166, BR-135):** los mantienen el Jefe de Ingeniería y el ADMIN. | No para el esquema |
| OI-21 | ASSUMPTION | Los nombres de rol de Keycloak (ADMIN, COLABORADOR, INSTRUCTOR, JEFE_INGENIERIA) son un supuesto del responsable (D-164); no se contrastaron con la configuración real de Keycloak. | No para el esquema. Sí para implementar los servicios |
| OI-22 | STALE_EVIDENCE | BR-134 (D-165): el ADMIN suple las seis capacidades exclusivas del Jefe de Ingeniería. | No para el esquema |

## Superpowers Execution Boundary
**Puede decidir:** la organización interna del código, la descomposición en tareas, los nombres de los módulos, las pruebas y su orden, y refactorizar sin cambiar la intención de la arquitectura.

**No puede, sin escalar a Arquitectura:**
- cambiar un esquema ya aplicado (solo versiones nuevas);
- añadir una clave foránea entre contextos o leer tablas de otro contexto;
- quitar el protocolo de bloqueo, el SSL, los permisos por tabla o por columna;
- decidir por sí mismo ADR-P4 (datos personales), ADR-P5 (mapa rol-permiso), el modo de replicación de MySQL o el tratamiento de los issues «Proyecto»;
- cambiar la retención por siempre ni introducir borrado de datos.

Si la implementación contradice la arquitectura aprobada: emitir `ARCHITECTURE_CONFLICT` con historia, ASR, ADR y regla afectados, la evidencia, el impacto y las alternativas como propuestas, y detener ese camino.

Cadena esperada: `Development Context Pack -> brainstorming (acotado) -> writing-plans -> TDD / implementación -> revisión de código -> Merge Request -> evidencia -> ARQ-104`.

## Traceability Summary
`US -> ASR -> ADR -> Rule -> Fitness Criterion`: 33 historias, 14 ASR citados, 16 ADR relevantes (ADR-P5 sin mapa rol-permiso aprobado), 16 reglas y 16 criterios de aptitud (5 con evidencia completa ejecutada, 6 con evidencia ejecutada solo en la base, 4 sin verificar y 1 que no aplica). Detalle: `traceability-map.md`.

## Readiness Recommendation
**READY_WITH_OBSERVATIONS.** Se puede empezar por el esquema y las migraciones. Antes de implementar los servicios: OI-21. Antes de producción: OI-03, OI-05, OI-06 y OI-09.

## Human Decision
PENDING hasta que lo registre el Solution Architect: `READY_FOR_DEV`, `RETURN_TO_ARCHITECTURE`, `REQUEST_EVIDENCE` o `REQUEST_DECISION`, con quién decide, la fecha, las condiciones y las observaciones sin resolver.
