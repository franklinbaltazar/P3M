---
type: Architecture Decision Record
title: "ADR-12 — Secretos y parámetros en HashiCorp Vault"
description: "Los parámetros y los datos sensibles se mantienen en HashiCorp Vault, bajo `secret/p3m/*`: credenciales de MySQL, usuario y contraseña de Redis, PAT de GitLab y URL base de GitLab"
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

# ADR-12 — Secretos y parámetros en HashiCorp Vault

## 1. Estado

Aceptada. Faltan la rotación y la autenticación de cada componente en Vault (ADR-P11)

## 2. Contexto

Proteger los secretos. No constan más motivos ni alternativas

## 3. Decisión

Los parámetros y los datos sensibles se mantienen en HashiCorp Vault, bajo `secret/p3m/*`: credenciales de MySQL, usuario y contraseña de Redis, PAT de GitLab y URL base de GitLab

## 4. Alternativas consideradas

No constan en las fuentes. No se inventaron.

## 5. Consecuencias

Ningún secreto va en el código, la configuración, las imágenes de contenedor ni el navegador. Cada componente necesita acceso a Vault

## 6. Requisitos a los que responde

[ASR-17](../asr/asr-17.md), [ASR-04](../asr/asr-04.md)

## 7. Fuente

D-119, D-124. Las decisiones D-xx están en el pack [RCP-001](../../requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md).

## 8. Preparación

- **Estado:** `draft`. La decisión la declaró el responsable. Ningún arquitecto la revisó.
- **Catálogo:** [CAT-ADR-001](../CAT-ADR-001-decisiones-de-arquitectura.md).
