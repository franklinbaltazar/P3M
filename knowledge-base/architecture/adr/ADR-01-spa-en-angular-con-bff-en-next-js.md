---
type: Architecture Decision Record
title: "ADR-01 — SPA en Angular con BFF en Next.js"
description: "La aplicación es un SPA en Angular con un BFF en Next.js"
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

# ADR-01 — SPA en Angular con BFF en Next.js

## 1. Estado

Aceptada

## 2. Contexto

Ingreso seguro sin datos sensibles en el navegador

## 3. Decisión

La aplicación es un SPA en Angular con un BFF en Next.js

## 4. Alternativas consideradas

No constan en las fuentes. No se inventaron.

## 5. Consecuencias

El SPA solo habla con el BFF. El BFF concentra la autenticación y la sesión

## 6. Requisitos a los que responde

[ASR-01](../asr/asr-01.md), [ASR-16](../asr/asr-16.md)

## 7. Fuente

D-115. Las decisiones D-xx están en el pack [RCP-001](../../requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md).

## 8. Preparación

- **Estado:** `draft`. La decisión la declaró el responsable. Ningún arquitecto la revisó.
- **Catálogo:** [CAT-ADR-001](../CAT-ADR-001-decisiones-de-arquitectura.md).
