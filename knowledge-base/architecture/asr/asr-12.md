---
type: ASR Candidate
title: "ASR-12 — La arquitectura incluye micro UI en Angular y un catálogo de componentes de interfaz reuti"
description: "La arquitectura incluye micro UI en Angular y un catálogo de componentes de interfaz reutilizables basado en Atomic Design"
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

# ASR-12 — La arquitectura incluye micro UI en Angular y un catálogo de componentes de interfaz reuti

- **Tipo:** Restricción
- **Requisito de origen:** La arquitectura incluye micro UI en Angular y un catálogo de componentes de interfaz reutilizables basado en Atomic Design
- **Quality Concern:** Modificabilidad y reutilización de la interfaz
- **Human Disposition:** PENDIENTE. El arquitecto la clasifica como `CANDIDATE`, `REJECT` o `INVESTIGATE`. Este documento no aprueba el ASR.

## Why Architecture-Significant?

Condiciona las decisiones de arquitectura ADR-04 y el atributo de calidad «Modificabilidad y reutilización de la interfaz». Si el requisito cambia, esas decisiones cambian.

## Impact Evidence

D-117. Las decisiones D-xx están en el pack [RCP-001](../../requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md) y las reglas BR-xxx en [BRC-001](../../business/rules/BRC-001-reglas-de-negocio-portal-curricula.md).

## Evidence IDs

D-117

## Evidence Classification

FACT: declaración del responsable o estándar, sin validar por un arquitecto. Detalle de la evidencia: Decisión humana, alta

## Confidence

Alta

## Missing Evidence

- Ninguno identificado.

## ADR relacionados

[ADR-04](../adr/ADR-04-micro-ui-y-catalogo-de-componentes-con-atomic.md)

## Preparación

- **Estado:** `draft`. Pendiente de la disposición humana del arquitecto.
- **Catálogo:** [asr-catalog](asr-catalog.md).
