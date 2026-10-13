---
type: ASR Candidate Catalog
title: "ASR Candidate Catalog — P3M"
description: "Catálogo de candidatos a requisitos arquitectónicamente significativos (ASR) de P3M, con su evidencia y su disposición humana pendiente."
tags: [architecture, asr]
status: draft
generated:
  by: "claude-code (renombrado según el skill asr-discovery)"
  at: "2026-10-11T15:00:00-05:00"
sources:
  - id: rcp-001
    resource: /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md
  - id: brc-001
    resource: /business/rules/BRC-001-reglas-de-negocio-portal-curricula.md
  - id: cat-adr-001
    resource: /architecture/CAT-ADR-001-decisiones-de-arquitectura.md
---

# ASR Candidate Catalog

## Metadata

- **Producto / iniciativa:** P3M (People, Product and Project Management)
- **Arquitecto:** Por definir
- **Fecha:** 2026-10-11
- **Versión:** 0.2.0 (renombrado de «ARS» a «ASR»; antes CAT-ARS-001)
- **Fuentes:** decisiones D-xx del pack [RCP-001](../../requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md) y reglas BR-xxx de [BRC-001](../../business/rules/BRC-001-reglas-de-negocio-portal-curricula.md). Las decisiones de arquitectura que los atienden están en [CAT-ADR-001](../CAT-ADR-001-decisiones-de-arquitectura.md).
- **Criterio:** un NFR no es automáticamente un ASR. Las tecnologías impuestas se tratan como restricciones. No se inventaron objetivos de SLO, SLA, disponibilidad, RTO o RPO.
- **Clasificación de la evidencia:** FACT, INFERENCE, ASSUMPTION, UNKNOWN o CONFLICT.

## Candidates

| ID | Requirement | Quality Concern | Why Architecture-Significant? | Impact Evidence | Evidence IDs | Confidence | Missing Evidence | Human Disposition |
|---|---|---|---|---|---|---|---|---|
| [ASR-01](asr-01.md) | Los usuarios ingresan al portal autenticándose en Keycloak, sin comprometer datos sensibles en el navegador (SPA Angular con BFF Next.js y PKCE) | Seguridad | Condiciona las decisiones de arquitectura ADR-01, ADR-02 y el atributo de calidad «Seguridad». Si el requisito cambia, esas decisiones cambian. | BR-095, D-115 | BR-095, D-115 | Alta | Decisión humana, alta | PENDIENTE |
| [ASR-02](asr-02.md) | El cierre de sesión es a demanda o por vencimiento controlado por Keycloak, y la sesión del portal y la de Keycloak están alineadas | Seguridad | Condiciona las decisiones de arquitectura ADR-02, ADR-03 y el atributo de calidad «Seguridad». Si el requisito cambia, esas decisiones cambian. | BR-096, D-116 | BR-096, D-116 | Alta | Decisión humana, alta. Faltan el tiempo de sesión, la anticipación del aviso y la renovación (RQ-31) | PENDIENTE |
| [ASR-03](asr-03.md) | Los roles de usuario son colaborador, Instructor, Jefe de Ingeniería y ADMIN, y se asignan en Keycloak. El portal registra al usuario al iniciar sesión con GUID, username, correo y roles | Seguridad / control de acceso | Condiciona las decisiones de arquitectura ADR-02, ADR-11 y el atributo de calidad «Seguridad / control de acceso». Si el requisito cambia, esas decisiones cambian. | BR-044, BR-062, BR-074, BR-075, BR-077, D-80, D-84 a D-86 | BR-044, BR-062, BR-074, BR-075, BR-077, D-80, D-84, D-86 | Alta | Decisión humana, alta. Falta saber si se actualiza en cada inicio (RQ-22) | PENDIENTE |
| [ASR-04](asr-04.md) | La integración con GitLab es de solo lectura, con credenciales de servicio de solo lectura | Seguridad | Condiciona las decisiones de arquitectura ADR-08, ADR-12 y el atributo de calidad «Seguridad». Si el requisito cambia, esas decisiones cambian. | BR-036, BR-037, D-29, D-33 | BR-036, BR-037, D-29, D-33 | Alta | Decisión humana. Falta cómo se otorgan las credenciales (RQ-09). El PAT y la URL base están en Vault (D-124) | PENDIENTE |
| [ASR-05](asr-05.md) | La información de GitLab se carga de forma automática y programada, cada 30 segundos por defecto, solo con lo creado o actualizado desde la carga más reciente (delta de cambio). La primera carga es completa. Las funcionalidades no consultan a GitLab directamente | Rendimiento y eficiencia de transferencia | Condiciona las decisiones de arquitectura ADR-08, ADR-06 y el atributo de calidad «Rendimiento y eficiencia de transferencia». Si el requisito cambia, esas decisiones cambian. | BR-039, BR-065, BR-094, D-69, D-71, D-114 | BR-039, BR-065, BR-094, D-69, D-71, D-114 | Alta | Decisión humana, alta | PENDIENTE |
| [ASR-06](asr-06.md) | Una carga fallida se reintenta 3 veces con esperas incrementales y un circuit breaker evita saturar a GitLab. Los parámetros del anexo B del pack son una propuesta según buenas prácticas | Disponibilidad y resiliencia | Condiciona las decisiones de arquitectura ADR-09 y el atributo de calidad «Disponibilidad y resiliencia». Si el requisito cambia, esas decisiones cambian. | BR-082, D-100, D-111 | BR-082, D-100, D-111 | Media | Decisión humana para el patrón; parámetros propuestos, sin confirmar | PENDIENTE |
| [ASR-07](asr-07.md) | Si GitLab no responde, el portal muestra «datos al <fecha y hora de la última carga exitosa>» en UTC-05 | Degradación controlada | Condiciona las decisiones de arquitectura ADR-08, ADR-09 y el atributo de calidad «Degradación controlada». Si el requisito cambia, esas decisiones cambian. | BR-092, D-112 | BR-092, D-112 | Alta | Decisión humana, alta | PENDIENTE |
| [ASR-08](asr-08.md) | Los logs de las cargas (fecha y hora, estado exitosa o fallida, reintento) se retienen por siempre. Cada evaluación de desempeño registra fecha y hora y el usuario que la registra | Auditabilidad y retención | Condiciona las decisiones de arquitectura ADR-08, ADR-05 y el atributo de calidad «Auditabilidad y retención». Si el requisito cambia, esas decisiones cambian. | BR-066, BR-087, BR-090, D-70, D-105, D-110 | BR-066, BR-087, BR-090, D-70, D-105, D-110 | Alta | Decisión humana, alta | PENDIENTE |
| [ASR-09](asr-09.md) | Se conservan historiales con vigencia: rol/nivel del colaborador, asignaciones, jefe de proyecto, «reporta a», membresía a organizaciones, valoraciones y evaluaciones de desempeño | Trazabilidad histórica | Condiciona las decisiones de arquitectura ADR-10, ADR-05 y el atributo de calidad «Trazabilidad histórica». Si el requisito cambia, esas decisiones cambian. | BR-051, BR-063, BR-071, BR-076, BR-078, BR-079, BR-080, BR-089 | BR-051, BR-063, BR-071, BR-076, BR-078, BR-079, BR-080, BR-089 | Alta | Decisión humana, alta | PENDIENTE |
| [ASR-10](asr-10.md) | Restricciones que el sistema debe garantizar: suma de dedicación ≤ 100 %, un milestone en un único proyecto, una sola membresía vigente y un solo jefe por colaborador, evaluación obligatoria para promover, evidencias solo de issues cerrados | Integridad de datos | Condiciona las decisiones de arquitectura ADR-05 y el atributo de calidad «Integridad de datos». Si el requisito cambia, esas decisiones cambian. | BR-020, BR-071, BR-076, BR-088, BR-091, BR-093 | BR-020, BR-071, BR-076, BR-088, BR-091, BR-093 | Alta | Decisión humana, alta | PENDIENTE |
| [ASR-11](asr-11.md) | El registro de colaboradores y sus relaciones se alinea con el Universal Data Model (UDM): persona, rol, relación entre partes, mecanismos de contacto, organización | Modificabilidad e interoperabilidad de datos | Condiciona las decisiones de arquitectura ADR-10 y el atributo de calidad «Modificabilidad e interoperabilidad de datos». Si el requisito cambia, esas decisiones cambian. | D-74, D-76 a D-79, D-81, D-83, D-87 | D-74, D-76, D-79, D-81, D-83, D-87 | Media | Decisión humana. La correspondencia con el UDM es propuesta del modelo (IMD-001, sección 5.1) | PENDIENTE |
| [ASR-14](asr-14.md) | Se tratan datos personales (nombres, apellidos, correo, teléfono, dirección, evaluación del colaborador). La política de datos personales está pendiente | Privacidad y cumplimiento | Condiciona las decisiones de arquitectura ADR-P4 y el atributo de calidad «Privacidad y cumplimiento». Si el requisito cambia, esas decisiones cambian. | BR-003, G-12, BR-070, BR-087 | BR-003, BR-070, BR-087, G-12 | Media | Parcial: falta la política (G-12) | PENDIENTE |
| [ASR-17](asr-17.md) | Los parámetros y los datos sensibles se mantienen en HashiCorp Vault, bajo `secret/p3m/*`: credenciales de MySQL, usuario y contraseña de Redis, PAT de GitLab y URL base de GitLab | Seguridad | Condiciona las decisiones de arquitectura ADR-12 y el atributo de calidad «Seguridad». Si el requisito cambia, esas decisiones cambian. | D-119, D-124 | D-119, D-124 | Alta | Decisión humana, alta. Faltan la rotación y cómo se autentica cada componente en Vault | PENDIENTE |
| [ASR-18](asr-18.md) | La integración entre el BFF y los microservicios usa un protocolo para el consumo seguro, sin token JWT | Seguridad | Condiciona las decisiones de arquitectura ADR-13 y el atributo de calidad «Seguridad». Si el requisito cambia, esas decisiones cambian. | D-120, D-122 | D-120, D-122 | Media | Decisión humana. La fuente no nombra el protocolo | PENDIENTE |
| [ASR-19](asr-19.md) | Los microservicios deben poder ser consumidos de forma segura por otras aplicaciones, además del Portal, a través de un API Gateway (Kong o KrakenD, variante OSS) integrado con Keycloak, que entrega un token JWT | Interoperabilidad y seguridad | Condiciona las decisiones de arquitectura ADR-14 y el atributo de calidad «Interoperabilidad y seguridad». Si el requisito cambia, esas decisiones cambian. | D-121, D-123 | D-121, D-123 | Media | Decisión humana. No se eligió el producto (ver EVA-001) ni se identificó a los consumidores | PENDIENTE |

## Constraints

Requisitos que fijan una tecnología, un estándar o una forma de despliegue. No se tratan como candidatos a ASR hasta que el arquitecto los clasifique.

| ID | Constraint | Tipo | Fuente |
|---|---|---|---|
| [ASR-12](asr-12.md) | La arquitectura incluye micro UI en Angular y un catálogo de componentes de interfaz reutilizables basado en Atomic Design | Restricción | D-117 |
| [ASR-13](asr-13.md) | El BFF usa Redis para el caching de datos | Restricción | D-118 |
| [ASR-15](asr-15.md) | La interfaz cumple WCAG 2.2 AA | NFR (estándar del repositorio) | Estándar del repositorio, citado en todas las historias |
| [ASR-16](asr-16.md) | Base de datos MySQL 8.x, microservicios en Python con FastAPI, SPA en Angular y BFF en Next.js | Restricción | D-115, D-118 |
| [ASR-20](asr-20.md) | La plataforma está completamente contenerizada | Restricción | D-125 |

## Rejected Candidates

Ninguno. Solo el arquitecto puede rechazar un candidato (`REJECT`).

## Knowledge Gaps

| Vacío | Afecta a | Pregunta |
|---|---|---|
| Volumen: número de colaboradores, productos, proyectos y usuarios concurrentes | ASR-05, ASR-13 | No hay cifras en las fuentes. Sin ellas no se pueden fijar objetivos de rendimiento ni de capacidad |
| Objetivos de disponibilidad y de recuperación (RTO y RPO) | ASR-06, ASR-07 | Sin respuesta |
| Tiempo de sesión, aviso previo y cierre global | ASR-02 | RQ-31 |
| Qué se guarda en Redis, por cuánto tiempo y si guarda la sesión del BFF | ASR-13, ASR-02 | Anotado en el anexo C del pack |
| Alcance de solo lectura del PAT de GitLab | ASR-04 | Por confirmar (ADR-P11) |
| Política de datos personales y retención de esos datos | ASR-14 | G-12 |
| Límites entre microservicios y forma de comunicación con el BFF | ASR-16 | Sin respuesta (ADR-P2) |
| Qué aplicaciones y terceros consumirán las API, con qué límites de uso | ASR-19 | Sin respuesta (ADR-P10) |
| Nombre del protocolo de consumo seguro entre el BFF y los microservicios | ASR-18 | Sin respuesta (ADR-P9) |
| Rotación de secretos y cómo se autentica cada componente en Vault | ASR-17 | Sin respuesta (ADR-P11) |

## Human Validation

- **Estado:** CONDITIONAL. Ningún candidato tiene disposición humana.
- **Decisión humana requerida:** un arquitecto clasifica cada candidato como `CANDIDATE`, `REJECT` o `INVESTIGATE` y confirma las restricciones.
