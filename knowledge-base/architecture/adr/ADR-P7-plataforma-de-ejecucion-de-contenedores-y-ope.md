---
type: Architecture Decision Record
title: "ADR-P7 — Plataforma de ejecución de contenedores y operación"
description: "Plataforma que ejecuta los contenedores (orquestador, registro de imágenes, CI/CD), entornos, observabilidad y objetivos de disponibilidad, recuperación y capacidad"
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

# ADR-P7 — Plataforma de ejecución de contenedores y operación

## 1. Estado

Aceptada por el responsable el 2026-10-10. **Aprobada por ianache el 2026-10-12** (en su rol de responsable funcional; no consta la revisión de un arquitecto distinto).

## 2. Contexto

La plataforma es contenerizada (ADR-15) pero no nombraba dónde corre.

## 3. Decisión

Docker en la máquina del desarrollador y Kubernetes en Oracle OKE para DEV, QA, PRE y PROD (INF-Q01 habla de OKE solo para QA, PRE y PROD: por confirmar si hay DEV en OKE). Las imágenes se publican en Docker Hub.

**Aclaración del 2026-10-13 (ianache, enmienda sin verificar):** no hay DEV en OKE. El desarrollo y las pruebas locales (laptop o PC del desarrollador y de QA) usan Docker y **Docker Compose** con todos los componentes de la solución; **QA, PRE y PROD** usan **Kubernetes 1.33.x** en Oracle OKE, con NGINX Ingress Controller y cert-manager. Ver INF-P3M-001 §15.1 e INF-DEC-24 y 25.

## 4. Alternativas consideradas

Solo se registran las que se discutieron con el responsable (ver la decisión). No se inventaron otras.

## 5. Consecuencias

Riesgo: en Docker Hub las imágenes privadas y las descargas desde OKE tienen límites; evaluar OCIR. Siguen sin definirse disponibilidad, RTO, RPO y carga (INF-Q02, INF-Q03).

## 6. Quién decidió

Responsable funcional, ianache

## 7. Preparación

- **Estado:** `approved` el 2026-10-12 por ianache. Ningún arquitecto distinto la revisó.
- **Catálogo:** [CAT-ADR-001](../CAT-ADR-001-decisiones-de-arquitectura.md).
