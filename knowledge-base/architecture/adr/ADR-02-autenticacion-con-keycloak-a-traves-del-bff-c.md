---
type: Architecture Decision Record
title: "ADR-02 — Autenticación con Keycloak a través del BFF con PKCE"
description: "La autenticación se hace con Keycloak a través del BFF usando PKCE. El BFF controla la cookie de sesión del SPA"
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

# ADR-02 — Autenticación con Keycloak a través del BFF con PKCE

## 1. Estado

Aceptada

## 2. Contexto

No comprometer datos sensibles en el navegador

## 3. Decisión

La autenticación se hace con Keycloak a través del BFF usando PKCE. El BFF controla la cookie de sesión del SPA

## 4. Alternativas consideradas

No constan en las fuentes. No se inventaron.

## 5. Consecuencias

Los tokens no llegan al navegador. El BFF debe gestionar la sesión y los roles

## 6. Requisitos a los que responde

[ASR-01](../asr/asr-01.md), [ASR-02](../asr/asr-02.md), [ASR-03](../asr/asr-03.md)

## 7. Fuente

D-115, D-116. Las decisiones D-xx están en el pack [RCP-001](../../requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md).

## 8. Preparación

- **Estado:** `draft`. La decisión la declaró el responsable. Ningún arquitecto la revisó.
- **Catálogo:** [CAT-ADR-001](../CAT-ADR-001-decisiones-de-arquitectura.md).
