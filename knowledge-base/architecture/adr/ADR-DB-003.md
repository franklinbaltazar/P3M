# ADR-DB-003 — Physical target and migrations

Physical designs target MySQL 8.x, use explicit charset/collation and indexes, and are delivered as versioned, observable Flyway migrations. Destructive changes require an approved expand/contract or forward-fix strategy.

**Estado:** aprobado por ianache el 2026-10-12 (en su rol de responsable funcional; no consta la revisión de un arquitecto distinto).
