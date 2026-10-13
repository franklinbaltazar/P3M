---
type: UI Screen Spec
title: "SCR-002 — Pantallas de administración del portal P3M"
description: "Pantallas de configuración y mantenimiento que SCR-001 no cubría (SCRQ-5): roles, perfiles, cursos, ediciones, organizaciones, plazas, relaciones, vínculo, productos, proyectos, motivos y valoración. Con el IA Design System."
tags: [ui, screens, admin, design-system]
status: draft
version: "0.1.0"
generated:
  by: "ui-spec-writer (aplicado por Claude Code)"
  at: "2026-10-13T03:30:00-05:00"
human-reviewed: false
sources:
  - id: scr-001
    resource: /design/ux/SCR-001-pantallas-del-bff.md
  - id: flw-002
    resource: /design/ux/FLW-002-flujos-de-administracion.md
  - id: dsc-001
    resource: /design/ux/DSC-001-cambios-al-design-system.md
  - id: api-prp-006
    resource: /design/api-contracts/API-PRP-006-bff-portal.md
  - id: us-001-035
    resource: /requirements/user-stories/
---

# SCR-002 — Pantallas de administración del portal P3M

> **Estado:** `draft`, sin revisión humana. Continúa a [SCR-001](SCR-001-pantallas-del-bff.md) (numera desde SCR-11). Mismas convenciones: componentes del **IA Design System** por nombre exacto; lo que el sistema no tiene se cita como brecha **DSG-n** de [DSC-001](DSC-001-cambios-al-design-system.md), que se asume **completado** (decisión D-UX-8). Pantallas y composición **candidatas (I)**.

## 1. Patrón común de mantenimiento (I)
Casi todas estas pantallas son un mantenimiento. Para no inventar un patrón por pantalla, se propone uno solo:

| Pieza | Componente del sistema | Notas |
|---|---|---|
| Lista | PaginatedDataTable (o DataTable si son pocas filas) con filtros en Input y un Button primario «Crear …» por toolbar | Un solo primario por toolbar (README de Button) |
| Alta y edición | Dialog (DSG-1) o panel lateral con FormField, Input, Select (DSG-6) y Button primario «Guardar» y secundario «Cancelar» | Errores de campo con FormField (DSG-6) |
| Estado vacío | EmptyState (DSG-7) con la acción de crear | Por ejemplo US-001 AC-4 |
| Fin de vigencia | Button secundario «Finalizar» o «Dar de baja» con confirmación (Dialog) | Nada se borra (BR-079, A-04) |
| Historial | DataTable con vigencia desde y hasta | Fechas con DatePicker |
| Rechazo del servidor | Alert de error (DSG-2) con el motivo de negocio | ADR-P5 |
| Permisos | Los botones de escritura solo se ven para JEFE_INGENIERIA y ADMIN; decide el servidor | ADR-P5 |

Todas las pantallas llevan los estados mínimos de SCR-001 §2: cargando, vacío, error, parcial y sin permiso.

## 2. Pantallas

### SCR-11 Catálogo de roles (US-001)
| Campo | Valor |
|---|---|
| Roles | JEFE_INGENIERIA, ADMIN (escritura); los demás no la ven |
| Rutas BFF | `/api/v1/roles` (paso) |
| Sistema | Patrón común: PaginatedDataTable de roles; Dialog de alta y edición |
| Estados | **Catálogo vacío** (US-001 AC-4) con EmptyState |
| Criterios | US-001 AC-1 a AC-4 |
| Abiertas | ADQ-2 (modificar un rol en uso) |

### SCR-12 Perfil y niveles mínimos de un rol (US-002, US-003)
| Campo | Valor |
|---|---|
| Roles | JEFE_INGENIERIA, ADMIN |
| Rutas BFF | `/api/v1/roles/{id}/perfil`, `/roles/{id}/niveles/{nivel}/niveles-minimos`, `/competencias`, `/seniorities` (paso) |
| Sistema | Tabs (DSG-4): «Perfil» y «Niveles mínimos». Perfil: DataTable de competencias del rol con Badge «General» o «Específica» y Button «Agregar competencia». Niveles mínimos: un selector de rol/nivel (Select, DSG-6) y una tabla con un Select N1 a N3 por competencia |
| Estados | Rol sin perfil; competencia específica ya en otro perfil (Alert); niveles mínimos incompletos **(I)** |
| Criterios | US-002 AC-1 a AC-6; US-003 AC-1 a AC-4 |
| Abiertas | ADQ-1 (alta de competencias) |

### SCR-13 Cursos, objetivos, rúbricas y evidencias esperadas (US-006, US-007)
| Campo | Valor |
|---|---|
| Roles | JEFE_INGENIERIA, ADMIN |
| Rutas BFF | `/api/v1/cursos`, `/cursos/{id}/objetivos`, `…/rubrica`, `/cursos/{id}/evidencias-esperadas` (paso) |
| Sistema | Lista de cursos; ficha con Tabs: «Objetivos» (competencia y nivel, Select), «Rúbrica» (una por objetivo, un campo por nivel de logro, Textarea) y «Evidencias esperadas» (Radio «Obligatoria» o «Opcional») |
| Estados | Curso sin objetivos; objetivo sin rúbrica |
| Criterios | US-006 AC-1 a AC-5; US-007 AC-1 a AC-4 |
| Abiertas | ADQ-3 (modalidad), ADQ-4 (curso con ediciones en marcha) |

### SCR-14 Ediciones de un curso (US-008)
| Campo | Valor |
|---|---|
| Roles | JEFE_INGENIERIA, ADMIN |
| Rutas BFF | `/api/v1/cursos/{id}/ediciones`, `/ediciones/{id}` (paso) |
| Sistema | DataTable de ediciones del curso (número, fechas, cupo, instructor); Dialog con DatePicker de inicio y fin, Input de cupo y Select de instructor |
| Brechas de datos | El Select de instructor necesita listar personas con rol de evaluador vigente; hoy no hay esa lectura (**ADQ-7**) |
| Estados | Curso sin ediciones; edición sin instructor |
| Criterios | US-008 AC-1 a AC-4 |

### SCR-15 Organizaciones y contactos (US-035, US-029)
| Campo | Valor |
|---|---|
| Roles | JEFE_INGENIERIA, ADMIN |
| Rutas BFF | `/api/v1/organizaciones`, `/partes/{id}/contactos` (paso) |
| Sistema | Lista de organizaciones con Badge «Activa» o «Inactiva»; ficha con una DataTable de contactos (tipo correo, teléfono, dirección) y Dialog de alta; el contacto dado de baja se muestra, no se borra |
| Estados | Correo duplicado (Alert con el motivo); sin correo o sin teléfono (validación de campo obligatorio, FormField) |
| Criterios | US-035 AC-1 a AC-5; US-029 AC-1 a AC-7 |
| Abiertas | ADQ-6 (datos personales) |

### SCR-16 Plazas y ocupaciones (US-030, US-031)
| Campo | Valor |
|---|---|
| Roles | JEFE_INGENIERIA, ADMIN |
| Rutas BFF | `/api/v1/plazas`, `/plazas/{id}/rol-nivel`, `/plazas/{id}/ocupaciones` (paso) |
| Sistema | Lista de plazas con Badge «Vacante» u «Ocupada»; ficha con historial del rol/nivel de la plaza (DataTable con vigencia) y de ocupaciones; Button «Ocupar» con Select de persona y DatePicker |
| Estados | Plaza vacante; intento de segundo ocupante (Alert); persona que ya ocupa otra plaza |
| Criterios | US-030 AC-1 a AC-4; US-031 AC-1 a AC-4 |
| Nota | El cambio de rol/nivel de una plaza por promoción no se edita aquí: llega por evento (INV-27, D-UX-7). La pantalla solo lo muestra |

### SCR-17 Roles de la parte y relaciones (US-032, US-034)
| Campo | Valor |
|---|---|
| Roles | JEFE_INGENIERIA, ADMIN |
| Rutas BFF | `/api/v1/personas/{id}/roles`, `/api/v1/relaciones` (paso) |
| Sistema | Sección «Roles» (DataTable con vigencia y Button «Finalizar») y sección «Relaciones» («Reporta a», «Membresía», «Es parte de») con Select de la parte destino y DatePicker. Pueden vivir como Tabs de la ficha de la persona (SCR-03) |
| Estados | Solape de roles del mismo tipo (Alert); segundo «reporta a» vigente (Alert) |
| Criterios | US-032 AC-1 a AC-3; US-034 AC-1 a AC-5 |

### SCR-18 Vínculo usuario–persona (US-033)
| Campo | Valor |
|---|---|
| Roles | JEFE_INGENIERIA y ADMIN (BR-134) |
| Rutas BFF | `/api/v1/usuarios`, `/usuarios/{id}/vinculo` (paso) |
| Sistema | Búsqueda de usuario (Input) y su persona vinculada; Button «Corregir vínculo» con Dialog de confirmación que pide el motivo; historial de correcciones (quién y cuándo) |
| Estados | Usuario sin persona; corrección por correo cambiado o reutilizado |
| Criterios | US-033 AC-1 a AC-5 |

### SCR-19 Productos y proyectos (US-018, US-019)
| Campo | Valor |
|---|---|
| Roles | JEFE_INGENIERIA, ADMIN |
| Rutas BFF | `/api/v1/productos`, `/productos/{id}/proyectos`, `/proyectos/{id}/milestones`, `…/roles-nivel-requeridos`, `…/jefatura` (paso); `/api/v1/gitlab/proyectos/{id}/milestones` para elegir |
| Sistema | Lista de productos con el proyecto de GitLab (id en `label-code`); alta de proyecto con Tabs: «Milestones» (lista con Checkbox para elegir los cargados desde GitLab), «Roles/niveles requeridos» (Select de rol/nivel e Input de cantidad) y «Jefe de proyecto» (Select de persona y DatePicker, con historial) |
| Estados | Producto sin proyectos; **sin milestones cargados** (Alert que lleva a SCR-09); milestone ya usado por otro proyecto |
| Criterios | US-018 AC-1; US-019 AC-1 a AC-4 |
| Abiertas | RQ-32 |
| Nota | El panel de lectura del proyecto con issues es SCR-07 |

### SCR-20 Codificador de motivos de excepción (US-023)
| Campo | Valor |
|---|---|
| Roles | JEFE_INGENIERIA, ADMIN |
| Rutas BFF | `/api/v1/motivos-de-excepcion` (paso) |
| Sistema | Patrón común; la acción «Retirar» está **deshabilitada con motivo** para un motivo en uso (US-023 AC-2) |
| Criterios | US-023 AC-1, AC-2 |

### SCR-21 Registrar valoración (US-016)
| Campo | Valor |
|---|---|
| Roles | JEFE_INGENIERIA, ADMIN |
| Rutas BFF | `/api/v1/colaboradores/{id}/valoraciones` (paso); se abre desde SCR-03 |
| Sistema | Dialog con Select de competencia, Radio N1 a N3 y la valoración anterior visible; el historial en DataTable |
| Criterios | US-016 AC-1 a AC-3 |

## 3. Cobertura de historias
Con SCR-001 y SCR-002 las 35 historias tienen pantalla:

| Pantallas | Historias |
|---|---|
| SCR-01 | US-025, 027, 028 |
| SCR-02, 03, 17, 21 | US-004, 005, 016, 032, 034 |
| SCR-04, 05, 06 | US-009 a 013 |
| SCR-07, 19, 20 | US-018 a 019, 021 a 024 |
| SCR-08, 10 | US-017, 026 |
| SCR-09 | US-020 |
| SCR-11, 12 | US-001 a 003 |
| SCR-13, 14 | US-006 a 008 |
| SCR-15, 16, 18 | US-029 a 031, 033, 035 |
| Sin pantalla propia | US-014 (aportar evidencias de proyecto) y US-015 (validar evidencias de proyecto) comparten SCR-05 y SCR-06 por diseño **(I)**: hay que confirmar que el flujo de proyecto no necesita pantalla distinta |

## 4. Asignación a micro UI (propuesta de SCR-001 §8)
SCR-11 y SCR-12 a `mfe-curricula`; SCR-13 y SCR-14 a `mfe-formacion`; SCR-15 a SCR-18 a `mfe-personas`; SCR-19 y SCR-20 a `mfe-portafolio`; SCR-21 a `mfe-progresion`.

## 5. Preguntas abiertas
Las de [FLW-002 §7](FLW-002-flujos-de-administracion.md) (ADQ-1 a ADQ-7), las de [UXR-001](UXR-001-vistas-del-bff.md) §5 y las de [SCR-001](SCR-001-pantallas-del-bff.md) §7.

## 6. Siguiente acción
Resolver ADQ-1, ADQ-2, ADQ-3 y ADQ-7, y completar el Design System ([DSC-001](DSC-001-cambios-al-design-system.md)). Luego el proyecto de diseño con SCR-001 y SCR-002.
