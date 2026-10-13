---
type: ASR Candidate
title: "ASR-14 — Se tratan datos personales (nombres, apellidos, correo, teléfono, dirección, evaluación de"
description: "Se tratan datos personales (nombres, apellidos, correo, teléfono, dirección, evaluación del colaborador). La política de datos personales está pendiente"
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

# ASR-14 — Se tratan datos personales (nombres, apellidos, correo, teléfono, dirección, evaluación de

- **Tipo:** Candidato a ASR
- **Requisito de origen:** Se tratan datos personales (nombres, apellidos, correo, teléfono, dirección, evaluación del colaborador). La política de datos personales está pendiente
- **Quality Concern:** Privacidad y cumplimiento
- **Human Disposition:** PENDIENTE. El arquitecto la clasifica como `CANDIDATE`, `REJECT` o `INVESTIGATE`. Este documento no aprueba el ASR.

## Why Architecture-Significant?

Condiciona las decisiones de arquitectura ADR-P4 y el atributo de calidad «Privacidad y cumplimiento». Si el requisito cambia, esas decisiones cambian.

## Impact Evidence

BR-003, G-12, BR-070, BR-087. Las decisiones D-xx están en el pack [RCP-001](../../requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md) y las reglas BR-xxx en [BRC-001](../../business/rules/BRC-001-reglas-de-negocio-portal-curricula.md).

## Evidence IDs

BR-003, BR-070, BR-087, G-12

## Evidence Classification

UNKNOWN: ver Missing Evidence. Detalle de la evidencia: Parcial: falta la política (G-12)

## Confidence

Media

## Missing Evidence

- Política de datos personales y retención de esos datos. G-12

## ADR relacionados

[ADR-P4](../adr/ADR-P4-tratamiento-de-datos-personales.md)

## Preparación

- **Estado:** `draft`. Pendiente de la disposición humana del arquitecto.
- **Catálogo:** [asr-catalog](asr-catalog.md).
