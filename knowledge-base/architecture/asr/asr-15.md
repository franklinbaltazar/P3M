---
type: ASR Candidate
title: "ASR-15 — La interfaz cumple WCAG 2.2 AA"
description: "La interfaz cumple WCAG 2.2 AA"
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

# ASR-15 — La interfaz cumple WCAG 2.2 AA

- **Tipo:** NFR (estándar del repositorio)
- **Requisito de origen:** La interfaz cumple WCAG 2.2 AA
- **Quality Concern:** Accesibilidad
- **Human Disposition:** PENDIENTE. El arquitecto la clasifica como `CANDIDATE`, `REJECT` o `INVESTIGATE`. Este documento no aprueba el ASR.

## Why Architecture-Significant?

Condiciona las decisiones de arquitectura ADR-04 y el atributo de calidad «Accesibilidad». Si el requisito cambia, esas decisiones cambian.

## Impact Evidence

Estándar del repositorio, citado en todas las historias. Las decisiones D-xx están en el pack [RCP-001](../../requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md) y las reglas BR-xxx en [BRC-001](../../business/rules/BRC-001-reglas-de-negocio-portal-curricula.md).

## Evidence IDs

Estándar del repositorio, sin ID de decisión

## Evidence Classification

FACT: declaración del responsable o estándar, sin validar por un arquitecto. Detalle de la evidencia: Estándar del repositorio, no decisión del proyecto

## Confidence

Media

## Missing Evidence

- Ninguno identificado.

## ADR relacionados

[ADR-04](../adr/ADR-04-micro-ui-y-catalogo-de-componentes-con-atomic.md)

## Preparación

- **Estado:** `draft`. Pendiente de la disposición humana del arquitecto.
- **Catálogo:** [asr-catalog](asr-catalog.md).
