---
type: Architecture Decision Record
title: "ADR-P8 — Selección del API Gateway (Kong OSS o KrakenD OSS)"
description: "Elegir entre Kong OSS y KrakenD OSS para el API Gateway"
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

# ADR-P8 — Selección del API Gateway (Kong OSS o KrakenD OSS)

## 1. Estado

Pendiente. Ninguna fuente decide esto todavía.

## 2. Decisión que falta

Elegir entre Kong OSS y KrakenD OSS para el API Gateway

## 3. Por qué importa

Hay una evaluación en [EVA-001](../EVA-001-evaluacion-api-gateway.md) que recomienda KrakenD CE (4,15 frente a 3,40), sujeta a una prueba de concepto y a verificar el estado de la edición abierta de Kong

## 4. Depende de

[ADR-14](ADR-14-api-gateway-oss-integrado-con-keycloak-para-c.md)

## 5. Quién decide

Arquitectura

## 6. Evaluación de apoyo

[EVA-001](../EVA-001-evaluacion-api-gateway.md) compara Kong OSS y KrakenD CE y recomienda KrakenD CE, sujeta a una prueba de concepto.

## Preparación

- **Estado:** `draft`. Hay que tomar la decisión y registrar el contexto, las alternativas y las consecuencias.
- **Catálogo:** [CAT-ADR-001](../CAT-ADR-001-decisiones-de-arquitectura.md).
