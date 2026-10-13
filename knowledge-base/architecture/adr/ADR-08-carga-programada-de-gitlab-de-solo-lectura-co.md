---
type: Architecture Decision Record
title: "ADR-08 — Carga programada de GitLab de solo lectura con delta de cambio"
description: "La integración con GitLab es de solo lectura. El portal carga de forma automática y programada, cada 30 segundos por defecto, solo el delta de cambio, y las funcionalidades leen la"
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

# ADR-08 — Carga programada de GitLab de solo lectura con delta de cambio

## 1. Estado

Aceptada

## 2. Contexto

Reducir la transferencia entre GitLab y el portal, no consultar a GitLab desde cada funcionalidad y poder auditar las cargas

## 3. Decisión

La integración con GitLab es de solo lectura. El portal carga de forma automática y programada, cada 30 segundos por defecto, solo el delta de cambio, y las funcionalidades leen la copia local. La primera carga es completa. Los logs se retienen por siempre y se muestra «datos al …» si GitLab no responde

## 4. Alternativas consideradas

No constan en las fuentes. No se inventaron.

## 5. Consecuencias

El portal guarda una copia local de issues y milestones. Se necesita un proceso programado, un registro de ejecuciones y una forma de reintento

## 6. Requisitos a los que responde

[ASR-04](../asr/asr-04.md), [ASR-05](../asr/asr-05.md), [ASR-07](../asr/asr-07.md), [ASR-08](../asr/asr-08.md)

## 7. Fuente

D-29, D-33, D-65 a D-71, D-110, D-112, D-114. Las decisiones D-xx están en el pack [RCP-001](../../requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md).

## 8. Preparación

- **Estado:** `draft`. La decisión la declaró el responsable. Ningún arquitecto la revisó.
- **Catálogo:** [CAT-ADR-001](../CAT-ADR-001-decisiones-de-arquitectura.md).
