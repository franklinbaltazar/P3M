---
type: ASR Candidate
title: "ASR-13 — El BFF usa Redis para el caching de datos"
description: "El BFF usa Redis para el caching de datos"
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

# ASR-13 — El BFF usa Redis para el caching de datos

- **Tipo:** Restricción
- **Requisito de origen:** El BFF usa Redis para el caching de datos
- **Quality Concern:** Rendimiento
- **Human Disposition:** PENDIENTE. El arquitecto la clasifica como `CANDIDATE`, `REJECT` o `INVESTIGATE`. Este documento no aprueba el ASR.

## Why Architecture-Significant?

Condiciona las decisiones de arquitectura ADR-06 y el atributo de calidad «Rendimiento». Si el requisito cambia, esas decisiones cambian.

## Impact Evidence

D-118. Las decisiones D-xx están en el pack [RCP-001](../../requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md) y las reglas BR-xxx en [BRC-001](../../business/rules/BRC-001-reglas-de-negocio-portal-curricula.md).

## Evidence IDs

D-118

## Evidence Classification

FACT: declaración del responsable o estándar, sin validar por un arquitecto; UNKNOWN: ver Missing Evidence. Detalle de la evidencia: Decisión humana. No se sabe qué se cachea ni por cuánto tiempo

## Confidence

Media

## Missing Evidence

- Volumen: número de colaboradores, productos, proyectos y usuarios concurrentes. No hay cifras en las fuentes. Sin ellas no se pueden fijar objetivos de rendimiento ni de capacidad
- Qué se guarda en Redis, por cuánto tiempo y si guarda la sesión del BFF. Anotado en el anexo C del pack

## ADR relacionados

[ADR-06](../adr/ADR-06-redis-para-el-caching-de-datos-en-el-bff.md)

## Preparación

- **Estado:** `draft`. Pendiente de la disposición humana del arquitecto.
- **Catálogo:** [asr-catalog](asr-catalog.md).
