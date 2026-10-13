---
type: Architecture Decision Record
title: "ADR-P5 — Estrategia de autorización por rol"
description: "Autorización por rol: guards en Angular, BFF con rol grueso y cada microservicio con rol más condición del recurso, usando el token del usuario reenviado por el BFF"
tags: [architecture, adr]
status: approved
generated:
  by: "claude-code (identificación manual)"
  at: "2026-10-11T13:00:00-05:00"
verified:
  by: "ianache (Functional Analysis)"
  at: "2026-10-12T17:00:00-05:00"
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

# ADR-P5 — Estrategia de autorización por rol

## 1. Estado

Aceptada por el responsable el 2026-10-10. **Aprobada por ianache el 2026-10-12** (D-163 a D-166 de RCP-001 y las respuestas P5-D1 a P5-D7 del anexo). No consta la revisión de un arquitecto distinto.

## 2. Contexto

Las reglas dicen quién puede hacer qué, pero no dónde se aplica. ADR-P9 hace que el BFF llame a los microservicios con un JWT de máquina, que no identifica al usuario; ADR-P5 pedía que cada servicio validara el rol del usuario. El anexo [ADR-P5-anexo](ADR-P5-anexo-mapa-rol-permiso-propuesta.md) detalla las brechas y el mapa rol-permiso.

## 3. Decisión

1. **Dónde se comprueba (P5-D2):** los guards de Angular activan o desactivan elementos de la interfaz; el BFF comprueba el rol grueso y oculta lo que no corresponde; **cada microservicio comprueba el rol y la condición del recurso y es la fuente de verdad**. Los guards no son un control de seguridad.
2. **Identidad del usuario en los servicios (P5-D1, opción A):** el BFF llama a cada microservicio con el JWT de máquina de ADR-P9, que autentica al BFF, **y reenvía además el token del usuario**. El servicio valida ese token contra Keycloak (JWKS) y obtiene de él el `sub` (actor de las escrituras, ARCH-RULE-012) y los roles. No se envían `sub` ni roles en cabeceras sin firma. ADR-P9 no cambia.
3. **Rol más condición (P5-D2):** los permisos de la forma «rol y dato» (evaluador de esa edición, jefe vigente de ese proyecto, dueño del registro) se deciden con el rol del token **más** la condición del recurso, comprobada con CON-01, CON-09 y `evaluador_ref`.
4. **Nombres de rol en Keycloak (P5-D4):** `ADMIN`, `COLABORADOR`, `INSTRUCTOR` y `JEFE_INGENIERIA`. Los **definió el responsable** (2026-10-12).
5. **Mapa rol-permiso:** el de la sección 3 del anexo, con estos cambios: el ADMIN suple las seis capacidades exclusivas del Jefe de Ingeniería (BR-134, P5-D5); el Jefe de Ingeniería y el ADMIN mantienen contactos, plazas, ocupaciones, roles de la parte, relaciones y organizaciones (BR-135, P5-D6).
6. **BR-003 (P5-D3):** se mantiene. Cualquier usuario autenticado consulta datos personales de los colaboradores; el riesgo se trata como parte de DT-01 (ADR-P4).

## 4. Alternativas consideradas

Para la identidad del usuario: B, intercambio de token (RFC 8693), y C, contexto del usuario en cabeceras. Se descartaron: B por más configuración sin necesidad actual y C porque el servicio confiaría a ciegas en el BFF. Para BR-003, restringirlo a Jefe de Ingeniería, ADMIN y el propio colaborador; el responsable decidió mantenerlo.

## 5. Consecuencias

- El BFF debe guardar y reenviar el token del usuario (ya lo guarda por PKCE) y manejar su caducidad.
- Cada servicio valida dos credenciales: la de máquina (quién llama) y la del usuario (en nombre de quién).
- Los datos personales siguen visibles para cualquier usuario autenticado hasta que se retome DT-01.
- Las historias que decían «solo el Jefe de Ingeniería» (US-002, US-003, US-006, US-007, US-008, US-017, US-021, US-022 y US-026) se actualizaron el 2026-10-12 y esperan una nueva verificación.

## 6. Quién decidió

Responsable funcional, ianache (sin revisión de un arquitecto distinto)

## 7. Preparación

- **Estado:** `approved` el 2026-10-12 por ianache.
- **Catálogo:** [CAT-ADR-001](../CAT-ADR-001-decisiones-de-arquitectura.md).
