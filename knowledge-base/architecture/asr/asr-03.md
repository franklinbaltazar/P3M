---
type: ASR Candidate
title: "ASR-03 — Los roles de usuario son colaborador, Instructor, Jefe de Ingeniería y ADMIN, y se asignan"
description: "Los roles de usuario son colaborador, Instructor, Jefe de Ingeniería y ADMIN, y se asignan en Keycloak. El portal registra al usuario al iniciar sesión con GUID, username, correo y"
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

# ASR-03 — Los roles de usuario son colaborador, Instructor, Jefe de Ingeniería y ADMIN, y se asignan

- **Tipo:** Candidato a ASR
- **Requisito de origen:** Los roles de usuario son colaborador, Instructor, Jefe de Ingeniería y ADMIN, y se asignan en Keycloak. El portal registra al usuario al iniciar sesión con GUID, username, correo y roles
- **Quality Concern:** Seguridad / control de acceso
- **Human Disposition:** PENDIENTE. El arquitecto la clasifica como `CANDIDATE`, `REJECT` o `INVESTIGATE`. Este documento no aprueba el ASR.

## Why Architecture-Significant?

Condiciona las decisiones de arquitectura ADR-02, ADR-11 y el atributo de calidad «Seguridad / control de acceso». Si el requisito cambia, esas decisiones cambian.

## Impact Evidence

BR-044, BR-062, BR-074, BR-075, BR-077, D-80, D-84 a D-86. Las decisiones D-xx están en el pack [RCP-001](../../requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md) y las reglas BR-xxx en [BRC-001](../../business/rules/BRC-001-reglas-de-negocio-portal-curricula.md).

## Evidence IDs

BR-044, BR-062, BR-074, BR-075, BR-077, D-80, D-84, D-86

## Evidence Classification

FACT: declaración del responsable o estándar, sin validar por un arquitecto; UNKNOWN: ver Missing Evidence. Detalle de la evidencia: Decisión humana, alta. Falta saber si se actualiza en cada inicio (RQ-22)

## Confidence

Alta

## Missing Evidence

- Ninguno identificado.

## ADR relacionados

[ADR-02](../adr/ADR-02-autenticacion-con-keycloak-a-traves-del-bff-c.md), [ADR-11](../adr/ADR-11-identidad-y-roles-de-usuario-gestionados-en-k.md)

## Preparación

- **Estado:** `draft`. Pendiente de la disposición humana del arquitecto.
- **Catálogo:** [asr-catalog](asr-catalog.md).
