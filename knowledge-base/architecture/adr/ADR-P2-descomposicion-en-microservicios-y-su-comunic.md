---
type: Architecture Decision Record
title: "ADR-P2 — Descomposición en microservicios y su comunicación"
description: "Descomposición en microservicios: límites, qué datos posee cada uno, cómo se comunican con el BFF y entre sí"
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

# ADR-P2 — Descomposición en microservicios y su comunicación

## 1. Estado

Aceptada por el responsable el 2026-10-10. **Aprobada por ianache el 2026-10-12** (en su rol de responsable funcional; no consta la revisión de un arquitecto distinto).

## 2. Contexto

Es la decisión estructural más grande; las fuentes solo fijaban el lenguaje (ADR-07).

## 3. Decisión

Los microservicios se delimitan con Domain-Driven Design (DDD). Se comunican de forma síncrona con llamadas REST seguras (ADR-13, ADR-P9) y de forma asíncrona con RabbitMQ como único mensajero. No se usan Kafka ni tópicos Redis.

**Enumeración (2026-10-12, ianache, enmienda sin verificar):** los 7 contextos de DDD (CTX-01 a CTX-07) son módulos. Se despliegan como **5 microservicios**: `svc-partes-identidad` (CTX-01 y CTX-02), `svc-curricula` (CTX-03), `svc-formacion-progresion` (CTX-04 y CTX-05), `svc-portafolio` (CTX-06) y `svc-gitlab` (CTX-07). Cada módulo conserva su esquema y sus puertos, sin claves foráneas entre contextos. Detalle y criterios en [API-PRP-000](../../design/api-contracts/API-PRP-000-resumen.md). El BFF no es un servicio de dominio (ADR-01).

## 4. Alternativas consideradas

Solo se registran las que se discutieron con el responsable (ver la decisión). No se inventaron otras.

## 5. Consecuencias

Los límites de cada microservicio salen de los contextos acotados de DDD, a partir de IMD-001. Quedan enumerados en la enmienda del §3. Falta la revisión de un arquitecto. RabbitMQ también era el broker de Celery (ADR-P3); con Java (ADR-16) Celery no aplica y ADR-P3 requiere revisión. Los servicios usan Spring AMQP o Spring Cloud Stream (por decidir).

## 6. Quién decidió

Responsable funcional, ianache

## 7. Preparación

- **Estado:** `approved` el 2026-10-12 por ianache. Ningún arquitecto distinto la revisó.
- **Catálogo:** [CAT-ADR-001](../CAT-ADR-001-decisiones-de-arquitectura.md).
