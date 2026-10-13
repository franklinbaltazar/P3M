---
name: management-orchestrator
description: Use when coordinating DSP, SSP, GitLab Milestones, US-* Issues and Management Skills across a project lifecycle.
---

# Management Orchestrator

Observa el estado, valida contratos, genera el plan, activa un Skill y controla sus resultados. No ejecuta análisis de dominio ni aprueba mutaciones.

## Workflow

1. Observar DSP, SSP, US-*, artefactos y GitLab.
2. Validar `project_id`, relaciones, labels, Milestones y contratos.
3. Construir `Engineering Execution Plan`.
4. Marcar mutaciones GitLab como `PENDING_APPROVAL`.
5. Activar solo Skills con precondiciones satisfechas.
6. Registrar outputs bajo `management/`.
7. Detener ante bloqueos, drift o aprobación pendiente.
8. Replanificar solo con cambios aprobados.

## Routing

- Contexto o Project Issue → `management-context-and-governance`.
- SSP o Milestone → `sprint-scope-and-milestone`.
- US-* sin Issue 1:1 → `userstory-traceability`.
- Plan o ejecución → `engineering-plan-and-execution`.
- Cierre → `closure-and-reporting`.

## Output

`Engineering Execution Plan` y `Execution Control Pack` con estado, razón, dependencias, drift, blockers y next actions.

## Boundaries

No guarda secretos, no modifica GitLab directamente y nunca omite aprobación humana.

