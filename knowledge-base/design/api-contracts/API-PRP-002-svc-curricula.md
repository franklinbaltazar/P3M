---
type: API Proposal
title: "API-PRP-002 — API de Currícula"
description: "Microservicio que aloja CTX-03: catálogo de roles, competencias, perfiles, niveles mínimos y seniorities. Upstream estable consumido por casi todos los demás servicios."
tags: [api, microservice, ctx-03]
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
---

# API-PRP-002 — API de Currícula

> **Estado:** `draft`, `REQUIRES_REVIEW`. Sin revisión humana. Lo inferido va marcado **(I)**.

## 1. Identidad
| Campo | Valor |
|---|---|
| ID | API-PRP-002 |
| Servicio | `svc-curricula` |
| Contextos alojados (módulos) | CTX-03 Currícula |
| Propietario de datos | Esquema `p3m_curricula` |
| Propietario funcional | Jefe de Ingeniería (BR-055) |
| Modo | propose |
| Versión de la propuesta | 0.1.0 |

## 2. Propósito y alcance
Mantener roles, competencias, perfiles de competencias, niveles mínimos por rol/nivel y los seniorities L1 a L4. Responder a los demás servicios si un rol/nivel o una competencia existe y cuáles son los niveles mínimos. **Fuera:** cursos y su formación (API-PRP-003).

## 3. Agrupación recomendada
| Decisión | Criterio | Evidencia | Alternativa descartada y costo |
|---|---|---|---|
| Servicio propio para CTX-03 | S-6, S-4 | Upstream de CTX-01, 04, 05 y 06 (CON-03, 04, 05); lectura intensiva; no consume a nadie | Fusionarlo con otro servicio: acopla el ritmo de cambio del catálogo con el de un dominio transaccional |

Estado de la decisión: **decidida por ianache (responsable funcional), 2026-10-12, sin revisión de un arquitecto** (H-01). Es la separación más sólida de la propuesta: no tiene dependencias salientes.

## 4. Recursos y operaciones (F1)
| Recurso | Operaciones | Historia | Actor | Tipo | Fuente |
|---|---|---|---|---|---|
| `/v1/roles` | `POST`, `GET`, `GET /{id}`, `PATCH /{id}` | US-001 | JI, ADM | R | API-ANL-001 §3.3; BR-001 |
| `/v1/competencias` | `POST`, `GET`, `GET /{id}`, `PATCH /{id}` | US-002 **(I)** | JI, ADM | R | §3.3; DDM-001 `DefinirCompetencia`; ver H-04 |
| `/v1/roles/{id}/perfil` | `PUT`, `GET` | US-002 | JI, ADM | R | §3.3; BR-055, BR-134 |
| `/v1/roles/{id}/niveles/{nivel}/niveles-minimos` | `PUT`, `GET` | US-003 | JI, ADM | R | §3.3; INV-11 |
| `/v1/roles/{id}/niveles/{nivel}/siguiente` | `GET` | US-017 **(I)** | JI, ADM | R | **Propuesto (D-UX-2, 2026-10-13):** se deriva de BR-031; Senior L4 no tiene siguiente; additive |
| `/v1/seniorities` | `GET` | **(I)** | AUT | R | §3.3; L1 a L4 sembrados |

## 5. Contratos internos
### Sirve
| ID | Consulta | Consumidores | Entrada → respuesta | Para qué |
|---|---|---|---|---|
| CON-03 | `RolNivelExiste` | API-PRP-001, API-PRP-003, API-PRP-004 | `rol_nivel_ref` → `{existe}` | `plaza_rol_nivel`, destino de promoción, requeridos, asignación |
| CON-04 | `NivelesMinimosDeRolNivel` | API-PRP-004 | `rol_nivel_ref` → lista `{competencia_ref, nivel_minimo}` | Nivel mínimo al asignar (BR-041) |
| CON-05 | `CompetenciaExiste` | API-PRP-003 | `competencia_ref` → `{existe}` | Objetivos de curso, valoraciones |
| CON-14 (propuesto) | `SiguienteRolNivel` | API-PRP-003 | `rol_nivel_ref` → `{siguiente_rol_nivel_ref \| null, motivo}` | Validar el destino de la promoción (BR-031, US-017). **Contrato nuevo**: ICP-001 no lo recoge y hay que actualizarlo |

### Consume
Ninguno.

### Puertos internos
Ninguno.

## 6. Eventos y ACL
Ninguno. Hoy no hay evento que salga de CTX-03 (`CurrículaActualizada` figura en DDM-001 §5 sin consumidor definido **(I)**).

## 7. Invariantes que protege
| ID | Invariante | Mecanismo | Origen |
|---|---|---|---|
| INV-09 | Competencia con código, nombre, tipo único y definición de cada nivel | A | BR-056, BR-060 |
| INV-10 | Un seniority contiene L1 a L4 | A | BR-011 |
| INV-11 | Un rol/nivel exige un nivel mínimo por cada competencia de su perfil | A | BR-014 |

## 8. Seguridad
| Aspecto | Propuesta | Fuente |
|---|---|---|
| Autenticación entre servicios | JWT de máquina y token del usuario; un *scope* por contrato (por ejemplo `ctx03.rol-nivel.read`) | ADR-P9, ICP-001 §5 |
| Autorización | Rol del token (solo JI y ADM escriben) | ADR-P5 |
| Datos expuestos | Sin datos personales | — |

## 9. Fallos, idempotencia y concurrencia
| Situación | Comportamiento propuesto |
|---|---|
| Consulta CON-03/04/05 | Idempotente y de solo lectura; los consumidores reintentan con esperas incrementales |
| Edición del perfil o de un nivel mínimo | `ETag` y `If-Match`, `409` **(I)** |
| Cambio del catálogo mientras otros lo consultan | Las respuestas negativas se rechazan con motivo de negocio; una referencia validada sigue existiendo (ICP-001 P-3) |

## 10. Observabilidad
Identificador de correlación; latencia y tasa de error por contrato (CON-03, 04, 05), por ser el servicio más consultado. **(I)**

## 11. Pruebas de contrato
| Tipo | Qué verifica | Dueño |
|---|---|---|
| Proveedor | OpenAPI de `/v1`, CON-03, CON-04 y CON-05 | Equipo de desarrollo |
| Consumidor | Los tres consumidores (API-PRP-001, 003, 004) contra el contrato | Equipo de desarrollo |
| Negativas | Nivel mínimo faltante para una competencia del perfil; rol no autorizado | QA |

## 12. Trazabilidad
| Historia | Recurso o contrato | Contexto |
|---|---|---|
| US-001 | `/v1/roles` | CTX-03 |
| US-002 | `/v1/competencias`, `/v1/roles/{id}/perfil` | CTX-03 |
| US-003 | `…/niveles-minimos` | CTX-03 |
| US-017 | `…/siguiente`, CON-14 | CTX-03 |

## 13. Riesgos y preguntas abiertas
| ID | Pregunta o riesgo | Severidad | Dueño | Impacto |
|---|---|---|---|---|
| H-01 | Agrupación decidida por el responsable; falta la revisión de un arquitecto | Media | Arquitectura | Número de servicios |
| H-04 | US-002 no dice quién da de alta las competencias | Media | Análisis funcional | `/v1/competencias` |
| H-07 | Tiempos de espera y reintentos sin definir | Media | Infraestructura | Disponibilidad de un upstream crítico |
| D-UX-2 | BR-031 no dice qué pasa desde Senior L4: hoy no tiene siguiente y la promoción queda bloqueada con ese motivo | Media | Responsable funcional | CON-14, US-017 |

## 14. Historial de refinamiento
| Versión | Fecha | Cambio | Clase | Pedido |
|---|---|---|---|---|
| 0.1.0 | 2026-10-12 | Propuesta inicial | additive | Probar `api-refiner` sobre API-ANL-001 |
| 0.2.0 | 2026-10-13 | Se añaden `GET …/siguiente` y CON-14 `SiguienteRolNivel` | additive | D-UX-2 (UXR-001 §7) |

## 15. Siguiente acción
Decidir H-01 y H-04. Luego `api-designer` redacta el OpenAPI. Es buen candidato para el primer contrato (Ola 1 y 2 de DSP-001: US-001, US-002).
