---
type: API Proposal
title: "API-PRP-{{nnn}} — {{api_name}}"
description: "{{one_sentence_purpose}}"
tags: [api, microservice, {{context_tags}}]
status: draft
gate_status: {{READY_FOR_CONTRACT | REQUIRES_REVIEW | BLOCKED}}
version: "{{semver}}"
generated:
  by: "api-refiner"
  at: "{{iso8601 con -05:00}}"
human-reviewed: false
sources:
  - id: {{analysis_id}}
    resource: {{/design/api-contracts/API-ANL-....md}}
  - id: {{other_source_id}}
    resource: {{/path}}
---

# API-PRP-{{nnn}} — {{api_name}}

> **Estado:** `draft`, `{{gate_status}}`. Sin revisión humana. Lo inferido va marcado **(I)**.

## 1. Identidad
| Campo | Valor |
|---|---|
| ID | API-PRP-{{nnn}} |
| Servicio | `{{svc-nombre}}` (un microservicio desplegable) |
| Contextos alojados (módulos) | {{CTX-xx, CTX-yy}} |
| Propietario de datos | {{esquemas}} |
| Propietario funcional | {{rol o equipo}} |
| Modo | {{propose o refine}} |
| Versión de la propuesta | {{semver}} |

## 2. Propósito y alcance
{{qué resuelve; qué queda fuera}}

## 3. Agrupación recomendada
| Decisión | Criterio (`grouping-criteria.md`) | Evidencia | Alternativa descartada y costo |
|---|---|---|---|
| {{fusión o separación}} | {{S-n / G-n}} | {{CON, INV, ADR}} | {{alternativa}} |

Estado de la decisión: {{recomendación pendiente, o decidida por <persona>, <fecha>}}.

## 4. Recursos y operaciones (F1)
| Recurso | Operaciones | Historia | Actor | Tipo (R / R+D) | Fuente |
|---|---|---|---|---|---|
| `{{/v1/...}}` | {{POST, GET, ...}} | {{US-nnn}} | {{rol}} | {{R}} | {{ID}} |

Regla: el fin de vigencia es una acción, no `DELETE`, si las reglas dicen que nada se borra.

## 5. Contratos internos
### Sirve
| ID | Consulta | Consumidores | Entrada → respuesta | Para qué |
|---|---|---|---|---|
| {{CON-nn}} | {{nombre}} | {{API-PRP-nnn}} | {{...}} | {{K, INV, BR}} |

### Consume
| ID | Proveedor | Cuándo se llama | Si falla |
|---|---|---|---|
| {{CON-nn}} | {{API-PRP-nnn}} | {{comando}} | {{rechazo 503, sin escritura parcial}} |

### Puertos internos (contratos lógicos entre módulos del mismo servicio)
| ID | Entre | Nota |
|---|---|---|
| {{CON-nn}} | {{CTX-xx → CTX-yy}} | Sin HTTP; conserva el contrato lógico |

## 6. Eventos y ACL
| ID | Tipo | Dirección | Consistencia |
|---|---|---|---|
| {{EVT-nn o ACL-nn}} | {{evento o ACL}} | {{publica o consume}} | {{outbox, idempotencia}} |

## 7. Invariantes que protege
| ID | Invariante | Mecanismo (A / P / E) | Origen |
|---|---|---|---|
| {{INV-nn}} | {{texto}} | {{A}} | {{BR, ADR}} |

## 8. Seguridad
| Aspecto | Propuesta | Fuente |
|---|---|---|
| Autenticación entre servicios | {{...}} | {{ADR}} |
| Autorización | Rol del token más condición del recurso; el servicio es la fuente de verdad | {{ADR}} |
| Datos expuestos | {{mínimos}} | {{ASR, BR}} |
| Secretos | {{Vault}} | {{ADR}} |

## 9. Fallos, idempotencia y concurrencia
| Situación | Comportamiento propuesto |
|---|---|
| Dependencia no disponible | {{...}} |
| Reintento de un comando | {{Idempotency-Key}} |
| Choque de concurrencia | {{409, ETag}} |

## 10. Observabilidad
{{correlation id, métricas, logs sin datos personales, alertas}}

## 11. Pruebas de contrato
| Tipo | Qué verifica | Dueño |
|---|---|---|
| Proveedor | {{contrato OpenAPI o AsyncAPI}} | {{equipo}} |
| Consumidor | {{consumidores listados en §5}} | {{equipo}} |
| Negativas | {{rechazos de negocio y de seguridad}} | {{QA}} |

## 12. Trazabilidad
| Historia | Recurso o contrato | Contexto |
|---|---|---|
| {{US-nnn}} | {{...}} | {{CTX-xx}} |

## 13. Riesgos y preguntas abiertas
| ID | Pregunta o riesgo | Severidad | Dueño | Impacto |
|---|---|---|---|---|

## 14. Historial de refinamiento
| Versión | Fecha | Cambio | Clase (additive / compatible / breaking / unknown) | Pedido |
|---|---|---|---|---|

## 15. Siguiente acción
{{api-designer para el contrato OpenAPI; revisores de contrato y de seguridad; decisiones que faltan}}
