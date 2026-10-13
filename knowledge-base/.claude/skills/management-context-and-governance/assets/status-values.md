# Valores del campo `status`

Valores permitidos para el campo `status` de los Packs de este skill.

| Valor | Significado |
|---|---|
| `READY` | Contexto suficiente y validado para continuar. |
| `PARTIAL` | Permite avanzar parcialmente, pero tiene vacíos declarados. |
| `BLOCKED` | Falta una dependencia obligatoria. |
| `NEEDS_CLARIFICATION` | Existe una ambigüedad que debe resolver el responsable. |
| `NEEDS_HUMAN_REVIEW` | Requiere revisión o decisión humana. |
| `COMPLETED` | El DCP fue producido y no quedan acciones obligatorias. |

## Equivalencias con valores anteriores

| Valor anterior | Equivale a | Nota |
|---|---|---|
| `REQUIRES_REVIEW` | `NEEDS_HUMAN_REVIEW` | Documento generado que espera revisión o decisión humana. Al leer un documento antiguo con `REQUIRES_REVIEW`, tratarlo como `NEEDS_HUMAN_REVIEW`. Los documentos nuevos usan solo los seis valores de la tabla. |

Los campos `scope_state` del DSP (por ejemplo `READY_FOR_SPRINT_SELECTION`) y el veredicto antiguo `CONDITIONAL` son de otra lista y no forman parte de esta equivalencia.
