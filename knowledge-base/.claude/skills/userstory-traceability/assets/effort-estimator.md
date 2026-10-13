# Estimador de esfuerzo de una User Story

Insumos: criterios de aceptación, dependencias y preguntas abiertas de la US-* y del DSP. Da una estimación de **referencia** para el Sprint Planning. No es un compromiso: el equipo la confirma o la corrige al asumir la historia.

**Unidad:** horas-persona de un Dev asistido por IA (Superpowers con Claude Code) para toda la historia. Incluye diseño, implementación, pruebas automatizadas, revisión humana del código y entrega a QA. No incluye el trabajo de QA (`TO TEST` e `IN TESTING`).

**Calibración:** los coeficientes de este documento son un punto de partida, sin datos históricos. Después de cada Sprint se comparan con el esfuerzo real y se ajustan (ver «Calibración»).

## Fórmula

```
Horas = ( 4 + 3 × criterios de aceptación ) × ( 1 + suma de factores )
```

Se redondea hacia arriba al siguiente múltiplo de 2 h.

- **4 h fijas:** arranque, plan de implementación, revisión humana y entrega a QA.
- **3 h por criterio de aceptación:** un escenario con su código, pruebas y revisión.

## Factores de complejidad

| Código | Factor | Se aplica cuando | Suma |
|---|---|---|---|
| E | Integración externa | La historia usa Keycloak, la API de GitLab u otro sistema externo | +0,30 |
| S | Seguridad o sesión | Autenticación, autorización, sesión o datos sensibles | +0,20 |
| V | Vigencia o integridad | Historial con vigencia o invariantes como «una sola vigente» o «suma ≤ 100 %» | +0,20 |
| F | Fundación | Es la primera historia que inaugura un patrón que otras reutilizan (acceso, esquema base, primer CRUD) | +0,20 |
| D | Dependencia en el Sprint | Depende de otra historia que se construye en el mismo Sprint | +0,10 |
| Q | Preguntas abiertas | Cada pregunta abierta que no bloquea la historia suma 0,05, con un máximo de 0,15 | +0,05 por pregunta |

## Talla

| Talla | Horas | Acción |
|---|---|---|
| S | hasta 12 | — |
| M | 13 a 24 | — |
| L | 25 a 40 | Revisar si conviene dividirla |
| XL | más de 40 | Dividir la historia antes del Sprint Planning (no se divide en tareas) |

## Confianza

Según la suma de factores: **Alta** hasta 0,15; **Media** hasta 0,50; **Baja** por encima de 0,50.

## Cómo se registra

En el Issue de la historia (sección «Estimación de esfuerzo (referencia)»), sin tocar el archivo US-*:

```
- **Estimación de esfuerzo:** <H> h (talla <S/M/L>, confianza <Alta/Media/Baja>). Propuesta; la confirma el equipo en el Sprint Planning
- **Base de la estimación:** <n> criterios; factores: <códigos>; preguntas abiertas no bloqueantes: <n>
```

## Estimate de GitLab

Las horas calculadas se registran también en el estimate nativo del Issue de GitLab (`/estimate {H}h`), para contrastarlas con las horas reportadas (`/spend`). Ver «Labels y estimate» en SKILL.md.

## Calibración

Al cerrar un Sprint, comparar horas reales con las estimadas por historia. Si la desviación media supera el 30 %, ajustar las 3 h por criterio o los factores en este documento y anotar la fecha del cambio.
