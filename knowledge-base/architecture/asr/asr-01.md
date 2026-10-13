---
type: ASR Candidate
title: "ASR-01 — Los usuarios ingresan al portal autenticándose en Keycloak, sin comprometer datos sensible"
description: "Los usuarios ingresan al portal autenticándose en Keycloak, sin comprometer datos sensibles en el navegador (SPA Angular con BFF Next.js y PKCE)"
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

# ASR-01 — Los usuarios ingresan al portal autenticándose en Keycloak, sin comprometer datos sensible

- **Tipo:** Candidato a ASR
- **Requisito de origen:** Los usuarios ingresan al portal autenticándose en Keycloak, sin comprometer datos sensibles en el navegador (SPA Angular con BFF Next.js y PKCE)
- **Quality Concern:** Seguridad
- **Human Disposition:** PENDIENTE. El arquitecto la clasifica como `CANDIDATE`, `REJECT` o `INVESTIGATE`. Este documento no aprueba el ASR.

## Why Architecture-Significant?

Condiciona las decisiones de arquitectura ADR-01, ADR-02 y el atributo de calidad «Seguridad». Si el requisito cambia, esas decisiones cambian.

## Impact Evidence

BR-095, D-115. Las decisiones D-xx están en el pack [RCP-001](../../requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md) y las reglas BR-xxx en [BRC-001](../../business/rules/BRC-001-reglas-de-negocio-portal-curricula.md).

## Evidence IDs

BR-095, D-115

## Evidence Classification

FACT: declaración del responsable o estándar, sin validar por un arquitecto. Detalle de la evidencia: Decisión humana, alta

## Confidence

Alta

## Missing Evidence

- Ninguno identificado.

## ADR relacionados

[ADR-01](../adr/ADR-01-spa-en-angular-con-bff-en-next-js.md), [ADR-02](../adr/ADR-02-autenticacion-con-keycloak-a-traves-del-bff-c.md)

## Preparación

- **Estado:** `draft`. Pendiente de la disposición humana del arquitecto.
- **Catálogo:** [asr-catalog](asr-catalog.md).
