---
type: API Proposal
title: "API-PRP-003 — API de Formación y Progresión"
description: "Microservicio que aloja CTX-04 (cursos, ediciones, enrolamientos, certificación) y CTX-05 (evidencias, valoraciones, evaluaciones de desempeño, solicitudes y promociones). Publica EVT-01."
tags: [api, microservice, ctx-04, ctx-05]
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
  - id: adr-p5-anexo
    resource: /architecture/adr/ADR-P5-anexo-mapa-rol-permiso-propuesta.md
---

# API-PRP-003 — API de Formación y Progresión

> **Estado:** `draft`, `REQUIRES_REVIEW`. Sin revisión humana. Lo inferido va marcado **(I)**.

## 1. Identidad
| Campo | Valor |
|---|---|
| ID | API-PRP-003 |
| Servicio | `svc-formacion-progresion` |
| Contextos alojados (módulos) | CTX-04 Formación, CTX-05 Progresión |
| Propietario de datos | Esquemas `p3m_formacion` y `p3m_progresion` (siguen separados) |
| Propietario funcional | Jefe de Ingeniería; evaluadores de edición (BR-008) |
| Modo | propose |
| Versión de la propuesta | 0.1.0 |

## 2. Propósito y alcance
Definir cursos con objetivos y rúbricas, crear ediciones, enrolar, validar evidencias, certificar, registrar valoraciones y evaluaciones de desempeño, y decidir promociones. **Fuera:** asignaciones a proyectos (API-PRP-004), réplica de GitLab (API-PRP-005).

## 3. Agrupación recomendada
| Decisión | Criterio | Evidencia | Alternativa descartada y costo |
|---|---|---|---|
| Fusionar CTX-04 y CTX-05 | G-1, G-2 | CON-06 (04→05) frente a CON-08 y CON-12 (05→04): acoplamiento bidireccional; INV-14 e INV-15 cruzan ambos contextos y DDM-001 §8 deja su mecanismo de consistencia «para S4» | Servicios separados: dependencia circular síncrona de 3 contratos y consistencia entre servicios para la certificación |
| Servicio grande (19 recursos, 7 historias de Progresión y 6 de Formación) | G-5 | Equipo pequeño **(I)**, equipo sin definir (MCP-B7) | Dividir luego por módulo: posible sin cambio de datos porque los esquemas están separados |

Estado de la decisión: **decidida por ianache (responsable funcional), 2026-10-12, sin revisión de un arquitecto** (H-01).

## 4. Recursos y operaciones (F1)
### CTX-04 Formación
| Recurso | Operaciones | Historia | Actor | Tipo | Fuente |
|---|---|---|---|---|---|
| `/v1/cursos` | `POST`, `GET`, `GET /{id}`, `PATCH /{id}` | US-006 | JI, ADM | R | API-ANL-001 §3.4 |
| `/v1/cursos/{id}/objetivos` | `POST`, `GET`, `PATCH /{oid}` | US-006 | JI, ADM | R | §3.4; INV-12 |
| `/v1/cursos/{id}/objetivos/{oid}/rubrica` | `PUT`, `GET` | US-007 | JI, ADM | R | §3.4 |
| `/v1/cursos/{id}/evidencias-esperadas` | `POST`, `GET`, `PATCH` | US-006/US-007 **(I)** | JI, ADM | R | §3.4 |
| `/v1/cursos/{id}/ediciones` | `POST`, `GET` | US-008 | JI, ADM | R | §3.4 |
| `/v1/ediciones/{id}` | `GET`, `PATCH` | US-008 | JI, ADM (escribir) | R | §3.4 |
| `/v1/ediciones/{id}/enrolamientos` | `POST`, `GET` | US-009 | COL (propio) | R+D | §3.4; `409` al llegar al cupo (INV-13) |
| `/v1/enrolamientos/{id}/desenrolar` | `POST` | US-010 | COL (propio) | R+D | §3.4 |
| `/v1/enrolamientos` | `GET` (filtros `colaborador_ref`, `edicion_id`, `estado`) | US-009, US-010 **(I)** | COL (los suyos), EVA (su edición), JI, ADM | R+D | Propuesto por API-PRP-006 (BFF-V1 a V3); additive |
| `/v1/enrolamientos/{id}/certificacion` | `POST`, `GET` | US-012 | EVA | R+D | §3.4; INV-14 |

### CTX-05 Progresión
| Recurso | Operaciones | Historia | Actor | Tipo | Fuente |
|---|---|---|---|---|---|
| `/v1/enrolamientos/{id}/evidencias` | `PUT /{evidencia_esperada_id}`, `GET` | US-013 | COL (enrolado) | R+D | §3.5; D-H11 |
| `/v1/evidencias` | `GET` (filtros `enrolamiento_ref`, `edicion_id`, `estado`, `tipo`) | US-011, US-015 **(I)** | EVA, JP, JI, ADM | R+D | Propuesto por API-PRP-006 (BFF-V2, V3, V5); additive |
| `/v1/colaboradores/{id}/certificaciones` | `GET` | US-012, US-017 **(I)** | COL (propio), JI, ADM | R+D | Responde a H-03; propuesto por API-PRP-006 (BFF-V1, V5); additive |
| `/v1/evidencias-de-proyecto` | `POST`, `GET` | US-014 | COL | R | §3.5; BR-020 |
| `/v1/evidencias/{id}/validacion` | `POST` | US-011 (curso), US-015 (proyecto) | EVA (curso); JP (proyecto) | R+D | §3.5; Pendiente → Validada |
| `/v1/colaboradores/{id}/valoraciones` | `POST`, `GET` | US-016 | Escribir: JI, ADM. Leer: COL (las suyas), JI, ADM | R+D | §3.5; INV-16; lectura por D-UX-3 |
| `/v1/colaboradores/{id}/evaluaciones-de-desempeno` | `POST`, `GET` | US-026 | JI, ADM | R | §3.5; INV-17 |
| `/v1/colaboradores/{id}/solicitudes-de-promocion` | `POST`, `GET` | US-014/US-017 **(I)** | COL (propia) | R+D | §3.5; ver H-05 |
| `/v1/solicitudes-de-promocion/{id}/promocion` | `POST` | US-017 | JI, ADM | R | §3.5; INV-18; publica EVT-01 |

Regla: sin `DELETE`; no existe el estado Rechazada (D-H11).

## 5. Contratos internos
### Sirve
| ID | Consulta | Consumidores | Entrada → respuesta | Para qué |
|---|---|---|---|---|
| CON-07 | `NivelActualDeCompetencias` | API-PRP-004 | `colaborador_ref` → lista `{competencia_ref, nivel_de_logro}` | Nivel mínimo al asignar (BR-041) |

### Consume
| ID | Proveedor | Cuándo se llama | Si falla |
|---|---|---|---|
| CON-01 | API-PRP-001 | Enrolar, certificar, validar (evaluador vigente) | `503`, sin escritura parcial |
| CON-02 | API-PRP-001 | Promoción: siguiente rol/nivel | `503` |
| CON-03 | API-PRP-002 | Destino de solicitud y promoción | `503` |
| CON-05 | API-PRP-002 | Objetivo de curso, valoración | `503` |
| CON-14 (propuesto) | API-PRP-002 | Decidir la promoción: el destino debe ser el siguiente rol/nivel; Senior L4 no tiene siguiente | `503`; sin siguiente, se rechaza con ese motivo |
| CON-09 | API-PRP-004 | Validar evidencia de proyecto (jefe vigente) | `503` |
| CON-10 | API-PRP-005 | Registrar evidencia (issue cerrado y válido) | Responde con la réplica y `datos_a`; si no hay servicio, `503` |

### Puertos internos (sin HTTP)
| ID | Entre | Nota |
|---|---|---|
| CON-06 `EvidenciasObligatoriasValidadas` | CTX-04 → CTX-05 | Respuesta monótona; la certificación se emite solo con el 100 % de obligatorias (INV-14) |
| CON-08 `CertificacionExiste` | CTX-05 → CTX-04 | Para evaluaciones y promociones |
| CON-12 `EvidenciaEsperadaDeEnrolamiento` | CTX-05 → CTX-04 | La evidencia esperada pertenece al curso del enrolamiento (K-22) |

## 6. Eventos y ACL
| ID | Tipo | Dirección | Consistencia |
|---|---|---|---|
| EVT-01 `PromocionDeNivelDecidida` v1 | Evento | **Publica** (consume API-PRP-001) | *Outbox* transaccional con la promoción; cola duradera; no se borra (P-3) |

## 7. Invariantes que protege
| ID | Invariante | Mecanismo | Origen |
|---|---|---|---|
| INV-12 | Objetivo con competencia, nivel y rúbrica | A | BR-017, BR-058 |
| INV-13 | Cupo de la edición | A | BR-026, BR-027 |
| INV-14 | Certificación solo con 100 % de obligatorias validadas | E → **A** si se fusionan | BR-021, BR-022 |
| INV-15 | Evidencia con issue Closed de tipo Task o UserStory | A + E | BR-019, BR-020 |
| INV-16 | Valoraciones solo se agregan | A | BR-004 |
| INV-17 | Evaluación con fecha-hora, usuario e historial | A | BR-087, BR-089 |
| INV-18 | Sin promoción sin evaluación de desempeño | A | BR-007, BR-086 |

## 8. Seguridad
| Aspecto | Propuesta | Fuente |
|---|---|---|
| Autenticación entre servicios | JWT de máquina y token del usuario; un *scope* por contrato | ADR-P9, ICP-001 §5 |
| Autorización | Rol del token más condición del recurso: evaluador de **esa** edición (CON-01 y `evaluador_ref`), jefe vigente del proyecto (CON-09), dueño del enrolamiento o solicitud | ADR-P5 anexo G-2 |
| Datos expuestos | Evidencia solo guarda la URL del issue; sin datos personales en contratos | ICP-001 P-5 |
| Lectura (D-UX-3) | COLABORADOR lee lo suyo (valoraciones, evidencias, certificaciones, enrolamientos); JI y ADM, todo; INSTRUCTOR, las evidencias de sus ediciones; el jefe de proyecto, las de proyecto que validará. Falta registrarlo en BRC-001 | Decisión de ianache, 2026-10-13 |

## 9. Fallos, idempotencia y concurrencia
| Situación | Comportamiento propuesto |
|---|---|
| Proveedor con circuit breaker abierto | El comando se rechaza con «dependencia no disponible» |
| Reintento de enrolar o certificar | `Idempotency-Key` **(I)**; sin reintento automático sin ella |
| Cupo | `409` al llegar al cupo |
| Promoción y EVT-01 | La promoción y su mensaje se confirman juntos; la entrega puede repetirse |
| Issue cerrado pero no cargado | CON-10 lo rechaza hasta la siguiente carga (BR-092) |

## 10. Observabilidad
Identificador de correlación; lag de la cola y mensajes en DLQ de EVT-01; conciliación de promociones no aplicadas (ICP-001 §2.2); latencia de CON-10 y CON-09. **(I)**

## 11. Pruebas de contrato
| Tipo | Qué verifica | Dueño |
|---|---|---|
| Proveedor | OpenAPI de `/v1`, CON-07; AsyncAPI de EVT-01 (publicación) | Equipo de desarrollo |
| Consumidor | CON-01, 02, 03, 05, 09 y 10 contra sus proveedores; consumidor API-PRP-004 de CON-07 | Equipo de desarrollo |
| Negativas | Certificar con una obligatoria pendiente; evidencia con issue abierto o sin label; evaluador que no es el de la edición; promoción sin evaluación | QA |

## 12. Trazabilidad
| Historia | Recurso o contrato | Contexto |
|---|---|---|
| US-006, US-007 | `/v1/cursos`, `/objetivos`, `/rubrica` | CTX-04 |
| US-008 | `/v1/cursos/{id}/ediciones` | CTX-04 |
| US-009, US-010 | `/enrolamientos`, `/desenrolar` | CTX-04 |
| US-011, US-015 | `/v1/evidencias/{id}/validacion` | CTX-05 |
| US-012 | `/v1/enrolamientos/{id}/certificacion` | CTX-04 |
| US-013, US-014 | `/enrolamientos/{id}/evidencias`, `/evidencias-de-proyecto` | CTX-05 |
| US-016 | `/valoraciones` | CTX-05 |
| US-017 | `/solicitudes-de-promocion/{id}/promocion` (EVT-01) | CTX-05 |
| US-026 | `/evaluaciones-de-desempeno` | CTX-05 |

## 13. Riesgos y preguntas abiertas
| ID | Pregunta o riesgo | Severidad | Dueño | Impacto |
|---|---|---|---|---|
| H-01 | Agrupación decidida por el responsable; falta la revisión de un arquitecto | Media | Arquitectura | Número de servicios |
| H-02 | Sin catálogo de rutas del BFF; faltan lecturas compuestas | Alta | Análisis funcional y UX | Consultas de pantalla |
| H-03 | CON-07 y CON-06 son internos; no hay lectura de valoraciones, evidencias o certificaciones para la interfaz | Media | Análisis funcional | Falta una API de lectura **(I)** |
| H-05 | `/solicitudes-de-promocion` sin historia propia (RQ-18) | Media | Análisis funcional | Ruta |
| A-1 | **Alerta de acoplamiento:** CON-09 (aquí → API-PRP-004) y CON-07 (API-PRP-004 → aquí) forman una dependencia circular síncrona. Son lecturas sobre datos que cada proveedor posee; ver resumen | Media | Arquitectura | Disponibilidad cruzada |
| T-1 | Tamaño del servicio: 19 recursos | Media | Arquitectura | Dividir por módulo si crece |

## 14. Historial de refinamiento
| Versión | Fecha | Cambio | Clase | Pedido |
|---|---|---|---|---|
| 0.1.0 | 2026-10-12 | Propuesta inicial | additive | Probar `api-refiner` sobre API-ANL-001 |
| 0.2.0 | 2026-10-12 | Se añaden 3 lecturas: `GET /v1/enrolamientos`, `GET /v1/evidencias`, `GET /v1/colaboradores/{id}/certificaciones`; H-01 decidida | additive | Necesidad del BFF (API-PRP-006); registro de la decisión H-01 |
| 0.3.0 | 2026-10-13 | Consume CON-14; se define la lectura por rol de valoraciones y certificaciones | additive | D-UX-2 y D-UX-3 (UXR-001 §7) |

## 15. Siguiente acción
Decidir H-01, H-02 y H-05. Luego `api-designer` redacta el OpenAPI. Conviene dividir los contratos por módulo (CTX-04 y CTX-05) aunque sea un solo servicio.
