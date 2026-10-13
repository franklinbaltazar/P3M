---
type: Architecture Decision Record
title: "ADR-13 — Protocolo de consumo seguro entre el BFF y los microservicios"
description: "La integración entre el BFF y los microservicios usa un protocolo para el consumo seguro, no un token JWT"
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

# ADR-13 — Protocolo de consumo seguro entre el BFF y los microservicios

## 1. Estado

Aceptada. Enmendada el 2026-10-10 por ADR-P9: el protocolo es OAuth2 Client Credentials (JWT de máquina emitido por Keycloak), no un «no JWT».

## 2. Contexto

Que los microservicios confíen en las llamadas del BFF sin depender del gateway. No constan más motivos

## 3. Decisión

La integración entre el BFF y los microservicios usa un protocolo para el consumo seguro, no un token JWT

## 4. Alternativas consideradas

No constan en las fuentes. No se inventaron.

## 5. Consecuencias

El BFF llama directamente a los microservicios y el gateway queda para consumidores externos. Los microservicios aceptan dos formas de acceso: JWT desde el gateway y el protocolo del BFF

## 6. Requisitos a los que responde

[ASR-18](../asr/asr-18.md)

## 7. Fuente

D-120, D-122. Las decisiones D-xx están en el pack [RCP-001](../../requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md).

## 8. Preparación

- **Estado:** `draft`. La decisión la declaró el responsable. Ningún arquitecto la revisó.
- **Catálogo:** [CAT-ADR-001](../CAT-ADR-001-decisiones-de-arquitectura.md).
