---
type: API Proposal
title: "API-PRP-001 — API de Partes e Identidad"
description: "Microservicio que aloja CTX-01 (partes y organización) y CTX-02 (identidad de acceso): personas, organizaciones, contactos, roles, relaciones, plazas, ocupaciones y vínculo usuario–persona."
tags: [api, microservice, ctx-01, ctx-02]
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
  - id: adr-p5-anexo
    resource: /architecture/adr/ADR-P5-anexo-mapa-rol-permiso-propuesta.md
---

# API-PRP-001 — API de Partes e Identidad

> **Estado:** `draft`, `REQUIRES_REVIEW`. Sin revisión humana. Lo inferido va marcado **(I)**.

## 1. Identidad
| Campo | Valor |
|---|---|
| ID | API-PRP-001 |
| Servicio | `svc-partes-identidad` |
| Contextos alojados (módulos) | CTX-01 Partes y organización, CTX-02 Identidad de acceso |
| Propietario de datos | Esquemas `p3m_partes` y `p3m_identidad` (siguen separados) |
| Propietario funcional | Jefe de Ingeniería (D-H6 de DDM-001) |
| Modo | propose |
| Versión de la propuesta | 0.1.0 |

## 2. Propósito y alcance
Mantener las partes (personas y organizaciones), sus datos de contacto, roles, relaciones, plazas y ocupaciones, y vincular al usuario de Keycloak con su persona al iniciar sesión. **Fuera:** roles de usuario (viven en Keycloak, ADR-11), login y sesión (BFF).

## 3. Agrupación recomendada
| Decisión | Criterio | Evidencia | Alternativa descartada y costo |
|---|---|---|---|
| Fusionar CTX-01 y CTX-02 | G-3, G-4 | CON-13 existe solo para vincular usuario y persona, con un único consumidor (CTX-02); `usuario.persona_ref` | Servicio aparte para CTX-02: un contrato HTTP más (CON-13) con una API de identidad muy pequeña y llamada solo en el primer login |

Estado de la decisión: **decidida por ianache (responsable funcional), 2026-10-12, sin revisión de un arquitecto** (H-01 de API-ANL-001). Las reglas de agrupación se cumplen: esquemas y puertos separados, sin claves foráneas entre módulos.

## 4. Recursos y operaciones (F1)
| Recurso | Operaciones | Historia | Actor | Tipo | Fuente |
|---|---|---|---|---|---|
| `/v1/personas` | `POST`, `GET`, `GET /{id}`, `PATCH /{id}` | US-004, US-005 | Escribir: JI, ADM. Leer: AUT | R | API-ANL-001 §3.1; BR-003 (ver H-06) |
| `/v1/organizaciones` | `POST`, `GET`, `GET /{id}`, `PATCH /{id}` | US-035 | JI, ADM | R | §3.1; BR-135 |
| `/v1/partes/{id}/contactos` | `POST`, `GET`, `PATCH /{cid}`, `POST /{cid}/baja` | US-029 | JI, ADM | R | §3.1; BR-133, K-44 |
| `/v1/personas/{id}/roles` | `POST`, `GET`, `POST /{rid}/finalizar` | US-032 | JI, ADM | R | §3.1 |
| `/v1/relaciones` | `POST`, `GET`, `POST /{id}/finalizar` | US-034 | JI, ADM | R | §3.1; INV-03, INV-04 |
| `/v1/plazas` | `POST`, `GET`, `GET /{id}` | US-030 | JI, ADM | R | §3.1 |
| `/v1/plazas/{id}/rol-nivel` | `GET` (historial) | US-030 | JI, ADM, AUT **(I)** | R | §3.1; INV-27. El cambio lo aplica EVT-01, no es un `POST` público |
| `/v1/plazas/{id}/ocupaciones` | `POST`, `GET`, `POST /{oid}/finalizar` | US-031 | JI, ADM | R | §3.1; INV-05, INV-06 |
| `/internal/v1/usuarios/registro-al-iniciar-sesion` | `POST` | US-025 | BFF (máquina) con token del usuario | — | §3.2; idempotente por `keycloak_guid`; INV-08 |
| `/v1/usuarios/{id}/vinculo` | `PUT` (corrección) | US-033 | JI, ADM | R | §3.2; K-45, registra quién y cuándo |
| `/v1/usuarios/{id}` | `GET` | US-033 **(I)** | JI, ADM | R | §3.2 |
| `/v1/usuarios` | `GET` (filtro `keycloak_guid`) | US-025 **(I)** | BFF con el token del usuario | R | Propuesto por API-PRP-006 (`/api/v1/me`); additive |

Regla: sin `DELETE`; el fin de vigencia es `/finalizar` o `/baja` (A-04).

## 5. Contratos internos
### Sirve
| ID | Consulta | Consumidores | Entrada → respuesta | Para qué |
|---|---|---|---|---|
| CON-01 | `PersonaConRolVigente` | API-PRP-003, API-PRP-004 | `persona_ref`, `tipo_rol`, `fecha` → `{existe, rol_vigente}` | K-09; evaluador y colaborador válidos |
| CON-02 | `RolNivelVigenteDePersona` | API-PRP-003 | `persona_ref`, `fecha` → `{rol_nivel_ref \| null}` | Siguiente rol/nivel en la promoción (BR-031) |

### Consume
| ID | Proveedor | Cuándo se llama | Si falla |
|---|---|---|---|
| CON-03 | API-PRP-002 | Al abrir la plaza o cambiar su rol/nivel | Rechazo `503`, sin escritura parcial (ICP-001 §6) |

### Puertos internos (sin HTTP)
| ID | Entre | Nota |
|---|---|---|
| CON-13 `PersonaPorCorreo` | CTX-02 → CTX-01 | Conserva el contrato lógico: respuesta mínima, mismo mensaje de rechazo, límite de uso por llamante, vínculo inmutable (K-45) |

## 6. Eventos y ACL
| ID | Tipo | Dirección | Consistencia |
|---|---|---|---|
| EVT-01 `PromocionDeNivelDecidida` v1 | Evento | **Consume** (publica API-PRP-003) | Cola duradera, al menos una vez; idempotente por `promocion_ref`; descarta obsoletos por `decidida_en` (K-46); DLQ con alerta |
| ACL-01 | ACL Keycloak → CTX-02 | Entrada en cada login | Rechaza sin `sub`; correo o roles ausentes se aceptan sin registrarlos (US-025-Q1 abierta) |

## 7. Invariantes que protege
| ID | Invariante | Mecanismo | Origen |
|---|---|---|---|
| INV-01, INV-02 | Parte persona u organización; correo y teléfono obligatorios | A | BR-070 |
| INV-03, INV-04 | Un «reporta a» y una membresía vigentes | P | BR-071, BR-076 |
| INV-05, INV-06 | Una ocupación vigente por persona y por plaza | P | BR-047, D-H4 |
| INV-07 | Historiales con vigencia | A | BR-079 |
| INV-08 | Todo colaborador tiene usuario | E | BR-077, D-H5 |
| INV-27 | Rol/nivel vigente único de la plaza, con historial | A | D-H12 |
| INV-26 | Retención de datos personales | A (política) | D-H1; ADR-P4 incompleto |

## 8. Seguridad
| Aspecto | Propuesta | Fuente |
|---|---|---|
| Autenticación entre servicios | JWT de máquina (Client Credentials) y reenvío del token del usuario | ADR-P9, ADR-P5 P5-D1 |
| Autorización | Rol del token más condición del recurso; el servicio es la fuente de verdad | ADR-P5 |
| Datos expuestos | Los contratos internos devuelven solo identificadores y booleanos; ningún dato personal cruza un servicio | ICP-001 P-5 |
| Datos personales | BR-003 permite a AUT leer personas; riesgo aceptado dentro de DT-01 | ADR-P5 P5-D3 |
| Secretos | Credenciales de Keycloak en Vault | ADR-12 |

## 9. Fallos, idempotencia y concurrencia
| Situación | Comportamiento propuesto |
|---|---|
| CTX-03 no disponible | Se rechaza el comando de plaza con `503` |
| Reintento de un alta | `Idempotency-Key` **(I)** |
| Choque de edición | `ETag` y `If-Match`, `409` **(I)** |
| Registro al iniciar sesión repetido | Idempotente por `keycloak_guid` |
| EVT-01 duplicado o fuera de orden | Ver §6 |

## 10. Observabilidad
Identificador de correlación entre BFF y servicios; métricas de EVT-01 (lag, DLQ, obsoletos descartados) y de primeros logins rechazados; los logs no contienen datos personales (ICP-001 §5). **(I)**

## 11. Pruebas de contrato
| Tipo | Qué verifica | Dueño |
|---|---|---|
| Proveedor | OpenAPI de `/v1` y de CON-01 y CON-02; AsyncAPI del consumo de EVT-01 | Equipo de desarrollo |
| Consumidor | Llamadas a CON-03 contra el contrato de API-PRP-002 | Equipo de desarrollo |
| Negativas | Un solo «reporta a» vigente; correo duplicado; vínculo inmutable; rechazo sin revelar si el correo existe | QA |

## 12. Trazabilidad
| Historia | Recurso o contrato | Contexto |
|---|---|---|
| US-004, US-005 | `/v1/personas` | CTX-01 |
| US-025 | `/internal/v1/usuarios/registro-al-iniciar-sesion` | CTX-02 |
| US-029 | `/v1/partes/{id}/contactos` | CTX-01 |
| US-030, US-031 | `/v1/plazas`, `/ocupaciones` | CTX-01 |
| US-032 | `/v1/personas/{id}/roles` | CTX-01 |
| US-033 | `/v1/usuarios/{id}/vinculo` | CTX-02 |
| US-034 | `/v1/relaciones` | CTX-01 |
| US-035 | `/v1/organizaciones` | CTX-01 |

## 13. Riesgos y preguntas abiertas
| ID | Pregunta o riesgo | Severidad | Dueño | Impacto |
|---|---|---|---|---|
| H-01 | Agrupación decidida por el responsable; falta la revisión de un arquitecto | Media | Arquitectura | Cambia el número de servicios |
| H-06 | BR-003 expone datos personales a AUT | Media | Seguridad | `GET /v1/personas` |
| H-07 | Tiempos de espera y límite de uso de CON-13 sin definir | Media | Infraestructura | Fallos |
| H-11 | US-025-Q1: Keycloak sin correo o roles | Baja | Responsable funcional | ACL-01 |

## 14. Historial de refinamiento
| Versión | Fecha | Cambio | Clase | Pedido |
|---|---|---|---|---|
| 0.1.0 | 2026-10-12 | Propuesta inicial | additive | Probar `api-refiner` sobre API-ANL-001 |
| 0.2.0 | 2026-10-12 | Se añade `GET /v1/usuarios` con filtro `keycloak_guid`; H-01 decidida | additive | Necesidad del BFF (API-PRP-006); registro de la decisión H-01 |

## 15. Siguiente acción
Decidir H-01. Luego `api-designer` redacta el OpenAPI de `/v1` y de CON-01, CON-02, y el AsyncAPI de EVT-01 (consumo).
