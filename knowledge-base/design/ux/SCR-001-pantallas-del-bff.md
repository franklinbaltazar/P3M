---
type: UI Screen Spec
title: "SCR-001 — Pantallas candidatas servidas por el BFF"
description: "Especificación independiente de herramienta de las pantallas que consumen las vistas del BFF, construida con el IA Design System de Comsatel: rutas, componentes y tokens por pantalla, estados, criterios, brechas del sistema y hallazgos de accesibilidad."
tags: [ui, screens, bff, h-02, design-system]
status: draft
version: "0.3.0"
generated:
  by: "ui-spec-writer (aplicado por Claude Code)"
  at: "2026-10-13T00:30:00-05:00"
human-reviewed: false
sources:
  - id: uxr-001
    resource: /design/ux/UXR-001-vistas-del-bff.md
  - id: api-prp-006
    resource: /design/api-contracts/API-PRP-006-bff-portal.md
  - id: adr-04
    resource: /architecture/adr/ADR-04-micro-ui-y-catalogo-de-componentes-con-atomic.md
  - id: ia-design-system
    resource: https://claude.ai/artifact/ALfAWpY5JHEvoNxemZyJRJ
    trust: advisory
---

# SCR-001 — Pantallas candidatas servidas por el BFF

> **Estado:** `draft`, versión 0.2.0. Sin revisión humana. Usa el **IA Design System** (artefacto de Claude, versión `1791859125-999d`, última modificación de Ilver Anache el 2026-10-13): sus tokens y componentes se citan por nombre exacto. **Sigue sin haber flujos de usuario ni diseños de pantalla**; las pantallas y la composición son **candidatas (I)**, no un diseño aprobado. Donde el sistema no tiene un componente se marca como **brecha** y no se inventa.

## 1. Sistema de diseño usado
| Aspecto | Valor del IA Design System |
|---|---|
| Orientación | Interfaz corporativa de alta confiabilidad, para uso de escritorio con datos densos (README) |
| Tema | Solo **claro** (`themes: [light]`); no hay modo oscuro |
| Color | `primary` `#c9141d`; superficies `surface`, `surface-page`, `surface-alt`, `surface-table-head`; texto `text-primary`, `text-secondary`, `text-muted`; bordes `border-subtle`, `border-medium`, `border-strong`; estado `status-active`, `status-inactive`, `status-pending`, `status-suspended`; `error`, `error-container` |
| Tipografía | Hanken Grotesk (títulos), Inter (datos y formularios), JetBrains Mono (identificadores) |
| Espaciado | `space-2xs` a `space-3xl`; `header-height` 56 px; `sidebar-width` 256 px |
| Radio y elevación | `radius-sm/default/md/lg/full`; `elevation-1` (sin sombra), `elevation-2` (menús), `elevation-3` (diálogos) |
| Puntos de quiebre | Escritorio 1280+, tableta 768–1023 (barra lateral como cajón), móvil < 768 (tablas como tarjetas) |
| Componentes (15) | Atómicos: Button, Input, Checkbox, Radio, Toggle, Badge, Spinner. Moléculas: Breadcrumb, DatePicker, TimeRangePicker. Organismos: DataTable, PaginatedDataTable, Sidebar, TopNav, UserMenu, Footer |

El sistema se construyó para telemática y gestión de flotas (README); aquí se reutiliza por ser el de Comsatel. Los textos por defecto de algunos componentes están en inglés (por ejemplo «Total records» de PaginatedDataTable): se pasan las etiquetas en español con `labels`.

## 2. Convenciones de pantalla
- **Estructura común (I):** TopNav (con Breadcrumb y UserMenu) arriba, Sidebar a la izquierda, lienzo de contenido con `space-xl` y Footer. TopNav y Sidebar solo tras autenticar.
- **Estados mínimos (UXR-X1):** cargando (Spinner `lg` sobre velo en la tabla; `sm` dentro del botón), vacío, error, **parcial** y sin permiso.
- **Un solo botón primario por toolbar o formulario** (README de Button); acciones secundarias con Button secundario.
- **Estado nunca solo por color:** punto o Badge con su texto (README de DataTable y Badge).
- **Identificadores** (issue, ids de milestone): `label-code` (JetBrains Mono); cifras en `tnum`.

## 3. Pantallas

### SCR-01 Inicio y sesión (US-025, US-027, US-028)
| Campo | Valor |
|---|---|
| Roles | Cualquiera |
| Rutas BFF | `/auth/login`, `/auth/callback`, `/auth/logout`, `/auth/session`, `GET /api/v1/me` |
| Sistema | Fondo `surface`; Button primario «Ingresar»; TopNav con UserMenu («Salir») una vez autenticado |
| Brechas | **Diálogo** para el aviso de vencimiento (UXR-S4) y **layout de página inicial sin sesión**: el sistema describe el scrim y `elevation-3` pero no tiene componente Dialog ni layout público |
| Estados | Keycloak no disponible: página inicial (UXR-S2); acceso denegado sin revelar la causa (UXR-S3); aviso previo al vencimiento; sesión vencida |
| Criterios | US-027 AC-2, AC-4, AC-5; US-028 AC-1 a AC-6 |
| Abiertas | UXQ-5 |

### SCR-02 Datos del colaborador (BFF-V7, US-005)
| Campo | Valor |
|---|---|
| Roles | Cualquier usuario autenticado (BR-003) |
| Ruta BFF | `GET /api/v1/colaboradores/{id}` |
| Sistema | PaginatedDataTable de colaboradores (nombres, apellidos, fecha de ingreso, rol/nivel) con filtros en Input; detalle en panel `elevation-1`, `radius-default` |
| Brechas | Panel de detalle (**Card**) y campos de solo lectura |
| Estados | Sin resultados («No records» traducido); sin permiso. Sin controles de edición salvo JI y ADM (UXR-C1) |
| Criterios | US-005 AC-1, AC-2 |
| Decisión | D-UX-4: solo lo de US-005; contactos solo para JI, ADM y el propio colaborador |

### SCR-03 Ficha de gestión del colaborador (BFF-V1, US-004, US-016, US-021)
| Campo | Valor |
|---|---|
| Roles | JEFE_INGENIERIA, ADMIN |
| Ruta BFF | `GET /api/v1/colaboradores/{id}/ficha`, escrituras por paso |
| Sistema | Input y DatePicker (alta y modificación); DataTable de ocupaciones, de valoraciones con historial y de asignaciones (Badge de estado, % de dedicación en `tnum`); Button primario «Guardar», secundario «Cancelar» |
| Brechas | **Tabs** para las secciones de la ficha; **Alert** para la advertencia de nivel mínimo y el rechazo por sobreasignación; **Progress** del total de dedicación |
| Estados | Parcial (si cae formación o portafolio); asignación Pendiente (UXR-C3) |
| Criterios | US-004 AC-1 a AC-5; US-016 AC-1 a AC-3; US-021 AC-1 a AC-8 |
| Decisión | D-UX-3: lectura de valoraciones y asignaciones por mínimo privilegio |

### SCR-04 Catálogo de ediciones (BFF-V8, US-009)
| Campo | Valor |
|---|---|
| Roles | COLABORADOR |
| Ruta BFF | `GET /api/v1/ediciones-disponibles`, enrolar por paso |
| Sistema | PaginatedDataTable (curso, fechas, cupo disponible) con Button primario «Enrolarme» por fila; Badge del estado (con cupo, sin cupo, ya enrolado) |
| Brechas | Tarjetas de edición (**Card**) para móvil, si el sistema solo ofrece «tabla como tarjetas» |
| Estados | Edición sin cupo: acción deshabilitada con motivo visible (UXR-F1) |
| Criterios | US-009 AC-1 a AC-4 |

### SCR-05 Mis cursos y evidencias (BFF-V2, US-010, US-013)
| Campo | Valor |
|---|---|
| Roles | COLABORADOR |
| Ruta BFF | `GET /api/v1/mis-cursos`, desenrolar y evidencias por paso |
| Sistema | DataTable de enrolamientos; DataTable de evidencias esperadas con Badge «Obligatoria» o «Deseable» y estado «Pendiente» o «Validada»; Input para el issue; Button secundario «Desenrolarme» |
| Brechas | **Mensaje de error del campo** y texto de ayuda (el README de Input no define estado de error ni etiqueta); **Alert** para «issue no cerrado» |
| Criterios | US-010 AC-1, AC-2; US-013 AC-1 a AC-3; US-011 AC-3 |
| Decisión | D-UX-5: el colaborador pega la URL del issue; validación inmediata |

### SCR-06 Panel del evaluador (BFF-V3, US-011, US-012)
| Campo | Valor |
|---|---|
| Roles | INSTRUCTOR (solo su edición; lo decide el servicio) |
| Ruta BFF | `GET /api/v1/ediciones/{id}/panel-evaluador` |
| Sistema | DataTable de enrolados; Checkbox para la selección; Button primario «Certificar» (deshabilitado hasta el 100 % de obligatorias, con motivo); Button «Validar» por evidencia |
| Brechas | **Progress** de obligatorias validadas frente a exigidas: el sistema solo tiene Spinner y dice no mezclarlo con un porcentaje (README de Spinner), así que falta un indicador de progreso determinado |
| Criterios | US-011 AC-1 a AC-3; US-012 AC-1 a AC-4 |

### SCR-07 Proyecto y GitLab (BFF-V4, US-019, US-021, US-024)
| Campo | Valor |
|---|---|
| Roles | JEFE_INGENIERIA, ADMIN |
| Ruta BFF | `GET /api/v1/proyectos/{id}/panel` |
| Sistema | DataTable de milestones y de issues (solo lectura, ids en `label-code`); DatePicker para la vigencia de la jefatura; Input para cantidades de roles/niveles; Badge para el estado |
| Brechas | **Alert** «datos al <fecha y hora> UTC-05» (UXR-P3); **Progress** para el % de avance del milestone |
| Estados | GitLab no responde: aviso con la fecha de la última carga |
| Criterios | US-019 AC-1 a AC-4; US-024 AC-1 a AC-5 |
| Decisión | D-UX-1: se amplía la réplica de GitLab; los campos de milestones e issues dependen de esa migración |

### SCR-08 Promoción y desempeño (BFF-V5, US-017, US-026)
| Campo | Valor |
|---|---|
| Roles | JEFE_INGENIERIA, ADMIN |
| Ruta BFF | `GET /api/v1/colaboradores/{id}/promocion` |
| Sistema | DataTable de la brecha por competencia (nivel actual frente a mínimo); Radio para el resultado (supera, cumple, parcial, no cumple); DatePicker para el periodo; Button primario «Decidir promoción» (deshabilitado sin evaluación) |
| Brechas | **Textarea** para los comentarios; **Alert** de bloqueo por falta de evaluación |
| Criterios | US-017 AC-1 a AC-5; US-026 AC-1 a AC-7 |
| Decisión | D-UX-2: el siguiente rol/nivel se deriva de BR-031; Senior L4 no tiene siguiente (promoción bloqueada con motivo). D-UX-7: tras decidir, estado «promoción registrada, aplicando el cambio de plaza» |

### SCR-09 Consola de cargas de GitLab (US-020)
| Campo | Valor |
|---|---|
| Roles | JEFE_INGENIERIA, ADMIN |
| Ruta BFF | `GET /api/v1/cargas`, `POST /api/v1/cargas` |
| Sistema | PaginatedDataTable de ejecuciones (fecha-hora, estado con Badge); Button secundario «Reintentar»; Spinner `sm` en el botón mientras se ejecuta |
| Criterios | US-020 AC-3, AC-4, AC-9 |

### SCR-10 Mi progreso (BFF-V9, D-UX-3)
| Campo | Valor |
|---|---|
| Roles | COLABORADOR (lo suyo) |
| Ruta BFF | `GET /api/v1/mi-progreso` (BFF-V9) |
| Sistema | DataTable de valoraciones por competencia con historial, de evidencias (Badge Pendiente o Validada), de certificaciones y de asignaciones con estado |
| Brechas | Tabs para separar las secciones (DSG-4); EmptyState (DSG-7) |
| Estados | Sin valoraciones; sin enrolamientos; parcial |
| Criterios | US-016 AC-2; US-013; US-012 AC-1; US-021 AC-6 |
| Origen | Decisión D-UX-3: el colaborador ve lo suyo. Ninguna historia pide esta pantalla (**(I)**) |

## 4. Navegación por rol (I)
Una sola barra lateral, un nivel de submenú (README de Sidebar), con los ítems visibles según el rol grueso (ADR-P5). Los guards solo ocultan; decide el servidor.

| Ítem | Roles que lo ven |
|---|---|
| Inicio | Todos |
| Colaboradores (SCR-02) | Todos |
| Currícula (roles, competencias, perfiles) | JEFE_INGENIERIA, ADMIN |
| Formación: Cursos y ediciones | JEFE_INGENIERIA, ADMIN |
| Formación: Catálogo y Mis cursos (SCR-04, 05) | COLABORADOR |
| Mi progreso (SCR-10) | COLABORADOR |
| Formación: Mis ediciones (SCR-06) | INSTRUCTOR |
| Progresión (valoraciones, evaluación, promoción) | JEFE_INGENIERIA, ADMIN |
| Portafolio (productos, proyectos, asignaciones, motivos) | JEFE_INGENIERIA, ADMIN |
| GitLab (cargas) | JEFE_INGENIERIA, ADMIN |
| Organización (partes, plazas, vínculo) | JEFE_INGENIERIA, ADMIN |

**Contadores de pendientes (D-UX-6):** cada ítem con trabajo por hacer muestra un Badge primario con la cantidad (evidencias por validar para INSTRUCTOR y jefe de proyecto, asignaciones Pendientes para JI y ADM, certificaciones por emitir para INSTRUCTOR) y la campana de TopNav suma el total, sin bandeja ni detalle. Los datos vienen de BFF-V10.

Cada ítem necesita un ícono (la barra contraída solo los muestra). El sistema trae `dashboard`, `map`, `truck`, `shield`, `chart`, `bell`, `users`, `settings`, `file`; varios de los de P3M no tienen equivalente y habrá que aportar SVG propios.

## 5. Brechas del Design System frente a P3M
Componentes que las pantallas necesitan y el sistema no tiene. **Decisión D-UX-8 (ianache, 2026-10-13): se completan todos**, junto con los contrastes. La especificación está en [DSC-001](DSC-001-cambios-al-design-system.md); **aquí no se diseñaron**.

| ID | Brecha | Pantallas | Observación |
|---|---|---|---|
| DSG-1 | **Dialog / Modal** | SCR-01 (vencimiento), confirmaciones | El README define scrim y `elevation-3`, pero no hay componente |
| DSG-2 | **Alert / Banner** (información, advertencia, error) | SCR-03, 05, 07, 08 | Existen `error` y `error-container`, no el componente. Falta advertencia |
| DSG-3 | **Progress** determinado | SCR-03, 06, 07 | Spinner no sirve para porcentajes |
| DSG-4 | **Tabs** | SCR-03 | |
| DSG-5 | **Card** | SCR-02, 04 | El README menciona tarjetas (elevación 1) sin componente |
| DSG-6 | **Textarea**, **Select** propio y **FormField** con etiqueta, ayuda y **estado de error** | SCR-05, 08 | Input no documenta etiqueta ni error (solo TimeRangePicker habla de error) |
| DSG-7 | **Estado vacío** y **Toast** | Todas | |
| DSG-8 | **Layout público** (sin TopNav ni Sidebar) | SCR-01 | |
| DSG-9 | **Tema oscuro** | — | No requerido por ninguna fuente; solo se anota |

## 6. Hallazgos de accesibilidad del Design System (WCAG 2.2 AA)

> **Corrección (2026-10-13):** al aplicar [DSC-001](DSC-001-cambios-al-design-system.md) y leer el código del sistema, **DSA-3 y DSA-4 se retiran** (el texto del Badge ya cumplía; el README estaba equivocado) y **DSA-1 solo era real en el DatePicker**. DSA-2 y DSA-5 se corrigieron en el sistema, y se corrigieron además Checkbox, Radio y Select, que no eran operables con teclado. La tabla de abajo es la versión original.
Contrastes calculados con las fórmulas de WCAG sobre los valores de `tokens.json` (tema claro).

| ID | Hallazgo | Medida | Requisito |
|---|---|---|---|
| DSA-1 | **Placeholder:** `text-muted` sobre `surface-page` | 2,54 : 1 | Texto: 4,5 : 1 (1.4.3). Los placeholders del sistema ya no lo cumplen |
| DSA-2 | **Borde de campo:** `border-medium` sobre `surface-page` | 1,47 : 1 | Componentes de interfaz: 3 : 1 (1.4.11). Input, Select y Checkbox usan ese borde como único indicador |
| DSA-3 | **Texto de Badge de estado** (color pleno sobre tinte al 12 %) | activo 2,27; inactivo 3,23; en espera 1,96; suspendido 4,16 | 4,5 : 1. El README ya exige acompañar el color con texto, pero el texto mismo no tiene contraste |
| DSA-4 | **Punto de estado** `status-active` sobre blanco | 2,54 : 1 | 3 : 1 para el indicador; el texto lo respalda |
| DSA-5 | **Encabezado de tabla:** `text-secondary` sobre `surface-table-head`, 11 px | 4,46 : 1 | 4,5 : 1 (por 0,04) |
| — | Cumplen: `text-primary` 14,68; `text-secondary` sobre blanco 4,83; `on-primary` sobre `primary` 5,83; migas sobre `primary` 4,94; `error` 6,46; `on-error-container` 7,24 | | |

**Consecuencia para P3M:** la accesibilidad WCAG 2.2 AA es criterio de prueba de DSP-001 (UX-F1). Con los tokens actuales, DSA-1, DSA-2 y DSA-3 harían fallar esa revisión en pantallas de formulario y de estados. Hace falta una decisión del dueño del sistema. No se modificó el sistema.

## 7. Preguntas abiertas
Las de UXR-001 §5. Además:
| ID | Pregunta | Dueño |
|---|---|---|
| SCRQ-1 | ¿Qué micro UI de Angular corresponde a cada pantalla (ADR-04)? **Propuesta en §8:** shell y 5 micro UI. Falta decidir la opción de construcción (A o B) | Arquitectura y UX |
| ~~SCRQ-5~~ | **Atendida:** las pantallas de Currícula, cursos y ediciones, organización, productos, motivos y valoración están en [SCR-002](SCR-002-pantallas-de-administracion.md) (SCR-11 a SCR-21) y sus flujos en [FLW-002](FLW-002-flujos-de-administracion.md) | UX |
| ~~SCRQ-2~~ | **Resuelta (D-UX-9, ianache, 2026-10-13): sí se requieren flujos de usuario.** [FLW-001](FLW-001-flujos-de-usuario.md) cubre 5; faltan los de las pantallas de SCRQ-5 | UX |
| ~~SCRQ-3~~ | **Resuelta (D-UX-8):** se completan DSG-1 a DSG-8 y se corrigen DSA-1 a DSA-5 antes del diseño visual. Pendiente aplicar los cambios (DSC-001) | Dueño del IA Design System |
| ~~SCRQ-4~~ | **Resuelta (D-UX-10, ianache, 2026-10-13): botones e inputs miden 6–8 px.** `radius-md` pasa de 12 px a 6 px (candidato, ver DSC-001 §1); `radius-default` (8 px) sigue para tarjetas, paneles y la pestaña activa de la barra lateral | Dueño del IA Design System |

## 8. Micro UI propuestas (SCRQ-1)

> **Actualización (2026-10-13):** al pedir ianache «el esqueleto del shell y las micro UI» con una biblioteca de componentes que ambos importan, el esqueleto se generó con **federación en tiempo de ejecución (opción A)** dentro de **un espacio de trabajo Angular** (`codebase/p3m-portal-web`): el shell es el anfitrión y las 5 micro UI son remotas (Native Federation). La biblioteca es `@comsatel/p3m-ui`. **Esto sustituye mi recomendación de la opción B.** Falta que ianache o Arquitectura lo confirmen como decisión sobre ADR-04.
ADR-04 decide «micro UI en Angular» y un catálogo de componentes con Atomic Design, pero no enumera las micro UI. Propuesta: **un shell y 5 micro UI**, con los mismos criterios que se usaron para agrupar los servicios ([API-PRP-000](../api-contracts/API-PRP-000-resumen.md)): menos piezas desplegables, separar por recorrido de usuario y por dominio, y no acoplar.

| Pieza | Aloja (pantallas) | Historias | Roles | Servicio detrás |
|---|---|---|---|---|
| **shell** (anfitrión) | SCR-01 (sesión), TopNav, Sidebar por rol, Footer, aviso de vencimiento, contadores (BFF-V10), `GET /api/v1/me` | US-025, 027, 028 | Todos | BFF |
| **mfe-personas** | SCR-02, SCR-03 y las pantallas de organización (partes, contactos, roles, relaciones, plazas, ocupaciones, vínculo) | US-004, 005, 029 a 035 | Todos (lectura); JI y ADM (gestión) | API-PRP-001 |
| **mfe-curricula** | Roles, competencias, perfiles y niveles mínimos | US-001 a 003 | JI, ADM | API-PRP-002 |
| **mfe-formacion** | SCR-04, SCR-05, SCR-06 y la gestión de cursos y ediciones | US-006 a 013 | COLABORADOR, INSTRUCTOR, JI, ADM | API-PRP-003 |
| **mfe-progresion** | SCR-08, SCR-10 y las valoraciones | US-014 a 017, 026 | COLABORADOR (lo suyo), JI, ADM | API-PRP-003 |
| **mfe-portafolio** | SCR-07, SCR-09 y la gestión de productos, proyectos, asignaciones y motivos | US-018 a 024 | JI, ADM | API-PRP-004 y 005 |

**Por qué estas fronteras:**
- **Formación y Progresión se separan en la interfaz, aunque comparten servicio** (criterio S-5 del skill): son recorridos y actores distintos (el colaborador que se enrola y el evaluador, frente al jefe que valora y promueve). Pueden evolucionar por separado sin tocar los datos.
- **GitLab no tiene micro UI propia:** la consola de cargas es una sola pantalla y el panel del proyecto ya muestra milestones e issues; vive en `mfe-portafolio`.
- **Personas reúne CTX-01 y CTX-02** por la misma razón que el servicio (G-3, G-4).

**Reglas de frontera (I):**
1. Cada micro UI habla **solo con su prefijo del BFF** (API-PRP-006 §6) y nunca con otro servicio.
2. Las micro UI **no se montan dentro de otras**. La ficha de gestión muestra valoraciones y asignaciones con **componentes presentacionales de la biblioteca** y datos de BFF-V1, no incrustando `mfe-progresion` ni `mfe-portafolio`.
3. La sesión, el usuario y los permisos los da el **shell**; las micro UI los reciben, no los recalculan.
4. Navegación entre micro UI por **URL** (rutas del shell), no por estado compartido.
5. Los componentes (átomos, moléculas y organismos del IA Design System) se publican como **biblioteca de Angular versionada** (ADR-04); ninguna micro UI define los suyos.

**Cómo se construye (sin decidir):**
| Opción | Qué es | Cuándo conviene |
|---|---|---|
| A. Federación en tiempo de ejecución | Shell y micro UI se despliegan por separado (Native Federation o Module Federation) | Equipos independientes o ritmos de entrega distintos |
| **B. Un espacio de trabajo con módulos perezosos (recomendada para empezar)** | Mismas 5 fronteras, un solo despliegue, un solo repositorio, con reglas de dependencia verificadas; se pasa a A si hace falta | Equipo pequeño; evita la complejidad de la federación hasta que se necesite |

La opción B cumple «micro UI» como frontera de diseño y mantiene abierta la A. Si ADR-04 exige despliegue independiente desde el inicio, es A. **Decisión pendiente (SCRQ-1).**

**Pantallas que SCR-001 todavía no especifica (SCRQ-5):** Currícula (US-001 a 003), cursos y ediciones (US-006 a 008), organización (US-029 a 035), productos y motivos de excepción (US-018, 023) y la valoración (US-016). Hoy SCR-001 cubre 10 pantallas, las que dependen de las vistas del BFF.

## 9. Siguiente acción
Resolver SCRQ-3 con el dueño del sistema y UXQ-1, UXQ-2 y UXQ-3. Luego `user-flow-designer` para los flujos de SCR-01, SCR-04/05/06 y SCR-08, y el diseño visual con este sistema (por ejemplo con `claude-design-orchestrator`).
