---
type: Architecture Decision Record
title: "ADR-10 — Modelo de personas y organizaciones alineado con el UDM"
description: "El registro de colaboradores y sus relaciones se alinea con el UDM: persona, rol de la parte, relación entre partes con vigencia, mecanismos de contacto, organización"
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

# ADR-10 — Modelo de personas y organizaciones alineado con el UDM

## 1. Estado

Aceptada. La correspondencia concreta con el UDM es una propuesta (IMD-001, sección 5.1)

## 2. Contexto

Alinear con un modelo de referencia. No consta motivo adicional

## 3. Decisión

El registro de colaboradores y sus relaciones se alinea con el UDM: persona, rol de la parte, relación entre partes con vigencia, mecanismos de contacto, organización

## 4. Alternativas consideradas

No constan en las fuentes. No se inventaron.

## 5. Consecuencias

El modelo de datos usa partes y relaciones con vigencia en vez de tablas planas por rol

## 6. Requisitos a los que responde

[ASR-09](../asr/asr-09.md), [ASR-11](../asr/asr-11.md)

## 7. Fuente

D-74, D-76 a D-79, D-81 a D-83, D-87 a D-90. Las decisiones D-xx están en el pack [RCP-001](../../requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md).

## 8. Preparación

- **Estado:** `draft`. La decisión la declaró el responsable. Ningún arquitecto la revisó.
- **Catálogo:** [CAT-ADR-001](../CAT-ADR-001-decisiones-de-arquitectura.md).
