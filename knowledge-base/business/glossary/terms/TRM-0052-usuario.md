---
type: Business Term
title: "Usuario"
description: "Persona autenticada en el portal mediante Keycloak. Al iniciar sesión se registra con su GUID de Keycloak, username, correo electrónico y los roles de usuario que tiene asignados en Keycloak (colaborador, Instructor, Jefe de Ingeniería o ADMIN). Es la identidad que le permite a un colaborador ingresar al portal y quien mantiene el GUID de Keycloak."
tags: [glossary, business-term]
status: approved
generated:
  by: "af-business-glossary-curator/1.1"
  at: "2026-10-10T21:00:00-05:00"
verified:
  by: "ianache (Functional Analysis)"
  at: "2026-10-10T22:00:00-05:00"
sources:
  - id: rcp-001
    resource: /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md
---

# Usuario

- **ID:** TRM-0052
- **Tipo:** concepto
- **Sinónimos:** —
- **Definición:** Persona autenticada en el portal mediante Keycloak. Al iniciar sesión se registra con su GUID de Keycloak, username, correo electrónico y los roles de usuario que tiene asignados en Keycloak (colaborador, Instructor, Jefe de Ingeniería o ADMIN). Es la identidad que le permite a un colaborador ingresar al portal y quien mantiene el GUID de Keycloak.
- **Ámbito:** P3M (People, Product and Project Management), Área de Desarrollo
- **Fuentes:**
  - [N2] RCP-001 — Requirement Context Pack del P3M — /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L488 — consultada 2026-10-10
  - [N2] RCP-001 — Requirement Context Pack del P3M — /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L490 — consultada 2026-10-10
  - [N2] RCP-001 — Requirement Context Pack del P3M — /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L484 — consultada 2026-10-10
- **Clasificación:** decision
- **Confianza:** medium
- **Responsable:** Jefe de Ingeniería
- **Relacionados:** [Keycloak](TRM-0037-keycloak.md); [Colaborador](TRM-0002-colaborador.md); [Evaluador](TRM-0016-evaluador.md); [Jefe de Ingeniería](TRM-0026-jefe-de-ingenieria.md); [ADMIN](TRM-0028-admin.md); [IdM](TRM-0038-idm.md)
- **Notas:** Corresponde al User Login del UDM: es la identidad con la que se identifica una persona (D-129). Responsable según [RCP-001:L109] (Jefe de Ingeniería, responsable funcional de la iniciativa). Un colaborador se vincula siempre a un usuario (D-84). La omisión del Instructor se corrigió en D-86.
