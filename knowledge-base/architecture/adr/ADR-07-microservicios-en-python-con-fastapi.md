---
type: Architecture Decision Record
title: "ADR-07 — Microservicios en Python con FastAPI"
description: "Los microservicios se desarrollan en Python con FastAPI"
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

# ADR-07 — Microservicios en Python con FastAPI

## 1. Estado

**Reemplazada por [ADR-16](ADR-16-microservicios-en-java-24-con-spring-boot-y-spring-cloud.md) el 2026-10-13** (decisión de ianache: los microservicios del core backend pasan a Java 24 con Spring Boot y Spring Cloud). Se conserva como histórico: ya no rige.

## 2. Contexto

No constan motivos ni alternativas

## 3. Decisión

Los microservicios se desarrollan en Python con FastAPI

## 4. Alternativas consideradas

No constan en las fuentes. No se inventaron.

## 5. Consecuencias

Falta definir los límites de cada microservicio (ADR-P2)

## 6. Requisitos a los que responde

[ASR-16](../asr/asr-16.md)

## 7. Fuente

D-118. Las decisiones D-xx están en el pack [RCP-001](../../requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md).

## 8. Preparación

- **Estado:** `draft`, **reemplazada** por ADR-16. La decisión original la declaró el responsable. Ningún arquitecto la revisó.
- **Catálogo:** [CAT-ADR-001](../CAT-ADR-001-decisiones-de-arquitectura.md).
