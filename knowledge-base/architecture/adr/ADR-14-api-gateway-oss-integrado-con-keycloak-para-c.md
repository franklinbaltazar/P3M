---
type: Architecture Decision Record
title: "ADR-14 — API Gateway OSS integrado con Keycloak para consumidores externos"
description: "Las API de los microservicios son consumibles de forma segura por otras aplicaciones, además del Portal, a través de un API Gateway OSS (Kong o KrakenD) integrado con Keycloak, que"
tags: [architecture, adr]
status: draft
generated:
  by: "claude-code (identificación manual)"
  at: "2026-10-11T13:00:00-05:00"
sources:
  - id: rcp-001
    resource: /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md
  - id: brc-001
    resource: /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md
  - id: cat-ars-001
    resource: /architecture/asr/asr-catalog.md
  - id: cat-adr-001
    resource: /architecture/CAT-ADR-001-decisiones-de-arquitectura.md
---

# ADR-14 — API Gateway OSS integrado con Keycloak para consumidores externos

## 1. Estado

Aceptada en parte: producto por elegir. Evaluación y recomendación en [EVA-001](../EVA-001-evaluacion-api-gateway.md) (ADR-P8)

## 2. Contexto

Abrir las API a otras aplicaciones de forma controlada con la identidad de Keycloak

## 3. Decisión

Las API de los microservicios son consumibles de forma segura por otras aplicaciones, además del Portal, a través de un API Gateway OSS (Kong o KrakenD) integrado con Keycloak, que entrega un token JWT

## 4. Alternativas consideradas

No constan en las fuentes. No se inventaron.

## 5. Consecuencias

Los consumidores externos no llaman directamente a los microservicios. El gateway valida el JWT. Cada aplicación se gestiona como cliente de Keycloak

## 6. Requisitos a los que responde

[ASR-19](../asr/asr-19.md), [ASR-03](../asr/asr-03.md)

## 7. Fuente

D-121, D-123. Las decisiones D-xx están en el pack [RCP-001](../../requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md). Evaluación de apoyo: [EVA-001](../EVA-001-evaluacion-api-gateway.md).

## 8. Preparación

- **Estado:** `draft`. La decisión la declaró el responsable. Ningún arquitecto la revisó.
- **Catálogo:** [CAT-ADR-001](../CAT-ADR-001-decisiones-de-arquitectura.md).
