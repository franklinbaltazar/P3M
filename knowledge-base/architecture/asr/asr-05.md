---
type: ASR Candidate
title: "ASR-05 — La información de GitLab se carga de forma automática y programada, cada 30 segundos por d"
description: "La información de GitLab se carga de forma automática y programada, cada 30 segundos por defecto, solo con lo creado o actualizado desde la carga más reciente (delta de cambio). La"
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

# ASR-05 — La información de GitLab se carga de forma automática y programada, cada 30 segundos por d

- **Tipo:** Candidato a ASR
- **Requisito de origen:** La información de GitLab se carga de forma automática y programada, cada 30 segundos por defecto, solo con lo creado o actualizado desde la carga más reciente (delta de cambio). La primera carga es completa. Las funcionalidades no consultan a GitLab directamente
- **Quality Concern:** Rendimiento y eficiencia de transferencia
- **Human Disposition:** PENDIENTE. El arquitecto la clasifica como `CANDIDATE`, `REJECT` o `INVESTIGATE`. Este documento no aprueba el ASR.

## Why Architecture-Significant?

Condiciona las decisiones de arquitectura ADR-08, ADR-06 y el atributo de calidad «Rendimiento y eficiencia de transferencia». Si el requisito cambia, esas decisiones cambian.

## Impact Evidence

BR-039, BR-065, BR-094, D-69, D-71, D-114. Las decisiones D-xx están en el pack [RCP-001](../../requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md) y las reglas BR-xxx en [BRC-001](../../business/rules/BRC-001-reglas-de-negocio-portal-curricula.md).

## Evidence IDs

BR-039, BR-065, BR-094, D-69, D-71, D-114

## Evidence Classification

FACT: declaración del responsable o estándar, sin validar por un arquitecto. Detalle de la evidencia: Decisión humana, alta

## Confidence

Alta

## Missing Evidence

- Volumen: número de colaboradores, productos, proyectos y usuarios concurrentes. No hay cifras en las fuentes. Sin ellas no se pueden fijar objetivos de rendimiento ni de capacidad

## ADR relacionados

[ADR-08](../adr/ADR-08-carga-programada-de-gitlab-de-solo-lectura-co.md), [ADR-06](../adr/ADR-06-redis-para-el-caching-de-datos-en-el-bff.md)

## Preparación

- **Estado:** `draft`. Pendiente de la disposición humana del arquitecto.
- **Catálogo:** [asr-catalog](asr-catalog.md).
