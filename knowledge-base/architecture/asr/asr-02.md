---
type: ASR Candidate
title: "ASR-02 — El cierre de sesión es a demanda o por vencimiento controlado por Keycloak, y la sesión de"
description: "El cierre de sesión es a demanda o por vencimiento controlado por Keycloak, y la sesión del portal y la de Keycloak están alineadas"
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

# ASR-02 — El cierre de sesión es a demanda o por vencimiento controlado por Keycloak, y la sesión de

- **Tipo:** Candidato a ASR
- **Requisito de origen:** El cierre de sesión es a demanda o por vencimiento controlado por Keycloak, y la sesión del portal y la de Keycloak están alineadas
- **Quality Concern:** Seguridad
- **Human Disposition:** PENDIENTE. El arquitecto la clasifica como `CANDIDATE`, `REJECT` o `INVESTIGATE`. Este documento no aprueba el ASR.

## Why Architecture-Significant?

Condiciona las decisiones de arquitectura ADR-02, ADR-03 y el atributo de calidad «Seguridad». Si el requisito cambia, esas decisiones cambian.

## Impact Evidence

BR-096, D-116. Las decisiones D-xx están en el pack [RCP-001](../../requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md) y las reglas BR-xxx en [BRC-001](../../business/rules/BRC-001-reglas-de-negocio-portal-curricula.md).

## Evidence IDs

BR-096, D-116

## Evidence Classification

FACT: declaración del responsable o estándar, sin validar por un arquitecto; UNKNOWN: ver Missing Evidence. Detalle de la evidencia: Decisión humana, alta. Faltan el tiempo de sesión, la anticipación del aviso y la renovación (RQ-31)

## Confidence

Alta

## Missing Evidence

- Tiempo de sesión, aviso previo y cierre global. RQ-31
- Qué se guarda en Redis, por cuánto tiempo y si guarda la sesión del BFF. Anotado en el anexo C del pack

## ADR relacionados

[ADR-02](../adr/ADR-02-autenticacion-con-keycloak-a-traves-del-bff-c.md), [ADR-03](../adr/ADR-03-sesion-del-bff-alineada-con-la-sesion-de-keyc.md)

## Preparación

- **Estado:** `draft`. Pendiente de la disposición humana del arquitecto.
- **Catálogo:** [asr-catalog](asr-catalog.md).
