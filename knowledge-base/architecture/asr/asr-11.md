---
type: ASR Candidate
title: "ASR-11 — El registro de colaboradores y sus relaciones se alinea con el Universal Data Model (UDM):"
description: "El registro de colaboradores y sus relaciones se alinea con el Universal Data Model (UDM): persona, rol, relación entre partes, mecanismos de contacto, organización"
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

# ASR-11 — El registro de colaboradores y sus relaciones se alinea con el Universal Data Model (UDM):

- **Tipo:** Candidato a ASR
- **Requisito de origen:** El registro de colaboradores y sus relaciones se alinea con el Universal Data Model (UDM): persona, rol, relación entre partes, mecanismos de contacto, organización
- **Quality Concern:** Modificabilidad e interoperabilidad de datos
- **Human Disposition:** PENDIENTE. El arquitecto la clasifica como `CANDIDATE`, `REJECT` o `INVESTIGATE`. Este documento no aprueba el ASR.

## Why Architecture-Significant?

Condiciona las decisiones de arquitectura ADR-10 y el atributo de calidad «Modificabilidad e interoperabilidad de datos». Si el requisito cambia, esas decisiones cambian.

## Impact Evidence

D-74, D-76 a D-79, D-81, D-83, D-87. Las decisiones D-xx están en el pack [RCP-001](../../requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md) y las reglas BR-xxx en [BRC-001](../../business/rules/BRC-001-reglas-de-negocio-portal-curricula.md).

## Evidence IDs

D-74, D-76, D-79, D-81, D-83, D-87

## Evidence Classification

FACT: declaración del responsable o estándar, sin validar por un arquitecto; ASSUMPTION: hay valores propuestos sin confirmar. Detalle de la evidencia: Decisión humana. La correspondencia con el UDM es propuesta del modelo (IMD-001, sección 5.1)

## Confidence

Media

## Missing Evidence

- Ninguno identificado.

## ADR relacionados

[ADR-10](../adr/ADR-10-modelo-de-personas-y-organizaciones-alineado.md)

## Preparación

- **Estado:** `draft`. Pendiente de la disposición humana del arquitecto.
- **Catálogo:** [asr-catalog](asr-catalog.md).
