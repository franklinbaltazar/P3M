---
type: API Proposal
title: "API-PRP-005 — API de Integración GitLab"
description: "Microservicio que aloja CTX-07: carga programada de solo lectura desde GitLab, registro de cargas, réplica de milestones e issues, y las consultas internas CON-10 y CON-11."
tags: [api, microservice, ctx-07]
status: draft
gate_status: REQUIRES_REVIEW
version: "0.2.0"
generated:
  by: "api-refiner"
  at: "2026-10-12T21:00:00-05:00"
human-reviewed: false
sources:
  - id: api-anl-001
    resource: /design/api-contracts/API-ANL-001-analisis-de-apis-por-dominio.md
  - id: ddm-001
    resource: /data/DDM-001-modelo-ddd.md
  - id: icp-001
    resource: /data/ICP-001-contratos-de-integracion.md
  - id: adr-08-09-p3
    resource: /architecture/adr/ADR-08-carga-programada-de-gitlab-de-solo-lectura-co.md
---

# API-PRP-005 — API de Integración GitLab

> **Estado:** `draft`, `REQUIRES_REVIEW`. Sin revisión humana. Lo inferido va marcado **(I)**.

## 1. Identidad
| Campo | Valor |
|---|---|
| ID | API-PRP-005 |
| Servicio | `svc-gitlab` (API más un proceso de carga programada; el planificador es por decidir: ADR-P3 requiere revisión por ADR-16) |
| Contextos alojados (módulos) | CTX-07 Integración GitLab |
| Propietario de datos | Esquema `p3m_gitlab` (réplica de solo lectura y registro de cargas) |
| Propietario funcional | Jefe de Ingeniería (BR-066, BR-069) |
| Modo | propose |
| Versión de la propuesta | 0.1.0 |

## 2. Propósito y alcance
Cargar de GitLab milestones e issues (primera carga completa, luego delta), llevar el registro de cargas, y responder a los demás servicios si un issue está cerrado y es válido o si un milestone existe. **Fuera:** cualquier escritura en GitLab (BR-036).

## 3. Agrupación recomendada
| Decisión | Criterio | Evidencia | Alternativa descartada y costo |
|---|---|---|---|
| Servicio propio para CTX-07 | S-1, S-2, S-3 | Sistema externo (ACL-02) con circuit breaker (ADR-09); tarea programada (ADR-P3); credenciales de GitLab en Vault (ADR-12) | Agruparlo con API-PRP-004: la caída o los límites de GitLab (R-12) afectarían a las asignaciones |
| CON-10 y CON-11 se responden desde la réplica | — | ICP-001 §2.3: nunca llama a GitLab durante la consulta | Consultar GitLab en línea: rompe la disponibilidad de quienes validan evidencias |

Estado de la decisión: **decidida por ianache (responsable funcional), 2026-10-12, sin revisión de un arquitecto** (H-01). Es la separación más sólida junto con API-PRP-002.

## 4. Recursos y operaciones (F1)
| Recurso | Operaciones | Historia | Actor | Tipo | Fuente |
|---|---|---|---|---|---|
| `/v1/cargas` | `GET` (registro), `GET /{id}`, `POST` (reintentar) | US-020 | JI, ADM | R | API-ANL-001 §3.7; `POST` responde `202` y el recurso de carga |
| `/v1/gitlab/proyectos/{gitlab_project_id}/milestones` | `GET` | US-024 | JI, ADM | R | §3.7; devuelve id, nombre, tareas totales, tareas cerradas y % de avance, y `datos_a` (BR-092). **Requiere ampliar la réplica (D-UX-1)** |
| `/v1/gitlab/proyectos/{gitlab_project_id}/issues` | `GET` | US-024 | JI, ADM | R | §3.7; filtros por milestone, tipo y estado; devuelve id, título, esfuerzo estimado, status, esfuerzo spent y due date. **Requiere ampliar la réplica (D-UX-1)** |

La carga programada la lanza un planificador (ADR-P3, hoy con Celery Beat, que requiere revisión porque ADR-16 pasa los servicios a Java con Spring) y **no es API**. Ningún `POST` o `PUT` sobre milestones o issues.

## 5. Contratos internos
### Sirve
| ID | Consulta | Consumidores | Entrada → respuesta | Para qué |
|---|---|---|---|---|
| CON-10 | `IssueCerrado` | API-PRP-003 | `issue_url` → `{valido, tipo, milestone_ref \| null, datos_a}` | K-23, INV-15, BR-020 |
| CON-11 | `MilestoneExiste` | API-PRP-004 | `milestone_ref` → `{existe}` | `proyecto_milestone` (K-30) |

### Consume
Ninguno entre servicios.

### Puertos internos
Ninguno.

## 6. Eventos y ACL
| ID | Tipo | Dirección | Consistencia |
|---|---|---|---|
| ACL-02 GitLab → CTX-07 | ACL | Entrada: carga con delta, solo lectura; **se amplía** con estimado, spent, due date, status y totales por milestone (D-UX-1) | Reintentos con esperas incrementales y circuit breaker (ADR-09); mapeo de vocabulario en ICP-001; la `issue_url` debe pertenecer a la URL base guardada en Vault |

Eventos propios de DDM-001 (`CargaCompletada`, `IssuesActualizados`, `GitLabNoDisponible`): sin consumidor definido; no se publican **(I)**.

## 7. Invariantes que protege
| ID | Invariante | Mecanismo | Origen |
|---|---|---|---|
| INV-24 | Primera carga completa, luego delta; 3 reintentos con esperas incrementales y circuit breaker; los logs se retienen siempre | A | ADR-08, BR-090, BR-094 |
| INV-25 | El portal no crea ni modifica issues, user stories ni milestones | A | BR-036 |

## 8. Seguridad
| Aspecto | Propuesta | Fuente |
|---|---|---|
| Autenticación entre servicios | JWT de máquina y token del usuario; *scope* por contrato | ADR-P9 |
| Autorización | Solo rol del token (JI, ADM) para `/v1`; CON-10 y CON-11 solo con *scope* de máquina | ADR-P5, ICP-001 §5 |
| Credenciales de GitLab | En Vault, con rotación | ADR-12, ADR-P11 |
| Validación de URL | Solo bajo la URL base configurada; otra se rechaza | ICP-001 §2.3 |

## 9. Fallos, idempotencia y concurrencia
| Situación | Comportamiento propuesto |
|---|---|
| GitLab no disponible | CON-10 y CON-11 siguen respondiendo desde la réplica con `datos_a`; la carga se reintenta |
| Una sola carga a la vez | Bloqueo de la ejecución; el `POST /v1/cargas` con una carga en curso devuelve `409` **(I)** |
| Issue cerrado aún no cargado | CON-10 lo rechaza hasta la siguiente carga (30 s por defecto, BR-092) |
| Reintento de carga | Idempotente: sin cambios se registra «sin cambios desde la carga previa» |

## 10. Observabilidad
Identificador de correlación; estado y duración de cada carga; reintentos y apertura del circuito; antigüedad de la réplica (`datos_a`); logs sin tokens ni secretos. **(I)**

## 11. Pruebas de contrato
| Tipo | Qué verifica | Dueño |
|---|---|---|
| Proveedor | OpenAPI de `/v1`, CON-10 y CON-11 | Equipo de desarrollo |
| Consumidor | API-PRP-003 (CON-10) y API-PRP-004 (CON-11) | Equipo de desarrollo |
| ACL | Mapeo de etiquetas y estados contra respuestas simuladas de GitLab; caída simulada de GitLab | QA |
| Negativas | Issue sin label `UserStory` ni `Task`; URL fuera de la base configurada | QA |

## 12. Trazabilidad
| Historia | Recurso o contrato | Contexto |
|---|---|---|
| US-020 | `/v1/cargas` | CTX-07 |
| US-024 | `/v1/gitlab/proyectos/{id}/milestones`, `/issues` | CTX-07 |

## 13. Riesgos y preguntas abiertas
| ID | Pregunta o riesgo | Severidad | Dueño | Impacto |
|---|---|---|---|---|
| H-01 | Agrupación decidida por el responsable; falta la revisión de un arquitecto | Media | Arquitectura | Número de servicios |
| R-12 | Caída o límites de la API de GitLab, carga duplicada | Media | Arquitectura | Frescura de la réplica |
| H-07 | Valores de reintentos y circuito para las consultas internas sin definir | Media | Infraestructura | Fallos |
| US-020 | Historia de 46 h (XL) con 10 criterios | Media | Equipo | Dividir antes del Sprint Planning |
| UXQ-1 | **Decidido (D-UX-1, 2026-10-13): se amplía la réplica** con estimado, spent, due date y status del issue, y total y cerradas por milestone. **Falta:** migración Flyway nueva en `p3m_gitlab` (hoy `replica_issue` solo guarda título, estado, tipo, URL, milestone y fecha) y actualizar ACL-02 en ICP-001. Mientras no se haga, `/issues` y `/milestones` no pueden devolver esos campos | Alta | Datos y arquitectura | US-024; se resuelve con el trabajo de datos pendiente |

## 14. Historial de refinamiento
| Versión | Fecha | Cambio | Clase | Pedido |
|---|---|---|---|---|
| 0.1.0 | 2026-10-12 | Propuesta inicial | additive | Probar `api-refiner` sobre API-ANL-001 |
| 0.2.0 | 2026-10-13 | `/issues` y `/milestones` devuelven los campos de US-024; ACL-02 se amplía | additive | D-UX-1 (UXR-001 §7) |

## 15. Siguiente acción
Decidir H-01. Luego `api-designer` redacta el OpenAPI de `/v1`, CON-10 y CON-11. Las pruebas de la ACL dependen de una instancia simulada de GitLab.
