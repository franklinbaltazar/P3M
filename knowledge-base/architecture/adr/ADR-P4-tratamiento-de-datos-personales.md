---
type: Architecture Decision Record
title: "ADR-P4 — Tratamiento de datos personales"
description: "Los datos personales se retienen por siempre, igual que los logs, y la política de clasificación, cifrado, acceso y borrado se aplaza como deuda técnica (DT-01)"
tags: [architecture, adr]
status: approved
generated:
  by: "claude-code (identificación manual)"
  at: "2026-10-11T13:00:00-05:00"
verified:
  by: "ianache (Functional Analysis)"
  at: "2026-10-12T15:00:00-05:00"
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

# ADR-P4 — Tratamiento de datos personales

## 1. Estado

**Aprobada por ianache el 2026-10-12**, en su rol de responsable funcional. No consta la revisión de un arquitecto distinto ni de Seguridad (la aceptación de Seguridad del aplazamiento se conoce solo por la declaración de ianache; falta el nombre del aceptante y una referencia).

## 2. Contexto

El ASR-14 pide tratar los datos personales (clasificación, cifrado, acceso y retención). La política G-12 no existe. El portal guarda datos personales de los colaboradores: nombres, correo, teléfono y dirección.

## 3. Decisión

1. **Retención:** los datos personales se retienen por siempre, igual que los logs (BR-101; respuesta U-01 del responsable, 2026-10-11, confirmada el 2026-10-12).
2. **Política aplazada:** la clasificación, el cifrado de columna, el control de acceso específico y el borrado a solicitud del titular **no se definen ahora**. Se tratan como deuda técnica **DT-01**, para una decisión futura (RQ-34).
3. **Lo que sí rige hoy:** los controles que ya existen y no se deben debilitar: cuentas con SSL obligatorio, mínimo privilegio por tabla, secretos en Vault, contactos que no se borran sino que se dan de baja (K-44) y contratos entre contextos que no llevan datos personales (ARCH-RULE-013).

## 4. Alternativas consideradas

Solo se registran las que se discutieron con el responsable. Definir la política G-12 completa ahora fue la alternativa; el responsable la descartó y pidió registrarla como deuda técnica.

## 5. Consecuencias

- No hay cifrado de columna, clasificación ni borrado a solicitud del titular. Los datos personales no tienen fecha de vencimiento.
- Si se retoma, el cambio llega por una migración nueva (Flyway) y puede exigir cifrar o anonimizar datos ya guardados. LDM-001 §10 describe el riesgo y la forma de retomarlo.
- La aprobación de este ADR **no** resuelve DT-01: la deuda sigue registrada en WP-DB-001.

## 6. Quién decidió

Responsable funcional, ianache (sin revisión de un arquitecto ni de Seguridad)

## 7. Preparación

- **Estado:** `approved` el 2026-10-12 por ianache.
- **Catálogo:** [CAT-ADR-001](../CAT-ADR-001-decisiones-de-arquitectura.md).
