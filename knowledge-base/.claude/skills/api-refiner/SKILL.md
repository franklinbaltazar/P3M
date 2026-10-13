---
name: api-refiner
description: Use when an OKF of type "API Requirements Analysis" must become recommended APIs (microservices) grouped from its bounded contexts, or when one or more existing API proposals must be refined or extended. Produces one proposal file per API from a fixed template. Does not write OpenAPI, code or ADRs.
metadata:
  package: dtc-api
  version: 0.1.0
  standard: google-okf-v0.2
---

# api-refiner

## Purpose
Convertir un análisis de API por dominio en **APIs recomendadas** (un microservicio desplegable cada una) o **refinar** APIs ya propuestas. Cada API sale de la plantilla `templates/api-proposal-v1.md`. Es el paso entre `API Requirements Analysis` y el contrato OpenAPI de `api-designer`.

## Triggers
- «Propón las API / microservicios de los contextos de API-ANL-…» → modo **propose**.
- «Refina / agrega / cambia la API X» o «necesito un API para Y» → modo **refine**.

No usar para escribir OpenAPI, código ni ADR, ni para decidir arquitectura que debe decidir una persona.

## Inputs
1. **Obligatorio:** uno o más OKF con `type: API Requirements Analysis` (se buscan en `design/api-contracts/` con `Grep "^type: API Requirements Analysis"`). Si no hay ninguno, detener y avisar.
2. Su base: DDM (contextos, agregados, invariantes), ICP (contratos CON/EVT/ACL), historias, y los ADR de descomposición, seguridad y comunicación.
3. Refine: las propuestas existentes `design/api-contracts/API-PRP-*.md` y el pedido concreto (API, recurso o historia afectada).
4. Decisiones humanas ya registradas (por ejemplo, la agrupación elegida para un hallazgo). **Una agrupación no decidida es una recomendación, no un hecho.**

## Procedure — modo propose
1. **Cargar y validar el análisis.** Extraer contextos (CTX-xx), recursos F1, contratos F2 (CON), evento F3, ACL F4, hallazgos abiertos, supuestos (A-xx) y la trazabilidad historia → API. Registrar versión y fecha de cada fuente. Los hallazgos de severidad alta sin resolver se anotan como bloqueos o supuestos explícitos; no se ocultan.
2. **Evaluar la agrupación** con `assets/grouping-criteria.md`: un contexto = un módulo, y decidir cuántos servicios desplegables hay. Construir la matriz de acoplamiento (quién consulta a quién y en qué sentido) a partir de los CON. Por cada fusión o separación, documentar el criterio y la alternativa descartada.
3. **Definir las APIs.** Una API = un servicio desplegable con ID estable (`API-PRP-NNN`), sus contextos (módulos), propietario de datos (esquemas), recursos y operaciones F1, contratos internos que sirve y consume, eventos, ACL, seguridad (rol y rol+condición), invariantes que protege, fallos, observabilidad y pruebas de contrato.
4. **Asignar sin huérfanos ni duplicados:** cada recurso F1, cada CON/EVT/ACL y cada historia del análisis queda en **exactamente una** API. Un CON entre contextos que quedan en el mismo servicio pasa a «puerto interno» (se conserva el contrato lógico, no hay HTTP).
5. **Escribir una propuesta por API** con `templates/api-proposal-v1.md` y un resumen `API-PRP-000-resumen.md` con `templates/api-summary-v1.md` (mapa de APIs, matriz de dependencias, cobertura, alternativas, decisiones pendientes).
6. **Correr las puertas de calidad** (`assets/validation-checklist.md`).
7. Actualizar `index.md` y `changelog.md` en el mismo cambio.

## Procedure — modo refine
1. Leer la propuesta existente y el pedido. Identificar la(s) API(s) afectada(s). Si el pedido necesita un API que no existe, evaluar con `assets/grouping-criteria.md` si va en una API existente (nuevo recurso o módulo) o en una nueva; recomendarlo, no imponerlo.
2. Cambiar **solo** lo que el pedido toca. Preservar IDs; no reutilizar IDs retirados (marcarlos `RETIRED`).
3. Clasificar cada cambio: `additive`, `compatible`, `breaking` o `unknown`, con su razón. Subir la `version` de la propuesta (mayor si hay `breaking`).
4. Repetir la verificación de cobertura sobre las APIs tocadas **y** sobre las que las consumen.
5. Registrar el cambio en «Historial de refinamiento» de cada API afectada y en el resumen.
6. Si el refinamiento contradice una decisión humana registrada, no aplicarlo: devolver `REQUIRES_REVIEW` con el conflicto.

## Rules
- No inventar recursos, campos, políticas ni decisiones. Todo elemento cita su fuente (ID del análisis, CON, US, ADR, BR) o se marca **(I)** inferido, con su razón.
- Las agrupaciones son **recomendaciones** con alternativas y trade-offs; las decide una persona. Registrar quién y cuándo cuando lo haga.
- El modelo de datos (`data/`) no se redefine: las APIs respetan la propiedad de datos y no comparten tablas entre contextos.
- No hay `DELETE` de negocio si las reglas dicen que nada se borra: el fin de vigencia es una acción.
- Un agente nunca pone `human-reviewed: true`; eso exige una persona nombrada y un evento de revisión. `generated`, `verified` y `status` describen evidencia, no intención.
- No fabricar `verified`. El estado OKF es `draft` hasta la verificación humana.
- Rutas internas relativas al repositorio; IDs estables.

## Outputs
Bajo `design/api-contracts/` (nunca en una carpeta raíz `design` o `architecture` distinta):
- `API-PRP-000-resumen.md`: mapa de APIs recomendadas, matriz de dependencias, cobertura, decisiones y alternativas.
- `API-PRP-NNN-<slug>.md`: una por API, con la plantilla.

Frontmatter OKF v0.2: `type: API Proposal` (o `API Proposal Summary`), `status: draft`, `gate_status` (`READY_FOR_CONTRACT`, `REQUIRES_REVIEW` o `BLOCKED`), `generated.by`, `generated.at` en ISO 8601 con `-05:00`, `sources` resolubles y `human-reviewed: false`.

## Quality gates
Cada recurso, CON/EVT/ACL e historia del análisis está en una sola API; no hay dependencia circular síncrona sin justificar; cada API tiene propietario de datos, seguridad (rol y rol+condición), fallos y pruebas de contrato; las inferencias están marcadas; cada fusión o separación cita su criterio y su alternativa; `gate_status` es coherente con los bloqueos. `READY_FOR_CONTRACT` exige que ningún hallazgo de severidad alta del análisis siga abierto sin un supuesto aceptado por una persona.

## Error handling
Análisis ausente, de otro `type` o sin trazabilidad: `BLOCKED`, indicando campo y archivo. Fuentes contradictorias: registrar el conflicto y la precedencia, y devolver `REQUIRES_REVIEW`. Nunca bajar la severidad de un hallazgo para llegar a `READY_FOR_CONTRACT`.

## Handoff
Cada propuesta enlaza el análisis de origen, las decisiones pendientes y el siguiente paso: `api-designer` para el contrato OpenAPI/AsyncAPI, luego `api-contract-reviewer` y `api-security-reviewer`.

## Assets y plantillas
- `templates/api-proposal-v1.md`: plantilla de cada API.
- `templates/api-summary-v1.md`: plantilla del resumen.
- `assets/grouping-criteria.md`: criterios de agrupación de contextos en servicios.
- `assets/validation-checklist.md`: verificación antes de entregar.
