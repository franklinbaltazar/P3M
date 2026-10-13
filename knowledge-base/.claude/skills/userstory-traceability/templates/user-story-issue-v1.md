# {{hu_id}} — {{title}}

Fuente única de la historia:
- Repositorio: [{{hu_path}}]({{hu_url}})
- Local: {{hu_local}}

Este Issue es una proyección operativa para el Board «Sprint Backlog»: sirve para ver y mover el estado. La historia, sus criterios de aceptación y la Definition of Done se leen y se cambian solo en el archivo US-* indicado. No copiar ese contenido aquí. La estimación de esfuerzo es de gestión: se calcula con el estimador del skill userstory-traceability y vive solo en este Issue, no en la US-*.

## Estimación de esfuerzo (referencia)

- **Estimación de esfuerzo:** {{effort_estimate}}
- **Base de la estimación:** {{effort_basis}}

## Trazabilidad
- DSP: `{{dsp_id}}` ([{{dsp_path}}]({{dsp_url}}) · Local: `{{dsp_path}}`)
- SSP: `{{ssp_id}}` ([{{ssp_path}}]({{ssp_url}}) · Local: `{{ssp_path}}`)
- US: `{{hu_path}}`
- Project ID: `{{project_id}}`
- Issue ID: `{{issue_id}}`
- Issue IID: `{{issue_iid}}`
- Project Issue: #{{project_issue_iid}}
- Milestone: {{milestone_title}}

<!--
{{hu_url}} = {{repo_blob_base}}/{{hu_path}}. {{hu_local}}: en el archivo local, enlace relativo a la US-* para navegar desde el editor; en el Issue de GitLab, la ruta en código (`{{hu_path}}`), porque un enlace relativo no resuelve allí. Ver «Enlaces a la fuente» en SKILL.md.
Labels iniciales: `User Story`, `AI Cowork` y `Status :: PENDING`. Milestone: el del SSP. Estimate de GitLab: las horas de «Estimación de esfuerzo» (ver «Labels y estimate» en SKILL.md).
El estado de avance vive solo en el label `Status :: …` (ver assets/status-labels.md). No se registra el estado en el archivo US-*.
-->
