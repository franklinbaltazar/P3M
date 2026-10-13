---
type: Architecture Decision Record
title: "ADR-P6 — Historial con vigencia y restricciones en MySQL"
description: "Estrategia para el historial con vigencia en MySQL (modelo temporal, restricciones de «una sola vigente»)"
tags: [architecture, adr]
status: approved
generated:
  by: "claude-code (identificación manual)"
  at: "2026-10-11T13:00:00-05:00"
verified:
  by: "ianache (Functional Analysis)"
  at: "2026-10-12T09:00:00-05:00"
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

# ADR-P6 — Historial con vigencia y restricciones en MySQL

## 1. Estado

Aceptada por el responsable el 2026-10-10. **Aprobada por ianache el 2026-10-12** (en su rol de responsable funcional; no consta la revisión de un arquitecto distinto).

## 2. Contexto

Los ASR-09 y ASR-10 exigen garantizar «una sola vigente» y «suma ≤ 100 %».

## 3. Decisión

Estrategia combinada: cada historial lleva fechas de inicio y fin de vigencia; un índice único sobre una columna calculada garantiza «una sola vigente» en la base de datos; la regla «suma de dedicación ≤ 100 %» se valida en el microservicio con una transacción y bloqueo de filas (SELECT ... FOR UPDATE).

## 4. Alternativas consideradas

Solo se registran las que se discutieron con el responsable (ver la decisión). No se inventaron otras.

## 5. Consecuencias

Se mantienen dos mecanismos. Es la opción recomendada por el equipo de gestión y se registró por respuesta «ok» del responsable.

## 6. Quién decidió

Responsable funcional, ianache (sin revisión de un arquitecto de datos)

## 7. Preparación

- **Estado:** `approved` el 2026-10-12 por ianache. Ningún arquitecto distinto la revisó.
- **Catálogo:** [CAT-ADR-001](../CAT-ADR-001-decisiones-de-arquitectura.md).
