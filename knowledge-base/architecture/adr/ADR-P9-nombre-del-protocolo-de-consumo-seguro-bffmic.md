---
type: Architecture Decision Record
title: "ADR-P9 — Nombre del protocolo de consumo seguro BFF–microservicios"
description: "Nombrar el protocolo de consumo seguro entre el BFF y los microservicios. Ya se decidió que no es JWT (D-122)"
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

# ADR-P9 — Protocolo de consumo seguro BFF–microservicios

## 1. Estado

Aceptada por el responsable el 2026-10-10. **Aprobada por ianache el 2026-10-12** (en su rol de responsable funcional; no consta la revisión de un arquitecto distinto).

## 2. Contexto

La fuente no nombraba el protocolo; se descartaron mTLS, API Key y HMAC.

## 3. Decisión

El BFF obtiene de Keycloak un token JWT con OAuth2 Client Credentials y lo presenta a los microservicios. Reemplaza al «no JWT» de D-122.

## 4. Alternativas consideradas

Solo se registran las que se discutieron con el responsable (ver la decisión). No se inventaron otras.

## 5. Consecuencias

Enmienda D-122 y ADR-13: el BFF usa un JWT de máquina, no el del usuario. Los microservicios aceptan un solo mecanismo (JWT de Keycloak, igual que desde el gateway). Se registró por respuesta «ok» a la recomendación del equipo de gestión.

**Nota del 2026-10-12 (ADR-P5):** el JWT de máquina autentica al BFF; no identifica al usuario. El BFF reenvía además el token del usuario y el servicio lo valida contra Keycloak. Esta nota no cambia la decisión de este ADR.

## 6. Quién decidió

Responsable funcional, ianache (sin revisión de seguridad)

## 7. Preparación

- **Estado:** `approved` el 2026-10-12 por ianache. Ningún arquitecto distinto la revisó.
- **Catálogo:** [CAT-ADR-001](../CAT-ADR-001-decisiones-de-arquitectura.md).
