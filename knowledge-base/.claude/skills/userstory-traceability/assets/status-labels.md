# Estados de una User Story en GitLab (labels `Status :: …`)

El estado de avance de la User Story vive solo en el label del Issue. El archivo US-* no lo guarda, para no tener dos fuentes. Los labels `Status :: …` son excluyentes entre sí (label con alcance): un Issue tiene uno solo a la vez.

| Label | Significado | Quién actúa | Salida |
|---|---|---|---|
| `Status :: PENDING` | Estado inicial del Issue generado por el skill. | — | Alguien toma la historia. |
| `Status :: IN PROGRESS` | Un colaborador, junto con un Agente IA en modo CoWork, implementa la User Story completa como unidad de trabajo (sin dividirla en tareas). La implementación usa Superpowers con Claude Code. | Dev + Agente IA | Implementación terminada. |
| `Status :: TO TEST` | El trabajo CoWork Dev–IA se libera para que un humano confirme que la implementación cumple los criterios de aceptación y la Definition of Done. | Humano (QA) | Se acepta para pruebas. |
| `Status :: IN TESTING` | Un QA humano con un Agente IA en modo CoWork ejecuta pruebas automatizadas o manuales sobre los criterios de aceptación y la Definition of Done. | QA + Agente IA | Resultado de la prueba. |
| `Status :: TESTED` | El aseguramiento QA–IA determinó que se cumplen los criterios de aceptación y la Definition of Done. | QA + Agente IA | Cierre. |
| `Status :: CLOSED` | Se cierra la User Story: concluye todo el trabajo CoWork Dev/QA–IA. | Responsable | Fin. |

## Label `Blocked`

Label independiente de `Status :: …`: no es excluyente con ellos. Se agrega a un Issue que no puede avanzar por una dependencia o impedimento, y se quita cuando se resuelve. Un Issue conserva su `Status :: …` mientras está bloqueado. Al marcarlo, comentar el motivo y quién lo resuelve.

## Historias en curso por persona

El límite de historias en curso por persona lo define el Sprint Planning de cada Sprint y se registra en el SSP. Este documento no fija un valor.

## Transiciones

`PENDING → IN PROGRESS → TO TEST → IN TESTING → TESTED → CLOSED`

Retorno: si el aseguramiento falla, `IN TESTING → IN PROGRESS`, con un comentario en el Issue que indique el criterio incumplido. Ningún otro retroceso.

## Reglas
- Cambiar de estado es una mutación de GitLab; el skill solo asigna `Status :: PENDING` al crear. Los demás cambios los hacen las personas en el Board.
- Al pasar a `Status :: CLOSED`, cerrar también el Issue (estado cerrado de GitLab) en el mismo paso.
- No se crean tareas ni sub-issues por User Story.
