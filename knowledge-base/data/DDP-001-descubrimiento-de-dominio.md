---
type: Domain Discovery Pack
title: "DDP-001 — Descubrimiento de dominio del P3M"
description: "Candidatos a bounded context, conceptos, actores, ciclo de vida, evidencia de propiedad, terminología, supuestos, conflictos y preguntas abiertas para el diseño de base de datos del Portal P3M."
tags: [database, domain-discovery, ddd]
status: draft
gate: DOMAIN_DISCOVERY_READY
gate-result: PASSED
human-reviewed: true
reviewed-by: "ianache (responsable funcional), 2026-10-11, en sesión: D-H5..D-H9"
generated:
  by: "domain-discovery-modeler"
  at: "2026-10-11T00:00:00-05:00"
plan-step: S1 (WP-DB-001)
sources:
  - id: imd-001
    resource: /business/information-model/IMD-001-portal-curricula.md
    trust: "approved en cabecera; CONDITIONAL en §9 (ver conflicto C-01)"
  - id: brc-001
    resource: /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md
    trust: draft
  - id: gls-001
    resource: /business/glossary/GLS-001-glosario-de-negocio.md
    trust: draft
  - id: adr-db-001
    resource: /architecture/adr/ADR-DB-001.md
  - id: adr-db-002
    resource: /architecture/adr/ADR-DB-002.md
  - id: adr-db-003
    resource: /architecture/adr/ADR-DB-003.md
  - id: adr-08
    resource: /architecture/adr/ADR-08-carga-programada-de-gitlab-de-solo-lectura-co.md
    trust: "Aceptada (sin revisión de arquitecto)"
  - id: adr-10
    resource: /architecture/adr/ADR-10-modelo-de-personas-y-organizaciones-alineado.md
    trust: draft
  - id: adr-11
    resource: /architecture/adr/ADR-11-identidad-y-roles-de-usuario-gestionados-en-k.md
    trust: draft
  - id: adr-p2
    resource: /architecture/adr/ADR-P2-descomposicion-en-microservicios-y-su-comunic.md
    trust: draft
  - id: adr-p4
    resource: /architecture/adr/ADR-P4-tratamiento-de-datos-personales.md
    trust: "PENDIENTE: la decisión no existe"
  - id: asr-09-10-11
    resource: /architecture/asr/
    trust: "candidatos; disposición humana PENDIENTE"
  - id: udm
    resource: /business/glossary/terms/TRM-0049-universal-data-model-udm.md
    trust: advisory
---

# DDP-001 — Descubrimiento de dominio del P3M

> **Alcance:** conceptos, límites y propiedad. No define columnas, tablas ni esquemas (eso es S3 y S5). Distingue **E**videncia (la fuente lo dice), **I**nferencia (deducida de fuentes citadas), **S**upuesto (sin respaldo) y **D**ecisión (de una persona).

## 1. Registro SSOT (ADR-DB-001)

| Concepto o grupo | Autoridad | Tipo | Evidencia |
|---|---|---|---|
| Reglas, estados, validaciones y permisos de negocio | BRC-001 (Jefe de Ingeniería como responsable funcional) | E | IMD-001 §6 |
| Conceptos y relaciones de negocio | IMD-001 (CIM) | E | cabecera `approved` |
| Términos y sinónimos | GLS-001 | E | |
| Credenciales, roles de usuario, GUID | **Keycloak** (externo) | E | ADR-11, BR-044 |
| Issue, User Story, Tarea de planning, Milestone | **GitLab** (externo, solo lectura) | E | ADR-08, BR-036 |
| Copia local de issues/milestones y bitácora de cargas | Portal | E | ADR-08 §5 |
| Estructura de Party (Persona, Organización, Relación…) | IMD-001; UDM solo consejo | E / UDM=I | ADR-10 §1 |
| Política de datos personales | **No existe** (ADR-P4 pendiente) | — | ver U-01 |

## 2. Candidatos a bounded context

Son hipótesis. Ningún ADR los fija (ADR-P2: «falta enumerarlos»). La confirmación es una **decisión humana** pendiente (§9).

| ID | Candidato | Conceptos que contendría | Autoridad / actor que mantiene | Propiedad | Notas |
|---|---|---|---|---|---|
| CTX-01 | **Partes y organización** | Parte, Persona, Organización, Rol de la parte, Relación entre partes, Dato de contacto, Plaza, Ocupación de plaza | Jefe de Ingeniería / ADMIN | I | Plaza usa Rol/nivel de CTX-03 por identificador. Si Plaza pertenece aquí o a CTX-03 se discute en U-04. |
| CTX-02 | **Identidad de acceso** | Usuario (referencia local al GUID de Keycloak) | Keycloak (autoridad); el portal solo registra | E | Candidato a **adaptador**, no a dominio. Puede fusionarse con CTX-01 (U-05). |
| CTX-03 | **Currícula** | Seniority, Nivel de desarrollo, Rol, Rol/nivel, Perfil de competencias, Competencia, Nivel de logro | Solo Jefe de Ingeniería (BR-055) | E | Núcleo estable y de baja frecuencia de cambio. |
| CTX-04 | **Formación** | Curso, Objetivo de curso, Edición, Rúbrica, Evidencia esperada, Enrolamiento, Certificación de curso | Jefe de Ingeniería (define), Evaluador (valida y certifica) | E | Evaluador es rol de usuario (EVD-2026-0109). |
| CTX-05 | **Progresión** | Evidencia aportada / de proyecto, Valoración de cumplimiento, Evaluación de desempeño, Solicitud de promoción, Promoción de nivel | Jefe de Ingeniería; Jefe de proyecto valida evidencias de proyecto | E | Evidencia aportada cruza CTX-04 y CTX-05 (C-02). Brecha es **derivada**, no se registra. |
| CTX-06 | **Portafolio y asignación** | Producto, Proyecto, Roles/niveles requeridos, Asignación, Excepción de asignación, Motivo de excepción, Jefe de proyecto (rol) | Jefe de Ingeniería (asigna y aprueba); Jefe de proyecto designado (registra requeridos, R-39) | E | Asignación: vigencia, % dedicación, historial. |
| CTX-07 | **Integración GitLab** | Carga automática (ejecuciones, estado, reintentos), copia local de Milestone/Issue/User Story/Tarea | GitLab (datos); portal (bitácora) | E | Logs retenidos siempre (BR-094). Proyecto en CTX-06 solo **referencia** milestones por identificador. |

**Relaciones entre contextos observadas (candidatas a contrato, ADR-DB-002):**
CTX-05→CTX-04 (certificación, objetivo), CTX-05→CTX-03 (competencia, nivel de logro, rol/nivel), CTX-05→CTX-01 (colaborador), CTX-05→CTX-07 (issue), CTX-06→CTX-01 (colaborador), CTX-06→CTX-03 (rol/nivel), CTX-06→CTX-07 (milestone), CTX-04→CTX-03 (competencia), CTX-04→CTX-01 (evaluador, colaborador), CTX-01→CTX-03 (rol/nivel de la plaza), CTX-01→CTX-02 (usuario).

## 3. Actores

| Actor | Tipo | Qué hace (fuente) |
|---|---|---|
| Colaborador | Persona en Rol de la parte | Se enrola, aporta evidencias, pide promoción (BR-025, BR-059, BR-068) |
| Evaluador / Instructor | Rol de usuario | Valida evidencias de curso y certifica (BR-008, BR-009, BR-022) |
| Jefe de proyecto | Colaborador con rol en un proyecto | Valida evidencias de proyecto (BR-010) |
| Jefe de Ingeniería | Rol de usuario | Define currícula, asigna, aprueba excepciones, valora, promueve (BR-004..007, BR-055) |
| ADMIN | Rol de usuario / permiso | Equivale al Jefe de Ingeniería en valoración y cargas |
| Keycloak, GitLab | Sistemas externos | Ver §1 |

## 4. Ciclo de vida

| Concepto | Ciclo | Evidencia |
|---|---|---|
| Rol de la parte, Ocupación de plaza, Relación entre partes, Asignación, Jefe de proyecto | Vigencia desde/hasta con historial; **una sola vigente** donde aplique (rol/nivel, «reporta a», membresía) | BR-047, BR-063, BR-071, BR-076, BR-079; ASR-09 |
| Valoración de cumplimiento, Evaluación de desempeño | Registros inmutables con historial | BR-051, BR-089 |
| Evidencia aportada | Pendiente → Validada (solo issues Closed) | BR-019, BR-020 |
| Asignación | Pendiente hasta excepción cuando no alcanza el nivel mínimo → asignada | BR-042 |
| Enrolamiento | Inscripción (hasta el cupo) → certificado o no; el colaborador puede desenrolarse | BR-026, BR-027 |
| Solicitud de promoción → Promoción de nivel | Solicitud con evidencias → evaluación → decisión; exige evaluación de desempeño | BR-064, BR-068, BR-086, BR-088 |
| Carga de GitLab | Programada (30 s por defecto), primera completa, luego delta; 3 reintentos con circuit breaker; log permanente | ADR-08, BR-090, BR-094 |
| Motivo de excepción | Codificador con mantenimiento propio | BR-043, BR-053 |

Los estados exactos de Asignación, Solicitud de promoción y Carga **no están enumerados** en las fuentes (U-07).

## 5. Terminología (sinónimos y equivalencias)

| Término | Equivale a | Fuente |
|---|---|---|
| Promoción en el curso | Certificación de curso (un solo concepto) | EVD-2026-0074 |
| Sprint | Milestone de GitLab | BR-035, BR-049 |
| Rol/nivel | Tipo de puesto (UDM: Position Type) | D-130 |
| Plaza / Ocupación de plaza | UDM: Position / Position Fulfillment | D-130, D-131 |
| Evaluador | Instructor de la edición | BR-008, BR-024 |
| Evidencia de proyecto | Evidencia aportada que referencia un issue Closed de GitLab | BR-020 |
| Promoción de nivel vs. Promoción en el curso | **Distintos**: no confundir | BR-029, BR-022 |

## 6. Supuestos

| ID | Supuesto | Riesgo |
|---|---|---|
| A-01 | Los 7 contextos son una partición razonable de los 4 bloques del IMD. | Fronteras erróneas se pagan en S3–S4. |
| A-02 | Un colaborador tiene una sola persona y una persona un solo usuario (R-83 es INFERENCE en la parte «un usuario, una persona»). | Cambia la unicidad del usuario. |
| A-04 | Una persona puede tener varios roles de la parte vigentes a la vez (colaborador, jefe de proyecto, evaluador). Inferido de D-H2 y D-H7. | Cambia la unicidad en Rol de la parte. |
| A-03 | Hay un único portal y un único conjunto de datos del P3M (no multi-tenant). | No consta; asumido por el alcance. |

## 7. Conflictos preservados

| ID | Conflicto | Precedencia aplicada |
|---|---|---|
| C-01 | IMD-001 declara `status: approved` en la cabecera pero §9 lo califica como **CONDITIONAL** (9 preguntas abiertas). | El modelo se usa como base, pero la condición manda: las 11 preguntas abiertas (§9) siguen abiertas. |
| C-02 | **Evidencia aportada** vive entre Formación y Progresión: sirve a un objetivo de curso (R-58) y a una solicitud de promoción (R-60), y es subtipo «de proyecto» (R-23). | **Resuelto** (D-H3, D-H9): referencia URL a GitLab ligada a una evidencia esperada, en CTX-05. |
| C-03 | IMD-001 §9 dice que IM-Q13 es de las más relevantes, pero §7 lo marca **Cerrada**. Contradicción interna. | Prevalece §7 (Cerrada, EVD-2026-0097). |
| C-04 | ASR-09, ASR-10 y ASR-11 son candidatos; sus decisiones (ADR-P6, ADR-10) se tratan como aceptadas por el responsable, pero ningún arquitecto las revisó. | Se aplican como restricciones declaradas, no validadas. |
| C-05 | R-39 y EVD-2026-0121 dicen que los roles/niveles requeridos los **registra el jefe de proyecto designado**; D-H8 dice que los define el **Jefe de Ingeniería o ADMIN**. | Prevalece D-H8 (decisión humana más reciente). Falta confirmar si el jefe de proyecto conserva algún permiso de registro. |

## 8. Fuera de alcance (non-goals)

- Autenticación, contraseñas y roles de usuario (Keycloak).
- Creación o edición de issues, user stories y milestones (GitLab es de solo lectura).
- Mapa rol-permiso (ADR-P5, pendiente).
- Columnas, tipos, índices y migraciones (etapas S3 y S5).
- Convertir el UDM en modelo canónico.

## 9. Decisiones humanas registradas

Responsable funcional: ianache. Fecha: 2026-10-11, en sesión. Son decisiones, no inferencias. **IMD-001, BRC-001 y los ADR aún no las reflejan**: hay que actualizarlos (ADR-DB-001) antes de S3.

| ID | Decisión | Cierra / afecta |
|---|---|---|
| D-H1 | Los datos personales se retienen igual que los logs (sin borrado). | U-01 (retención). Riesgo: el borrado a solicitud del titular queda sin mecanismo; lo decide ADR-P4. |
| D-H2 | Un proyecto puede tener varios jefes de proyecto a lo largo del tiempo, pero **uno solo vigente a la vez**. Un colaborador puede ser jefe de varios proyectos. | U-02, IM-Q11, R-55. Invariante «una sola vigente» (ADR-P6). |
| D-H3 | Por cada evidencia esperada definida, el colaborador registra su evidencia aportada específica. La evidencia aportada es una **referencia URL a GitLab**. La certificación es un **resultado emitido** por el Evaluador, no una evidencia aportada. | IM-Q2 → R-46 pasa a FACT. IM-Q10 → R-24 queda sin efecto. |
| D-H4 | Una plaza la ocupa **como máximo un colaborador**. Si se requieren 2 Developers Senior se abren 2 plazas. | IM-Q29 (parcial), R-86. Una plaza tiene como máximo una ocupación vigente. |
| D-H5 | Usuarios Keycloak sin los roles Jefe de Ingeniería, ADMIN o Instructor, y sin ser colaborador, se envían al login. | IM-Q19 (R-69/R-83). |

**D-H5 confirmado por ianache (2026-10-11):** un usuario que ingresa **sin colaborador registrado y sin ninguno de esos tres roles** es devuelto al login; los colaboradores registrados sí entran.

| ID | Decisión adicional (2026-10-11) |
|---|---|
| D-H7 | El **Evaluador** (instructor) y el **Jefe de proyecto** son **roles de la parte con vigencia**, igual que el de colaborador. | U-06, IM-Q27, R-78, R-79. Un colaborador que es jefe de varios proyectos (D-H2) implica roles simultáneos; no se respondió expresamente si una persona puede tener varios roles de la parte a la vez. Se asume que sí (A-04). |
| D-H8 | Los roles/niveles que requiere un proyecto los define **cualquier usuario con rol de usuario Jefe de Ingeniería o ADMIN**. | U-08 (IM-Q8), R-39. Contradice EVD-2026-0121 (ver C-05). |
| D-H9 | **Evidencia aportada** pertenece a CTX-05 Progresión. **Plaza** y **Ocupación de plaza** pertenecen a CTX-01 Partes y organización. | Cierra C-02 y U-04 (ubicación). |
| D-H6 | ianache **confirma los 7 contextos candidatos** (CTX-01..07) como partición de trabajo. Quedan abiertas solo dos asignaciones de concepto: Evidencia aportada (C-02) y Plaza (U-04). CTX-01 pasa de propiedad inferida a **decidida**. |

## 10. Preguntas abiertas

| ID | Pregunta | Dueño | Bloquea |
|---|---|---|---|
| U-01 | **PARCIAL.** Retención decidida (D-H1): los datos personales se retienen igual que los logs. Siguen pendientes clasificación, cifrado y acceso (ADR-P4). | Responsable funcional y Seguridad | S5 (controles) |
| U-02 | **CERRADA** (D-H2). | — | — |
| U-03 | **CERRADA** (D-H3, D-H9). | — | — |
| U-04 | **PARCIAL.** Ubicación cerrada (D-H9) y una persona por plaza (D-H4). Siguen abiertos los datos de la plaza (IM-Q28) y las plazas de proveedores (IM-Q29). | Jefe de Ingeniería | S3 |
| U-05 | **PARCIAL.** IM-Q19 y D-H5 cerradas y confirmadas. Con D-H6 CTX-02 queda como contexto propio; se tratará como adaptador de Keycloak en DDD (no tiene dominio propio, ADR-11). | Responsable funcional | CTX-01/02 |
| U-06 | **CERRADA** (D-H7). Queda por confirmar solo si una persona puede tener varios roles de la parte a la vez. | Jefe de Ingeniería | CTX-01 / CTX-04 / CTX-06 |
| U-07 | Estados enumerados de Asignación, Solicitud de promoción y Carga de GitLab. | Jefe de Ingeniería | S3 |
| U-08 | **PARCIAL.** IM-Q8 cerrada (D-H8). Siguen abiertas IM-Q6 (escala de nivel de desarrollo), IM-Q9 (un perfil por rol) e IM-Q26 (contacto de organizaciones). | Jefe de Ingeniería | S3 (cardinalidades) |

## 11. Trazabilidad

Cada concepto de §2 proviene de IMD-001 §4 (42 conceptos) y cada regla de BRC-001 vía IMD-001 §6. Las relaciones R-xx se heredan al modelo lógico (S3). Fuentes de ADR en cabecera.

## 12. Estado del gate

`DOMAIN_DISCOVERY_READY` = **PASSED**, por decisión de ianache (2026-10-11).

| Requisito del gate | Estado |
|---|---|
| Alcance | Cumplido (§8) |
| Registro SSOT | Cumplido (§1) |
| Candidatos a contexto | Cumplido (§2), confirmados (D-H6) |
| Evidencia de propiedad | Cumplido: todos los contextos y conceptos tienen propiedad evidenciada o decidida (D-H6, D-H9) |
| Ciclo de vida | Cumplido con reserva: estados enumerados pendientes (U-07), se resuelven antes de S3 |
| Incógnitas explícitas | Cumplido (§10) |

**Deuda que no bloquea S2 pero sí S3:**
- Actualizar IMD-001 y BRC-001 con D-H1..D-H9 (ADR-DB-001).
- U-01 (ADR-P4: clasificación, cifrado, acceso), U-07, IM-Q6, IM-Q9, IM-Q26, IM-Q28, IM-Q29.
- Confirmar C-05 (permiso del jefe de proyecto) y A-04 (varios roles de la parte a la vez).
