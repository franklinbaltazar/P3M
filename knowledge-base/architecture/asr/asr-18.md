---
type: ASR Candidate
title: "ASR-18 — La integración entre el BFF y los microservicios usa un protocolo para el consumo seguro,"
description: "La integración entre el BFF y los microservicios usa un protocolo para el consumo seguro, sin token JWT"
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

# ASR-18 — La integración entre el BFF y los microservicios usa un protocolo para el consumo seguro,

- **Tipo:** Candidato a ASR
- **Requisito de origen:** La integración entre el BFF y los microservicios usa un protocolo para el consumo seguro, sin token JWT
- **Quality Concern:** Seguridad
- **Human Disposition:** PENDIENTE. El arquitecto la clasifica como `CANDIDATE`, `REJECT` o `INVESTIGATE`. Este documento no aprueba el ASR.

## Why Architecture-Significant?

Condiciona las decisiones de arquitectura ADR-13 y el atributo de calidad «Seguridad». Si el requisito cambia, esas decisiones cambian.

## Impact Evidence

D-120, D-122. Las decisiones D-xx están en el pack [RCP-001](../../requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md) y las reglas BR-xxx en [BRC-001](../../business/rules/BRC-001-reglas-de-negocio-portal-curricula.md).

## Evidence IDs

D-120, D-122

## Evidence Classification

FACT: declaración del responsable o estándar, sin validar por un arquitecto. Detalle de la evidencia: Decisión humana. La fuente no nombra el protocolo

## Confidence

Media

## Missing Evidence

- Nombre del protocolo de consumo seguro entre el BFF y los microservicios. Sin respuesta (ADR-P9)

## ADR relacionados

[ADR-13](../adr/ADR-13-protocolo-de-consumo-seguro-entre-el-bff-y-lo.md)

## Preparación

- **Estado:** `draft`. Pendiente de la disposición humana del arquitecto.
- **Catálogo:** [asr-catalog](asr-catalog.md).
