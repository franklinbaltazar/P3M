---
name: management-context-and-governance
description: Use when validating a DSP, its Project Issue, scope governance, GitLab metadata or scope changes before Sprint planning.
---

# Management Context and Governance

Consolida el contexto del DSP, la relación con el Project Issue y el control de cambios.

## Workflow

1. Leer DSP, alcance, exclusiones, riesgos y decisiones.
2. Validar `project_id` y el Project Issue con label `Proyecto`.
3. Validar `issue_id`, `issue_iid` y relación bidireccional.
4. Separar hechos, supuestos, preguntas y bloqueos.
5. Comparar DSP, SSP, US-* e Issues para detectar scope drift.
6. Preparar cambios como propuesta; no aplicarlos automáticamente.
7. Renderizar el documento final con `templates/management-context-pack-v1.md` (Management Context Pack) o `templates/project-issue-v1.md` (Project Issue).
8. Guardar Packs en `management/projects/` y `controls/`.

## Output

`Management Context Pack`, `Project GitLab Link Pack` o `Scope Change and Drift Pack`, según la operación solicitada.

## Assets

- `assets/status-values.md`: valores permitidos del campo `status` (`READY`, `PARTIAL`, `BLOCKED`, `NEEDS_CLARIFICATION`, `NEEDS_HUMAN_REVIEW`, `COMPLETED`) y su significado.

## Templates

- `templates/management-context-pack-v1.md`: documento final del DSP (gobierno antes de Sprint Selection), con 13 secciones: pregunta y cambios, hechos, supuestos, hipótesis, vacíos, decisiones humanas, bloqueos del DSP, contradicciones y deriva, provenance, evaluación de gobierno, pendientes antes del SSP, preguntas humanas y preparación.
- `templates/project-issue-v1.md`: descripción del Project Issue.

Reglas del Pack: IDs estables por prefijo (F, S, H, G, DH, B, C, P, Q); cada hecho cita `archivo:Lnn`; las comprobaciones de GitLab son evidencia de ejecución, no fuente autorizada; el estado (`status`) y el veredicto de gobierno usan solo los valores de `assets/status-values.md`; el Pack siempre sale con `human-reviewed: false`.

## Referencias

Toda referencia a un artefacto (DSP, RCP, packs) lleva dos formas de acceso, según `management-contracts/gitlab-traceability.md`: URL del repositorio y referencia local. Se valida que la URL resuelva antes de publicarla.

## Security

Usar `GITLAB_PAT` solo desde el entorno. Nunca registrarlo ni incluirlo en salidas.

## Boundaries

No crea SSP, Milestones ni US-*. No modifica GitLab sin aprobación humana explícita.

