# {{ssp_id}} — {{sprint_name}}

## Sprint Goal
{{sprint_goal}}

## Scope
{{scope}}

## User Stories
{{hu_list}}

## Compromiso del Sprint
- Límite de historias en curso por persona: {{wip_limit}} (se define en el Sprint Planning)
- Referencia de esfuerzo: suma de la «Estimación de esfuerzo (referencia)» de los Issues de las US-* del Sprint, en horas-persona con IA. Capacidad y asignación: las define el equipo en el Sprint Planning.

## Trazabilidad
- DSP: `{{dsp_id}}` ([{{dsp_path}}]({{dsp_url}}) · Local: `{{dsp_path}}`)
- SSP: [{{ssp_path}}]({{ssp_url}}) · Local: `{{ssp_path}}`
- Project ID: `{{project_id}}`
- Milestone ID: `{{milestone_id}}`
- Milestone URL: `{{milestone_url}}`

## Descripción del Milestone
Texto que se publica como descripción del Milestone en GitLab. Otra plataforma lo lee para extraer métricas: las cinco líneas de comandos van al inicio, una por línea y sin cambiar los nombres. Después puede añadirse el resumen del Sprint.

```
/project {{project_name}}
/subproject {{sprint_name}}
/cost {{cost}}
/time {{time}}
/client {{client}}
/group {{group}}
```

| Campo | Significado | Origen |
|---|---|---|
| `/project` | Nombre de todo el proyecto (DSP) | Título del DSP |
| `/subproject` | Sprint específico (SSP) | Nombre del SSP |
| `/cost` | Costo estimado en S/ de ejecutar todo el proyecto | Lo informa el responsable; no se inventa |
| `/time` | Esfuerzo estimado para completar el proyecto, en horas-persona | Lo informa el equipo o el responsable; no se inventa |
| `/client` | Para quién está orientado el resultado | Por defecto: COMSATEL |
| `/group` | Clasificador del Milestone | Por defecto: Proyectos |

Si `/cost` o `/time` no se conocen, el SSP queda en `NEEDS_CLARIFICATION` y el Milestone no se crea ni se actualiza con esos campos vacíos.
