---
type: Architecture Decision Record
title: "ADR-09 — Reintentos con esperas incrementales y circuit breaker"
description: "Una carga fallida se reintenta 3 veces con esperas incrementales y un circuit breaker evita saturar a GitLab"
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

# ADR-09 — Reintentos con esperas incrementales y circuit breaker

## 1. Estado

Aceptada para el patrón. **Propuesta** para los parámetros (anexo B del pack): jitter, 5, 15 y 45 s, apertura tras 5 fallos y 5 minutos abierto

## 2. Contexto

Proteger a GitLab ante fallas

## 3. Decisión

Una carga fallida se reintenta 3 veces con esperas incrementales y un circuit breaker evita saturar a GitLab

## 4. Alternativas consideradas

No constan en las fuentes. No se inventaron.

## 5. Consecuencias

Hace falta un componente de resiliencia con estado: cerrado, abierto o semiabierto

## 6. Requisitos a los que responde

[ASR-06](../asr/asr-06.md), [ASR-07](../asr/asr-07.md)

## 7. Fuente

D-100, D-111. Las decisiones D-xx están en el pack [RCP-001](../../requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md).

## 8. Preparación

- **Estado:** `draft`. La decisión la declaró el responsable. Ningún arquitecto la revisó.
- **Catálogo:** [CAT-ADR-001](../CAT-ADR-001-decisiones-de-arquitectura.md).
