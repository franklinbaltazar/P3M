---
type: Architecture Decision Record
title: "ADR-P11 — Rotación de secretos y acceso a Vault"
description: "Rotación de secretos, cómo se autentica cada componente en Vault y confirmar que el PAT de GitLab tenga alcance de solo lectura. Ya se decidió qué se guarda y dónde (`secret/p3m/*`"
tags: [architecture, adr, pendiente]
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

# ADR-P11 — Rotación de secretos y acceso a Vault

## 1. Estado

Pendiente. Ninguna fuente decide esto todavía.

## 2. Decisión que falta

Rotación de secretos, cómo se autentica cada componente en Vault y confirmar que el PAT de GitLab tenga alcance de solo lectura. Ya se decidió qué se guarda y dónde (`secret/p3m/*`, D-124)

## 3. Por qué importa

Cierra RQ-09 en lo que respecta a las credenciales

## 4. Depende de

[ADR-12](ADR-12-secretos-y-parametros-en-hashicorp-vault.md)

## 5. Quién decide

Arquitectura y seguridad

## Preparación

- **Estado:** `draft`. Hay que tomar la decisión y registrar el contexto, las alternativas y las consecuencias.
- **Catálogo:** [CAT-ADR-001](../CAT-ADR-001-decisiones-de-arquitectura.md).
