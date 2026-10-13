---
type: ASR Candidate
title: "ASR-07 — Si GitLab no responde, el portal muestra «datos al <fecha y hora de la última carga exitos"
description: "Si GitLab no responde, el portal muestra «datos al <fecha y hora de la última carga exitosa>» en UTC-05"
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

# ASR-07 — Si GitLab no responde, el portal muestra «datos al <fecha y hora de la última carga exitos

- **Tipo:** Candidato a ASR
- **Requisito de origen:** Si GitLab no responde, el portal muestra «datos al <fecha y hora de la última carga exitosa>» en UTC-05
- **Quality Concern:** Degradación controlada
- **Human Disposition:** PENDIENTE. El arquitecto la clasifica como `CANDIDATE`, `REJECT` o `INVESTIGATE`. Este documento no aprueba el ASR.

## Why Architecture-Significant?

Condiciona las decisiones de arquitectura ADR-08, ADR-09 y el atributo de calidad «Degradación controlada». Si el requisito cambia, esas decisiones cambian.

## Impact Evidence

BR-092, D-112. Las decisiones D-xx están en el pack [RCP-001](../../requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md) y las reglas BR-xxx en [BRC-001](../../business/rules/BRC-001-reglas-de-negocio-portal-curricula.md).

## Evidence IDs

BR-092, D-112

## Evidence Classification

FACT: declaración del responsable o estándar, sin validar por un arquitecto. Detalle de la evidencia: Decisión humana, alta

## Confidence

Alta

## Missing Evidence

- Objetivos de disponibilidad y de recuperación (RTO y RPO). Sin respuesta

## ADR relacionados

[ADR-08](../adr/ADR-08-carga-programada-de-gitlab-de-solo-lectura-co.md), [ADR-09](../adr/ADR-09-reintentos-con-esperas-incrementales-y-circui.md)

## Preparación

- **Estado:** `draft`. Pendiente de la disposición humana del arquitecto.
- **Catálogo:** [asr-catalog](asr-catalog.md).
