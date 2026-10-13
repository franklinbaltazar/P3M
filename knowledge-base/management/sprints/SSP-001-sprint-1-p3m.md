---
artifact: sprint-scope-pack
id: SSP-001
dsp: DSP-001
project_id: 633
milestone_title: "Sprint 1 - P3M"
milestone_id: 1755
milestone_iid: 1
milestone_url: "https://project.comsatel.com.pe/comsatel/development/training/dev-juniors/p3m/collaboration/-/milestones/1"
status: DRAFT
human-reviewed: false
generated: 2026-10-10
---

# SSP-001 — Sprint 1 - P3M

## Sprint Goal
Entregar la base de P3M: ingreso seguro con cierre de sesión, catálogo de roles con sus perfiles de competencias, registro de colaboradores y registro de productos y proyectos vinculados a GitLab.

## Scope
Olas 1 y 2 del DSP-001: 9 historias Must, con 35 criterios de aceptación. Todas las dependencias están dentro del Sprint o no existen. Referencia de esfuerzo: 212 h-persona con IA (suma de las estimaciones de referencia de las 9 historias, a confirmar por el equipo). Capacidad, duración y límite de historias en curso por persona: los define el equipo en el Sprint Planning (MCP-B7, Q-06).

Exclusiones (siguen en el DSP-001, olas 3 a 9): US-003, 005, 006, 007 a 017, 020 a 022, 024 y 026. Se mantienen las exclusiones generales del DSP-001.

Riesgos: decisiones de arquitectura sin revisión de un arquitecto (DSP-B3), RQ-31 (tiempo de sesión) que afecta a US-028 y G-12 (datos personales) que afecta a US-004.

## User Stories

| ID | Historia | Ola | Prioridad | Depende de | Criterios |
|---|---|---|---|---|---|
| US-001 | Mantener el catálogo oficial de roles | 1 | Must | — | 4 |
| US-018 | Registrar un producto y vincularlo a un proyecto de GitLab | 1 | Must | — | 1 |
| US-023 | Mantener el codificador de motivos de excepción | 1 | Must | — | 2 |
| US-025 | Registrar al usuario autenticado al iniciar sesión | 1 | Must | — | 2 |
| US-027 | Ingresar al portal de forma segura | 1 | Must | US-004 (solo para el AC-4) | 5 |
| US-002 | Definir el perfil de competencias de un rol | 2 | Must | US-001 | 6 |
| US-004 | Registrar y modificar colaboradores | 2 | Must | US-001 | 5 |
| US-019 | Registrar un proyecto de un producto con sus milestones | 2 | Must | US-018 | 4 |
| US-028 | Cerrar la sesión a demanda o por vencimiento | 2 | Must | US-027 | 6 |

## Trazabilidad
- DSP: `DSP-001`
- SSP: `management/sprints/SSP-001-sprint-1-p3m.md`
- Project ID: `633`
- Milestone ID: `1755` (iid 1)
- Milestone URL: https://project.comsatel.com.pe/comsatel/development/training/dev-juniors/p3m/collaboration/-/milestones/1

## Descripción del Milestone

```
/project P3M - People, Product and Project Management
/subproject Sprint 1 - P3M
/cost 4500
/time 212
/client COMSATEL
/group Proyectos
```

`/cost` (S/ 4500) y `/time` (212 horas-persona, igual a la suma de las estimaciones de las 9 historias; ajustado desde 70) son valores referenciales informados por el responsable el 2026-10-11. La descripción del Milestone 1755 en GitLab ya incluye estos comandos.
