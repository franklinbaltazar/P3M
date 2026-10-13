---
type: READY_FOR_DEV Assessment
title: "READY_FOR_DEV Assessment — Base de datos del P3M"
description: "Evaluación de preparación para desarrollo del handoff de base de datos: recomendación y resultado por compuerta."
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

# READY_FOR_DEV Assessment

## Recommendation
**READY_WITH_OBSERVATIONS**

El skill recomienda; **no aprueba**. La aprobación es del Solution Architect.

## Gate Results
| Gate | Result | Evidence / finding |
|---|---|---|
| Scope | PASS con observaciones | 33 historias con persistencia y 7 esquemas (26 originales y 7 nuevas del 2026-10-12). US-027 y US-028 quedan fuera (OI-17). Falta una historia para las organizaciones (OI-11) y los servicios no están enumerados (OI-12) |
| Architecture context | PASS | 7 contextos, 51 tablas, contratos y componentes identificados (DDM-001, LDM-001, ICP-001, PDM-001) |
| ASRs | OBSERVACIÓN | Todos con disposición humana pendiente (OI-02) |
| ADRs / open decisions | OBSERVACIÓN | ADR aprobados por ianache sin revisión de arquitecto distinto (OI-01); ADR-P4 aprobada con el aplazamiento DT-01 (OI-03); ADR-P5 aprobada, con el token del usuario reenviado por el BFF (OI-04 y OI-18 resueltos); alojamiento y replicación de MySQL (OI-05) |
| Architecture Rules | OBSERVACIÓN | 16 reglas derivadas de decisiones; todas `PROPOSED` hasta que el Solution Architect las apruebe. Ninguna regla inventa una decisión nueva |
| Contracts | PASS con observaciones | ICP-001 aprobado. Faltan los parámetros operativos (OI-13) |
| Security | OBSERVACIÓN | Controles de acceso, SSL y secretos definidos y probados. Datos personales diferidos como DT-01, aceptado por Seguridad según ianache; ADR-P4 aprobada con el aplazamiento DT-01 (OI-03). La identidad del usuario llega al servicio con el token reenviado (ADR-P5) |
| NFRs | OBSERVACIÓN | Disponibilidad, RTO y RPO definidos; la recuperación no está verificada (OI-06); carga parcial (OI-07) |
| Fitness Criteria | PASS en la base; NOT_VERIFIABLE en servicios | 11 criterios tienen evidencia ejecutada en la base (5 completos y 6 parciales); 4 están sin verificar porque dependen de servicios o pruebas que aún no existen; 1 no aplica por ahora |
| Evidence & provenance | PASS | 10 evidencias con fuente, fecha y vigencia. Fuentes de negocio y seis historias verificadas el 2026-10-12; las historias nuevas siguen en `draft` (OI-10) |
| Unknowns / assumptions | OBSERVACIÓN | 22 elementos abiertos; ninguno bloquea el esquema ni las migraciones; OI-21 (nombres de rol) debe cerrarse antes de implementar la capa de servicios |
| Conflicts | OBSERVACIÓN | Los dos conflictos de peso se resolvieron el 2026-10-12 (ADR-P5 frente a ADR-P9, OI-18; contactos de organizaciones, OI-19). Queda uno menor (INF-DEC-02 frente a ADR-P7, OI-16) |

## Blocking Findings
Ninguno para el alcance transferido (esquema, migraciones, permisos y contratos).

**No bloquea el esquema pero sí bloquea la capa de servicios** (no incluida en este pack): OI-21 (nombres de rol sin contrastar con Keycloak), OI-13 (parámetros de los contratos) y, para la parte de organizaciones de US-029, OI-19.

## Observations
- **OI-01** (OPEN_DECISION): **Resuelto en parte.** ianache aprobó el 2026-10-12 ADR-P2, P3, P6, P7, P9 y ADR-DB-001/002/003, en su rol de responsable funcional.
- **OI-02** (MISSING_EVIDENCE): Los 20 ASR tienen disposición humana PENDIENTE.
- **OI-03** (OPEN_DECISION): ADR-P4 (datos personales) fue **aprobada el 2026-10-12** y su decisión es aplazar la política (DT-01): sin clasificación, cifrado de columna, acceso ni borrado a solicitud del titular; los datos personales se retienen por siempre (BR-101).
- **OI-04** (FACT): **RESUELTO el 2026-10-12:** ianache respondió P5-D1 a P5-D7 y aprobó ADR-P5 (con su anexo).
- **OI-05** (OPEN_DECISION): Alojamiento y modo de alta disponibilidad de MySQL: ¿servicio gestionado o contenedor?, ¿replicación semisíncrona o de grupo? (INF-DEC-11).
- **OI-06** (MISSING_EVIDENCE): La recuperación de MySQL no está verificada: sin conmutación ni restauración de prueba contra 99,9 % / RTO 4 h / RPO 1 h.
- **OI-07** (UNKNOWN): Carga parcial: más de 50 colaboradores.
- **OI-08** (OPEN_DECISION): Issues de tipo «Proyecto» (BR-039) y campos que BR-038 manda mostrar (esfuerzo estimado, esfuerzo gastado, fecha de vencimiento): la réplica no los guarda (DT-03).
- **OI-09** (ASSUMPTION): Ningún ambiente aplicó los `V1` anteriores de `p3m_partes`, `p3m_identidad` y `p3m_portafolio`.
- **OI-10** (STALE_EVIDENCE): **Resuelto en parte.** IMD-001, BRC-001, RCP-001 y las seis historias actualizadas fueron **verificadas por ianache el 2026-10-12** (D-H41).
- **OI-11** (UNKNOWN): **Resuelto en parte.** Se redactaron el 2026-10-12 las historias US-029 (contactos), US-030 (plazas), US-031 (ocupaciones), US-032 (roles de la parte), US-033 (corrección de vínculo) y US-034 (relaciones).
- **OI-12** (ASSUMPTION): Se asume un servicio por contexto (7).
- **OI-13** (OPEN_DECISION): Parámetros operativos de los contratos internos (tiempos de espera, circuit breaker, reintentos).
- **OI-14** (UNKNOWN): Preguntas abiertas de las historias que afectan a la implementación: US-010-Q2 (el desenrolamiento y el registro), US-025-Q1 y US-025-Q2 (datos que no entrega Keycloak; correo ya vinculado), RQ-32 (permiso del jefe de proyecto), RQ-33 (roles de la parte simultáneos), RQ-22 (actualizar el usuario en cada inicio).
- **OI-15** (UNKNOWN): INF-Q17: cómo se federa Keycloak con Active Directory y qué pasa si no responde.
- **OI-16** (CONFLICT): INF-P3M-001 mantiene INF-DEC-02 como «PENDIENTE» (plataforma de contenedores) mientras ADR-P7 decide Docker local y Kubernetes en Oracle OKE.
- **OI-17** (OPEN_DECISION): Fuera de este alcance: US-027 y US-028 (ingreso y cierre de sesión) no usan la base de datos; los resuelven el BFF y Keycloak.
- **OI-18** (FACT): **RESUELTO el 2026-10-12 (P5-D1 = A):** el BFF reenvía el token del usuario además del JWT de máquina y cada servicio lo valida contra Keycloak; ADR-P9 no cambia.
- **OI-19** (FACT): RESUELTO el 2026-10-12 (D-160, BR-131: toda parte tiene contactos; F-19).
- **OI-20** (FACT): **RESUELTO el 2026-10-12 (D-166, BR-135):** los mantienen el Jefe de Ingeniería y el ADMIN.
- **OI-21** (ASSUMPTION): Los nombres de rol de Keycloak (ADMIN, COLABORADOR, INSTRUCTOR, JEFE_INGENIERIA) son un supuesto del responsable (D-164); no se contrastaron con la configuración real de Keycloak.
- **OI-22** (STALE_EVIDENCE): BR-134 (D-165): el ADMIN suple las seis capacidades exclusivas del Jefe de Ingeniería.

## Human Decision Gate
- Decision: PENDING
- Decision maker: Solution Architect
- Conditions: resolver o aceptar explícitamente OI-01, OI-03 y OI-06 antes de producción; confirmar OI-09 antes de aplicar migraciones en un entorno compartido.
