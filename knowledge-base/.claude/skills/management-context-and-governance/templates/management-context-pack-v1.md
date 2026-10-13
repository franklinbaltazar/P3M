---
okf_version: "0.2"
id: "MCP-{{dsp_id}}"
title: "Management Context Pack — Gobierno de {{dsp_id}} antes de Sprint Selection"
status: "{{status}}"  # READY | PARTIAL | BLOCKED | NEEDS_CLARIFICATION | NEEDS_HUMAN_REVIEW | COMPLETED (ver assets/status-values.md)
version: "{{version}}"
date: "{{date}}"
generated: true
verified: false
human-reviewed: false
provenance:
  agent: "{{agent}}"
  method: "management-context-and-governance"
  sources:
    - {{rcp_path}}
    - {{dsp_path}}
sources:
  - id: "{{rcp_id_lower}}"
    resource: {{rcp_path}}
  - id: "{{dsp_id_lower}}"
    resource: {{dsp_path}}
---

# Management Context Pack — Gobierno de {{dsp_id}}

<!--
Instrucciones de uso (borrar al generar el documento):
- Una fila por hecho, supuesto, vacío, decisión, bloqueo o contradicción. Cada ID es estable y no se reutiliza.
- Las citas usan `archivo:Lnn`. Lo que no esté en una fuente autorizada se marca como «evidencia de ejecución» y no como hecho de la fuente.
- Una consulta de solo lectura a GitLab es evidencia de ejecución, no fuente autorizada.
- Cada cambio a GitLab (Issue, label, Milestone) se registra solo si tuvo aprobación humana explícita.
- Un elemento resuelto se tacha con ~~texto~~ y se explica en «Resuelta», no se borra.
- El Pack no aplica cambios: los propone (sección 13).
- Los siguientes IDs usan prefijos fijos: F hecho, S supuesto, H hipótesis, G vacío, DH decisión humana, B bloqueo, C contradicción, P provenance, Q pregunta.
-->

## 1. Pregunta de trabajo, alcance y cambios

**Pregunta:** {{working_question}}

**Fuentes autorizadas:** {{authorized_sources}}. {{extra_evidence_note}} {{unconsulted_sources_note}} {{mutations_note}}

**Cambios de la versión {{version}}:** {{changes_this_version}}

**Cambios de versiones anteriores:** {{changes_previous_versions}}

**Respuesta corta:** {{short_answer}} Estado de gobierno: `{{status}}`.

## 2. Hechos (con evidencia)

| ID | Hecho | Evidencia |
|---|---|---|
| MCP-F01 | {{fact}} | {{dsp_id}}:L{{nn}} |
<!-- Cubrir como mínimo: estado y scope_state del DSP; verified, human-reviewed, approved_by y approved_on; sprint asignado; tipo de fuentes (rutas o URL); PO; número de historias, criterios y olas; estimación; exclusiones; estado de cada bloqueo; Definition of Ready; project_id; Project Issue (label `Proyecto`, issue_id, issue_iid, relación bidireccional); estado del RCP; responsable funcional; decisiones citadas frente a las del RCP. -->

## 3. Supuestos

| ID | Supuesto | Por qué se usa | Cómo se confirma |
|---|---|---|---|
| MCP-S01 | {{assumption}} | {{why}} | {{how_to_confirm}} |

## 4. Hipótesis (propuestas del agente, sin respaldo en las fuentes)

| ID | Hipótesis | Origen | Qué la confirmaría |
|---|---|---|---|
| MCP-H01 | {{hypothesis}} | {{origin}} | {{confirmation}} |

## 5. Vacíos

| ID | Vacío | Impacto | Responsable |
|---|---|---|---|
| MCP-G01 | {{gap}} | {{impact}} | {{owner}} |
<!-- Cubrir: project_id, Project Issue, evidencia de los cierres de bloqueos, equipo y capacidad, criterios de selección del Sprint, estimaciones, deriva de historias, alcance de decisiones transversales, publicación de las fuentes. -->

## 6. Decisiones humanas registradas en las fuentes

| ID | Decisión | Evidencia |
|---|---|---|
| MCP-DH01 | {{decision}} | {{evidence}} |

**Decisiones que NO existen todavía:** {{missing_decisions}}

## 7. Bloqueos del DSP (IDs conservados)

| ID | Bloqueo | Declarado en el DSP | Verificable con las fuentes autorizadas | Estado según este Pack | Responsable |
|---|---|---|---|---|---|
| {{dsp_id}}-B1 | {{blocker}} | {{declared}} | {{verifiable}} | **{{state}}** | {{owner}} |
<!-- Una fila por cada bloqueo del DSP, con su ID original. Los bloqueos nuevos del Pack usan MCP-Bnn y se marcan «(nuevo)». Estados posibles: Cerrado, Cerrado por decisión con excepción, Cerrado pero no verificable, Resuelto, Vigente. -->

## 8. Contradicciones y deriva

| ID | Contradicción o deriva | Evidencia A | Evidencia B | Estado |
|---|---|---|---|---|
| MCP-C01 | {{contradiction}} | {{dsp_id}}:L{{nn}} | {{other_source}}:L{{nn}} | **Abierta** / Resuelta / Sin verificar |
<!-- Cubrir: DSP frente a RCP (decisiones, números), DSP frente a sí mismo (estado, cierres, fechas, Definition of Ready, verified), y, si existen, DSP frente a SSP, US-* e Issues. -->

**Resueltas desde la versión {{previous_version}}:** {{resolved_list}}

## 9. Observaciones de provenance

| ID | Observación | Evidencia |
|---|---|---|
| MCP-P01 | {{observation}} | {{evidence}} |
<!-- Cubrir: quién generó y quién editó el DSP, separación de funciones entre autor y aprobador, aprobaciones generales o sin segundo rol, cierres sin evidencia, comprobaciones de ejecución que no son fuente autorizada. -->

## 10. Evaluación de gobierno

| Criterio del flujo de gobierno | Resultado | Evidencia |
|---|---|---|
| Leer DSP, alcance, exclusiones, riesgos y decisiones | {{result}} | {{evidence}} |
| Validar `project_id` | {{result}} | {{evidence}} |
| Validar el Project Issue con label `Proyecto` | {{result}} | {{evidence}} |
| Validar `issue_id`, `issue_iid` y relación bidireccional | {{result}} | {{evidence}} |
| Separar hechos, supuestos, preguntas y bloqueos | {{result}} | Secciones 2 a 7 |
| Detectar deriva entre DSP, RCP, SSP, US-* e Issues | {{result}} | {{evidence}} |
| Coherencia interna del DSP | {{result}} | {{evidence}} |
| Aprobación humana del DSP | {{result}} | {{evidence}} |
| Cambios como propuesta, no aplicados | {{result}} | — |

**Estado:** `{{status}}`.
- **Sprint Selection:** {{sprint_selection_statement}}
- **Preparación de un SSP:** {{ssp_preparation_statement}}

<!-- Estado: usar solo los valores de assets/status-values.md. Guía: `READY` sin bloqueos vigentes; `PARTIAL` si puede continuar con vacíos o riesgos aceptados y documentados; `BLOCKED` si falta una dependencia obligatoria; `NEEDS_CLARIFICATION` si hay una ambigüedad del responsable; `NEEDS_HUMAN_REVIEW` si espera revisión o decisión humana; `COMPLETED` si no quedan acciones obligatorias. -->

## 11. Qué debe resolverse antes de preparar un SSP

1. {{pending_item_1}}
2. {{pending_item_2}}
<!-- Lista ordenada por prioridad. Cada ítem cita el ID que resuelve (MCP-Bnn, MCP-Cnn, MCP-Gnn, Q-nn). Los ítems cerrados se tachan y se marcan «Hecho». -->

## 12. Preguntas que requieren revisión humana

| ID | Pregunta | Responsable | Bloquea |
|---|---|---|---|
| Q-01 | {{question}} | {{owner}} | {{blocks}} |

## 13. Preparación

- **Estado del Pack:** `{{status}}`. {{pack_basis}} (`human-reviewed: false`).
- **Estado de gobierno de {{dsp_id}}:** `{{status}}`.
- **Cambios propuestos (no aplicados):** {{proposed_changes}}
- **Siguiente skill:** {{next_skill}}
- **Mutaciones de GitLab ejecutadas con aprobación:** {{executed_mutations}}
