---
type: Architecture Decision Record
title: "ADR-06 — Redis para el caching de datos en el BFF"
description: "El BFF usa Redis para el caching de datos"
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

# ADR-06 — Redis para el caching de datos en el BFF

## 1. Estado

Aceptada. Falta la política (ADR-P1)

## 2. Contexto

Rendimiento. No constan más motivos

## 3. Decisión

El BFF usa Redis para el caching de datos

## 4. Alternativas consideradas

No constan en las fuentes. No se inventaron.

## 5. Consecuencias

Hace falta una política de caché (qué, cuánto tiempo, invalidación). Con el delta de GitLab hay que invalidar lo que cambia

## 6. Requisitos a los que responde

[ASR-05](../asr/asr-05.md), [ASR-13](../asr/asr-13.md)

## 7. Fuente

D-118. Las decisiones D-xx están en el pack [RCP-001](../../requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md).

## 8. Preparación

- **Estado:** `draft`. La decisión la declaró el responsable. Ningún arquitecto la revisó.
- **Catálogo:** [CAT-ADR-001](../CAT-ADR-001-decisiones-de-arquitectura.md).
