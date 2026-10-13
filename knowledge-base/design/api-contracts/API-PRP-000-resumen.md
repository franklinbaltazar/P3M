---
type: API Proposal Summary
title: "API-PRP-000 — Resumen de APIs recomendadas"
description: "Mapa de las 5 APIs (microservicios) recomendadas a partir de API-ANL-001, con su matriz de dependencias, cobertura, alternativas y decisiones pendientes."
tags: [api, microservice, summary]
status: draft
gate_status: REQUIRES_REVIEW
version: "0.4.0"
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

# API-PRP-000 — Resumen de APIs recomendadas

> **Estado:** `draft`, `REQUIRES_REVIEW`. La agrupación en 5 servicios la **decidió ianache (responsable funcional) el 2026-10-12**, sin revisión de un arquitecto (H-01 de API-ANL-001). El BFF tiene su propuesta en [API-PRP-006](API-PRP-006-bff-portal.md). Sin revisión humana de los documentos.

## 1. Mapa de APIs
| ID | Servicio | Contextos | Propietario de datos | Justificación (criterios) |
|---|---|---|---|---|
| [API-PRP-001](API-PRP-001-svc-partes-identidad.md) | `svc-partes-identidad` | CTX-01 + CTX-02 | `p3m_partes`, `p3m_identidad` | G-3, G-4 |
| [API-PRP-002](API-PRP-002-svc-curricula.md) | `svc-curricula` | CTX-03 | `p3m_curricula` | S-6, S-4 |
| [API-PRP-003](API-PRP-003-svc-formacion-progresion.md) | `svc-formacion-progresion` | CTX-04 + CTX-05 | `p3m_formacion`, `p3m_progresion` | G-1, G-2, G-5 |
| [API-PRP-004](API-PRP-004-svc-portafolio.md) | `svc-portafolio` | CTX-06 | `p3m_portafolio` | S-4, G-4 |
| [API-PRP-005](API-PRP-005-svc-gitlab.md) | `svc-gitlab` | CTX-07 | `p3m_gitlab` | S-1, S-2, S-3 |
| [API-PRP-006](API-PRP-006-bff-portal.md) | `bff-portal` (no es un servicio de dominio) | Ninguno | Solo sesión y caché en Redis | ADR-01, ADR-02, ADR-03 |

Cada contexto sigue siendo un módulo con su esquema y sus puertos; no hay claves foráneas entre contextos aunque compartan servicio.

## 2. Matriz de dependencias síncronas
Contratos HTTP internos que cruzan servicios (consumidor ↓, proveedor →):

| Consumidor ↓ / Proveedor → | 001 | 002 | 003 | 004 | 005 |
|---|---|---|---|---|---|
| **001** partes-identidad | | CON-03 | | | |
| **002** curricula | | | | | |
| **003** formacion-progresion | CON-01, CON-02 | CON-03, CON-05, CON-14 | | CON-09 | CON-10 |
| **004** portafolio | CON-01 | CON-03, CON-04 | CON-07 | | CON-11 |
| **005** gitlab | | | | | |

Más el evento EVT-01: publica 003, consume 001.

**Dependencia circular síncrona:** 003 ⇄ 004 (CON-09 y CON-07). Se acepta como alerta, no como defecto: son lecturas sobre datos que cada proveedor posee, de solo lectura, y una consulta no dispara otra (ICP-001 §6). Alternativa: fusionarlos en un servicio de ~26 recursos. Salientes por servicio: 001 → 1; 003 → 4 servicios (6 contratos); 004 → 4 servicios (5 contratos). Ninguno supera el umbral de revisión.

**Puertos internos** (contrato lógico conservado, sin HTTP): CON-06, CON-08, CON-12 (dentro de 003) y CON-13 (dentro de 001). Antes: 13 contratos HTTP; ahora: 10 (incluye CON-14, propuesto).

## 3. Cobertura
| Elemento del análisis | Total | Asignados | Huérfanos |
|---|---|---|---|
| Recursos F1 | 45 del análisis, más 5 lecturas del BFF y 1 consulta de siguiente nivel | 51 (001: 12, 002: 6, 003: 19, 004: 11, 005: 3) | 0 |
| Contratos CON | 13 de ICP-001, más CON-14 propuesto | 14 (10 HTTP y 4 puertos internos) | 0 |
| Evento y ACL | 3 (EVT-01, ACL-01, ACL-02) | 3 | 0 |
| Historias | 35 | 33 en una API de dominio; US-027 y US-028 en API-PRP-006 (BFF con Keycloak); US-025 también tiene su ruta de inicio en el BFF | 0 |

Asignación de CON: 001 sirve CON-01 y CON-02 (CON-13 es puerto); 002 sirve CON-03, 04, 05; 003 sirve CON-07 (CON-06, 08, 12 son puertos); 004 sirve CON-09; 005 sirve CON-10 y CON-11. EVT-01 se publica en 003 y se consume en 001. ACL-01 va en 001 y ACL-02 en 005.

## 4. Alternativas evaluadas
| Opción | Servicios | Ventajas | Costos | Estado |
|---|---|---|---|---|
| Un servicio por contexto | 7 | Respeta ADR-P2 al pie de la letra; escalado y equipos independientes | 13 contratos HTTP; dependencia circular CTX-04 ⇄ CTX-05 y CON-13; más operación | Descartada por defecto |
| **Agrupación por criterios** | **5** | 9 contratos HTTP; sin circularidad en Formación y Progresión; aísla GitLab | Servicio de 19 recursos; exige disciplina de módulos | **Adoptada** (decisión de ianache, 2026-10-12) |
| Monolito modular más worker de GitLab | 2 | Lo más simple para un equipo pequeño | Contradice «microservicios» de ADR-P2 | Descartada |

## 5. Decisiones pendientes
| ID | Decisión | Dueño | Bloquea |
|---|---|---|---|
| ~~D-A~~ | ~~Elegir la agrupación~~ **Resuelta 2026-10-12:** 5 servicios, registrada en ADR-P2. Falta la revisión de un arquitecto | Arquitectura | — |
| D-B | Aceptar la dependencia circular 003 ⇄ 004 o fusionarlos | Arquitectura | API-PRP-003 y API-PRP-004 |
| D-C | Convenciones de §2 de API-ANL-001 (errores, paginación, idempotencia, concurrencia) como ADR | Arquitectura | Estilo de los contratos |
| D-E | **Trabajo de datos pendiente** por D-UX-1: migración Flyway en `p3m_gitlab` y ampliar ACL-02 y añadir CON-14 en ICP-001 | Datos y arquitectura | API-PRP-005, US-024, API-PRP-002 |

## 6. Hallazgos del análisis que afectan a la propuesta
| Hallazgo | Severidad | Tratamiento |
|---|---|---|
| H-01 Microservicios sin enumerar en ADR-P2 | Alta | **Resuelta** el 2026-10-12: 5 servicios, registrados en ADR-P2 |
| H-02 Sin catálogo de rutas del BFF | Alta | **Propuesta** en API-PRP-006 v0.2.0 (sesión, paso y 7 vistas compuestas), contrastada con los criterios de aceptación en UXR-001. Decididas el 2026-10-13: ampliar la réplica de GitLab, derivar el siguiente nivel de BR-031 y lectura por mínimo privilegio (UXR-001 §7). **Sigue bloqueando `READY_FOR_CONTRACT`** hasta aplicar el trabajo de datos (D-E) y completar el Design System, y por no haber diseño visual aprobado |
| H-03 Sin API de lectura de valoraciones, evidencias y certificaciones | Media | Señalada en API-PRP-003 |
| H-04 Altas de competencias sin historia clara | Media | Señalada en API-PRP-002 |
| H-05 Solicitud de promoción sin historia (RQ-18) | Media | Señalada en API-PRP-003 |
| H-06 BR-003 expone datos personales | Media | Señalada en API-PRP-001 |
| H-07 Valores operativos sin definir | Media | Señalada en cada API |
| H-08 ADR-13 desactualizado | Media | La autenticación sigue ADR-P9 y ADR-P5 P5-D1 |
| H-09 Convenciones de API sin ADR | Media | D-C |
| H-10, H-11 | Info, Baja | Registradas |

## 7. Historial de refinamiento
| Versión | Fecha | Cambio | Clase | Pedido |
|---|---|---|---|---|
| 0.1.0 | 2026-10-12 | Propuesta inicial de 5 APIs | additive | Probar `api-refiner` sobre API-ANL-001 |
| 0.2.0 | 2026-10-12 | H-01 decidida (5 servicios); se añade API-PRP-006 (BFF); 5 lecturas nuevas en 001, 003 y 004 | additive | Decisión de ianache y propuesta para H-02 |
| 0.3.0 | 2026-10-12 | API-PRP-006 pasa a 0.2.0 tras UXR-001; se registra UXQ-1 en API-PRP-005 | additive | Apoyo de `ux-requirements-analyzer` y `ui-spec-writer` |
| 0.4.0 | 2026-10-13 | Se añade CON-14 y `…/siguiente` en API-PRP-002; lectura por rol; API-PRP-005 amplía US-024; API-PRP-006 pasa a 0.3.0 | additive | Decisiones D-UX-1 a D-UX-7 |

## 8. Siguiente acción
1. Decidir D-B y D-C.
2. Hacer el trabajo de datos de D-E, completar el Design System ([DSC-001](../ux/DSC-001-cambios-al-design-system.md)) y validar las vistas con un diseño visual. Sin eso, la propuesta no pasa a `READY_FOR_CONTRACT`. Las decisiones de UX están en [UXR-001](../ux/UXR-001-vistas-del-bff.md) §7.
3. Con eso, `api-designer` redacta el OpenAPI de cada API. Orden sugerido por las olas de DSP-001: API-PRP-002 y API-PRP-005 primero (no tienen dependencias salientes).
