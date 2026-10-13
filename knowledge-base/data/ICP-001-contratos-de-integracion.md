---
type: Integration Contract Pack
title: "ICP-001 — Contratos de integración entre contextos del P3M"
description: "Contratos entre contextos (consultas síncronas, un evento asíncrono y capas anticorrupción con Keycloak y GitLab): propiedad, esquema, mapeo de identificadores, consistencia, idempotencia, fallos y trazabilidad."
tags: [database, integration, contracts, ddd]
status: draft
gate: INTEGRATION_CONTRACT_READY
gate-result: PASSED
human-reviewed: true
reviewed-by: "ianache (responsable funcional), 2026-10-11, en sesión: D-H18..D-H22"
generated:
  by: "cross-domain-integration-designer"
  at: "2026-10-11T21:00:00-05:00"
plan-step: S4 (WP-DB-001)
predecessors: [DDM-001 (DDD_MODEL_READY = PASSED), LDM-001 (LOGICAL_MODEL_READY = PASSED)]
sources:
  - id: ldm-001
    resource: /data/LDM-001-modelo-logico.md
  - id: ddm-001
    resource: /data/DDM-001-modelo-ddd.md
  - id: adr-db-002
    resource: /architecture/adr/ADR-DB-002.md
  - id: adr-p2
    resource: /architecture/adr/ADR-P2-descomposicion-en-microservicios-y-su-comunic.md
  - id: adr-p9
    resource: /architecture/adr/ADR-P9-nombre-del-protocolo-de-consumo-seguro-bffmic.md
  - id: adr-08-09-p3
    resource: /architecture/adr/ADR-08-carga-programada-de-gitlab-de-solo-lectura-co.md
  - id: us-025
    resource: /requirements/user-stories/US-025-registrar-al-usuario-al-iniciar-sesion.md
---

# ICP-001 — Contratos de integración entre contextos del P3M

> **Alcance:** cómo se relacionan los contextos sin tablas compartidas (ADR-DB-002). Cada contrato nombra **proveedor** (dueño del dato) y **consumidor**. Los valores operativos (tiempos de espera, umbrales, tamaños de cola) **no se fijan aquí**: son de despliegue (S5 e infraestructura). Solo se citan los parámetros que un ADR ya propone.

## 1. Principios

| ID | Principio | Origen |
|---|---|---|
| P-1 | Ningún contexto lee las tablas de otro ni comparte esquema. Se consume por contrato | ADR-DB-002 |
| P-2 | Un agregado externo **no se duplica como verdad local**. Solo se guarda su identificador (`*_ref`) | ADR-DB-002, LDM-001 §1 |
| P-3 | **Nada se borra** (historiales, logs y datos personales, D-H1). Por eso una referencia validada una vez **sigue existiendo siempre**; solo cambian los estados con vigencia | LDM-001 §1, BR-090 |
| P-4 | Las comprobaciones de **estado** (rol vigente, evidencia validada) se hacen al ejecutar el comando, preguntando al proveedor. Lo que se decide queda registrado con su fecha y no se reevalúa | DDM-001 §3 |
| P-5 | Las consultas que cruzan contextos devuelven lo mínimo (un booleano, identificadores o niveles), nunca datos personales | D-H1, ADR-P4 pendiente |
| P-6 | Las llamadas síncronas internas usan un JWT de máquina de Keycloak (OAuth2 Client Credentials) **y reenvían el token del usuario**, que el servicio valida para obtener el actor y los roles | ADR-P9, ADR-13, ADR-P5 |
| P-7 | El único cambio de estado entre contextos que se difiere en el tiempo viaja por RabbitMQ con *outbox* | ADR-P2 |
| P-8 | El vocabulario del UDM no aparece en los contratos: se usan los términos del glosario | Regla del skill |

## 2. Catálogo de contratos

### 2.1 Consultas síncronas (REST interno, solo lectura)

**Contrato CON-13 (R-01, R-07).** Respuesta mínima: un identificador y un booleano, nunca datos personales. Si no hay coincidencia o la persona ya está vinculada a otro usuario (K-10), el inicio de sesión se rechaza con **el mismo mensaje** que cualquier otro rechazo, sin revelar si el correo existe. Límite de uso por llamante (valor operativo de infraestructura). Una vez fijado, el vínculo **no se rehace** aunque cambie el correo (K-45).

Todas son internas (no pasan por el API Gateway, que es para consumidores externos, ADR-14). Versión en la ruta `/internal/v1/…`. Las consultas son idempotentes.

| ID | Consulta | Proveedor | Consumidor | Entrada | Respuesta | Para qué (K) |
|---|---|---|---|---|---|---|
| CON-01 | `PersonaConRolVigente` | CTX-01 | CTX-04, CTX-06 | `persona_ref`, `tipo_rol` {COLABORADOR, EVALUADOR}, `fecha` | `{existe: bool, rol_vigente: bool}` | K-09, `evaluador_ref`, `colaborador_ref` |
| CON-02 | `RolNivelVigenteDePersona` | CTX-01 | CTX-05 | `persona_ref`, `fecha` | `{rol_nivel_ref \| null}` (el de la plaza que ocupa) | Validar el «siguiente» rol/nivel en la promoción (BR-031) |
| CON-03 | `RolNivelExiste` | CTX-03 | CTX-01, CTX-05, CTX-06 | `rol_nivel_ref` | `{existe: bool}` | `plaza_rol_nivel`, destino de solicitud/promoción, requeridos y asignación |
| CON-04 | `NivelesMinimosDeRolNivel` | CTX-03 | CTX-06 | `rol_nivel_ref` | Lista de `{competencia_ref, nivel_minimo}` | Verificar el nivel mínimo al asignar (BR-041) |
| CON-05 | `CompetenciaExiste` | CTX-03 | CTX-04, CTX-05 | `competencia_ref` | `{existe: bool}` | `objetivo_de_curso`, `valoracion_de_competencia` |
| CON-06 | `EvidenciasObligatoriasValidadas` | CTX-05 | CTX-04 | `enrolamiento_ref` | Lista de `evidencia_esperada_ref` en estado VALIDADA | Emitir la certificación solo con el 100 % de las obligatorias (K-20, INV-14) |
| CON-07 | `NivelActualDeCompetencias` | CTX-05 | CTX-06 | `colaborador_ref` | Lista de `{competencia_ref, nivel_de_logro}` (la valoración más reciente de cada una) | Verificar el nivel mínimo al asignar (BR-041) |
| CON-08 | `CertificacionExiste` | CTX-04 | CTX-05 | `certificacion_ref` | `{existe: bool}` | `evaluacion_certificacion`, `promocion_certificacion` |
| CON-09 | `EsJefeVigenteDeProyectoDelMilestone` | CTX-06 | CTX-05 | `persona_ref`, `milestone_ref`, `fecha` | `{es_jefe_vigente: bool}` | Validar evidencias de proyecto (BR-010, K-24) |
| CON-10 | `IssueCerrado` | CTX-07 | CTX-05 | `issue_url` | `{valido: bool, tipo, milestone_ref \| null, datos_a: fecha-hora}` | K-23, INV-15, BR-020 |
| CON-11 | `MilestoneExiste` | CTX-07 | CTX-06 | `milestone_ref` | `{existe: bool}` | `proyecto_milestone` (K-30) |
| CON-12 | `EvidenciaEsperadaDeEnrolamiento` | CTX-04 | CTX-05 | `enrolamiento_ref`, `evidencia_esperada_ref` | `{existe_y_pertenece: bool, obligatoriedad}` | La evidencia esperada pertenece al curso del enrolamiento (K-22) |
| CON-13 | `PersonaPorCorreo` | CTX-01 | CTX-02 | `correo` (normalizado) | `{persona_ref \| null, rol_colaborador_vigente: bool}` | Vincular al usuario con la persona la **primera vez** que inicia sesión (D-H19, INV-08). Solo se llama si el usuario aún no tiene `persona_ref`. Busca el correo entre todos los contactos vigentes (único entre partes, BR-133) y solo acepta una coincidencia con una **persona**: si el correo es de una organización, responde que no hay coincidencia |

**Primer inicio de sesión (INV-08, D-H5, D-H19, D-H34):** (1) CTX-02 recibe el token (`sub`, `email`, roles). (2) Si ya existe un `usuario` con ese `keycloak_guid`, usa su `persona_ref` y no consulta nada. (3) Si no existe, llama a CON-13 con el correo. (4) Si hay persona y está libre, inserta el `usuario` con `persona_ref`; ese valor ya no cambia. (5) Si no hay persona, solo ingresan los usuarios con rol Jefe de Ingeniería, ADMIN o Instructor; los demás vuelven al login. (6) Un vínculo equivocado, o un correo cambiado o reutilizado, lo corrige el Jefe de Ingeniería con la cuenta de corrección, que registra quién y cuándo en `correccion_de_vinculo`; si hay que liberar una dirección, da de baja el contacto anterior (K-44).

**Por qué consulta síncrona y no proyección para CON-06 (decisión de diseño).** La certificación necesita saber si están validadas todas las obligatorias. Una evidencia solo pasa de PENDIENTE a VALIDADA y no vuelve (BR-019, D-H11). La respuesta de CON-06 es por tanto **monótona**: si una evidencia figura validada, lo seguirá estando. No hace falta una copia local en CTX-04, que sería una segunda verdad. CTX-04 compara la lista devuelta con su propio conjunto de evidencias esperadas obligatorias (K-17).

### 2.2 Evento asíncrono

| ID | Evento | Proveedor | Consumidor | Disparador | Carga útil | Efecto |
|---|---|---|---|---|---|---|
| EVT-01 | `PromocionDeNivelDecidida` v1 | CTX-05 | CTX-01 | Se inserta `promocion_de_nivel` | `evento_id`, `promocion_ref`, `persona_ref`, `rol_nivel_destino_ref`, `decidida_en`, `schema_version` | Cierra el rol/nivel vigente de la plaza que ocupa la persona y abre el nuevo en `plaza_rol_nivel` (D-H12, INV-27) |

La carga útil lleva solo identificadores y la fecha: ningún dato personal.

**Consistencia de EVT-01:** *outbox* transaccional en CTX-05 (la promoción y su mensaje se confirman juntos), publicación a una cola duradera de RabbitMQ y consumo **al menos una vez**. El consumidor es **idempotente** por `promocion_ref` (ver DEC-I01).

| Situación | Comportamiento |
|---|---|
| Entrega duplicada | CTX-01 detecta `promocion_ref` ya aplicado y no hace nada |
| CTX-01 no disponible | El mensaje queda en cola; reintentos con esperas incrementales (patrón de ADR-09) y luego cola de mensajes fallidos (DLQ) con alerta |
| La persona no tiene ocupación vigente | Se envía a la DLQ con alerta: es un error de datos, no se reintenta |
| El rol/nivel destino ya es el vigente de la plaza | No-op |
| Orden y eventos obsoletos (R-04) | **No se confía en el orden de entrega.** El consumidor aplica el evento solo si `decidida_en` es posterior al `vigente_desde` del rol/nivel vigente de la plaza (K-46); si no, lo **descarta como obsoleto y lo registra**. El nuevo rol/nivel se abre con `vigente_desde` = `decidida_en`. Con eventos con el mismo `decidida_en` se desempata por `promocion_ref` |
| Reproceso | El *outbox* no se borra (P-3): se puede republicar y el consumidor lo absorbe |
| Visibilidad del desfase | Una promoción cuya `promocion_ref` no aparece en `plaza_rol_nivel` aún no se aplicó. Una tarea de conciliación la reporta |

### 2.3 Capas anticorrupción (ACL)

| ID | ACL | Proveedor externo | Contexto dueño | Dirección |
|---|---|---|---|---|
| ACL-01 | Keycloak → CTX-02 | Keycloak | CTX-02 | Entrada: usuario, correo y roles en cada inicio de sesión (BR-074) |
| ACL-02 | GitLab → CTX-07 | GitLab | CTX-07 | Entrada: carga con delta, solo lectura (ADR-08) |

**ACL-01 Mapeo de vocabulario**

| Keycloak | P3M (`usuario`) | Nota |
|---|---|---|
| `sub` (GUID) | `keycloak_guid` | Clave alterna única |
| `preferred_username` | `username` | |
| `email` | `correo` | |
| Roles `colaborador`, `Instructor`, `Jefe de Ingeniería`, `ADMIN` | `COLABORADOR`, `INSTRUCTOR`, `JEFE_INGENIERIA`, `ADMIN` | Copia no autoritativa (LDM-001 §2.2). La autorización usa el token |

Si Keycloak no entrega un dato del usuario: **sin resolver** (US-025-Q1). Hasta que se defina, el contrato rechaza el inicio de sesión sin `sub`, y acepta correo o roles ausentes sin registrarlos.

**ACL-02 Mapeo de vocabulario**

| GitLab | P3M | Nota |
|---|---|---|
| Milestone | `replica_milestone` (el concepto de negocio es «Sprint», BR-035) | |
| Issue con label `UserStory` | `replica_issue.tipo = USER_STORY` | |
| Issue con label `Task` | `replica_issue.tipo = TASK` | BR-050 |
| `state = closed` / `opened` | `CLOSED` / `OPENED` | |
| `web_url` | `web_url` | Se compara con `issue_url` |
| `project_id` | `gitlab_project_id`; coincide con `producto.gitlab_project_id` | |
| Issue sin label `UserStory` ni `Task` | **No es válido** como evidencia | BR-020 |

**Mapeo de `issue_url`:** CTX-07 interpreta la URL y la traduce a (`gitlab_project_id`, `gitlab_issue_id`). Reglas de seguridad: la URL debe pertenecer a la **URL base de GitLab configurada** (guardada en Vault, ADR-12); cualquier otra se rechaza. CTX-07 **nunca llama a GitLab durante la consulta**: usa su réplica.

**Obsolescencia (BR-092):** un issue cerrado en GitLab pero aún no cargado figura abierto en la réplica y CON-10 lo rechaza hasta la siguiente carga (30 s por defecto). Si GitLab no responde, CON-10 sigue respondiendo con la réplica y devuelve `datos_a` (fecha-hora de la última carga exitosa) para que la interfaz muestre el aviso «datos al …».

## 3. Mapeo de identificadores

| Concepto | Identificador de referencia | Quién lo asigna |
|---|---|---|
| Persona, colaborador, evaluador, jefe de proyecto | `persona_ref` = id de `persona` (CTX-01), opaco | CTX-01 |
| Rol/nivel, competencia | `rol_nivel_ref`, `competencia_ref` = id opaco (CTX-03) | CTX-03 |
| Enrolamiento, certificación, evidencia esperada | id opaco (CTX-04) | CTX-04 |
| Milestone, issue | (`gitlab_project_id`, `gitlab_*_id`); externo, GitLab es la autoridad | GitLab |
| Actor que registra (`*_por_ref`) | `keycloak_guid` del token (claim `sub`) | Keycloak (ver DEC-I03) |

Un identificador externo **no es propiedad local** (regla del skill): CTX-07 posee la réplica, no los issues.

## 4. Matriz de referencias → contrato

Cada `*_ref` de LDM-001 §3 queda cubierto.

| Referencia (LDM-001) | Contrato |
|---|---|
| `plaza_rol_nivel.rol_nivel_ref` | CON-03 |
| `usuario.persona_ref` | CON-13 (vinculación por correo, D-H19) |
| `edicion_de_curso.evaluador_ref` | CON-01 (EVALUADOR) |
| `objetivo_de_curso.competencia_ref` | CON-05 |
| `enrolamiento.colaborador_ref`, `jefatura_de_proyecto.colaborador_ref`, `asignacion.colaborador_ref` | CON-01 (COLABORADOR) |
| `evidencia_aportada.issue_url` | CON-10 |
| `evidencia_aportada.validada_por_ref` | CON-01 (EVALUADOR, evidencia de curso) o CON-09 (jefe de proyecto, evidencia de proyecto) |
| `evidencia_aportada.enrolamiento_ref`, `evidencia_esperada_ref` | Mismo contexto que el consumidor lógico de CTX-04: se valida al registrar contra CTX-04 (**CON-12, ver abajo**) |
| `valoracion_de_competencia.competencia_ref` | CON-05 |
| `solicitud/promocion.rol_nivel_destino_ref` | CON-03 y CON-02 |
| `evaluacion_certificacion`, `promocion_certificacion` | CON-08 |
| `proyecto_milestone.milestone_ref` | CON-11 |
| `proyecto_rol_nivel_requerido`, `asignacion.rol_nivel_ref` | CON-03 |
| Nivel mínimo en la asignación | CON-04 y CON-07 |
| Certificación (K-20) | CON-06 |
| `plaza_rol_nivel` al promover (D-H12) | EVT-01 |
| `*_por_ref` | DEC-I03 |

**CON-12 `EvidenciaEsperadaDeEnrolamiento` (cubre una brecha de mi propia lista de §2.1)**: proveedor CTX-04, consumidor CTX-05. Entrada: `enrolamiento_ref`, `evidencia_esperada_ref`. Respuesta: `{existe_y_pertenece: bool, obligatoriedad}`. Garantiza que la evidencia esperada pertenece al curso del enrolamiento (K-22). Se agrega al catálogo.

## 5. Seguridad y exposición de datos

| Aspecto | Regla |
|---|---|
| Autenticación entre servicios | JWT de máquina (Client Credentials) emitido por Keycloak; un *client* por servicio (ADR-P9) |
| Autorización | Un *scope* por contrato (mínimo privilegio), por ejemplo `ctx01.persona-rol.read` |
| Superficie | Rutas `/internal/…` no publicadas en el API Gateway (ADR-14; consumidores externos pendientes en ADR-P10) |
| Datos en tránsito | Solo identificadores, booleanos y niveles. Ningún nombre, correo ni teléfono cruza un contexto |
| Registro (logs) | No se escribe el contenido de los datos personales en los logs de integración (ADR-P4 pendiente) |
| URL de issue | Solo bajo la URL base de GitLab configurada |

## 6. Fallos de las consultas síncronas

| Situación | Comportamiento |
|---|---|
| Proveedor no disponible o con el *circuit breaker* abierto | El **comando de escritura se rechaza** con «dependencia no disponible». No hay escritura parcial. Es seguro: las consultas no cambian estado |
| Consulta idempotente que falla de forma transitoria | Reintento con esperas incrementales (patrón de ADR-09) |
| Comando que cambia estado | **Sin reintento automático** sin clave de idempotencia. El reintento es del usuario |
| Respuesta negativa (`false`) | Se rechaza el comando con el motivo de negocio (por ejemplo «el colaborador no tiene el rol vigente») |
| Dos contextos se consultan entre sí | No hay ciclo de autoridad: CTX-04 consulta a CTX-05 (CON-06) y CTX-05 consulta a CTX-04 (CON-08, CON-12), pero cada consulta es de **solo lectura** sobre un dato que el proveedor posee. Una consulta no dispara otra |

Los valores de tiempo de espera, apertura del circuito y reintentos de las consultas internas **no están decididos**. ADR-09 solo propone parámetros para GitLab (jitter, 5, 15 y 45 s; apertura tras 5 fallos y 5 minutos abierto). Se fijan en infraestructura.

## 7. Política de compatibilidad (propuesta, DEC-I04)

| Aspecto | Política propuesta |
|---|---|
| Versionado | Ruta `/internal/v1/…`; evento con `schema_version` |
| Cambios compatibles | Añadir campos opcionales o nuevas consultas: sin cambio de versión mayor |
| Cambios incompatibles | Nueva versión mayor. La anterior convive hasta que el último consumidor migra |
| Lectores | Tolerantes: ignoran campos desconocidos |
| Obsolescencia | Se anuncia y se mide el uso antes de retirar |
| Ámbito | Solo contratos **internos**. El versionado de API para terceros sigue pendiente en ADR-P10 |

## 8. Propuestas de datos compartidos (decisión explícita)

| ID | Propuesta | Decisión |
|---|---|---|
| SDP-01 | CTX-05 y CTX-06 leen directamente `replica_issue` / `replica_milestone` | **Rechazada.** Se consume por CON-10 y CON-11 (ADR-DB-002) |
| SDP-02 | CTX-04 mantiene una proyección local del estado de validación de evidencias | **Rechazada.** Duplicaría una verdad ajena; CON-06 es monótona |
| SDP-03 | Una tabla común de «personas» para todos los contextos | **Rechazada.** Solo CTX-01 posee la persona; el resto guarda `persona_ref` |
| SDP-04 | Réplica de GitLab dentro de CTX-07 | **Aceptada** por ADR-08 y propiedad de CTX-07, sin compartirla |

## 9. Trazabilidad

| Contrato | Invariante / restricción | Regla de negocio |
|---|---|---|
| CON-01 | K-09, INV-05 | BR-047, D-H7 |
| CON-02 | INV-18 | BR-031, BR-029 |
| CON-03, CON-05 | INV-11, INV-12 | BR-014, BR-017 |
| CON-04, CON-07 | INV-22 | BR-041, BR-042 |
| CON-06 | INV-14 | BR-021, BR-104 |
| CON-08 | R-31, R-73 | BR-030, BR-083 |
| CON-09 | INV-15 | BR-010 |
| CON-10 | INV-15, INV-25 | BR-020, BR-103 |
| CON-11 | INV-19 | BR-091 |
| CON-12 | K-22 | BR-105, D-H11 |
| EVT-01 | INV-27 | BR-110, D-H12 |
| ACL-01 | INV-08 | BR-074, BR-075, BR-107 |
| ACL-02 | INV-24, INV-25 | BR-065, BR-082, BR-090, ADR-08 |

## 10. Decisiones registradas

Responsable funcional: ianache, 2026-10-11, en sesión. Aceptó las cinco recomendaciones.

| ID | Decisión | Efecto |
|---|---|---|
| D-H18 | **DEC-I01:** `plaza_rol_nivel.promocion_ref` | LDM-001: atributo y K-42 |
| D-H19 | **DEC-I02:** el usuario de Keycloak se vincula con la persona por el **correo**, único entre personas y verificado al registrar al colaborador | LDM-001: K-43. Falta registrar la regla en BRC-001 |
| D-H20 | **DEC-I03:** los actores se guardan con el GUID de Keycloak | LDM-001: `*_por_ref` de actor |
| D-H21 | **DEC-I04:** política de compatibilidad de §7 para contratos internos | §7 pasa de propuesta a decisión |
| D-H22 | **DEC-I05:** consultas síncronas de solo lectura y un solo evento con *outbox* | §2 queda fijado |
| D-H30 | **Revisión (RPT-DDR-001 R-01):** Keycloak no permite registro libre ni edición del correo; está en solo lectura (declarado por ianache, 2026-10-11) | Mitiga el riesgo de suplantación de D-H19. Se propone declararlo como requisito de despliegue y hacer el vínculo inmutable; pendiente de aceptación |
| D-H31 | **Revisión (RPT-DDR-001 R-01):** los usuarios no pueden crear cuentas; las identidades de Keycloak vienen de su conexión con Active Directory, que gestiona el equipo de infraestructura. No hay casos de correos duplicados (declarado por ianache, 2026-10-11) | R-01 baja a Baja. Se retira la propuesta de exigir `email_verified`, que en un Keycloak federado suele no estar activado. Queda por decidir el vínculo inmutable y el caso de cambio o reutilización de correo |
| D-H33 | **Revisión (RPT-DDR-001 R-01):** no se habilitará el registro libre ni el auto-registro de cuentas, ni en el login del portal ni en el flujo de login de Keycloak (declarado por ianache, 2026-10-11) | Requisito de despliegue declarado. Falta anotarlo en INF-P3M-001. No sustituye al vínculo inmutable ni al procedimiento de cambio o reutilización de correo, que siguen pendientes |
| D-H34 | **Correcciones de la revisión (RPT-DDR-001):** se aplican R-02 (tabla `colaborador_carga` y protocolo K-47), R-04 (regla de evento obsoleto, K-46), R-07 (contrato CON-13 `PersonaPorCorreo`; CON-12 pasa a §2.1) y R-01 (vínculo inmutable K-45, corrección manual por el Jefe de Ingeniería con registro de quién y cuándo, y baja de contactos K-44) | LDM-001 (K-44 a K-47, tablas nuevas), PDM-001 (V1 de `p3m_partes`, `p3m_identidad` y `p3m_portafolio`) |

**Detalle original de las decisiones (conservado para trazabilidad):**

| ID | Pregunta | Recomendación |
|---|---|---|
| DEC-I01 | Para que el consumidor de EVT-01 sea idempotente y trazable, **añadir a LDM-001** `plaza_rol_nivel.promocion_ref` (nulo si el cambio no vino de una promoción; único si no es nulo). Es un cambio de modelo lógico | Aceptar |
| DEC-I02 | **¿Cómo se vincula el usuario de Keycloak con la persona al iniciar sesión?** Ninguna fuente lo define (BR-074, BR-077, US-025). Sin esa clave no se puede aplicar la regla «sin colaborador registrado vuelve al login» (D-H5) | Por el **correo**: el de Keycloak (normalizado a minúsculas) debe coincidir con un `dato_de_contacto` CORREO de una persona. Ver riesgo abajo |
| DEC-I03 | Los actores de las escrituras (`registrada_por_ref`, `decidida_por_ref`, `aprobada_por_ref`, `realizada_por_ref`) se guardan con el **GUID de Keycloak** (`sub` del token), sin consultar a CTX-02. Cambia el significado de esas referencias en LDM-001: apuntan a `usuario.keycloak_guid` y no a `usuario.id` | Aceptar |
| DEC-I04 | Aceptar la política de compatibilidad de §7 para los contratos internos | Aceptar |
| DEC-I05 | Aceptar el estilo de consistencia: consultas síncronas de solo lectura en el momento del comando (CON-01..CON-12) y **un solo evento** asíncrono (EVT-01) con *outbox* e idempotencia | Aceptar |

**Riesgo de DEC-I02:** si dos personas comparten un correo, o si el correo de Keycloak difiere del registrado (correo personal frente a corporativo), el vínculo falla o se asigna mal. Mitigación propuesta: el correo de vinculación debe ser **único entre las personas** y se verifica al registrar al colaborador. Si prefieres otra clave (por ejemplo, que el Jefe de Ingeniería registre el GUID al dar de alta al colaborador), dímelo.

**Arrastrado (no bloquea este gate):** US-025-Q1 (qué hace el portal si Keycloak no entrega el correo o los roles) y los parámetros operativos de §6.

## 11. Estado del gate

`INTEGRATION_CONTRACT_READY` = **PASSED**, por decisión de ianache (2026-10-11).

| Requisito del gate | Estado |
|---|---|
| Propiedad del proveedor | Cumplido (§2): cada contrato nombra proveedor y consumidor |
| Necesidad del consumidor | Cumplido (§2.1, columna «Para qué») |
| Esquema del contrato | Cumplido en lo lógico (entradas y respuestas). El esquema OpenAPI/AsyncAPI es de implementación |
| Política de compatibilidad | Cumplido: aceptada (D-H21) |
| Comportamiento ante fallos | Cumplido (§2.2 y §6); parámetros operativos pendientes |
| Decisión explícita por dato compartido | Cumplido (§8) |
| Identificadores | Cumplido: vinculación por correo único (D-H19), actores por GUID (D-H20) |

No hay autoridad circular ni exposición insegura de datos, así que no es `BLOCKED`.
