---
type: Design System Change Request
title: "DSC-001 — Cambios solicitados al IA Design System"
description: "Correcciones de contraste y componentes que faltan en el IA Design System para cubrir las pantallas de P3M (SCR-001). Valores candidatos calculados; sin aplicar al sistema."
tags: [ux, design-system, accessibility, change-request]
status: draft
version: "0.1.0"
generated:
  by: "ui-spec-writer (aplicado por Claude Code)"
  at: "2026-10-13T02:00:00-05:00"
human-reviewed: false
sources:
  - id: scr-001
    resource: /design/ux/SCR-001-pantallas-del-bff.md
  - id: ia-design-system
    resource: https://claude.ai/artifact/ALfAWpY5JHEvoNxemZyJRJ
    trust: advisory
---

# DSC-001 — Cambios solicitados al IA Design System

> **APLICADO el 2026-10-13** (ianache lo confirmó). Lo publicado en el IA Design System difiere de lo propuesto abajo, porque al leer el código encontré que dos de mis hallazgos eran errores míos:
> - **DSA-3 (texto del Badge) y DSA-4 (puntos de estado) se retiran.** El README del sistema decía que el texto del Badge usaba el color pleno del estado, pero el código ya usa colores más oscuros con contraste de 4,74 a 6,34 : 1; los puntos son decorativos y llevan texto. Se publicaron los tokens `status-*-text` con **los valores que el código ya usaba** (`#0a7a5c`, `#b91c1c`, `#92620a`, `#4b5563`) y se corrigió el README. **No** se cambiaron los colores de los puntos.
> - **DSA-1 (placeholder)** solo era real en el DatePicker; el Input usa el color por defecto del navegador (4,61 : 1). Se fijó la regla en `bundle.css` (`.ds-field::placeholder` con `text-secondary`) y el DatePicker lo usa.
> - **DSA-2 (borde de campo) y DSA-5 (encabezado de tabla) eran reales y se aplicaron:** `border-control` `#8b919c` y `table-header-text` `#6a717f`.
> - **Defectos nuevos hallados al leer el código y corregidos:** Checkbox y Radio ocultaban su `input` con `display:none` (inaccesibles con teclado) y Select era un `div` con `onClick` (sin teclado); ahora son operables con teclado, con anillo de foco. DatePicker usaba 12 px de radio: ahora todos los controles usan `radius-md` (6 px, D-UX-10).
> - **Componentes agregados (10):** Dialog, Alert, Progress, Tabs, Card, FormField, Textarea, EmptyState, Toast y PublicLayout (Select ya existía en el bundle sin README propio). Tokens nuevos: `border-control`, `table-header-text`, `status-*-text`, `success-container`, `on-success-container`, `warning-container`, `on-warning-container`.
> - **Sin cambiar:** DSG-9 (tema oscuro, no pedido), iconos de P3M (DSC-Q1) y ejemplos del dominio (DSC-Q2). Quedan los textos «Portal KM» del Footer por defecto y el espacio de nombres `FleetKM` del bundle.
>
> El resto del documento conserva la **propuesta original** para trazabilidad.

> **Estado original:** `draft`, sin revisión humana. Decisión **D-UX-8** (ianache, 2026-10-13): completar el sistema con todo lo que falta antes del diseño visual. **Este documento no modifica el sistema**; es la especificación de lo que se le va a pedir. Los valores de color son **candidatos calculados** (ratio WCAG sobre los valores del tema claro actual) y los valida quien diseñe. No inventan paletas nuevas: derivan de los tokens existentes oscureciéndolos hasta el contraste exigido.

## 1. Correcciones de contraste (DSA-1 a DSA-5)

| ID | Problema actual | Cambio propuesto | Resultado calculado |
|---|---|---|---|
| DSA-1 | Placeholder con `text-muted` (2,54 : 1) | Los placeholders usan **`text-secondary`**. `text-muted` queda solo para íconos inactivos y texto deshabilitado | 4,83 : 1 sobre `surface-page` |
| DSA-2 | Borde de campo `border-medium` (1,47 : 1) | Nuevo token **`border-control`** `#8b919c` para el borde de Input, Select, Checkbox, Radio y DatePicker. `border-medium` se conserva para separadores y paneles | 3,17 : 1 sobre `surface-page`; 3,01 sobre `surface-alt` |
| DSA-3 | Texto de Badge de estado: color pleno sobre tinte al 12 % (1,96 a 4,16 : 1) | Nuevos tokens de texto de estado: **`status-active-text`** `#0b7e58`, **`status-inactive-text`** `#c43838`, **`status-pending-text`** `#9a6407`, **`status-suspended-text`** `#666c7a`. El Badge los usa para el texto y conserva el tinte | 4,54 / 4,54 / 4,56 / 4,53 : 1 sobre el tinte |
| DSA-4 | Punto `status-active` (2,54 : 1) y `status-pending` (2,15 : 1) | Puntos: **`status-active`** `#0fa875` y **`status-pending`** `#ce8509`; `status-inactive` y `status-suspended` ya cumplen | 3,05 y 3,01 : 1 sobre blanco |
| DSA-5 | Encabezado de tabla con `text-secondary` sobre `surface-table-head` (4,46 : 1) | Nuevo token **`table-header-text`** `#6a717f` (o usar `text-primary`) | 4,53 : 1 (13,55 con `text-primary`) |

**Radio de los controles (D-UX-10, ianache, 2026-10-13):** el sistema decía 12 px en `radius-md` y 6–8 px en los README de Button e Input. Vale 6–8 px. Cambio propuesto: **`radius-md` de 12 px a 6 px** (el valor que ya cita el README de Input), con lo que Button, Input, Select, Textarea y DatePicker quedan dentro de la especificación. `radius-default` (8 px) no cambia y sigue para tarjetas, paneles y la pestaña activa de la barra lateral. Si prefieres 8 px, solo cambia el valor; ambos están en el rango.

Los tokens existentes que **no** cambian: `primary` y `on-primary` (5,83), `text-primary` (14,68), `text-secondary` sobre blanco (4,83), `error` (6,46), `on-error-container` (7,24).

## 2. Tokens nuevos para Alert
El sistema no tiene color de advertencia, éxito ni información. Se derivan de los estados existentes, sin introducir colores nuevos:

| Variante | Fondo | Texto | Contraste |
|---|---|---|---|
| Error | `error-container` | `on-error-container` | 7,24 : 1 (ya existe) |
| Advertencia | tinte de `status-pending` al 12 % (`#fef3e2`) | `status-pending-text` | 4,56 : 1 |
| Éxito | tinte de `status-active` al 12 % (`#e2f7f0`) | `status-active-text` | 4,54 : 1 |
| Información | `surface-container` | `text-primary` | neutral; **el sistema no define un azul** y no se inventa |

Nombres propuestos: `warning-container`, `on-warning-container`, `success-container`, `on-success-container`.

## 3. Componentes que faltan (DSG-1 a DSG-8)
Cada uno lleva README y `preview.html` en el sistema. Aquí solo la especificación mínima. Todos usan tokens existentes; nada de valores crudos.

| ID | Componente | Nivel | Anatomía propuesta | Accesibilidad |
|---|---|---|---|---|
| DSG-1 | **Dialog** | O | Scrim `rgba(15, 23, 42, 0.45)`, panel `surface-page`, `radius-lg`, `elevation-3`; título `headline-md`, cuerpo `body-md`; pie con Button primario y secundario | `role="dialog"`, foco atrapado y devuelto, cierre con `Escape`, título como nombre accesible. Variante «aviso de sesión» |
| DSG-2 | **Alert** | M | Franja con ícono, título opcional, mensaje, acción opcional y cierre opcional; variantes error, advertencia, éxito e información (§2) | `role="alert"` para error, `role="status"` para el resto; no depende solo del color |
| DSG-3 | **Progress** | A | Barra determinada: pista `border-subtle`, relleno `primary`, etiqueta «n de m» en `tnum`; variante con umbral cumplido | `role="progressbar"` con `aria-valuenow`, `aria-valuemin`, `aria-valuemax`; el valor siempre en texto |
| DSG-4 | **Tabs** | M | Pestañas horizontales, activa con subrayado `primary` y texto `text-primary` semibold; panel debajo | `role="tablist"`, flechas izquierda y derecha, `aria-selected` |
| DSG-5 | **Card** | M | `surface-page`, 1 px `border-subtle`, `radius-default`, `elevation-1`, relleno `space-lg`; encabezado, cuerpo y acciones | Encabezado como nivel de título; tarjeta clicable con un único enlace |
| DSG-6 | **FormField**, **Textarea**, **Select** | M / A | FormField: etiqueta `title-sm`, texto de ayuda `body-sm` en `text-secondary`, mensaje de error en `error` con ícono y borde `error`. Textarea y Select con la carcasa de Input (38 px de alto mínimo, borde `border-control`) | Etiqueta asociada con `for`, ayuda y error enlazados con `aria-describedby`, `aria-invalid`; el error no depende solo del color |
| DSG-7 | **EmptyState**, **Toast** | M | EmptyState: ícono, título, texto y acción opcional dentro de la tabla o el panel. Toast: `elevation-2`, esquina inferior derecha, 5 s, con cierre | EmptyState como texto, no imagen; Toast con `role="status"`, sin acciones críticas |
| DSG-8 | **Layout público** | T | Página sin TopNav ni Sidebar: cabecera de marca, contenido centrado, Footer | Región principal etiquetada; foco inicial en la acción principal |

DSG-9 (tema oscuro) **no se pide**: ninguna fuente lo exige.

## 4. Otras decisiones del dueño del sistema
| ID | Pregunta |
|---|---|
| ~~SCRQ-4~~ | **Resuelta (D-UX-10):** valen 6–8 px. Ver el cambio de `radius-md` en §1 |
| DSC-Q1 | Los íconos de P3M (colaboradores, currícula, formación, progresión, portafolio, GitLab, organización) no tienen equivalente en la lista del sistema: ¿quién aporta los SVG? |
| DSC-Q2 | El sistema se construyó para telemática. Los ejemplos de los README (unidades, IMEI) no aplican a P3M: ¿se agregan ejemplos del dominio? |

## 5. Cómo se aplicaría
El sistema es un artefacto publicado, propiedad de ianache. Aplicar este documento significa publicar en él: `project/tokens.json` (tokens nuevos), un `README.md` y un `preview.html` por componente, los componentes en `components/bundle.js` y los tipos en `components/index.d.ts`. Es un cambio sobre un artefacto compartido, así que **no se hace sin tu confirmación**. Los contrastes se vuelven a calcular sobre lo que se publique.

## 6. Siguiente acción
Confirmar los valores de §1 y §2 y el alcance de §3. Luego aplicar los cambios al sistema y crear el proyecto de diseño con `claude-design-orchestrator`.
