---
type: ASR Candidate
title: "ASR-06 — Una carga fallida se reintenta 3 veces con esperas incrementales y un circuit breaker evit"
description: "Una carga fallida se reintenta 3 veces con esperas incrementales y un circuit breaker evita saturar a GitLab. Los parámetros del anexo B del pack son una propuesta según buenas prá"
tags: [architecture, asr]
status: draft
generated:
  by: "claude-code (renombrado según el skill asr-discovery)"
  at: "2026-10-11T15:00:00-05:00"
sources:
  - id: rcp-001
    resource: /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md
  - id: brc-001
    resource: /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md
  - id: cat-adr-001
    resource: /architecture/CAT-ADR-001-decisiones-de-arquitectura.md
---

# ASR-06 — Una carga fallida se reintenta 3 veces con esperas incrementales y un circuit breaker evit

- **Tipo:** Candidato a ASR
- **Requisito de origen:** Una carga fallida se reintenta 3 veces con esperas incrementales y un circuit breaker evita saturar a GitLab. Los parámetros del anexo B del pack son una propuesta según buenas prácticas
- **Quality Concern:** Disponibilidad y resiliencia
- **Human Disposition:** PENDIENTE. El arquitecto la clasifica como `CANDIDATE`, `REJECT` o `INVESTIGATE`. Este documento no aprueba el ASR.

## Why Architecture-Significant?

Condiciona las decisiones de arquitectura ADR-09 y el atributo de calidad «Disponibilidad y resiliencia». Si el requisito cambia, esas decisiones cambian.

## Impact Evidence

BR-082, D-100, D-111. Las decisiones D-xx están en el pack [RCP-001](../../requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md) y las reglas BR-xxx en [BRC-001](../../business/rules/BRC-001-reglas-de-negocio-portal-curricula.md).

## Evidence IDs

BR-082, D-100, D-111

## Evidence Classification

FACT: declaración del responsable o estándar, sin validar por un arquitecto; ASSUMPTION: hay valores propuestos sin confirmar. Detalle de la evidencia: Decisión humana para el patrón; parámetros propuestos, sin confirmar

## Confidence

Media

## Missing Evidence

- Objetivos de disponibilidad y de recuperación (RTO y RPO). Sin respuesta

## ADR relacionados

[ADR-09](../adr/ADR-09-reintentos-con-esperas-incrementales-y-circui.md)

## Preparación

- **Estado:** `draft`. Pendiente de la disposición humana del arquitecto.
- **Catálogo:** [asr-catalog](asr-catalog.md).
