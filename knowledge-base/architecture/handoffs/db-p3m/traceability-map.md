---
type: Traceability Map
title: "Traceability Map — Base de datos del P3M"
description: "Mapa US → ASR → ADR → regla → criterio de aptitud, con las columnas que se completan durante la implementación."
tags: [handoff, database, development-context-pack]
status: draft
generated:
  by: "architecture-development-handoff"
  at: "2026-10-12T04:00:00-05:00"
sources:
  - id: wp-db-001
    resource: /data/WP-DB-001-plan-de-trabajo-diseno-bd.md
  - id: ddp-001
    resource: /data/DDP-001-descubrimiento-de-dominio.md
  - id: ddm-001
    resource: /data/DDM-001-modelo-ddd.md
  - id: ldm-001
    resource: /data/LDM-001-modelo-logico.md
  - id: icp-001
    resource: /data/ICP-001-contratos-de-integracion.md
  - id: pdm-001
    resource: /data/PDM-001-modelo-fisico-mysql.md
  - id: rpt-ddr-001
    resource: /data/RPT-DDR-001-revision-del-diseno.md
  - id: inf-p3m-001
    resource: /deployment/INF-P3M-001-arquitectura-de-infraestructura.md
  - id: asr-catalog
    resource: /architecture/asr/asr-catalog.md
  - id: cat-adr-001
    resource: /architecture/CAT-ADR-001-decisiones-de-arquitectura.md
  - id: adr-db-001
    resource: /architecture/adr/ADR-DB-001.md
  - id: adr-db-002
    resource: /architecture/adr/ADR-DB-002.md
  - id: adr-db-003
    resource: /architecture/adr/ADR-DB-003.md
  - id: brc-001
    resource: /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md
  - id: imd-001
    resource: /business/information-model/IMD-001-portal-curricula.md
---

# Traceability Map

Las columnas «Superpowers Task», «Code/Test Evidence», «MR» y «ARQ-104 Result» se completan durante la implementación.

| User Story | ASR | ADR | Architecture Rule | Fitness Criterion | Superpowers Task | Code/Test Evidence | MR | ARQ-104 Result |
|---|---|---|---|---|---|---|---|---|
| US-001 | ASR-16 | ADR-05, ADR-DB-001, ADR-DB-002, ADR-DB-003 | ARCH-RULE-001, ARCH-RULE-002, ARCH-RULE-003, ARCH-RULE-006, ARCH-RULE-014 | FIT-001, FIT-002, FIT-003, FIT-006, FIT-014 | — | — | — | — |
| US-002 | ASR-16 | ADR-05, ADR-DB-001, ADR-DB-002, ADR-DB-003 | ARCH-RULE-001, ARCH-RULE-002, ARCH-RULE-003, ARCH-RULE-006, ARCH-RULE-014 | FIT-001, FIT-002, FIT-003, FIT-006, FIT-014 | — | — | — | — |
| US-003 | ASR-16 | ADR-05, ADR-DB-001, ADR-DB-002, ADR-DB-003 | ARCH-RULE-001, ARCH-RULE-002, ARCH-RULE-003, ARCH-RULE-006, ARCH-RULE-014 | FIT-001, FIT-002, FIT-003, FIT-006, FIT-014 | — | — | — | — |
| US-004 | ASR-09, ASR-11, ASR-14, ASR-16 | ADR-05, ADR-10, ADR-P6, ADR-P4 | ARCH-RULE-001, ARCH-RULE-002, ARCH-RULE-004, ARCH-RULE-006, ARCH-RULE-013, ARCH-RULE-014 | FIT-001, FIT-002, FIT-004, FIT-006, FIT-013, FIT-014 | — | — | — | — |
| US-005 | ASR-09, ASR-11, ASR-14, ASR-16 | ADR-05, ADR-10, ADR-P6, ADR-P4 | ARCH-RULE-001, ARCH-RULE-002, ARCH-RULE-004, ARCH-RULE-006, ARCH-RULE-013, ARCH-RULE-014 | FIT-001, FIT-002, FIT-004, FIT-006, FIT-013, FIT-014 | — | — | — | — |
| US-006 | ASR-16 | ADR-05, ADR-P2, ADR-DB-002 | ARCH-RULE-001, ARCH-RULE-002, ARCH-RULE-003, ARCH-RULE-006, ARCH-RULE-008, ARCH-RULE-014 | FIT-001, FIT-002, FIT-003, FIT-006, FIT-008, FIT-014 | — | — | — | — |
| US-007 | ASR-16 | ADR-05, ADR-P2, ADR-DB-002 | ARCH-RULE-001, ARCH-RULE-002, ARCH-RULE-003, ARCH-RULE-006, ARCH-RULE-008, ARCH-RULE-014 | FIT-001, FIT-002, FIT-003, FIT-006, FIT-008, FIT-014 | — | — | — | — |
| US-008 | ASR-16 | ADR-05, ADR-P2, ADR-DB-002 | ARCH-RULE-001, ARCH-RULE-002, ARCH-RULE-003, ARCH-RULE-006, ARCH-RULE-008, ARCH-RULE-014 | FIT-001, FIT-002, FIT-003, FIT-006, FIT-008, FIT-014 | — | — | — | — |
| US-009 | ASR-10, ASR-16 | ADR-05, ADR-P2, ADR-P6 | ARCH-RULE-001, ARCH-RULE-004, ARCH-RULE-006, ARCH-RULE-014 | FIT-001, FIT-004, FIT-006, FIT-014 | — | — | — | — |
| US-010 | ASR-10, ASR-16 | ADR-05, ADR-P2, ADR-P6 | ARCH-RULE-001, ARCH-RULE-004, ARCH-RULE-006, ARCH-RULE-014 | FIT-001, FIT-004, FIT-006, FIT-014 | — | — | — | — |
| US-011 | ASR-10, ASR-16 | ADR-P2, ADR-P9, ADR-DB-002 | ARCH-RULE-008, ARCH-RULE-013, ARCH-RULE-014, ARCH-RULE-016 | FIT-008, FIT-013, FIT-014, FIT-016 | — | — | — | — |
| US-012 | ASR-10, ASR-16 | ADR-P2, ADR-P9, ADR-DB-002 | ARCH-RULE-008, ARCH-RULE-013, ARCH-RULE-014, ARCH-RULE-016 | FIT-008, FIT-013, FIT-014, FIT-016 | — | — | — | — |
| US-013 | ASR-04, ASR-05, ASR-10 | ADR-08, ADR-P2, ADR-P9 | ARCH-RULE-006, ARCH-RULE-008, ARCH-RULE-010, ARCH-RULE-013, ARCH-RULE-014, ARCH-RULE-016 | FIT-006, FIT-008, FIT-010, FIT-013, FIT-014, FIT-016 | — | — | — | — |
| US-014 | ASR-04, ASR-05, ASR-10 | ADR-08, ADR-P2, ADR-P9 | ARCH-RULE-006, ARCH-RULE-008, ARCH-RULE-010, ARCH-RULE-013, ARCH-RULE-014, ARCH-RULE-016 | FIT-006, FIT-008, FIT-010, FIT-013, FIT-014, FIT-016 | — | — | — | — |
| US-015 | ASR-04, ASR-05, ASR-10 | ADR-08, ADR-P2, ADR-P9 | ARCH-RULE-006, ARCH-RULE-008, ARCH-RULE-010, ARCH-RULE-013, ARCH-RULE-014, ARCH-RULE-016 | FIT-006, FIT-008, FIT-010, FIT-013, FIT-014, FIT-016 | — | — | — | — |
| US-016 | ASR-09, ASR-14 | ADR-P6, ADR-P4 | ARCH-RULE-004, ARCH-RULE-006, ARCH-RULE-012, ARCH-RULE-013 | FIT-004, FIT-006, FIT-012, FIT-013 | — | — | — | — |
| US-017 | ASR-09, ASR-10, ASR-14 | ADR-P2, ADR-P6, ADR-P4 | ARCH-RULE-004, ARCH-RULE-008, ARCH-RULE-009, ARCH-RULE-012, ARCH-RULE-013, ARCH-RULE-014 | FIT-004, FIT-008, FIT-009, FIT-012, FIT-013, FIT-014 | — | — | — | — |
| US-018 | ASR-09, ASR-10 | ADR-05, ADR-P6 | ARCH-RULE-001, ARCH-RULE-004, ARCH-RULE-006, ARCH-RULE-014 | FIT-001, FIT-004, FIT-006, FIT-014 | — | — | — | — |
| US-019 | ASR-09, ASR-10 | ADR-05, ADR-P6 | ARCH-RULE-001, ARCH-RULE-004, ARCH-RULE-006, ARCH-RULE-014 | FIT-001, FIT-004, FIT-006, FIT-014 | — | — | — | — |
| US-020 | ASR-04, ASR-05, ASR-06, ASR-07, ASR-08 | ADR-08, ADR-09, ADR-P3, ADR-12 | ARCH-RULE-006, ARCH-RULE-007, ARCH-RULE-010 | FIT-006, FIT-007, FIT-010 | — | — | — | — |
| US-021 | ASR-09, ASR-10 | ADR-P6, ADR-P9 | ARCH-RULE-004, ARCH-RULE-005, ARCH-RULE-006, ARCH-RULE-008, ARCH-RULE-012, ARCH-RULE-014 | FIT-004, FIT-005, FIT-006, FIT-008, FIT-012, FIT-014 | — | — | — | — |
| US-022 | ASR-09, ASR-10 | ADR-P6, ADR-P9 | ARCH-RULE-004, ARCH-RULE-005, ARCH-RULE-006, ARCH-RULE-008, ARCH-RULE-012, ARCH-RULE-014 | FIT-004, FIT-005, FIT-006, FIT-008, FIT-012, FIT-014 | — | — | — | — |
| US-023 | ASR-09, ASR-10 | ADR-P6, ADR-P9 | ARCH-RULE-004, ARCH-RULE-005, ARCH-RULE-006, ARCH-RULE-008, ARCH-RULE-012, ARCH-RULE-014 | FIT-004, FIT-005, FIT-006, FIT-008, FIT-012, FIT-014 | — | — | — | — |
| US-024 | ASR-04, ASR-05, ASR-06, ASR-07, ASR-08 | ADR-08, ADR-09, ADR-P3, ADR-12 | ARCH-RULE-006, ARCH-RULE-007, ARCH-RULE-010 | FIT-006, FIT-007, FIT-010 | — | — | — | — |
| US-025 | ASR-03, ASR-14 | ADR-11, ADR-P5, ADR-12 | ARCH-RULE-007, ARCH-RULE-008, ARCH-RULE-011, ARCH-RULE-012, ARCH-RULE-013 | FIT-007, FIT-008, FIT-011, FIT-012, FIT-013 | — | — | — | — |
| US-026 | ASR-08, ASR-09, ASR-14 | ADR-P6, ADR-P4 | ARCH-RULE-004, ARCH-RULE-006, ARCH-RULE-012, ARCH-RULE-013 | FIT-004, FIT-006, FIT-012, FIT-013 | — | — | — | — |
| US-029 | ASR-11, ASR-14, ASR-16 | ADR-10, ADR-P6, ADR-P4, ADR-DB-002 | ARCH-RULE-001, ARCH-RULE-004, ARCH-RULE-006, ARCH-RULE-013, ARCH-RULE-014 | FIT-001, FIT-004, FIT-006, FIT-013, FIT-014 | — | — | — | — |
| US-030 | ASR-09, ASR-11, ASR-16 | ADR-10, ADR-P6, ADR-DB-002 | ARCH-RULE-001, ARCH-RULE-004, ARCH-RULE-006, ARCH-RULE-009, ARCH-RULE-014 | FIT-001, FIT-004, FIT-006, FIT-009, FIT-014 | — | — | — | — |
| US-031 | ASR-09, ASR-11, ASR-16 | ADR-10, ADR-P6, ADR-DB-002 | ARCH-RULE-001, ARCH-RULE-004, ARCH-RULE-006, ARCH-RULE-009, ARCH-RULE-014 | FIT-001, FIT-004, FIT-006, FIT-009, FIT-014 | — | — | — | — |
| US-032 | ASR-09, ASR-10, ASR-11 | ADR-10, ADR-P6 | ARCH-RULE-004, ARCH-RULE-006, ARCH-RULE-014 | FIT-004, FIT-006, FIT-014 | — | — | — | — |
| US-033 | ASR-03, ASR-14 | ADR-11, ADR-P5 | ARCH-RULE-006, ARCH-RULE-011, ARCH-RULE-012, ARCH-RULE-013 | FIT-006, FIT-011, FIT-012, FIT-013 | — | — | — | — |
| US-034 | ASR-09, ASR-10, ASR-11 | ADR-10, ADR-P6 | ARCH-RULE-004, ARCH-RULE-006, ARCH-RULE-014 | FIT-004, FIT-006, FIT-014 | — | — | — | — |
| US-035 | ASR-09, ASR-10, ASR-11 | ADR-10, ADR-P6 | ARCH-RULE-004, ARCH-RULE-006, ARCH-RULE-014 | FIT-004, FIT-006, FIT-014 | — | — | — | — |
