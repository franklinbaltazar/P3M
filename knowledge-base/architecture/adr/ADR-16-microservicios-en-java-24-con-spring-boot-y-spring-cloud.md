---
type: Architecture Decision Record
title: "ADR-16 — Microservicios (core backend) en Java 24 con Spring Boot y Spring Cloud"
description: "Los microservicios del core backend se implementan en Java 24 con la última versión estable compatible de Spring Boot y Spring Cloud. Sustituye a ADR-07 (Python con FastAPI)."
tags: [architecture, adr, java, spring]
status: draft
supersedes: ADR-07
generated:
  by: "claude-code (redactado desde la declaración del responsable)"
  at: "2026-10-13T14:00:00-05:00"
sources:
  - id: declaracion-ianache-2026-10-13
    resource: "Declaración de ianache (responsable funcional) en sesión, 2026-10-13: los microservicios se implementan con Java 24 y la última versión de Spring Boot y Spring Cloud"
  - id: adr-07
    resource: /architecture/adr/ADR-07-microservicios-en-python-con-fastapi.md
  - id: adr-p2
    resource: /architecture/adr/ADR-P2-descomposicion-en-microservicios-y-su-comunic.md
  - id: maven-central
    resource: https://repo.maven.apache.org/maven2/org/springframework/
    trust: advisory
---

# ADR-16 — Microservicios (core backend) en Java 24 con Spring Boot y Spring Cloud

## 1. Estado

**Decisión declarada por el responsable (ianache) el 2026-10-13, en sesión.** Sustituye a [ADR-07](ADR-07-microservicios-en-python-con-fastapi.md). No consta la revisión de un arquitecto distinto. `draft`: falta su aprobación formal.

## 2. Contexto

ADR-07 fijaba Python con FastAPI para los microservicios (D-118) sin motivos ni alternativas. El responsable decidió que **los microservicios del core backend** se implementen en **Java 24** con **Spring Boot 4.0.8 y Spring Cloud 2025.1.3** (en un primer momento se dijo «la última versión»; ver §3). El BFF sigue siendo Next.js (ADR-01) y la SPA, Angular: esta decisión solo alcanza a los microservicios de dominio de [ADR-P2](ADR-P2-descomposicion-en-microservicios-y-su-comunic.md) (los cinco servicios `svc-*`).

No constan los motivos de la decisión ni las alternativas que se evaluaron. No se inventaron.

## 3. Decisión

1. **Lenguaje y plataforma:** los microservicios se escriben en **Java 24**.
2. **Marco:** **Spring Boot 4.0.8** y **Spring Cloud 2025.1.3** (decisión de ianache, 2026-10-13: «usar Spring Boot 4.0.8»; Spring Cloud 2025.1.3 es el tren estable construido sobre esa versión).
3. **Arquitectura interna:** hexagonal, con la organización de paquetes y las reglas de dependencia de [ADR-17](ADR-17-arquitectura-hexagonal-y-paquetes-de-los-microservicios.md).

### Versiones a la fecha de este ADR (verificadas en Maven Central, 2026-10-13)

| Componente | Última estable | Observación |
|---|---|---|
| Spring Boot | **4.1.1** | Hay un hito 4.2.0-M2 (no estable) |
| Spring Cloud | **2025.1.3** | Está construido sobre **Spring Boot 4.0.8**, no sobre 4.1.x |
| Spring Cloud 2026.0 | 2026.0.0-M1 | Hito (no estable); apunta a Spring Boot 4.2.0-M2 |
| Spring Framework | 7.0.9 | Línea de Spring Boot 4.0 |

**«La última versión» de Spring Boot y «la última versión» de Spring Cloud no son compatibles hoy:** Spring Boot 4.1.1 todavía no tiene un tren de Spring Cloud estable. **Decisión del responsable (ianache, 2026-10-13), una vez vista esta tabla: Spring Boot 4.0.8**, la última versión estable de Spring Boot para la que existe un tren de Spring Cloud estable, que es **Spring Cloud 2025.1.3**. Se pasa a Spring Boot 4.1.x cuando exista el tren estable de Spring Cloud 2026.0 (nueva decisión, no automática). Las versiones se fijan en un solo lugar de cada servicio (el BOM) y se revisan en cada Sprint de mantenimiento.

## 4. Alternativas consideradas

- **Python con FastAPI (ADR-07, la decisión anterior):** reemplazada. No constan los motivos del cambio.
- **Spring Boot 4.1.1 sin Spring Cloud, o con el tren 2026.0.0-M1 (hito):** no se adopta por defecto: la primera pierde los módulos de Spring Cloud que se prevé usar y el segundo no es una versión estable para producción.

No constan otras alternativas.

## 5. Consecuencias

**Riesgo declarado y verificable: Java 24 no es una versión de soporte a largo plazo (LTS).** Es una versión de seis meses cuyo soporte con actualizaciones públicas terminó cuando salió Java 25 (LTS, septiembre de 2025); hoy hay versiones posteriores. Con Java 24 los servicios **no reciben parches de seguridad** de las distribuciones habituales. Es un riesgo de seguridad y operación (R-xx a registrar). **Recomendación del equipo de gestión: Java 25 (LTS)**, que Spring Boot 4 soporta, como versión de producción. Se registra aquí la decisión tal como se declaró (Java 24) y se pide al responsable que confirme si se mantiene o se pasa a 25.

Lo que se deduce de la decisión, **sin decidirlo todavía**:

| Tema | Consecuencia | Afecta a |
|---|---|---|
| Servicio programado de GitLab | Celery no aplica. El planificador, la **única carga a la vez** y los reintentos deben resolverse en Java | [ADR-P3](ADR-P3-ejecucion-de-la-carga-programada-de-gitlab.md) (requiere revisión) |
| Reintentos y circuit breaker | Se pueden implementar con **Resilience4j** (Spring Cloud Circuit Breaker). Los parámetros siguen siendo los de ADR-09 | [ADR-09](ADR-09-reintentos-con-esperas-incrementales-y-circui.md) |
| Secretos | **Spring Cloud Vault** para leer `secret/p3m/*` | [ADR-12](ADR-12-secretos-y-parametros-en-hashicorp-vault.md), [ADR-P11](ADR-P11-rotacion-de-secretos-y-acceso-a-vault.md) |
| Seguridad entre servicios | **Spring Security como servidor de recursos OAuth2** valida el JWT de máquina y el token del usuario | [ADR-P9](ADR-P9-nombre-del-protocolo-de-consumo-seguro-bffmic.md), [ADR-P5](ADR-P5-estrategia-de-autorizacion-por-rol.md) |
| Mensajería | **Spring AMQP** o Spring Cloud Stream con RabbitMQ | [ADR-P2](ADR-P2-descomposicion-en-microservicios-y-su-comunic.md) |
| Concurrencia en la base de datos | El bloqueo de filas por colaborador (`SELECT ... FOR UPDATE`) se expresa con bloqueo pesimista de la capa de persistencia | [ADR-P6](ADR-P6-historial-con-vigencia-y-restricciones-en-mys.md) |
| Migraciones | Flyway se mantiene (es independiente del lenguaje) | [ADR-DB-003](ADR-DB-003.md) |
| API Gateway | Spring Cloud Gateway pasa a ser un candidato más, junto a Kong y KrakenD | [ADR-P8](ADR-P8-seleccion-del-api-gateway-kong-oss-o-krakend.md) |
| Observabilidad | Spring Boot Actuator y Micrometer exponen salud y métricas para Prometheus; logs a Loki | INF-DEC-27 |
| Contenedor | Imagen basada en un JDK/JRE de la versión elegida. Con Java 24 no hay imágenes con parches vigentes | [ADR-15](ADR-15-plataforma-contenerizada.md) |
| Esqueletos de código | Los 5 repositorios `p3m-svc-*` generados en Python/FastAPI quedan **obsoletos** y hay que regenerarlos en Java | `codebase/` |
| Spring Cloud | No se prevé service discovery ni Config Server: Kubernetes y Docker Compose resuelven los nombres, y los secretos van en Vault. Se adoptan **módulos sueltos** de Spring Cloud | (I) |

### Decisiones que faltan (no las toma este ADR)

| ID | Pregunta | Dueño |
|---|---|---|
| J-1 | ¿Java 24 se mantiene o se pasa a Java 25 (LTS)? | Responsable funcional y arquitectura |
| ~~J-2~~ | **Resuelta (ianache, 2026-10-13): Spring Boot 4.0.8 con Spring Cloud 2025.1.3** | — |
| J-3 | Herramienta de construcción: Maven o Gradle | Arquitectura |
| J-4 | Pila web: Spring MVC (con hilos virtuales) o WebFlux | Arquitectura |
| J-5 | Persistencia: JPA con Hibernate, JDBC o jOOQ (hay mapeo entre el modelo de dominio y el de persistencia, ver ADR-17) | Arquitectura |
| J-6 | Planificación de la carga de GitLab (reemplazo de Celery Beat) | Arquitectura ([ADR-P3](ADR-P3-ejecucion-de-la-carga-programada-de-gitlab.md)) |
| J-7 | Pruebas de contrato entre servicios (por ejemplo, Spring Cloud Contract) | Arquitectura y QA |

## 6. Requisitos a los que responde

[ASR-16](../asr/asr-16.md) (actualizado por este ADR), [ASR-18](../asr/asr-18.md), [ASR-17](../asr/asr-17.md).

## 7. Fuente

Declaración de ianache, 2026-10-13. Sustituye a D-118 en lo que dice del lenguaje de los microservicios (D-118 conserva MySQL 8.x y Redis).

## 8. Preparación

- **Estado:** `draft`. La decisión la declaró el responsable. Ningún arquitecto la revisó. Hay un riesgo explícito de seguridad (Java 24 sin LTS) que debe aceptarse o corregirse.
- **Catálogo:** [CAT-ADR-001](../CAT-ADR-001-decisiones-de-arquitectura.md).
