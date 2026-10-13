---
type: Architecture Decision Record
title: "ADR-03 — Sesión del BFF alineada con la sesión de Keycloak"
description: "La cookie del BFF y la sesión de Keycloak deben estar alineadas. El cierre de sesión es a demanda o por vencimiento controlado por Keycloak"
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

# ADR-03 — Sesión del BFF alineada con la sesión de Keycloak

## 1. Estado

Aceptada. Faltan el tiempo de sesión, la anticipación del aviso y la renovación (RQ-31)

## 2. Contexto

Evitar sesiones del portal vivas con la sesión de Keycloak terminada, y al revés

## 3. Decisión

La cookie del BFF y la sesión de Keycloak deben estar alineadas. El cierre de sesión es a demanda o por vencimiento controlado por Keycloak

## 4. Alternativas consideradas

No constan en las fuentes. No se inventaron.

## 5. Consecuencias

Hace falta un cierre coordinado entre el BFF y Keycloak

## 6. Requisitos a los que responde

[ASR-02](../asr/asr-02.md)

## 7. Fuente

D-116. Las decisiones D-xx están en el pack [RCP-001](../../requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md).

## 8. Preparación

- **Estado:** `draft`. La decisión la declaró el responsable. Ningún arquitecto la revisó.
- **Catálogo:** [CAT-ADR-001](../CAT-ADR-001-decisiones-de-arquitectura.md).
