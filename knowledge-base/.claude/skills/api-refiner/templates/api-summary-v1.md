---
type: API Proposal Summary
title: "API-PRP-000 — Resumen de APIs recomendadas"
description: "Mapa de las APIs (microservicios) recomendadas a partir de {{analysis_id}}, con su matriz de dependencias, cobertura, alternativas y decisiones pendientes."
tags: [api, microservice, summary]
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
---

# API-PRP-000 — Resumen de APIs recomendadas

## 1. Mapa de APIs
| ID | Servicio | Contextos | Propietario de datos | Justificación (criterios) |
|---|---|---|---|---|
| [API-PRP-{{nnn}}]({{archivo}}) | `{{svc}}` | {{CTX}} | {{esquemas}} | {{S-n, G-n}} |

## 2. Matriz de dependencias síncronas
| Consumidor ↓ / Proveedor → | {{API-PRP-nnn}} | {{...}} |
|---|---|---|

Dependencias circulares y su justificación: {{...}}

## 3. Cobertura
| Elemento del análisis | Total | Asignados | Huérfanos |
|---|---|---|---|
| Recursos F1 | {{n}} | {{n}} | {{0}} |
| Contratos CON | {{n}} | {{n}} | {{0}} |
| Eventos y ACL | {{n}} | {{n}} | {{0}} |
| Historias | {{n}} | {{n}} | {{0}} |

## 4. Alternativas evaluadas
| Opción | Servicios | Ventajas | Costos | Estado |
|---|---|---|---|---|

## 5. Decisiones pendientes
| ID | Decisión | Dueño | Bloquea |
|---|---|---|---|

## 6. Hallazgos del análisis que afectan a la propuesta
| Hallazgo | Severidad | Tratamiento |
|---|---|---|

## 7. Historial de refinamiento
| Versión | Fecha | Cambio | Clase | Pedido |
|---|---|---|---|---|

## 8. Siguiente acción
{{...}}
