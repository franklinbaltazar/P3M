---
type: Architecture Decision Record
title: "ADR-P3 — Ejecución de la carga programada de GitLab"
description: "Dónde y cómo se ejecuta la carga programada de GitLab (qué servicio, planificador, una sola carga a la vez)"
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

# ADR-P3 — Ejecución de la carga programada de GitLab

## 1. Estado

Aceptada por el responsable el 2026-10-10. **Aprobada por ianache el 2026-10-12** (en su rol de responsable funcional; no consta la revisión de un arquitecto distinto).

## 2. Contexto

La propuesta del anexo B pide una carga a la vez, de solo lectura, con delta, reintentos y circuit breaker (ADR-08, ADR-09).

## 3. Decisión

> **REQUIERE REVISIÓN (2026-10-13).** Esta decisión nombra Python y Celery, y [ADR-16](ADR-16-microservicios-en-java-24-con-spring-boot-y-spring-cloud.md) establece que los microservicios son Java con Spring. **Lo que sigue vigente:** la carga es un proceso independiente, una sola carga a la vez, de solo lectura, con RabbitMQ en la plataforma (ADR-P2). **Lo que ya no aplica:** Python, Celery Beat y los workers de Celery. Hay que decidir el reemplazo (J-6 de ADR-16); opciones a evaluar (propuesta del agente, sin decidir): `@Scheduled` con un bloqueo distribuido (por ejemplo ShedLock sobre MySQL o Redis), Quartz en modo clúster, o Spring Batch con un lanzador planificado. Los requisitos no cambian: una sola carga a la vez aunque haya varias réplicas, reintentos con esperas incrementales y circuit breaker (ADR-09).

La carga de GitLab corre como proceso independiente en Python, planificado con Celery Beat y ejecutado por workers de Celery con RabbitMQ como broker (ADR-P2). Solo se ejecuta una carga a la vez.

## 4. Alternativas consideradas

Solo se registran las que se discutieron con el responsable (ver la decisión). No se inventaron otras.

## 5. Consecuencias

Hay que garantizar una sola carga a la vez aunque Celery Beat y los workers tengan varias réplicas (un solo Beat y un candado en Redis). Las historias US-020 y US-024 dependen de esto.

## 6. Quién decidió

Responsable funcional, ianache

## 7. Preparación

- **Estado:** `approved` el 2026-10-12 por ianache. Ningún arquitecto distinto la revisó.
- **Catálogo:** [CAT-ADR-001](../CAT-ADR-001-decisiones-de-arquitectura.md).
