---
type: Business Term
title: "Carga automática de GitLab"
description: "Proceso automático programado y de solo lectura que trae de GitLab los issues y milestones creados o actualizados desde la ejecución más reciente (delta de cambio). Cada ejecución queda en un registro con fecha y hora y estado (exitosa o fallida), que el Jefe de Ingeniería y los ADMIN consultan y desde el cual pueden reintentar."
tags: [glossary, business-term]
status: approved
generated:
  by: "af-business-glossary-curator/1.1"
  at: "2026-10-10T18:00:00-05:00"
verified:
  by: "ianache (Functional Analysis)"
  at: "2026-10-10T22:00:00-05:00"
sources:
  - id: rcp-001
    resource: /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md
---

# Carga automática de GitLab

- **ID:** TRM-0047
- **Tipo:** concepto
- **Sinónimos:** —
- **Definición:** Proceso automático programado y de solo lectura que trae de GitLab los issues y milestones creados o actualizados desde la ejecución más reciente (delta de cambio). Cada ejecución queda en un registro con fecha y hora y estado (exitosa o fallida), que el Jefe de Ingeniería y los ADMIN consultan y desde el cual pueden reintentar.
- **Ámbito:** P3M (People, Product and Project Management), Área de Desarrollo
- **Fuentes:**
  - [N2] RCP-001 — Requirement Context Pack del P3M — /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L188 — consultada 2026-10-10
  - [N2] RCP-001 — Requirement Context Pack del P3M — /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L189 — consultada 2026-10-10
  - [N2] RCP-001 — Requirement Context Pack del P3M — /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L190 — consultada 2026-10-10
  - [N2] RCP-001 — Requirement Context Pack del P3M — /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L134 — consultada 2026-10-10
- **Clasificación:** decision
- **Confianza:** high
- **Responsable:** Jefe de Ingeniería
- **Relacionados:** [GitLab](TRM-0036-gitlab.md); [Jefe de Ingeniería](TRM-0026-jefe-de-ingenieria.md); [ADMIN](TRM-0028-admin.md)
- **Notas:** La primera carga es completa y, sin cambios, se registra «sin cambios desde carga previa» (/requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L521). Si GitLab no responde, el portal muestra «datos al <fecha y hora de la última carga exitosa>» (/requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L519). Los logs de carga se retienen por siempre (/requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L517). El circuit breaker sigue las buenas prácticas del anexo B del pack (/requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L518). Una carga fallida se reintenta 3 veces con esperas incrementales y un circuit breaker (/requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L507). Responsable según [RCP-001:L109] (Jefe de Ingeniería, responsable funcional de la iniciativa). Frecuencia por defecto: cada 30 segundos (D-69).
