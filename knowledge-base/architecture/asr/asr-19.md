---
type: ASR Candidate
title: "ASR-19 — Los microservicios deben poder ser consumidos de forma segura por otras aplicaciones, adem"
description: "Los microservicios deben poder ser consumidos de forma segura por otras aplicaciones, además del Portal, a través de un API Gateway (Kong o KrakenD, variante OSS) integrado con Key"
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

# ASR-19 — Los microservicios deben poder ser consumidos de forma segura por otras aplicaciones, adem

- **Tipo:** Candidato a ASR
- **Requisito de origen:** Los microservicios deben poder ser consumidos de forma segura por otras aplicaciones, además del Portal, a través de un API Gateway (Kong o KrakenD, variante OSS) integrado con Keycloak, que entrega un token JWT
- **Quality Concern:** Interoperabilidad y seguridad
- **Human Disposition:** PENDIENTE. El arquitecto la clasifica como `CANDIDATE`, `REJECT` o `INVESTIGATE`. Este documento no aprueba el ASR.

## Why Architecture-Significant?

Condiciona las decisiones de arquitectura ADR-14 y el atributo de calidad «Interoperabilidad y seguridad». Si el requisito cambia, esas decisiones cambian.

## Impact Evidence

D-121, D-123. Las decisiones D-xx están en el pack [RCP-001](../../requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md) y las reglas BR-xxx en [BRC-001](../../business/rules/BRC-001-reglas-de-negocio-portal-curricula.md).

## Evidence IDs

D-121, D-123

## Evidence Classification

FACT: declaración del responsable o estándar, sin validar por un arquitecto; UNKNOWN: ver Missing Evidence. Detalle de la evidencia: Decisión humana. No se eligió el producto (ver EVA-001) ni se identificó a los consumidores

## Confidence

Media

## Missing Evidence

- Qué aplicaciones y terceros consumirán las API, con qué límites de uso. Sin respuesta (ADR-P10)

## ADR relacionados

[ADR-14](../adr/ADR-14-api-gateway-oss-integrado-con-keycloak-para-c.md)

## Preparación

- **Estado:** `draft`. Pendiente de la disposición humana del arquitecto.
- **Catálogo:** [asr-catalog](asr-catalog.md).
