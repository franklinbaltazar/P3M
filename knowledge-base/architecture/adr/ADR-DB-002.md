# ADR-DB-002 — Domain ownership and boundaries

Each bounded context owns its aggregates and persistence. Hexagonal boundaries keep domain logic independent from adapters. Cross-domain data is exchanged through explicit contracts, identifiers or anti-corruption layers; shared tables are not the default.

**Estado:** aprobado por ianache el 2026-10-12 (en su rol de responsable funcional; no consta la revisión de un arquitecto distinto).
