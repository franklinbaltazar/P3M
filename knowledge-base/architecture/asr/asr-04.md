---
type: ASR Candidate
title: "ASR-04 — La integración con GitLab es de solo lectura, con credenciales de servicio de solo lectura"
description: "La integración con GitLab es de solo lectura, con credenciales de servicio de solo lectura"
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

# ASR-04 — La integración con GitLab es de solo lectura, con credenciales de servicio de solo lectura

- **Tipo:** Candidato a ASR
- **Requisito de origen:** La integración con GitLab es de solo lectura, con credenciales de servicio de solo lectura
- **Quality Concern:** Seguridad
- **Human Disposition:** PENDIENTE. El arquitecto la clasifica como `CANDIDATE`, `REJECT` o `INVESTIGATE`. Este documento no aprueba el ASR.

## Why Architecture-Significant?

Condiciona las decisiones de arquitectura ADR-08, ADR-12 y el atributo de calidad «Seguridad». Si el requisito cambia, esas decisiones cambian.

## Impact Evidence

BR-036, BR-037, D-29, D-33. Las decisiones D-xx están en el pack [RCP-001](../../requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md) y las reglas BR-xxx en [BRC-001](../../business/rules/BRC-001-reglas-de-negocio-portal-curricula.md).

## Evidence IDs

BR-036, BR-037, D-29, D-33

## Evidence Classification

FACT: declaración del responsable o estándar, sin validar por un arquitecto; UNKNOWN: ver Missing Evidence. Detalle de la evidencia: Decisión humana. Falta cómo se otorgan las credenciales (RQ-09). El PAT y la URL base están en Vault (D-124)

## Confidence

Alta

## Missing Evidence

- Alcance de solo lectura del PAT de GitLab. Por confirmar (ADR-P11)

## ADR relacionados

[ADR-08](../adr/ADR-08-carga-programada-de-gitlab-de-solo-lectura-co.md), [ADR-12](../adr/ADR-12-secretos-y-parametros-en-hashicorp-vault.md)

## Preparación

- **Estado:** `draft`. Pendiente de la disposición humana del arquitecto.
- **Catálogo:** [asr-catalog](asr-catalog.md).
