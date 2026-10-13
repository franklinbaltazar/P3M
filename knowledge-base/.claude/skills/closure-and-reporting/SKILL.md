---
name: closure-and-reporting
description: Use when Sprint or project outputs must be validated, consolidated and prepared for governed closure.
---

# Closure and Reporting

Gestiona el cierre del SSP, su Milestone y posteriormente el proyecto completo.

## Sprint closure

1. Verificar estado y evidencia de cada HU-*.
2. Comparar resultados contra Sprint Goal y Definition of Done.
3. Consolidar pendientes, excepciones, riesgos y drift.
4. Verificar `project_id`, `milestone_id` y descripción.
5. Preparar cambios GitLab como `PENDING_APPROVAL`.

## Project closure

1. Verificar cierre de todos los SSP.
2. Validar cobertura del DSP y User Stories.
3. Consolidar riesgos residuales, Handover y pendientes.
4. Verificar Project Issue, `issue_id` e `issue_iid`.
5. Preparar recomendación de cierre para revisión humana.

## Output

`Sprint Closure Pack` y `Project Closure Pack` en `management/closures/`.

## Boundaries

No declara cierre aprobado y no modifica GitLab sin autorización humana explícita.
