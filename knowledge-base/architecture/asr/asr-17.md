---
type: ASR Candidate
title: "ASR-17 — Los parámetros y los datos sensibles se mantienen en HashiCorp Vault, bajo `secret/p3m/*`:"
description: "Los parámetros y los datos sensibles se mantienen en HashiCorp Vault, bajo `secret/p3m/*`: credenciales de MySQL, usuario y contraseña de Redis, PAT de GitLab y URL base de GitLab"
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

# ASR-17 — Los parámetros y los datos sensibles se mantienen en HashiCorp Vault, bajo `secret/p3m/*`:

- **Tipo:** Candidato a ASR
- **Requisito de origen:** Los parámetros y los datos sensibles se mantienen en HashiCorp Vault, bajo `secret/p3m/*`: credenciales de MySQL, usuario y contraseña de Redis, PAT de GitLab y URL base de GitLab
- **Quality Concern:** Seguridad
- **Human Disposition:** PENDIENTE. El arquitecto la clasifica como `CANDIDATE`, `REJECT` o `INVESTIGATE`. Este documento no aprueba el ASR.

## Why Architecture-Significant?

Condiciona las decisiones de arquitectura ADR-12 y el atributo de calidad «Seguridad». Si el requisito cambia, esas decisiones cambian.

## Impact Evidence

D-119, D-124. Las decisiones D-xx están en el pack [RCP-001](../../requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md) y las reglas BR-xxx en [BRC-001](../../business/rules/BRC-001-reglas-de-negocio-portal-curricula.md).

## Evidence IDs

D-119, D-124

## Evidence Classification

FACT: declaración del responsable o estándar, sin validar por un arquitecto; UNKNOWN: ver Missing Evidence. Detalle de la evidencia: Decisión humana, alta. Faltan la rotación y cómo se autentica cada componente en Vault

## Confidence

Alta

## Missing Evidence

- Rotación de secretos y cómo se autentica cada componente en Vault. Sin respuesta (ADR-P11)

## ADR relacionados

[ADR-12](../adr/ADR-12-secretos-y-parametros-en-hashicorp-vault.md)

## Preparación

- **Estado:** `draft`. Pendiente de la disposición humana del arquitecto.
- **Catálogo:** [asr-catalog](asr-catalog.md).
