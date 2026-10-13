---
type: Work Plan
title: "WP-DB-001 — Plan de trabajo del diseño de base de datos del P3M"
description: "Plan por etapas, con dependencias y gates, para diseñar la base de datos del Portal P3M (dominio, DDD, lógico, integración, físico MySQL 8.x y revisión)."
tags: [database, work-plan, ddd, mysql]
status: draft
generated:
  by: "database-design-orchestrator"
  at: "2026-10-11T00:00:00-05:00"
human-reviewed: false
sources:
  - id: imd-001
    resource: /business/information-model/IMD-001-portal-curricula.md
    trust: approved (verificado por ianache, 2026-10-10)
  - id: brc-001
    resource: /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md
    trust: draft
  - id: gls-001
    resource: /business/glossary/GLS-001-glosario-de-negocio.md
    trust: draft
  - id: rcp-001
    resource: /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md
    trust: draft
  - id: adr-db-001
    resource: /architecture/adr/ADR-DB-001.md
    trust: registrado (SSOT y ownership)
  - id: adr-db-002
    resource: /architecture/adr/ADR-DB-002.md
    trust: registrado (propiedad y límites de dominio)
  - id: adr-db-003
    resource: /architecture/adr/ADR-DB-003.md
    trust: registrado (MySQL 8.x y Flyway)
  - id: adr-05
    resource: /architecture/adr/ADR-05-mysql-8-x-como-base-de-datos.md
    trust: draft
  - id: adr-10
    resource: /architecture/adr/ADR-10-modelo-de-personas-y-organizaciones-alineado.md
    trust: draft (alineación UDM = propuesta)
  - id: adr-p2
    resource: /architecture/adr/ADR-P2-descomposicion-en-microservicios-y-su-comunic.md
    trust: draft (límites de microservicios sin enumerar)
  - id: adr-p4
    resource: /architecture/adr/ADR-P4-tratamiento-de-datos-personales.md
    trust: draft
  - id: adr-p6
    resource: /architecture/adr/ADR-P6-historial-con-vigencia-y-restricciones-en-mys.md
    trust: draft (sin revisión de arquitecto de datos)
  - id: trm-0049
    resource: /business/glossary/terms/TRM-0049-universal-data-model-udm.md
    trust: advisory
---

# WP-DB-001 — Plan de trabajo del diseño de base de datos

## 1. Alcance y precedencia

- **Alcance:** base(s) de datos del Portal P3M: roles y competencias, cursos y evidencias, progresión, portafolio y asignación, personas/organizaciones (Party), carga de GitLab.
- **Objetivo físico:** MySQL 8.x (ADR-05) con migraciones Flyway.
- **Precedencia (SSOT):** BRC-001 / IMD-001 (negocio) → ADR vigentes → UDM. El UDM es **solo consejo**: informa a DDD, no lo sobrescribe (ADR-10 §1: la correspondencia es una propuesta).
- **Ownership:** un dato, un contexto propietario. Sin tablas compartidas entre contextos por comodidad; GitLab es dueño de ISSUE, USER_STORY, TAREA_DE_PLANNING y SPRINT (solo lectura en el portal).

## 2. Hallazgos que afectan el plan

| ID | Hallazgo | Efecto |
|---|---|---|
| F-01 | ADR-DB-001/002/003 incorporados a la base de conocimiento y registrados como fuentes. | **Resuelto.** Rigen la precedencia: SSOT (001), límites de contexto y contratos explícitos (002), MySQL 8.x con charset/collation explícitos y Flyway con expand/contract para cambios destructivos (003). |
| F-02 | Todos los ADR consultados están en `draft`, sin revisión de arquitecto. | Las decisiones se tratan como restricciones declaradas por el responsable, no validadas. |
| F-03 | ADR-P2: «falta enumerar» los bounded contexts. | Lo cubre S2–S3; la salida debe someterse al responsable antes de fijar límites de microservicio. |
| F-04 | Faltan los archivos `contracts.md` y `templates/work-plan.yaml` en la skill. | Este plan sigue la estructura mínima del contrato de salida. |
| F-05 | Preguntas abiertas del IMD-001: IM-Q2, Q6, Q8, Q9, Q10, Q11, Q19, Q26–Q29 (Q25 está cerrada). | Bloquean o condicionan decisiones de cardinalidad en S3–S5 (ver §4). |

## 3. Pasos

```yaml
plan_id: WP-DB-001
steps:
  - id: S0
    name: Registrar fuentes, ADR y restricciones
    skill: database-design-orchestrator
    depends_on: []
    produces: Este plan + registro de fuentes
    gate: PLAN_READY
    evidence: [imd-001, brc-001, adr-db-001, adr-db-002, adr-db-003, adr-05, adr-10, adr-p2, adr-p6]
    status: PASSED            # aprobado por ianache (responsable funcional) en sesión, 2026-10-11
    next_action: Ninguna. Reservas vigentes: F-02 (ADR en draft).

  - id: S1
    name: Descubrimiento de dominio
    skill: domain-discovery-modeler
    depends_on: [S0]
    produces: Conceptos candidatos, propiedad, ciclo de vida, incógnitas
    gate: DOMAIN_DISCOVERY_READY
    evidence: [imd-001 §4-§5, brc-001, rcp-001]
    status: PASSED            # aprobado por ianache, 2026-10-11 (DDP-001 §12)
    produces_ref: /data/DDP-001-descubrimiento-de-dominio.md
    next_action: Ninguna. Las decisiones están registradas en RCP-001, BRC-001 e IMD-001.

  - id: S2
    name: Modelo DDD
    skill: ddd-domain-modeler
    depends_on: [S1]
    produces: Bounded contexts, agregados, entidades, value objects, invariantes, eventos, puertos
    gate: DDD_MODEL_READY
    evidence: [S1, adr-p2, adr-10 (UDM advisory)]
    status: PASSED            # aprobado por ianache, 2026-10-11 (DDM-001 §9)
    produces_ref: /data/DDM-001-modelo-ddd.md
    next_action: Ninguna. Las decisiones están registradas en RCP-001, BRC-001 e IMD-001.

  - id: S3
    name: Modelo lógico por contexto
    skill: logical-data-modeler
    depends_on: [S2]
    produces: Modelo relacional neutral (claves, restricciones, cardinalidades, linaje)
    gate: LOGICAL_MODEL_READY
    evidence: [S2, imd-001 §5, adr-p6]
    status: PASSED            # aprobado por ianache, 2026-10-11 (LDM-001 §9)
    produces_ref: /data/LDM-001-modelo-logico.md
    next_action: Ninguna. Decisiones registradas (RCP-001 D-143..D-159, BRC-001 BR-114..BR-130). Deuda: DT-01.

  - id: S4
    name: Contratos de integración entre contextos
    skill: cross-domain-integration-designer
    depends_on: [S3]
    produces: Identificadores, ACL, reglas de consistencia (RabbitMQ, ADR-P2)
    gate: INTEGRATION_CONTRACT_READY
    evidence: [S3, adr-p2, adr-p4]
    status: PASSED            # aprobado por ianache, 2026-10-11 (ICP-001 §11)
    produces_ref: /data/ICP-001-contratos-de-integracion.md
    next_action: Ninguna. Decisiones registradas. Deuda: parámetros operativos y US-025-Q1.

  - id: S5
    name: Modelo físico MySQL 8.x y migraciones Flyway
    skill: physical-database-designer
    depends_on: [S3, S4]
    produces: Esquemas, índices, controles de seguridad, migraciones Flyway versionadas
    gate: PHYSICAL_MODEL_READY
    evidence: [S3, S4, adr-05, adr-db-003, adr-p6]
    status: PASSED            # aprobado por ianache, 2026-10-11 (PDM-001 §11)
    produces_ref: /data/PDM-001-modelo-fisico-mysql.md
    next_action: Ninguna. Deuda: DT-01, DT-02, DT-03.

  - id: S6
    name: Revisión del diseño
    skill: database-design-reviewer
    depends_on: [S5]
    produces: Informe de revisión con hallazgos por severidad
    gate: DATABASE_DESIGN_APPROVED
    evidence: [S1..S5]
    status: PASSED            # aprobado por ianache, 2026-10-12 (D-H36 a D-H39); R-10 aceptado como riesgo residual (DT-04)
    produces_ref: /data/RPT-DDR-001-revision-del-diseno.md
    next_action: Ninguna. Riesgos residuales: DT-01, DT-02, DT-03, DT-04. Sin aprobaciones pendientes en este plan: las fuentes de negocio y las historias se verificaron (D-H41) y Seguridad aceptó DT-01 (D-H40).
```

## 4. Insumos y riesgos por etapa

**Contextos candidatos (hipótesis para S1–S2, no decisión):**

1. **Party / Personas y organizaciones** — Parte, Persona, Organización, Rol de la parte, Relación entre partes, Dato de contacto, Plaza, Ocupación de plaza (alineación UDM, ADR-10).
2. **Identidad y acceso** — Usuario (GUID de Keycloak; ADR-11), roles de usuario.
3. **Currícula** — Rol, Perfil, Competencia, Nivel de logro, Seniority, Nivel de desarrollo, Rol/nivel.
4. **Formación** — Curso, Objetivo, Edición, Rúbrica, Evidencia esperada, Enrolamiento, Certificación.
5. **Progresión** — Evidencia aportada/de proyecto, Valoración, Evaluación de desempeño, Solicitud y Promoción de nivel.
6. **Portafolio y asignación** — Producto, Proyecto, Asignación, Excepción, Motivo de excepción.
7. **Integración GitLab** — Carga de GitLab y copia de solo lectura de milestones/issues.

**Invariantes que deben llegar a la base de datos o al servicio** (ADR-P6, BRC-001):
- Un solo rol/nivel vigente por persona (BR-047), una sola relación «reporta a» y una sola membresía vigentes (BR-071, BR-076): índice único sobre columna calculada.
- Suma de dedicación ≤ 100 % por colaborador (BR-078/080): validación en el microservicio con `SELECT ... FOR UPDATE`.
- Historial con vigencia desde/hasta en asignación, valoración, evaluación de desempeño, jefe de proyecto y ocupación de plaza.
- Logs de la carga de GitLab retenidos siempre (BR-094).

**Riesgos abiertos:** datos personales (ADR-P4: cifrado/minimización en `DATO_DE_CONTACTO`), Evidencia aportada con dos usos (curso/proyecto; IM-Q2/Q10), jefe de proyecto simultáneo (IM-Q11).

## 4.1 Deuda técnica

| ID | Deuda | Decidido por | Detalle |
|---|---|---|---|
| DT-04 | Recuperación de MySQL sin verificar: conmutación en minutos (INF-DEC-23), restauración dentro de RTO 4 h y RPO 1 h, concurrencia de K-18 y modo de replicación (INF-DEC-11) | ianache, 2026-10-12 (D-H39) | Antes de producción: conmutación y restauración de prueba (INF-P3M-001, sección 14) y decidir la replicación semisíncrona o de grupo |
| DT-03 | Réplica de GitLab sin esfuerzo estimado, esfuerzo gastado ni fecha de vencimiento (BR-038) y sin issues «Proyecto» (BR-039) | ianache, 2026-10-11 (D-H32) | La carga debe ignorar y registrar lo que no replica, sin fallar. Se retoma con `V2` de `p3m_gitlab` (RPT-DDR-001 R-03) |
| DT-02 | Evidencia de carga de trabajo parcial: más de 50 colaboradores, RPO 1 h, RTO 4 h y 99,9 % definidos (INF-Q02); faltan usuarios concurrentes, volumen de issues, crecimiento, IOPS y modo de alta disponibilidad | aceptada por ianache (D-H29) | Índices solo por restricciones y consultas de contrato; sin particionado. Verificar el diseño de recuperación contra los objetivos y revisar los índices con datos reales (PDM-001 §8) |
| DT-01 | Política de datos personales (ADR-P4): clasificación, cifrado, acceso y borrado | ianache, 2026-10-11 (D-H24), confirmada el 2026-10-12 (D-H35); aceptada por Seguridad según ianache (D-H40, 2026-10-12) | Se ignora por ahora. S5 no implementa controles específicos. Riesgo y forma de retomarlo en LDM-001 §10 |

## 5. Reglas del plan

- No se omite ningún paso. Un paso solo corre cuando los gates predecesores pasaron.
- El UDM nunca anula IMD-001, BRC-001 ni un ADR.
- Sin `human-reviewed: true` hasta que exista un evento humano con nombre (quién y cuándo).
- Un cambio al DAG requiere un registro de cambio.

## 6. Control de cambios

| Fecha | Cambio | Autor |
|---|---|---|
| 2026-10-11 | Versión inicial | database-design-orchestrator |
| 2026-10-11 | S0 aprobado por ianache; S1 ejecutado (DDP-001) y queda en REQUIRES_REVIEW; se corrige F-05 (IM-Q25 está cerrada) | database-design-orchestrator |
| 2026-10-12 | D-H38 (INF-P3M-001, opción A: dos clases de falla) y D-H39 (R-10 aceptado como riesgo residual): el gate DATABASE_DESIGN_APPROVED pasa a PASSED; se añade DT-04. INF-P3M-001 0.1.2 | database-design-orchestrator |
| 2026-10-12 | D-H40 a D-H43: Seguridad acepta DT-01 (declarado por ianache), verificación aprobada de las fuentes de negocio y seis historias, ADR-P2, P3, P6, P7, P9 y ADR-DB-001 a 003 aprobados (no ADR-P5), R-10 confirmado como DT-04 | database-design-orchestrator |
| 2026-10-12 | D-H44: ianache decide que toda parte (persona u organización) tiene datos de contacto; reemplaza D-150/BR-121. `dato_de_contacto` pasa a `parte_id` y `tipo_parte` (F-19, pendiente de confirmación); RCP-001, BRC-001 e IMD-001 vuelven a `draft` hasta nueva verificación | database-design-orchestrator |
| 2026-10-12 | D-H45: F-19 confirmada; contactos de organización (correo, teléfono, dirección; correo y teléfono obligatorios) y correo único entre todas las partes (D-161, D-162); ADR-P4 aprobada con el aplazamiento DT-01 como decisión; historia US-035 (registrar organizaciones) | database-design-orchestrator |
| 2026-10-12 | D-H46: ADR-P5 aprobada (P5-D1 a P5-D7 respondidos); BR-134 y BR-135; nombres de rol de Keycloak; F-20 en `p3m_identidad` | database-design-orchestrator |
| 2026-10-12 | D-H47: F-20 confirmada; nombres de rol definidos; nueve historias actualizadas por BR-134; RCP-001, BRC-001 e IMD-001 verificados | database-design-orchestrator |
| 2026-10-12 | D-H37: ianache aprueba una por una las decisiones de diseño físico F-14 a F-18 (la premisa de F-18 sobre ambientes sin confirmar expresamente) | database-design-orchestrator |
| 2026-10-12 | D-H36: ianache aprueba el diseño con condiciones; F-14..F-18 confirmadas; el gate DATABASE_DESIGN_APPROVED sigue en REQUIRES_REVIEW por R-10. Corregidos 18 localizadores de BRC-001 desfasados en seis historias (otros 3 ya se habían corregido en US-019 y US-021) | database-design-orchestrator |
| 2026-10-12 | Corrección: RPO 1 h, RTO 4 h, 99,9 % y más de 50 colaboradores sí estaban definidos (INF-Q02, INF-Q03); se corrigen PDM-001 §8, RPT-DDR-001 R-10 y DT-02. INF-P3M-001 0.1.1: requisito de identidad (sin auto-registro, correo de solo lectura, Active Directory) | database-design-orchestrator |
| 2026-10-12 | D-H35 (R-05: ianache confirma el aplazamiento de datos personales como DT-01; sin aceptación de Seguridad) | database-design-orchestrator |
| 2026-10-12 | R-06 corregido: D-143..D-159 en RCP-001, BR-114..BR-130 en BRC-001, IMD-001 actualizado (91 relaciones, 0 errores); equivalencias en LDM-001 §10 | database-design-orchestrator |
| 2026-10-11 | D-H34 (correcciones R-02, R-04, R-07, R-01): LDM-001 K-44..K-47 y 2 tablas nuevas; ICP-001 CON-13; PDM-001 51 tablas; revalidado desde contenedor nuevo, sin fallas | database-design-orchestrator |
| 2026-10-11 | D-H33 (sin auto-registro en el portal ni en Keycloak): requisito de despliegue declarado para R-01 | database-design-orchestrator |
| 2026-10-11 | D-H32 (R-03 aceptado como deuda técnica DT-03: tratamiento de issues «Proyecto» sin decidir) | database-design-orchestrator |
| 2026-10-11 | D-H31 (identidades vía Active Directory, gestionado por infraestructura): R-01 baja a Baja; se retira la exigencia de email_verified | database-design-orchestrator |
| 2026-10-11 | D-H30 (Keycloak sin registro libre ni edición del correo): R-01 baja a Media; S6 pasa de BLOCKED a REQUIRES_REVIEW | database-design-orchestrator |
| 2026-10-11 | S6 ejecutado (RPT-DDR-001): BLOCKED por R-01; 6 hallazgos altos o medios que impiden aprobar | database-design-orchestrator |
| 2026-10-11 | D-H29 (DEC-F05 aceptada); S5 pasa a PASSED (PHYSICAL_MODEL_READY); DT-02 aceptada con condiciones | database-design-orchestrator |
| 2026-10-11 | D-H26..D-H28 (PEN y horas-persona, diseño físico aceptado, permisos). DDL ejecutados con Flyway real en MySQL 8.4.11: 49 tablas, 107 pruebas superadas; 3 defectos corregidos. S5 sigue en REQUIRES_REVIEW solo por DEC-F05 | database-design-orchestrator |
| 2026-10-11 | D-H25 (nota >= 12 informativa); S5 ejecutado (PDM-001, 49 tablas, 7 esquemas); queda en REQUIRES_REVIEW | database-design-orchestrator |
| 2026-10-11 | D-H23 (nota 0..20, mínimo 12) y D-H24 (ADR-P4 diferido: DT-01); S5 desbloqueado | database-design-orchestrator |
| 2026-10-11 | D-H18..D-H22 registradas; S4 pasa a PASSED (INTEGRATION_CONTRACT_READY); LDM-001 recibe K-42 y K-43 | database-design-orchestrator |
| 2026-10-11 | S4 ejecutado (ICP-001); queda en REQUIRES_REVIEW | database-design-orchestrator |
| 2026-10-11 | D-H16, D-H17 registradas; S3 pasa a PASSED (LOGICAL_MODEL_READY) | database-design-orchestrator |
| 2026-10-11 | D-H14 (evidencia de proyecto solo por URL) y D-H15 (supuestos S-01..S-08 aceptados) | database-design-orchestrator |
| 2026-10-11 | S3 ejecutado (LDM-001); queda en REQUIRES_REVIEW | database-design-orchestrator |
| 2026-10-11 | D-H10..D-H13 registradas; S2 pasa a PASSED (DDD_MODEL_READY) | database-design-orchestrator |
| 2026-10-11 | S2 ejecutado (DDM-001); queda en REQUIRES_REVIEW | database-design-orchestrator |
| 2026-10-11 | D-H9 aceptada; S1 pasa a PASSED (DOMAIN_DISCOVERY_READY) | database-design-orchestrator |
| 2026-10-11 | D-H7 y D-H8 (U-06 cerrada, IM-Q8 cerrada) | database-design-orchestrator |
| 2026-10-11 | D-H5 confirmado y D-H6 (7 contextos confirmados) | database-design-orchestrator |
| 2026-10-11 | Se registran D-H1..D-H5 en DDP-001 (respuestas de ianache); S1 sigue en REQUIRES_REVIEW | database-design-orchestrator |
| 2026-10-11 | Se registran ADR-DB-001/002/003 y se cierra F-01 | database-design-orchestrator |
