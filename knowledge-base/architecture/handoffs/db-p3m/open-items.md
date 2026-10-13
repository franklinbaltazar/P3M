---
type: Open Items
title: "Open Items — Base de datos del P3M"
description: "Supuestos, desconocidos, conflictos, evidencia ausente y decisiones abiertas del handoff de base de datos."
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

# Open Items

| ID | Type | Description | Evidence | Blocking | Owner | Action |
|---|---|---|---|---|---|---|
| OI-01 | OPEN_DECISION | **Resuelto en parte.** ianache aprobó el 2026-10-12 ADR-P2, P3, P6, P7, P9 y ADR-DB-001/002/003, en su rol de responsable funcional. **ADR-P5 no se aprobó** (OI-04, OI-18). No consta la revisión de un arquitecto distinto. Las reglas ARCH-RULE siguen en `PROPOSED` hasta que el Solution Architect las apruebe. | CAT-ADR-001, ADR-P2, ADR-P6 | No | Solution Architect | Aprobar o devolver las reglas ARCH-RULE |
| OI-02 | MISSING_EVIDENCE | Los 20 ASR tienen disposición humana PENDIENTE. Ninguno está clasificado como `CANDIDATE`, `REJECT` o `INVESTIGATE`. | asr-catalog, asr-01 a asr-20 | No | Solution Architect | Clasificar los ASR citados (ASR-03 a ASR-11, ASR-14, ASR-16 a ASR-18, ASR-20) |
| OI-03 | OPEN_DECISION | ADR-P4 (datos personales) fue **aprobada el 2026-10-12** y su decisión es aplazar la política (DT-01): sin clasificación, cifrado de columna, acceso ni borrado a solicitud del titular; los datos personales se retienen por siempre (BR-101). **Seguridad aceptó el aplazamiento (DT-01)** según ianache el 2026-10-12; no consta el nombre del aceptante ni una referencia. | ADR-P4, RPT-DDR-001 R-05, LDM-001 §4, PDM-001 D-H40 | No para el esquema. Sí antes de producción decidir ADR-P4 | Seguridad y responsable funcional | Adjuntar el nombre y la referencia de la aceptación; decidir ADR-P4 y aplicarlo con una migración nueva |
| OI-04 | FACT | **RESUELTO el 2026-10-12:** ianache respondió P5-D1 a P5-D7 y aprobó ADR-P5 (con su anexo). Antes: ADR-P5: el mapa rol-permiso está **propuesto** en `ADR-P5-anexo-mapa-rol-permiso-propuesta.md` y **no aprobado**. Hay 7 decisiones pendientes (P5-D1 a P5-D7). Los permisos de negocio (BR-002, BR-005, BR-055, BR-109 y otros) los aplica el servicio. | ADR-P5, anexo de ADR-P5 | No para el esquema. Sí para la capa de servicios | Arquitectura y responsable funcional | Responder P5-D1 a P5-D7 y aprobar ADR-P5 antes de implementar los servicios |
| OI-05 | OPEN_DECISION | Alojamiento y modo de alta disponibilidad de MySQL: ¿servicio gestionado o contenedor?, ¿replicación semisíncrona o de grupo? (INF-DEC-11). INF-DEC-23 exige conmutación en minutos. | INF-P3M-001 INF-DEC-11, INF-DEC-23 | No para las migraciones. Sí antes de producción | Arquitectura e infraestructura | Decidirlo y probar la conmutación |
| OI-06 | MISSING_EVIDENCE | La recuperación de MySQL no está verificada: sin conmutación ni restauración de prueba contra 99,9 % / RTO 4 h / RPO 1 h. **Aceptado como deuda técnica DT-04** (D-H39), confirmado por ianache el 2026-10-12 (D-H43). | RPT-DDR-001 R-10, PDM-001 §8 | No | Infraestructura | Conmutación y restauración de prueba antes de producción |
| OI-07 | UNKNOWN | Carga parcial: más de 50 colaboradores. Faltan usuarios concurrentes, volumen de issues, crecimiento e IOPS (DT-02). Los índices cubren solo restricciones y consultas de contrato. | INF-P3M-001 INF-Q03, PDM-001 §8 | No | Arquitectura | Revisar los índices con datos reales y el registro de consultas lentas |
| OI-08 | OPEN_DECISION | Issues de tipo «Proyecto» (BR-039) y campos que BR-038 manda mostrar (esfuerzo estimado, esfuerzo gastado, fecha de vencimiento): la réplica no los guarda (DT-03). | BRC-001 RQ-35, RPT-DDR-001 R-03 | No | Jefe de Ingeniería | Decidir el tratamiento y añadir una `V2` de `p3m_gitlab` |
| OI-09 | ASSUMPTION | Ningún ambiente aplicó los `V1` anteriores de `p3m_partes`, `p3m_identidad` y `p3m_portafolio`. El responsable aprobó F-18 sin confirmarlo expresamente. | PDM-001 F-18 | No | Responsable funcional | Confirmarlo. Si algún ambiente los aplicó, añadir una `V2` por esquema |
| OI-10 | STALE_EVIDENCE | **Resuelto en parte.** IMD-001, BRC-001, RCP-001 y las seis historias actualizadas fueron **verificadas por ianache el 2026-10-12** (D-H41). Siguen desfasados los issues de GitLab #17, #19 y #21 y TRC-SSP-001, que reflejan la versión anterior de las historias. Las historias US-029 a US-035 son nuevas y están en `draft`. | PDM-001 D-H41, RPT-DDR-001 | No | Análisis funcional | Republicar los issues y la trazabilidad; verificar las historias nuevas |
| OI-11 | UNKNOWN | **Resuelto en parte.** Se redactaron el 2026-10-12 las historias US-029 (contactos), US-030 (plazas), US-031 (ocupaciones), US-032 (roles de la parte), US-033 (corrección de vínculo) y US-034 (relaciones). Cinco están CONDITIONAL y una READY; todas en `draft`. **Se redactó después US-035 para el registro de las organizaciones** (BR-072). | US-029 a US-035, LDM-001, IMD-001 | No | Análisis funcional | Verificar las historias, responder sus preguntas y redactar la de organizaciones |
| OI-12 | ASSUMPTION | Se asume un servicio por contexto (7). ADR-P2 dice que falta enumerar los servicios; DDM-001 enumera contextos, no servicios. | ADR-P2 §5, DDM-001 §1 | No | Arquitectura | Confirmar el número y el nombre de los servicios |
| OI-13 | OPEN_DECISION | Parámetros operativos de los contratos internos (tiempos de espera, circuit breaker, reintentos). ADR-09 solo propone parámetros para GitLab. | ICP-001 §6 | No para el esquema. Sí para los servicios | Infraestructura | Fijarlos antes de implementar los clientes de contrato |
| OI-14 | UNKNOWN | Preguntas abiertas de las historias que afectan a la implementación: US-010-Q2 (el desenrolamiento y el registro), US-025-Q1 y US-025-Q2 (datos que no entrega Keycloak; correo ya vinculado), RQ-32 (permiso del jefe de proyecto), RQ-33 (roles de la parte simultáneos), RQ-22 (actualizar el usuario en cada inicio). | US-010, US-025, US-019, BRC-001 | No | Jefe de Ingeniería | Responderlas antes de implementar cada historia |
| OI-15 | UNKNOWN | INF-Q17: cómo se federa Keycloak con Active Directory y qué pasa si no responde. Afecta al ingreso (US-025, US-027). | INF-P3M-001 INF-Q17, INF-DEC-22 | No | Infraestructura y seguridad | Definirlo |
| OI-16 | CONFLICT | INF-P3M-001 mantiene INF-DEC-02 como «PENDIENTE» (plataforma de contenedores) mientras ADR-P7 decide Docker local y Kubernetes en Oracle OKE. Queda por confirmar si DEV también va en OKE. | INF-P3M-001 INF-DEC-02, ADR-P7 | No | Arquitectura | Alinear INF-DEC-02 con ADR-P7 |
| OI-17 | OPEN_DECISION | Fuera de este alcance: US-027 y US-028 (ingreso y cierre de sesión) no usan la base de datos; los resuelven el BFF y Keycloak. | US-027, US-028 | No | Arquitectura | Transferir en otro pack |
| OI-18 | FACT | **RESUELTO el 2026-10-12 (P5-D1 = A):** el BFF reenvía el token del usuario además del JWT de máquina y cada servicio lo valida contra Keycloak; ADR-P9 no cambia. Antes: ADR-P5 dice que cada microservicio valida el rol del usuario; ADR-P9 (aprobado) hace que el BFF llame con un JWT de máquina, no el del usuario. El servicio no recibe la identidad ni los roles del usuario, ni el GUID del actor que exige ARCH-RULE-012. Opciones y recomendación en el anexo de ADR-P5 (G-1). | ADR-P5, ADR-P9, anexo de ADR-P5, ICP-001 D-H20 | No para el esquema. **Sí para implementar los servicios** | Arquitectura y responsable funcional | Decidir P5-D1 (recomendación: reenviar el token del usuario además del de máquina) |
| OI-19 | FACT | RESUELTO el 2026-10-12 (D-160, BR-131: toda parte tiene contactos; F-19). Faltan tipos y obligatoriedad para organizaciones (RQ-36). Antes: BR-121 y D-150 dicen que solo las personas tienen contactos; el responsable indicó el 2026-10-12 «contactos de las Party (Person u Organization)». Afecta a `dato_de_contacto`, que hoy solo se relaciona con `persona`. | BRC-001 BR-121, US-029-Q1 | Parcial: bloquea la parte de organizaciones de US-029 y un posible cambio del esquema | Jefe de Ingeniería | Confirmar si las organizaciones tienen contactos, con qué tipos y cuáles obligatorios; si es así, registrar la decisión y añadir una migración |
| OI-20 | FACT | **RESUELTO el 2026-10-12 (D-166, BR-135):** los mantienen el Jefe de Ingeniería y el ADMIN. Antes: Ninguna regla dice quién mantiene los contactos, plazas, ocupaciones, roles de la parte y relaciones. Las historias lo asumen como hipótesis (Jefe de Ingeniería o ADMIN, por analogía con BR-002). | US-029 a US-035, anexo de ADR-P5 (P5-D6) | No para el esquema | Jefe de Ingeniería | Responder P5-D6 |
| OI-21 | ASSUMPTION | Los nombres de rol de Keycloak (ADMIN, COLABORADOR, INSTRUCTOR, JEFE_INGENIERIA) son un supuesto del responsable (D-164); no se contrastaron con la configuración real de Keycloak. El DDL (`ck_usuario_rol`) y ACL-01 ya los usan. | ADR-P5 §3.4, ICP-001 ACL-01, `p3m_identidad` V1 (F-20) | No para el esquema. Sí para implementar los servicios | Infraestructura / responsable funcional | Contrastar con Keycloak antes de implementar la autorización |
| OI-22 | STALE_EVIDENCE | BR-134 (D-165): el ADMIN suple las seis capacidades exclusivas del Jefe de Ingeniería. Las historias aprobadas US-002, US-003, US-006, US-007, US-008, US-017, US-021, US-022 y US-026 aún dicen «solo el Jefe de Ingeniería». Cambiarlas devuelve a `draft` lo verificado. | US-002, 003, 006, 007, 008, 017, 021, 022, 026; BRC-001 C-12 | No para el esquema | Jefe de Ingeniería | Decidir si se actualizan esas historias y se verifican de nuevo |
