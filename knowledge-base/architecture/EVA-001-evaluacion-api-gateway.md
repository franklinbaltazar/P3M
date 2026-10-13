---
type: Architecture Evaluation
title: "EVA-001 — Evaluación del API Gateway: Kong OSS frente a KrakenD CE"
description: "Evaluación comparativa para sustentar el ADR-14 (API Gateway integrado con Keycloak para exponer las API de los microservicios con token JWT). Recomienda una opción y lista lo que debe verificarse con una prueba de concepto."
tags: [architecture, evaluation, api-gateway, kong, krakend, keycloak]
status: draft
generated:
  by: "claude-code (evaluación asistida)"
  at: "2026-10-11T12:00:00-05:00"
sources:
  - id: rcp-001
    resource: /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md
  - id: cat-adr-001
    resource: /architecture/CAT-ADR-001-decisiones-de-arquitectura.md
  - id: krakend-keycloak
    resource: https://www.krakend.io/docs/v2.7/authorization/keycloak
  - id: kong-jwks
    resource: https://developer.konghq.com/support/configure-kong-to-handle-public-key-rotation-for-consumer-credentials-without-hardcoding-the-public-key/
  - id: kong-oidc
    resource: https://developer.konghq.com/plugins/openid-connect/
---

# EVA-001 — Evaluación del API Gateway

## 1. Pregunta y alcance

El responsable decidió (D-121, D-123) que las API de los microservicios las consuman terceros y otras aplicaciones, además del Portal, a través de un API Gateway basado en Kong o KrakenD, en su variante OSS, integrado con Keycloak para obtener un token JWT. Esta evaluación sustenta la elección del producto (ADR-P8). **Es una recomendación, no una decisión**: la decide Arquitectura.

Contexto que condiciona la elección: plataforma completamente contenerizada (D-125), microservicios en Python con FastAPI (D-118; sustituido el 2026-10-13 por Java con Spring Boot, ADR-16: **Spring Cloud Gateway pasa a ser un candidato más** que esta evaluación no analizó), secretos en Vault (D-124) y el BFF usa un protocolo propio de consumo seguro, no el gateway ni JWT (D-122).

## 2. Hechos verificados y límites de la evidencia

| Afirmación | Fuente | Confianza |
|---|---|---|
| KrakenD valida el JWT de Keycloak con `auth/validator`, leyendo las claves públicas desde la URL JWK del realm. Valida la firma de cada llamada sin consultar a Keycloak (sin introspección) | [Documentación de KrakenD sobre Keycloak](https://www.krakend.io/docs/v2.7/authorization/keycloak) | Alta para el mecanismo. La documentación consultada es de versiones antiguas: confirmar la sintaxis de la versión vigente |
| KrakenD CE usa la licencia Apache-2.0 y se describe como sin estado y con configuración declarativa (GitOps), cada nodo independiente | [Repositorio krakend-ce](https://github.com/krakend/krakend-ce) | Alta |
| El plugin JWT de Kong en la edición abierta guarda la clave pública como credencial de un consumidor y no soporta rotación automática de claves | [Soporte de Kong sobre rotación de claves](https://developer.konghq.com/support/configure-kong-to-handle-public-key-rotation-for-consumer-credentials-without-hardcoding-the-public-key/) | Media: el artículo no precisa la versión |
| El plugin OpenID Connect de Kong obtiene las claves desde el JWKS del emisor y las rota solo. Según mensajes de foros, solo está disponible en la edición comercial | [Plugin OpenID Connect de Kong](https://developer.konghq.com/plugins/openid-connect/) y foros de Kong | Baja para la restricción de licencia: no hallé confirmación oficial actual |
| El repositorio de Kong declara la licencia Apache-2.0 y su README no distingue una edición abierta ni lista las funciones solo comerciales | [Repositorio Kong](https://github.com/Kong/kong) | Alta para la licencia |
| La continuidad de la edición abierta de Kong es incierta: un sitio de seguimiento muestra 3.9 como la última versión de la edición comunitaria con fin de soporte en 12/2025, y un mensaje de foro dice que ya no hay versión abierta desde 3.9.1. No hay anuncio oficial en las fuentes consultadas | [endoflife.date](https://endoflife.date/kong-gateway) (consultada 2026-10-11) | **Baja. Verificar** |

## 3. Criterios y puntuación

Puntuación de 1 (débil) a 5 (fuerte), criterio del evaluador sobre la evidencia de la sección 2. Los pesos se proponen según los requisitos ASR-03, ASR-17, ASR-19 y ASR-20 y deben confirmarse.

| Criterio | Peso | KrakenD CE | Kong OSS | Razón |
|---|---|---|---|---|
| Integración con Keycloak y JWT con rotación de claves | 30 % | 5 | 2 | KrakenD valida con la URL JWK sin configuración adicional. En Kong OSS el plugin JWT exige cargar la clave y no la rota. La alternativa con rotación (OpenID Connect) sería solo comercial |
| Licencia abierta y continuidad de la edición | 20 % | 4 | 3 | Ambos Apache-2.0. En KrakenD algunas funciones son de la edición de pago. En Kong la continuidad de la edición abierta es incierta |
| Operación contenerizada y declarativa | 15 % | 5 | 4 | KrakenD es sin estado y declarativo, sin base de datos. Kong puede correr sin base de datos pero su operación habitual usa una |
| Gestión de clientes terceros | 10 % | 3 | 4 | En KrakenD los clientes se gestionan en Keycloak y los cambios de configuración exigen redesplegar. Kong ofrece consumidores y una API de administración |
| Extensibilidad y ecosistema de plugins | 10 % | 3 | 5 | Kong tiene un ecosistema más amplio |
| Rendimiento y consumo de recursos | 5 % | 4 | 4 | Ambos son de alto rendimiento. No se midió |
| Madurez, comunidad y soporte | 10 % | 3 | 5 | Kong tiene mayor base instalada |
| **Total ponderado** | 100 % | **4,15** | **3,40** | |

## 4. Recomendación

Se recomienda **KrakenD Community Edition**, sujeta a la prueba de concepto de la sección 5. Los motivos principales son la validación nativa del JWT de Keycloak con rotación de claves por URL JWK, la configuración declarativa sin estado (encaja con la contenerización) y la menor incertidumbre sobre la edición abierta.

Sería preferible **Kong** si Arquitectura valora más: un ecosistema de plugins amplio, la gestión dinámica de consumidores por API de administración, o si dispone de la edición comercial que incluye OpenID Connect.

## 5. Prueba de concepto antes de decidir

| Prueba | Criterio de éxito |
|---|---|
| Validar un JWT emitido por Keycloak con rotación de claves del realm | Se aceptan los tokens válidos y se rechazan los vencidos o con firma inválida, también tras rotar la clave |
| Control por rol y alcance del token | Se restringen rutas por rol y alcance. Confirmar en la edición abierta si el control por alcance está disponible |
| Un tercero con su propio cliente de Keycloak | Obtiene un token y consume solo las API que se le autorizaron |
| Límite de uso por cliente | Se limita el uso por cliente sin afectar al Portal |
| Contenedor y configuración desde Vault | Arranca sin secretos en la imagen y toma la configuración declarativa de forma reproducible |
| Observabilidad | Registra métricas y trazas de las llamadas |

## 6. Verificaciones pendientes

- Estado oficial actual de la edición abierta de Kong y el reparto de funciones entre edición abierta y comercial (fuente oficial de Kong).
- Funciones de la edición comunitaria de KrakenD para el control por rol y alcance, con la documentación de la versión vigente.
- Los pesos de la sección 3 los debe confirmar Arquitectura.

## 7. Preparación

- **Estado:** CONDITIONAL. La evaluación es un insumo, no la decisión. Faltan la prueba de concepto y las verificaciones de la sección 6.
- **Decisión humana requerida:** Arquitectura elige el producto y actualiza ADR-14 y ADR-P8.
