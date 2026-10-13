---
type: Architecture Decision Record
title: "ADR-11 — Identidad y roles de usuario gestionados en Keycloak"
description: "Los usuarios y sus roles de usuario (colaborador, Instructor, Jefe de Ingeniería, ADMIN) se gestionan en Keycloak. El portal registra al usuario al iniciar sesión y guarda el GUID."
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

# ADR-11 — Identidad y roles de usuario gestionados en Keycloak

## 1. Estado

Aceptada. Falta si se actualiza en cada inicio (RQ-22)

## 2. Contexto

Una sola fuente de identidad

## 3. Decisión

Los usuarios y sus roles de usuario (colaborador, Instructor, Jefe de Ingeniería, ADMIN) se gestionan en Keycloak. El portal registra al usuario al iniciar sesión y guarda el GUID. Un colaborador tiene siempre un usuario

## 4. Alternativas consideradas

No constan en las fuentes. No se inventaron.

## 5. Consecuencias

El portal no gestiona contraseñas ni roles. Depende de la disponibilidad de Keycloak

## 6. Requisitos a los que responde

[ASR-03](../asr/asr-03.md)

## 7. Fuente

BR-044, D-79, D-80, D-84 a D-86. Las decisiones D-xx están en el pack [RCP-001](../../requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md).

## 8. Preparación

- **Estado:** `draft`. La decisión la declaró el responsable. Ningún arquitecto la revisó.
- **Catálogo:** [CAT-ADR-001](../CAT-ADR-001-decisiones-de-arquitectura.md).
