---
type: Architecture Decision Record
title: "ADR-P10 — Aplicaciones consumidoras y límites de uso de las API"
description: "Qué aplicaciones consumirán las API además del Portal, cuáles se exponen, límites de uso y versionado. Ya se decidió que los microservicios quedan preparados para el consumo seguro"
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

# ADR-P10 — Aplicaciones consumidoras y límites de uso de las API

## 1. Estado

Pendiente. Ninguna fuente decide esto todavía.

## 2. Decisión que falta

Qué aplicaciones consumirán las API además del Portal, cuáles se exponen, límites de uso y versionado. Ya se decidió que los microservicios quedan preparados para el consumo seguro con JWT vía gateway (D-123)

## 3. Por qué importa

No se identifican consumidores concretos

## 4. Depende de

[ADR-14](ADR-14-api-gateway-oss-integrado-con-keycloak-para-c.md)

## 5. Quién decide

Responsable funcional y arquitectura

## Preparación

- **Estado:** `draft`. Hay que tomar la decisión y registrar el contexto, las alternativas y las consecuencias.
- **Catálogo:** [CAT-ADR-001](../CAT-ADR-001-decisiones-de-arquitectura.md).
