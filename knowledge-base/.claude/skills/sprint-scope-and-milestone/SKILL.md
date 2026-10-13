---
name: sprint-scope-and-milestone
description: Use when decomposing a DSP into an SSP and associating that SSP with one GitLab Milestone inside the provided project_id.
---

# Sprint Scope and Milestone

Define el alcance de un Sprint y gestiona exclusivamente su vínculo con un Milestone.

## Workflow

1. Resolver DSP y Management Context Pack.
2. Seleccionar las HU-* del Sprint.
3. Definir Sprint Goal, inclusiones, exclusiones, dependencias y riesgos.
4. Validar que ninguna HU-* exceda el DSP.
5. Renderizar `templates/sprint-milestone-v1.md`.
6. Buscar o preparar el Milestone dentro del `project_id`.
7. Solicitar aprobación antes de crear o actualizar el Milestone.
8. Registrar `milestone_id`, URL y descripción en el SSP.
9. Actualizar siempre el Project Issue del DSP: añadir una fila a la sección «Milestones» con el numeral consecutivo, el nombre del SSP y el enlace a la URL del Milestone. Es una mutación GitLab: preparar como `PENDING_APPROVAL` y aplicar solo con aprobación humana. No borrar filas anteriores ni reutilizar numerales.

La descripción del Milestone debe empezar con los comandos `/project`, `/subproject`, `/cost`, `/time`, `/client` y `/group` (otra plataforma los usa para extraer métricas). Ver `templates/sprint-milestone-v1.md`.

## Referencias

El SSP y el Milestone citan el DSP y el SSP con dos formas de acceso: URL del repositorio y referencia local (ver `management-contracts/gitlab-traceability.md`). La descripción del Milestone en GitLab incluye ambas para el SSP, y se valida que la URL resuelva antes de publicarla.

## Output

`Sprint Scope Pack` y `Sprint GitLab Control Pack`.

## Boundaries

El SSP solo se vincula a un Milestone. No crea ni requiere un Sprint Issue y no añade labels de Issue. Su única modificación a un Issue es la sección «Milestones» del Project Issue.

