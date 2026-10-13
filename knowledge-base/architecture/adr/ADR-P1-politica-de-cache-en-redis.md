---
type: Architecture Decision Record
title: "ADR-P1 — Política de caché en Redis"
description: "Política de caché en Redis: qué datos se guardan, tiempo de vida, invalidación y si guarda la sesión del BFF"
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

# ADR-P1 — Política de caché en Redis

## 1. Estado

Aceptada por el responsable el 2026-10-10. Sin revisión de un arquitecto.

## 2. Contexto

Con consistencia hacia el delta de GitLab y el cierre de sesión (ADR-03). El BFF y los microservicios escalan en réplicas, por lo que la sesión no puede vivir en la memoria de una instancia.

## 3. Decisión

Redis guarda: (a) la parametría extraída de HashiCorp Vault, (b) los resultados de las consultas de los microservicios y (c) la sesión del BFF. El TTL se define por escenario de uso.

## 4. Alternativas consideradas

Solo se registran las que se discutieron con el responsable (ver la decisión). No se inventaron otras.

## 5. Consecuencias

Redis pasa a ser un componente crítico: hace falta su alta disponibilidad (INF-P3M-001). Quedan por definir los TTL concretos por escenario y la invalidación con el delta de GitLab.

## 6. Quién decidió

Responsable funcional, ianache

## 7. Preparación

- **Estado:** `draft`. Ningún arquitecto la revisó.
- **Catálogo:** [CAT-ADR-001](../CAT-ADR-001-decisiones-de-arquitectura.md).
