# {{dsp_id}} — {{project_name}}

## Objetivo
{{objective}}

## Alcance
{{scope}}

## Exclusiones
{{exclusions}}

## Riesgos
{{risks_intro}}

| ID | Riesgo | Clasificación | Impacto (1-5) | Probabilidad (1-5) | Incidencia (I×P) | Afecta a | Respuesta | Responsable |
|---|---|---|---|---|---|---|---|---|
| R-01 | {{risk}} | {{classification}} | {{impact}} | {{probability}} | {{incidence}} | {{affects}} | {{response}} | {{owner}} |

<!--
Incluir todos los riesgos identificados para el alcance del DSP (decisiones sin revisar, bloqueos cerrados con excepción, dependencias externas, vacíos). Una fila por riesgo, con ID estable R-nn.
- Clasificación: Técnico, Negocio, Persona, Seguridad, Operación, Datos, Proveedor u Otro.
- Impacto: 1 muy bajo, 2 bajo, 3 medio, 4 alto, 5 muy alto.
- Probabilidad: 1 muy improbable, 2 improbable, 3 posible, 4 probable, 5 casi seguro.
- Incidencia: impacto × probabilidad. 1-5 baja, 6-12 media, 15-25 alta.
- Afecta a: uno o más de Objetivo, Alcance, Cronograma, Costo.
- Respuesta: Evitar, Mitigar, Transferir o Aceptar, con la acción.
-->

## Milestones
{{milestones_intro}}

| N.º | SSP | Milestone |
|---|---|---|
| {{n}} | {{ssp_name}} | [{{milestone_title}}]({{milestone_url}}) |

<!--
Una fila por cada Milestone de GitLab generado para este DSP, en orden de creación. Esta sección la actualiza el skill sprint-scope-and-milestone cada vez que crea un Milestone.
- N.º: numeral consecutivo (1, 2, 3...), sin saltos ni reutilización.
- SSP: nombre del SSP (por ejemplo, SSP-001 — Sprint 1 - P3M).
- Milestone: título enlazado a la URL del Milestone en GitLab.
Mientras no haya Milestones, la tabla queda vacía y la introducción dice «Aún no hay Milestones».
-->

## Trazabilidad
- DSP: [{{dsp_path}}]({{dsp_url}}) · Local: `{{dsp_path}}`
- Project ID: `{{project_id}}`
- Issue ID: `{{issue_id}}`
- Issue IID: `{{issue_iid}}`
