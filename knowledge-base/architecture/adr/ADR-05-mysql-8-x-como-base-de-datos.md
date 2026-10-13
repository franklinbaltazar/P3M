---
type: Architecture Decision Record
title: "ADR-05 — MySQL 8.x como base de datos"
description: "La base de datos es MySQL 8.x"
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

# ADR-05 — MySQL 8.x como base de datos

## 1. Estado

Aceptada

## 2. Contexto

No consta el motivo. No constan alternativas

## 3. Decisión

La base de datos es MySQL 8.x

## 4. Alternativas consideradas

No constan en las fuentes. No se inventaron.

## 5. Consecuencias

El modelo de datos debe expresar historiales con vigencia y las restricciones de integridad de los ASR 08 a 10 en MySQL 8.x

## 6. Requisitos a los que responde

[ASR-08](../asr/asr-08.md), [ASR-09](../asr/asr-09.md), [ASR-10](../asr/asr-10.md), [ASR-16](../asr/asr-16.md)

## 7. Fuente

D-118. Las decisiones D-xx están en el pack [RCP-001](../../requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md).

## 8. Preparación

- **Estado:** `draft`. La decisión la declaró el responsable. Ningún arquitecto la revisó.
- **Catálogo:** [CAT-ADR-001](../CAT-ADR-001-decisiones-de-arquitectura.md).
