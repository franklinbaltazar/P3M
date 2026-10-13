---
type: Architecture Decision Record
title: "ADR-15 — Plataforma contenerizada"
description: "La plataforma está completamente contenerizada"
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

# ADR-15 — Plataforma contenerizada

## 1. Estado

Aceptada

## 2. Contexto

No constan motivos. No constan alternativas

## 3. Decisión

La plataforma está completamente contenerizada

## 4. Alternativas consideradas

No constan en las fuentes. No se inventaron.

## 5. Consecuencias

Todos los componentes se empaquetan como contenedores y los secretos llegan desde Vault, no desde la imagen. Hace falta una plataforma que ejecute los contenedores (ADR-P7)

## 6. Requisitos a los que responde

[ASR-20](../asr/asr-20.md)

## 7. Fuente

D-125. Las decisiones D-xx están en el pack [RCP-001](../../requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md).

## 8. Preparación

- **Estado:** `draft`. La decisión la declaró el responsable. Ningún arquitecto la revisó.
- **Catálogo:** [CAT-ADR-001](../CAT-ADR-001-decisiones-de-arquitectura.md).
