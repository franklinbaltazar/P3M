---
name: engineering-plan-and-execution
description: Use when an SSP and its canonical US-* Issues must become a dependency-aware Engineering Execution Plan and controlled Skill execution.
---

# Engineering Plan and Execution

Convierte el SSP en tareas asignadas y controla su ejecución.

## Workflow

1. Resolver SSP, US-* y dependencias.
2. Crear tareas para planificación, GitLab, ejecución, control y cierre.
3. Asignar cada tarea a un Skill.
4. Definir precondiciones, dependencias, outputs y gates humanos.
5. Activar solo tareas `READY`.
6. Registrar `RUNNING`, resultados, provenance y estado final.
7. Detener ante errores, bloqueos o aprobación pendiente.
8. Replanificar solo con cambios aprobados.

## States

`PLANNED`, `READY`, `RUNNING`, `PARTIAL`, `BLOCKED`, `NEEDS_CLARIFICATION`, `NEEDS_HUMAN_REVIEW`, `COMPLETED`, `FAILED`, `CANCELLED`.

## Output

`Engineering Execution Plan` y `Execution Control Pack` en `management/plans/` y `execution/`.

## Boundaries

No decide alcance, calidad, riesgo o cierre. No ejecuta mutaciones GitLab sin aprobación.

