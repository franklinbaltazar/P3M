---
type: ASR Candidate
title: "ASR-10 — Restricciones que el sistema debe garantizar: suma de dedicación ≤ 100 %, un milestone en"
description: "Restricciones que el sistema debe garantizar: suma de dedicación ≤ 100 %, un milestone en un único proyecto, una sola membresía vigente y un solo jefe por colaborador, evaluación o"
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

# ASR-10 — Restricciones que el sistema debe garantizar: suma de dedicación ≤ 100 %, un milestone en

- **Tipo:** Candidato a ASR
- **Requisito de origen:** Restricciones que el sistema debe garantizar: suma de dedicación ≤ 100 %, un milestone en un único proyecto, una sola membresía vigente y un solo jefe por colaborador, evaluación obligatoria para promover, evidencias solo de issues cerrados
- **Quality Concern:** Integridad de datos
- **Human Disposition:** PENDIENTE. El arquitecto la clasifica como `CANDIDATE`, `REJECT` o `INVESTIGATE`. Este documento no aprueba el ASR.

## Why Architecture-Significant?

Condiciona las decisiones de arquitectura ADR-05 y el atributo de calidad «Integridad de datos». Si el requisito cambia, esas decisiones cambian.

## Impact Evidence

BR-020, BR-071, BR-076, BR-088, BR-091, BR-093. Las decisiones D-xx están en el pack [RCP-001](../../requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md) y las reglas BR-xxx en [BRC-001](../../business/rules/BRC-001-reglas-de-negocio-portal-curricula.md).

## Evidence IDs

BR-020, BR-071, BR-076, BR-088, BR-091, BR-093

## Evidence Classification

FACT: declaración del responsable o estándar, sin validar por un arquitecto. Detalle de la evidencia: Decisión humana, alta

## Confidence

Alta

## Missing Evidence

- Ninguno identificado.

## ADR relacionados

[ADR-05](../adr/ADR-05-mysql-8-x-como-base-de-datos.md)

## Preparación

- **Estado:** `draft`. Pendiente de la disposición humana del arquitecto.
- **Catálogo:** [asr-catalog](asr-catalog.md).
