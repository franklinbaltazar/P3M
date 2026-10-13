---
name: userstory-traceability
description: Use when US-* User Stories in an SSP need canonical one-to-one GitLab Issues with labels User Story and AI Cowork and bidirectional references.
---

# User Story Traceability

Garantiza que cada US-* tenga exactamente un Issue canónico dentro del `project_id`.

## Workflow

1. Enumerar todas las US-* del SSP.
2. Resolver el Issue canónico por referencias y `project_id`.
3. Validar relación 1:1, `issue_id`, `issue_iid`, URL, labels `User Story` y `AI Cowork`, un único label `Status :: …` y el estimate de GitLab.
4. Calcular la estimación de esfuerzo de referencia con `assets/effort-estimator.md` y renderizar `templates/user-story-issue-v1.md`. La estimación vive en el Issue, no en el archivo US-*.
5. Preparar mutaciones como `PENDING_APPROVAL`. Al crear, el Issue lleva los labels `User Story`, `AI Cowork` y `Status :: PENDING`, el Milestone del SSP y el estimate de GitLab con las horas-persona estimadas.
6. Aplicar solo después de `APPROVED`.
7. Registrar referencias bidireccionales en US-* e Issue.

## Labels y estimate

- **`User Story`:** identifica el Issue como User Story (no `Userstory`).
- **`AI Cowork`:** indica que la User Story se trabaja de forma colaborativa entre un humano (Dev o QA) y un Agente IA. Todos los Issues generados por este skill lo llevan.
- **Estimate de GitLab:** al crear o actualizar el Issue, registrar las horas-persona estimadas (calculadas con `assets/effort-estimator.md`) en el estimate nativo de GitLab, para contrastarlas luego con las horas reportadas con `/spend`. Se hace con la API `POST /projects/{id}/issues/{iid}/time_estimate?duration={H}h` (equivale a `/estimate {H}h`). Usar siempre horas (por ejemplo `22h`), sin días, para evitar conversiones. Si la estimación cambia, volver a calcularla y sobrescribir el estimate; no tocar el tiempo ya reportado. Si no hay estimación, no registrar un estimate en cero.
- Crear los labels en el proyecto del Issue si no existen.

## Enlaces a la fuente

La misma regla de dos formas de acceso (URL del repositorio y referencia local) aplica a las referencias al DSP y al SSP de la sección «Trazabilidad» (ver `management-contracts/gitlab-traceability.md`).

El Issue enlaza a la US-* con una URL absoluta del repositorio donde está el archivo, no con una ruta suelta:

`{web_url del proyecto}/-/blob/{ref}/{ruta de la US-*}`

- **Repositorio de la fuente:** el del workspace. Se lee de `.git/config` (`remote "origin"`) y se convierte a la URL web, sin credenciales. Si el workspace no tiene `.git`, se usa el repositorio declarado por el responsable para el DSP (en P3M, el proyecto 605). Puede ser distinto del `project_id` donde se crean el Project Issue, los Issues de US-* y los Milestones.
- **Rama:** `main`, salvo que el responsable indique otra.
- **Validación antes de publicar:** comprobar con la API (`GET /projects/{id}/repository/files/{ruta}?ref={ref}`) que el archivo existe en esa rama; si no existe, no publicar el Issue con ese enlace y avisar. No dejar enlaces rotos.
- **Referencia local:** además del enlace al repositorio, el Issue indica la ruta local de la US-* (`Local:`). En el archivo del Issue dentro del workspace es un enlace relativo, que facilita la navegación desde el editor; en la descripción del Issue de GitLab es la ruta en código, porque allí un enlace relativo no resuelve.
- **Valor actual de P3M:** `https://project.comsatel.com.pe/comsatel/development/training/dev-juniors/-/blob/main/`

## Output

`User Story Traceability Pack` en `management/user-stories/`.

## Assets

- `assets/status-labels.md`: estados `Status :: …`, su significado y las transiciones.
- `assets/effort-estimator.md`: criterios para la estimación de esfuerzo de referencia.

## Boundaries

No crea User Stories, no duplica Issues, no copia en el Issue el contenido de la US-* (historia, criterios, Definition of Done: el Issue enlaza al archivo, lleva trazabilidad y la estimación de esfuerzo, que es de gestión), no acepta relaciones 1:N y no persiste `GITLAB_PAT`.

