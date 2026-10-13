---
type: ASR Candidate
title: "ASR-08 — Los logs de las cargas (fecha y hora, estado exitosa o fallida, reintento) se retienen por"
description: "Los logs de las cargas (fecha y hora, estado exitosa o fallida, reintento) se retienen por siempre. Cada evaluación de desempeño registra fecha y hora y el usuario que la registra"
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

# ASR-08 — Los logs de las cargas (fecha y hora, estado exitosa o fallida, reintento) se retienen por

- **Tipo:** Candidato a ASR
- **Requisito de origen:** Los logs de las cargas (fecha y hora, estado exitosa o fallida, reintento) se retienen por siempre. Cada evaluación de desempeño registra fecha y hora y el usuario que la registra
- **Quality Concern:** Auditabilidad y retención
- **Human Disposition:** PENDIENTE. El arquitecto la clasifica como `CANDIDATE`, `REJECT` o `INVESTIGATE`. Este documento no aprueba el ASR.

## Why Architecture-Significant?

Condiciona las decisiones de arquitectura ADR-08, ADR-05 y el atributo de calidad «Auditabilidad y retención». Si el requisito cambia, esas decisiones cambian.

## Impact Evidence

BR-066, BR-087, BR-090, D-70, D-105, D-110. Las decisiones D-xx están en el pack [RCP-001](../../requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md) y las reglas BR-xxx en [BRC-001](../../business/rules/BRC-001-reglas-de-negocio-portal-curricula.md).

## Evidence IDs

BR-066, BR-087, BR-090, D-70, D-105, D-110

## Evidence Classification

FACT: declaración del responsable o estándar, sin validar por un arquitecto. Detalle de la evidencia: Decisión humana, alta

## Confidence

Alta

## Missing Evidence

- Ninguno identificado.

## ADR relacionados

[ADR-08](../adr/ADR-08-carga-programada-de-gitlab-de-solo-lectura-co.md), [ADR-05](../adr/ADR-05-mysql-8-x-como-base-de-datos.md)

## Preparación

- **Estado:** `draft`. Pendiente de la disposición humana del arquitecto.
- **Catálogo:** [asr-catalog](asr-catalog.md).
