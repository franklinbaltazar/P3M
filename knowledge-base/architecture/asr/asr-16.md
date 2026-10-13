---
type: ASR Candidate
title: "ASR-16 — Base de datos MySQL 8.x, microservicios en Python con FastAPI, SPA en Angular y BFF en Nex"
description: "Base de datos MySQL 8.x, microservicios en Python con FastAPI, SPA en Angular y BFF en Next.js"
tags: [architecture, asr]
status: draft
generated:
  by: "claude-code (renombrado según el skill asr-discovery)"
  at: "2026-10-11T15:00:00-05:00"
sources:
  - id: rcp-001
    resource: /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md
  - id: brc-001
    resource: /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md
  - id: cat-adr-001
    resource: /architecture/CAT-ADR-001-decisiones-de-arquitectura.md
---

# ASR-16 — Base de datos MySQL 8.x, microservicios en Python con FastAPI, SPA en Angular y BFF en Nex

- **Tipo:** Restricción
- **Requisito de origen:** Base de datos MySQL 8.x, microservicios en Python con FastAPI, SPA en Angular y BFF en Next.js
- **Actualización (2026-10-13):** los microservicios del core backend pasan a **Java 24 con Spring Boot 4.0.8 y Spring Cloud 2025.1.3** ([ADR-16](../adr/ADR-16-microservicios-en-java-24-con-spring-boot-y-spring-cloud.md)) con arquitectura hexagonal ([ADR-17](../adr/ADR-17-arquitectura-hexagonal-y-paquetes-de-los-microservicios.md)). El resto de la restricción (MySQL 8.x, Angular, Next.js) no cambia.
- **Quality Concern:** Restricción tecnológica
- **Human Disposition:** PENDIENTE. El arquitecto la clasifica como `CANDIDATE`, `REJECT` o `INVESTIGATE`. Este documento no aprueba el ASR.

## Why Architecture-Significant?

Condiciona las decisiones de arquitectura ADR-01, ADR-05, ADR-07 y el atributo de calidad «Restricción tecnológica». Si el requisito cambia, esas decisiones cambian.

## Impact Evidence

D-115, D-118. Las decisiones D-xx están en el pack [RCP-001](../../requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md) y las reglas BR-xxx en [BRC-001](../../business/rules/BRC-001-reglas-de-negocio-portal-curricula.md).

## Evidence IDs

D-115, D-118

## Evidence Classification

FACT: declaración del responsable o estándar, sin validar por un arquitecto. Detalle de la evidencia: Decisión humana, alta

## Confidence

Alta

## Missing Evidence

- Límites entre microservicios y forma de comunicación con el BFF. Sin respuesta (ADR-P2)

## ADR relacionados

[ADR-01](../adr/ADR-01-spa-en-angular-con-bff-en-next-js.md), [ADR-05](../adr/ADR-05-mysql-8-x-como-base-de-datos.md), [ADR-07](../adr/ADR-07-microservicios-en-python-con-fastapi.md)

## Preparación

- **Estado:** `draft`. Pendiente de la disposición humana del arquitecto.
- **Catálogo:** [asr-catalog](asr-catalog.md).
