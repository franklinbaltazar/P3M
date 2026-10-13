---
type: API Proposal
title: "API-PRP-004 — API de Portafolio y Asignación"
description: "Microservicio que aloja CTX-06: productos, proyectos con milestones y jefatura, roles/niveles requeridos, asignaciones, excepciones y codificador de motivos."
tags: [api, microservice, ctx-06]
status: draft
gate_status: REQUIRES_REVIEW
version: "0.3.0"
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
---

# API-PRP-004 — API de Portafolio y Asignación

> **Estado:** `draft`, `REQUIRES_REVIEW`. Sin revisión humana. Lo inferido va marcado **(I)**.

## 1. Identidad
| Campo | Valor |
|---|---|
| ID | API-PRP-004 |
| Servicio | `svc-portafolio` |
| Contextos alojados (módulos) | CTX-06 Portafolio y asignación |
| Propietario de datos | Esquema `p3m_portafolio` |
| Propietario funcional | Jefe de Ingeniería (BR-005, BR-061) |
| Modo | propose |
| Versión de la propuesta | 0.1.0 |

## 2. Propósito y alcance
Registrar productos y proyectos, designar la jefatura de proyecto, definir los roles/niveles requeridos, asignar colaboradores con verificación del nivel mínimo, aprobar excepciones y mantener el codificador de motivos. **Fuera:** lectura de milestones e issues (API-PRP-005).

## 3. Agrupación recomendada
| Decisión | Criterio | Evidencia | Alternativa descartada y costo |
|---|---|---|---|
| Servicio propio para CTX-06 | S-4 **(I)**, G-4 | Invariante propia de dedicación ≤ 100 % con bloqueo de filas por colaborador (INV-21, ADR-P6); ciclo de vida y propietario funcionales propios | Fusionar con API-PRP-003: se evita la dependencia circular CON-07/CON-09, pero crea un servicio de ~26 recursos y mezcla el portafolio con la progresión |
| No fusionar con API-PRP-005 | S-1, S-2, S-3 | GitLab es externo e inestable; carga por lotes; credenciales propias | Agrupar CTX-06 y CTX-07: arrastra al portafolio la caída de GitLab |

Estado de la decisión: **decidida por ianache (responsable funcional), 2026-10-12, sin revisión de un arquitecto** (H-01). Dependencia circular con API-PRP-003 señalada en el resumen.

## 4. Recursos y operaciones (F1)
| Recurso | Operaciones | Historia | Actor | Tipo | Fuente |
|---|---|---|---|---|---|
| `/v1/productos` | `POST`, `GET`, `GET /{id}`, `PATCH /{id}` | US-018 | JI, ADM | R | API-ANL-001 §3.6; vinculado a `gitlab_project_id` |
| `/v1/productos/{id}/proyectos` | `POST`, `GET` | US-019 | JI, ADM | R | §3.6 |
| `/v1/proyectos` | `GET` (filtro `producto_id`) | US-019 **(I)** | JI, ADM | R | Propuesto por API-PRP-006; additive |
| `/v1/proyectos/{id}` | `GET`, `PATCH` | US-019 | JI, ADM (escribir) | R | §3.6 |
| `/v1/proyectos/{id}/milestones` | `POST`, `GET`, `POST /{mid}/baja` **(I)** | US-019 | JI, ADM | R | §3.6; valida con CON-11 (K-30) |
| `/v1/proyectos/{id}/roles-nivel-requeridos` | `PUT`, `GET` | US-019 | JI, ADM | R | §3.6; RQ-32 abierta |
| `/v1/proyectos/{id}/jefatura` | `POST`, `GET`, `POST /{jid}/finalizar` | US-019 | JI, ADM | R | §3.6; INV-20 |
| `/v1/asignaciones` | `POST`, `GET` (filtros `colaborador_ref`, `proyecto_ref`, `estado`), `GET /{id}` | US-021 | Escribir: JI, ADM. Leer: COL (las suyas), JP (las de su proyecto), JI, ADM | R+D | §3.6; `409` si > 100 % (INV-21); lectura por D-UX-3 |
| `/v1/asignaciones/{id}/excepcion` | `POST`, `GET` | US-022 | JI, ADM | R | §3.6; BR-006, BR-134 |
| `/v1/asignaciones/{id}/finalizar` | `POST` | US-021 **(I)** | JI, ADM | R | §3.6 |
| `/v1/motivos-de-excepcion` | `POST`, `GET`, `PATCH /{id}` | US-023 | JI, ADM | R | §3.6 |

## 5. Contratos internos
### Sirve
| ID | Consulta | Consumidores | Entrada → respuesta | Para qué |
|---|---|---|---|---|
| CON-09 | `EsJefeVigenteDeProyectoDelMilestone` | API-PRP-003 | `persona_ref`, `milestone_ref`, `fecha` → `{es_jefe_vigente}` | Validar evidencias de proyecto (BR-010) |

### Consume
| ID | Proveedor | Cuándo se llama | Si falla |
|---|---|---|---|
| CON-01 | API-PRP-001 | Colaborador y jefe de proyecto válidos | `503` |
| CON-03 | API-PRP-002 | Rol/nivel requerido y asignado | `503` |
| CON-04 | API-PRP-002 | Nivel mínimo al asignar | `503` |
| CON-07 | API-PRP-003 | Nivel actual del colaborador al asignar | `503`; sin escritura parcial |
| CON-11 | API-PRP-005 | Milestone de un proyecto | `503` o respuesta desde la réplica |

### Puertos internos
Ninguno.

## 6. Eventos y ACL
Ninguno. DDM-001 define `AsignaciónRegistrada`, `AsignaciónPendiente` y `ExcepciónAprobada` sin consumidor; no se publican **(I)**.

## 7. Invariantes que protege
| ID | Invariante | Mecanismo | Origen |
|---|---|---|---|
| INV-19 | Un proyecto pertenece a un solo producto y cada milestone a un solo proyecto | A + P | BR-048, BR-091 |
| INV-20 | Un solo jefe de proyecto vigente | A | D-H2 |
| INV-21 | Suma de dedicación vigente ≤ 100 % | P (bloqueo de filas) | BR-093, ADR-P6 |
| INV-22 | Nivel mínimo verificado; si no, Pendiente hasta excepción con motivo y aprobador | A | BR-041 a BR-043 |
| INV-23 | Roles/niveles requeridos solo por JI o ADM | A (permiso) | D-H8 |

## 8. Seguridad
| Aspecto | Propuesta | Fuente |
|---|---|---|
| Autenticación entre servicios | JWT de máquina y token del usuario; *scope* por contrato | ADR-P9 |
| Autorización | Solo rol del token (JI, ADM); sin condición de recurso | ADR-P5 anexo §3 |
| Datos expuestos | CON-09 devuelve un booleano | ICP-001 P-5 |

## 9. Fallos, idempotencia y concurrencia
| Situación | Comportamiento propuesto |
|---|---|
| Dos asignaciones simultáneas del mismo colaborador | Bloqueo de filas por colaborador; `409` si supera 100 % |
| Dependencia no disponible al asignar | Se rechaza el comando, sin escritura parcial |
| Reintento de asignar | `Idempotency-Key` **(I)** |
| Asignación que no cumple el nivel mínimo | Queda Pendiente (no es un error) |

## 10. Observabilidad
Identificador de correlación; contador de asignaciones Pendientes; esperas y colisiones del bloqueo por colaborador. **(I)**

## 11. Pruebas de contrato
| Tipo | Qué verifica | Dueño |
|---|---|---|
| Proveedor | OpenAPI de `/v1`, CON-09 | Equipo de desarrollo |
| Consumidor | CON-01, 03, 04, 07 y 11 contra sus proveedores; consumidor API-PRP-003 de CON-09 | Equipo de desarrollo |
| Negativas | Dedicación > 100 %; nivel mínimo no cumplido sin excepción; segundo jefe vigente | QA |
| Concurrencia | Prueba de dos sesiones sobre el mismo colaborador (K-31) | QA |

## 12. Trazabilidad
| Historia | Recurso o contrato | Contexto |
|---|---|---|
| US-018 | `/v1/productos` | CTX-06 |
| US-019 | `/proyectos`, `/milestones`, `/jefatura`, `/roles-nivel-requeridos` | CTX-06 |
| US-021, US-022 | `/v1/asignaciones`, `/excepcion` | CTX-06 |
| US-023 | `/v1/motivos-de-excepcion` | CTX-06 |

## 13. Riesgos y preguntas abiertas
| ID | Pregunta o riesgo | Severidad | Dueño | Impacto |
|---|---|---|---|---|
| H-01 | Agrupación decidida por el responsable; falta la revisión de un arquitecto | Media | Arquitectura | Número de servicios |
| A-1 | Dependencia circular síncrona con API-PRP-003 (CON-07 y CON-09) | Media | Arquitectura | Disponibilidad cruzada |
| RQ-32 | Si el jefe de proyecto conserva algún permiso | Baja | Responsable funcional | `/roles-nivel-requeridos` |
| H-07 | Tiempos de espera sin definir | Media | Infraestructura | Fallos |

## 14. Historial de refinamiento
| Versión | Fecha | Cambio | Clase | Pedido |
|---|---|---|---|---|
| 0.1.0 | 2026-10-12 | Propuesta inicial | additive | Probar `api-refiner` sobre API-ANL-001 |
| 0.2.0 | 2026-10-12 | Se añade `GET /v1/proyectos`; H-01 decidida | additive | Necesidad del BFF (API-PRP-006); registro de la decisión H-01 |
| 0.3.0 | 2026-10-13 | Se define la lectura de asignaciones por rol y los filtros | additive | D-UX-3 (UXR-001 §7) |

## 15. Siguiente acción
Decidir H-01. Luego `api-designer` redacta el OpenAPI. US-018, US-019 y US-023 están en el Sprint 1.
