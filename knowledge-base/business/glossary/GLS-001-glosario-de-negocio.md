---
type: Business Glossary
title: "GLS-001 — Glosario de negocio"
description: "Catálogo indexado y ordenado alfabéticamente de los conceptos, términos y siglas de negocio del P3M. Cada término reside en su propio archivo OKF en terms/."
tags: [glossary, business, terms, acronyms]
status: approved
generated:
  by: "af-business-glossary-curator/1.1"
  at: "2026-10-10T12:00:00-05:00"
verified:
  by: "ianache (Functional Analysis)"
  at: "2026-10-10T22:00:00-05:00"
sources:
  - id: rcp-001
    resource: /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md
---

# GLS-001 — Glosario de negocio

> **Procedencia:** RCP-001 (Requirement Context Pack del P3M), en estado `draft`, construido con las decisiones del responsable funcional dadas en sesión. Es una fuente N2 hasta que un humano la verifique. **Alcance:** P3M (People, Product and Project Management) del Área de Desarrollo de COMSATEL. **Consumidor:** Analista Funcional y los Skills `af-business-rule-extractor`, `af-conceptual-model-designer` y `af-user-story-refiner`. Ninguna definición está verificada hasta que la valide su responsable.

## Cómo leer este glosario

- Cada término es un artefacto OKF v0.2 propio en `terms/TRM-NNNN-<slug>.md`, con su estado y su verificación. Este catálogo es solo el índice: se genera con `glossary.py build` y no se edita a mano entre los marcadores.
- El índice está en orden alfabético del español: sin distinguir mayúsculas ni tildes, con la Ñ después de la N y las cifras antes de la A.
- El índice incluye sinónimos y formas completas de siglas en cursiva (*Sinónimo* → Término).
- Niveles de fuente: **N1** primaria, **N2** secundaria confiable, **N3** terciaria (no respalda una definición por sí sola).
- `Clasificación: gap` significa que no hay una fuente N1 o N2 que respalde la definición.

## Índice

<!-- glossary:index:start -->
### A

| Término | Tipo | Definición | Estado |
|---|---|---|---|
| [ADMIN](terms/TRM-0028-admin.md) | término | Perfil de usuario del portal que, igual que el Jefe de Ingeniería, puede registrar y modificar colaboradores, mantener el catálogo de roles y registrar la valoración de los colaboradores. | approved |
| [Asignación](terms/TRM-0034-asignacion.md) | concepto | Vínculo de un colaborador con un proyecto según el rol/nivel que el proyecto requiere. Lo realiza el Jefe de Ingeniería y un colaborador puede tener varias a la vez. Si el colaborador no alcanza el nivel mínimo de las competencias del rol/nivel, el portal advierte y la asignación queda pendiente hasta que se apruebe una excepción. | draft |
| *Asignación a proyecto* → [Asignación](terms/TRM-0034-asignacion.md) | | | |
| [Atomic Design](terms/TRM-0057-atomic-design.md) | término | Enfoque en el que se basa el catálogo de componentes de interfaz reutilizables del portal. | draft |

### B

| Término | Tipo | Definición | Estado |
|---|---|---|---|
| [BFF](terms/TRM-0054-bff.md) | sigla | Componente de servidor, en Next.js, que está entre el SPA en Angular y Keycloak. Autentica a los usuarios con PKCE y controla la cookie de sesión del SPA para no comprometer datos sensibles en el navegador. | draft |
| [Brecha de cumplimiento](terms/TRM-0042-brecha-de-cumplimiento.md) | concepto | Diferencia entre el nivel actual de cada competencia de un colaborador y el nivel mínimo del siguiente rol/nivel, que el portal muestra a partir de la valoración. | approved |

### C

| Término | Tipo | Definición | Estado |
|---|---|---|---|
| [Carga automática de GitLab](terms/TRM-0047-carga-automatica-de-gitlab.md) | concepto | Proceso automático programado y de solo lectura que trae de GitLab los issues y milestones creados o actualizados desde la ejecución más reciente (delta de cambio). Cada ejecución queda en un registro con fecha y hora y estado (exitosa o fallida), que el Jefe de Ingeniería y los ADMIN consultan y desde el cual pueden reintentar. | approved |
| *Categoría* → [Seniority](terms/TRM-0004-seniority.md) | | | |
| *Certificación* → [Certificación de curso](terms/TRM-0022-certificacion-de-curso.md) | | | |
| [Certificación de curso](terms/TRM-0022-certificacion-de-curso.md) | concepto | Reconocimiento que se emite por edición a un colaborador cuando el 100% de las evidencias obligatorias están Validadas. Es el mismo resultado que la promoción en el curso. Es una forma de evidencia del logro de una competencia y sustenta la escalada de nivel y de seniority. | approved |
| *Certificado* → [Certificación de curso](terms/TRM-0022-certificacion-de-curso.md) | | | |
| [Colaborador](terms/TRM-0002-colaborador.md) | concepto | Persona del Área de Desarrollo de COMSATEL registrada en el portal con nombres, apellido paterno, apellido materno, fecha de ingreso a Comsatel y un único rol/nivel vigente. | approved |
| [Competencia](terms/TRM-0007-competencia.md) | concepto | Lo esperado de un rol/nivel. Tiene código, nombre, un tipo único (conocimiento, habilidad o actitud) y la definición de cada nivel de logro N1 a N3. Una competencia general puede estar en más de un perfil de competencias y las demás son exclusivas de un perfil. Tiene un indicador que define si es general o específica (exclusiva de un rol). | draft |
| [Cupo](terms/TRM-0014-cupo.md) | concepto | Límite de enrolamientos de una edición de curso. Al llegar a él no se admite más enrolamiento. | approved |
| [Curso](terms/TRM-0011-curso.md) | concepto | Actividad de entrenamiento interna del portal, virtual, presencial o híbrida, con código, nombre, sumilla y objetivos de aprendizaje vinculados a competencias, y con ediciones. El Jefe de Ingeniería lo define. Puede desarrollar más de una competencia. La modalidad no cambia su tratamiento. | approved |

### D

| Término | Tipo | Definición | Estado |
|---|---|---|---|
| [Dato de contacto](terms/TRM-0051-dato-de-contacto.md) | concepto | Información para contactar a un colaborador. Su tipo es correo, teléfono o dirección. El teléfono y el correo electrónico son obligatorios. | approved |

### E

| Término | Tipo | Definición | Estado |
|---|---|---|---|
| *Edición* → [Edición de curso](terms/TRM-0013-edicion-de-curso.md) | | | |
| [Edición de curso](terms/TRM-0013-edicion-de-curso.md) | concepto | Realización de un curso con número de edición, fecha de inicio y fin, cupo e instructor asignado, que actúa como Evaluador. El colaborador se auto-enrola en la edición. | approved |
| [Enrolamiento](terms/TRM-0015-enrolamiento.md) | concepto | Inscripción de un colaborador en una edición de curso. El colaborador se auto-enrola y puede desenrolarse. Sobre el enrolamiento se registran el avance, la evaluación y el certificado. | approved |
| *Escala de logro* → [Nivel de logro (N1–N3)](terms/TRM-0008-nivel-de-logro-n1-n3.md) | | | |
| [Estado de evidencia](terms/TRM-0021-estado-de-evidencia.md) | concepto | Clasificación del estado de una evidencia aportada: Pendiente o Validada. | approved |
| [Evaluación de desempeño](terms/TRM-0053-evaluacion-de-desempeno.md) | concepto | Evaluación del Jefe de Ingeniería sobre un colaborador, hecha con la información de evaluación de los cursos y las evidencias que el colaborador aporta sobre su desempeño en los proyectos. Es semestral, aunque puede hacerse a demanda, y su resultado es supera, cumple, parcial o no cumple. Registra además el periodo, los comentarios, las evidencias consideradas, la fecha y hora del registro y el usuario que la registra, y se conserva su historial. Es obligatoria e insumo para decidir la promoción según el cumplimiento de los requisitos de las competencias del nuevo rol/nivel. | draft |
| [Evaluador](terms/TRM-0016-evaluador.md) | concepto | Rol del portal, asignado a usuarios en Keycloak, que corresponde al instructor asignado a una edición de curso. Valida las evidencias del curso, evalúa, emite el certificado y promociona al colaborador en el curso. | approved |
| [Evidencia](terms/TRM-0017-evidencia.md) | concepto | Prueba del logro de una competencia de un rol/nivel: el certificado de un curso o una tarea o user story de un proyecto. Se distingue la evidencia esperada, que define el curso o la competencia, de la evidencia aportada por un colaborador. | approved |
| [Evidencia aportada](terms/TRM-0041-evidencia-aportada.md) | concepto | Referencia a un issue de GitLab cerrado (Task o UserStory) que un colaborador presenta como evidencia del logro de un objetivo. La de curso la registra en la edición en que está enrolado y la valida el instructor; la de proyecto la valida el jefe de proyecto. Tiene estado Pendiente o Validada. | approved |
| [Evidencia de proyecto](terms/TRM-0018-evidencia-de-proyecto.md) | concepto | Evidencia aportada que referencia un issue de GitLab con label Task o UserStory en estado Closed. La aporta el colaborador y la valida el jefe de proyecto. | approved |
| [Evidencia deseable](terms/TRM-0020-evidencia-deseable.md) | concepto | Evidencia esperada que la rúbrica del objetivo define como opcional (deseable): no limita la certificación de la edición. | approved |
| [Evidencia esperada](terms/TRM-0040-evidencia-esperada.md) | concepto | Evidencia que la rúbrica de un objetivo de curso define, para cada nivel de logro, para mostrar el logro. Es obligatoria (mandatoria o requerida) u opcional (deseable). | approved |
| [Evidencia obligatoria](terms/TRM-0019-evidencia-obligatoria.md) | concepto | Evidencia esperada que la rúbrica del objetivo define como obligatoria: debe estar 100% Validada para certificar la edición. | approved |
| *Evidencia opcional* → [Evidencia deseable](terms/TRM-0020-evidencia-deseable.md) | | | |
| *Evidencia requerida* → [Evidencia obligatoria](terms/TRM-0019-evidencia-obligatoria.md) | | | |
| [Excepción de asignación](terms/TRM-0035-excepcion-de-asignacion.md) | concepto | Aprobación del Jefe de Ingeniería para asignar a un colaborador a un proyecto aunque no alcance el nivel mínimo de las competencias. Hasta que se aprueba, la asignación queda pendiente. De la excepción se registran el motivo, tomado de un codificador prestablecido, y quién la aprobó. | approved |

### G

| Término | Tipo | Definición | Estado |
|---|---|---|---|
| [GitLab](terms/TRM-0036-gitlab.md) | concepto | Sistema externo donde se registran, por producto, los issues (user stories y tareas) y los milestones. El portal los lee, consultados de forma automática (cada 30 segundos por defecto), y no escribe en él. | approved |

### I

| Término | Tipo | Definición | Estado |
|---|---|---|---|
| [IdM](terms/TRM-0038-idm.md) | sigla | Gestión de identidades y roles de los usuarios del portal, que se mantiene en Keycloak. | approved |
| *Instructor* → [Evaluador](terms/TRM-0016-evaluador.md) | | | |
| *Instructor de la edición* → [Evaluador](terms/TRM-0016-evaluador.md) | | | |
| *Issue* → [Issue de GitLab](terms/TRM-0032-issue-de-gitlab.md) | | | |
| [Issue de GitLab](terms/TRM-0032-issue-de-gitlab.md) | concepto | Elemento de trabajo registrado en GitLab. Con label UserStory representa una user story y con label Task, una tarea. El portal muestra su id, título, esfuerzo estimado, status, esfuerzo spent y due date. | approved |

### J

| Término | Tipo | Definición | Estado |
|---|---|---|---|
| [Jefe de Ingeniería](terms/TRM-0026-jefe-de-ingenieria.md) | concepto | Responsable funcional del portal. Registra y modifica colaboradores, mantiene el catálogo de roles, define los perfiles de competencias, el nivel mínimo, los cursos con sus objetivos y evidencias esperadas, y las ediciones, registra la valoración de los colaboradores, asigna colaboradores a proyectos, aprueba las excepciones de asignación y decide las promociones de nivel. | approved |
| [Jefe de proyecto](terms/TRM-0027-jefe-de-proyecto.md) | concepto | Colaborador con el rol Jefe de Proyecto en un proyecto, con vigencia desde y hasta e historial de cambios, que valida las evidencias de proyecto de ese proyecto. Se registra al gestionar los proyectos de un producto. | approved |

### K

| Término | Tipo | Definición | Estado |
|---|---|---|---|
| [Keycloak](terms/TRM-0037-keycloak.md) | concepto | Sistema que mantiene el IdM de los usuarios del portal y donde se asignan los roles. Los perfiles ADMIN, Jefe de Ingeniería, Evaluador y colaborador se administran en él. | approved |

### M

| Término | Tipo | Definición | Estado |
|---|---|---|---|
| *Mandatoria* → [Evidencia obligatoria](terms/TRM-0019-evidencia-obligatoria.md) | | | |
| [Micro UI](terms/TRM-0058-micro-ui.md) | término | Parte de la interfaz del portal desarrollada en Angular que se integra al SPA y reutiliza el catálogo de componentes. | draft |
| *Milestone* → [Sprint](terms/TRM-0031-sprint.md) | | | |
| *Milestone de GitLab* → [Sprint](terms/TRM-0031-sprint.md) | | | |
| [Motivo de excepción](terms/TRM-0039-motivo-de-excepcion.md) | concepto | Código y descripción de un codificador prestablecido que se registra, junto con quién aprobó, al excepcionar una asignación. Existe una funcionalidad para mantener el codificador. | approved |

### N

| Término | Tipo | Definición | Estado |
|---|---|---|---|
| [Nivel de desarrollo (L1–L4)](terms/TRM-0005-nivel-de-desarrollo-l1-l4.md) | concepto | Escala de niveles L1, L2, L3 y L4 dentro de cada seniority, que expresa niveles de desarrollo de competencias. De L4 de un seniority se pasa a L1 del siguiente (Junior a Semisenior, Semisenior a Senior). | approved |
| [Nivel de logro (N1–N3)](terms/TRM-0008-nivel-de-logro-n1-n3.md) | concepto | Escala de desarrollo de una competencia: N1 no desarrollada, N2 en desarrollo y N3 desarrollada. | approved |
| [Nivel mínimo de competencia](terms/TRM-0009-nivel-minimo-de-competencia.md) | concepto | Nivel de logro (N1 a N3) que un rol/nivel exige como mínimo de cada competencia asociada a su perfil, y solo de ellas. Lo define el Jefe de Ingeniería. Se usa para valorar el cumplimiento del siguiente rol/nivel y para advertir en la asignación a un proyecto. | approved |

### O

| Término | Tipo | Definición | Estado |
|---|---|---|---|
| *Objetivo de aprendizaje* → [Objetivo de curso](terms/TRM-0012-objetivo-de-curso.md) | | | |
| [Objetivo de curso](terms/TRM-0012-objetivo-de-curso.md) | concepto | Objetivo de aprendizaje de un curso, vinculado a una competencia y al nivel objetivo que se desarrolla. Define una rúbrica con las evidencias esperadas, obligatorias u opcionales. | approved |
| [Ocupación de plaza](terms/TRM-0064-ocupacion-de-plaza.md) | concepto | Periodo, con fecha desde y hasta, en que una persona ocupa una plaza. Es la forma en que un colaborador tiene un rol/nivel y de ella sale el historial de sus cambios de nivel y seniority. | draft |
| [Organización](terms/TRM-0050-organizacion.md) | concepto | Entidad a la que se vinculan los colaboradores. COMSATEL y el Área de Desarrollo son organizaciones, y el Área de Desarrollo es parte de COMSATEL. También lo son otras, como los proveedores que proporcionan colaboradores. | approved |

### P

| Término | Tipo | Definición | Estado |
|---|---|---|---|
| *P3M* → [Portal](terms/TRM-0001-portal.md) | | | |
| [Parte](terms/TRM-0059-parte.md) | concepto | Persona u organización que el P3M registra y con la que se relaciona. Es el concepto general del que son especializaciones la persona y la organización, según el UDM. | draft |
| *People, Product and Project Management* → [Portal](terms/TRM-0001-portal.md) | | | |
| *Perfil ADMIN* → [ADMIN](terms/TRM-0028-admin.md) | | | |
| [Perfil de competencias](terms/TRM-0010-perfil-de-competencias.md) | concepto | Conjunto de competencias a las que se vincula un rol, cada una con niveles de logro N1 a N3. Una competencia general puede estar en más de un perfil. Se registra y mantiene en el catálogo del portal, y el Jefe de Ingeniería lo define. El rol/nivel selecciona de cada competencia su nivel mínimo. | approved |
| [Persona](terms/TRM-0060-persona.md) | concepto | Parte que es un individuo, con sus nombres, apellido paterno y materno. Un colaborador es una persona en el rol de colaborador. La persona tiene datos de contacto y se identifica con un usuario. | draft |
| [PKCE](terms/TRM-0055-pkce.md) | sigla | Protocolo que usa el BFF para integrar el portal con Keycloak y permitir el ingreso seguro de los usuarios, sin comprometer datos sensibles en el navegador. | draft |
| *Plataforma* → [Portal](terms/TRM-0001-portal.md) | | | |
| [Plaza](terms/TRM-0063-plaza.md) | concepto | Puesto concreto de una organización, de un rol/nivel (por ejemplo, Developer, Junior, Nivel 2), que un colaborador ocupa durante un periodo. | draft |
| [Portal](terms/TRM-0001-portal.md) | concepto | Sistema independiente del Área de Desarrollo de COMSATEL, llamado P3M (People, Product and Project Management), para gestionar a las personas (colaboradores, currícula de entrenamiento y competencias), los productos y los proyectos, y la asignación de colaboradores a proyectos. | draft |
| [Producto](terms/TRM-0029-producto.md) | concepto | Software que desarrollan los colaboradores del Área de Desarrollo. Tiene código y nombre y se vincula a un proyecto de GitLab mediante su project_id. | approved |
| *Promoción* → [Promoción de nivel](terms/TRM-0024-promocion-de-nivel.md) | | | |
| [Promoción de nivel](terms/TRM-0024-promocion-de-nivel.md) | concepto | Decisión del Jefe de Ingeniería de pasar a un colaborador al siguiente nivel L o seniority de su rol. Es de criterio libre y se basa en la valoración del cumplimiento del siguiente rol/nivel en su nivel mínimo, con los resultados de los cursos y las evidencias de proyecto del colaborador. | approved |
| [Promoción en el curso](terms/TRM-0023-promocion-en-el-curso.md) | concepto | Resultado que el Evaluador otorga al colaborador en un curso. Es el mismo resultado que la certificación de curso. Acredita el logro de los objetivos del curso, pero no acredita por sí solo el nivel de las competencias. | approved |
| [Proyecto](terms/TRM-0030-proyecto.md) | concepto | Trabajo de un solo producto, con código, nombre, fechas de inicio y fin, costo y esfuerzo estimados. Es un conjunto de milestones de GitLab, que el usuario selecciona al registrarlo, y puede requerir varios roles/niveles con cantidades. | approved |

### R

| Término | Tipo | Definición | Estado |
|---|---|---|---|
| [Relación entre partes](terms/TRM-0062-relacion-entre-partes.md) | concepto | Vínculo con vigencia (desde y hasta) entre dos partes, de un tipo. Los tipos que las fuentes definen son «reporta a» (un colaborador con su único jefe), «membership» (un colaborador con una organización, una sola vigente) y «es parte de» (una organización con otra). | draft |
| *Requerida* → [Evidencia obligatoria](terms/TRM-0019-evidencia-obligatoria.md) | | | |
| [Rol](terms/TRM-0003-rol.md) | concepto | Función del catálogo oficial de roles del portal. El catálogo no está predefinido y lo mantienen el Jefe de Ingeniería o un ADMIN. Cada rol se vincula a un perfil de competencias, y roles y perfiles se registran y mantienen en ese catálogo. | approved |
| [Rol de la parte](terms/TRM-0061-rol-de-la-parte.md) | concepto | Función que una parte desempeña durante un periodo, por ejemplo colaborador, jefe de proyecto o instructor. No es el rol del catálogo oficial de la currícula ni un rol de usuario. | draft |
| [Rol/nivel](terms/TRM-0006-rol-nivel.md) | concepto | Combinación de un rol con un nivel (seniority y L1–L4). Determina qué currícula le corresponde a un colaborador y qué roles requiere un proyecto. | approved |
| [Rúbrica](terms/TRM-0045-rubrica.md) | concepto | Descriptor que define cada objetivo de un curso: define los niveles de logro de la competencia y, para cada nivel, la descripción observable del desempeño y las evidencias requeridas para mostrar el logro, obligatorias u opcionales. | approved |

### S

| Término | Tipo | Definición | Estado |
|---|---|---|---|
| [Seniority](terms/TRM-0004-seniority.md) | concepto | Categoría de progresión profesional: Junior, Semisenior o Senior. Cada seniority contiene los niveles de desarrollo L1 a L4. | approved |
| [Solicitud de promoción](terms/TRM-0048-solicitud-de-promocion.md) | concepto | Petición que registra un colaborador para pasar a un nuevo rol/nivel de su línea de carrera, con las evidencias que la sustentan. La evalúa el Jefe de Ingeniería, que valora todas las evidencias aportadas. | approved |
| [SPA](terms/TRM-0056-spa.md) | sigla | Aplicación web de una sola página del portal, desarrollada en Angular, con micro UI. Se comunica con el BFF. | draft |
| [Sprint](terms/TRM-0031-sprint.md) | concepto | Unidad en que se organiza el desarrollo de un proyecto. Equivale a un milestone de GitLab, que tiene asignados issues Task y UserStory y del que el portal muestra id, nombre, tareas totales, tareas cerradas y % de avance. | approved |
| [Sumilla](terms/TRM-0046-sumilla.md) | concepto | Texto que resume un curso. Es un dato mínimo del curso, junto con su código, nombre y objetivos de aprendizaje. | draft |

### T

| Término | Tipo | Definición | Estado |
|---|---|---|---|
| [Tarea de planning](terms/TRM-0043-tarea-de-planning.md) | concepto | Issue de GitLab con label Task, vinculado a un issue con label UserStory durante el sprint planning de un sprint. | approved |
| [Tipo de competencia](terms/TRM-0044-tipo-de-competencia.md) | concepto | Clasificación única de una competencia: conocimiento, habilidad o actitud. | approved |

### U

| Término | Tipo | Definición | Estado |
|---|---|---|---|
| *Universal Data Model* → [Universal Data Model (UDM)](terms/TRM-0049-universal-data-model-udm.md) | | | |
| [Universal Data Model (UDM)](terms/TRM-0049-universal-data-model-udm.md) | sigla | Modelo de referencia con el que se alinean el registro de colaboradores y las relaciones entre ellos. Se usan sus construcciones de Party (persona u organización), rol de la parte, relación entre partes y mecanismos de contacto, entre otras. | approved |
| [User story](terms/TRM-0033-user-story.md) | concepto | Issue de GitLab con label UserStory. Forma el alcance de un proyecto y se obtiene de GitLab, no se crea en el portal. | approved |
| [Usuario](terms/TRM-0052-usuario.md) | concepto | Persona autenticada en el portal mediante Keycloak. Al iniciar sesión se registra con su GUID de Keycloak, username, correo electrónico y los roles de usuario que tiene asignados en Keycloak (colaborador, Instructor, Jefe de Ingeniería o ADMIN). Es la identidad que le permite a un colaborador ingresar al portal y quien mantiene el GUID de Keycloak. | approved |

### V

| Término | Tipo | Definición | Estado |
|---|---|---|---|
| [Valoración de cumplimiento](terms/TRM-0025-valoracion-de-cumplimiento.md) | concepto | Registro que hacen el Jefe de Ingeniería o un ADMIN del nivel actual (N1 a N3) de cada competencia de un colaborador, con historial. Con él, el portal muestra la brecha frente al siguiente rol/nivel y el Jefe de Ingeniería decide la promoción de nivel. | approved |
<!-- glossary:index:end -->

## Preguntas abiertas

| ID | Término | Pregunta | Responsable | Prioridad | Estado |
|---|---|---|---|---|---|
| GQ-01 | [IdM](terms/TRM-0038-idm.md) | ¿Cuál es la forma completa de la sigla IdM? Ninguna fuente la expande. | Por definir | Baja | Abierta |
| GQ-02 | [GitLab](terms/TRM-0036-gitlab.md), [Keycloak](terms/TRM-0037-keycloak.md), [IdM](terms/TRM-0038-idm.md) | ¿Qué rol es responsable de estos términos de sistemas externos? Ninguna fuente lo asigna. | Jefe de Ingeniería | Baja | Abierta |
| GQ-03 | [Nivel mínimo de competencia](terms/TRM-0009-nivel-minimo-de-competencia.md) | Contradicción: el mínimo para asignar es N2 (RCP-001:L123), pero el rol/nivel selecciona el mínimo de cada competencia (RCP-001:L136). ¿N2 es la regla general o un caso? | Jefe de Ingeniería | Media | Cerrada — /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L158 (N2, sin verificar): N2 era solo un ejemplo |
| GQ-04 | [Evidencia](terms/TRM-0017-evidencia.md) | ¿Se distingue la evidencia requerida (definida en el curso o la competencia) de la evidencia aportada por un colaborador? Hoy el término cubre ambas. | Jefe de Ingeniería | Media | Cerrada — /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L171 (N2, sin verificar): se diferencian. Nuevos términos [Evidencia esperada](terms/TRM-0040-evidencia-esperada.md) y [Evidencia aportada](terms/TRM-0041-evidencia-aportada.md) |
| GQ-05 | [Edición de curso](terms/TRM-0013-edicion-de-curso.md) | La fuente atribuía la fecha de inicio y fin al curso. ¿Pertenece al curso o a cada edición? | Jefe de Ingeniería | Baja | Cerrada — RCP-001:L498: pertenece a la edición |
| GQ-06 | [Promoción en el curso](terms/TRM-0023-promocion-en-el-curso.md) | ¿La promoción en el curso es lo mismo que la certificación de la edición, o son resultados distintos? | Jefe de Ingeniería | Media | Cerrada — /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L169 (N2, sin verificar): es el mismo resultado. Se mantienen ambos términos porque las fuentes usan ambos nombres |
| GQ-08 | [Motivo de excepción](terms/TRM-0039-motivo-de-excepcion.md) | Existe una funcionalidad para mantener el codificador de motivos de excepción (RCP-001:L170). ¿Quién puede mantenerlo y cuáles son sus códigos y descripciones iniciales? | Jefe de Ingeniería | Media | Abierta |
| GQ-09 | [Sumilla](terms/TRM-0046-sumilla.md) | ¿Qué es la «sumilla» de un curso? | Jefe de Ingeniería | Baja | Cerrada — RCP-001:L504: texto que resume el curso |
| GQ-10 | [Universal Data Model (UDM)](terms/TRM-0049-universal-data-model-udm.md) | ¿Qué fuente N1 del UDM se usa como referencia (libro, versión) y quién es el responsable del término? | Por definir | Media | Abierta |
| GQ-11 | Evaluación de desempeño | ¿Qué es la evaluación de desempeño? | Jefe de Ingeniería | Media | Cerrada — RCP-001:L508: ver TRM-0053 |
| GQ-12 | [BFF](terms/TRM-0054-bff.md), [PKCE](terms/TRM-0055-pkce.md), [SPA](terms/TRM-0056-spa.md) | ¿Cuál es la forma completa de estas siglas? Ninguna fuente las expande. ¿Quién es el responsable de estos términos de arquitectura? | Arquitectura | Baja | Abierta |
| GQ-10 | [Competencia](terms/TRM-0007-competencia.md), [Tipo de competencia](terms/TRM-0044-tipo-de-competencia.md) | Contradicción entre la competencia como combinación de conocimiento, habilidad y actitud y su tipo único; y entre las evidencias definidas en la competencia o en la rúbrica. | Jefe de Ingeniería | Media | Cerrada — /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L181 (N2, sin verificar): tipo único; las evidencias se definen en la rúbrica (/requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L182) |
| GQ-11 | [Evidencia esperada](terms/TRM-0040-evidencia-esperada.md), [Evidencia obligatoria](terms/TRM-0019-evidencia-obligatoria.md) | ¿«Requerida» es sinónimo de «mandatoria» o es el término general de ambas condiciones? | Jefe de Ingeniería | Baja | Cerrada — /requirements/context-packs/RCP-001-portal-gestion-curricula-desarrollo.md:L183 (N2, sin verificar): «requerida» es sinónimo de «mandatoria». El término general pasa a ser «Evidencia esperada» |
| GQ-07 | [Evaluador](terms/TRM-0016-evaluador.md) | ¿«Instructor» y «Evaluador» son sinónimos o el Evaluador es el rol del portal que asume el instructor de una edición? Se registró «Instructor» como sinónimo. | Jefe de Ingeniería | Baja | Abierta |

## Preparación y entrega

- **Estado:** CONDITIONAL
- **Términos con `gap`:** ninguno. Todos los términos tienen una fuente N2 (RCP-001, en `draft`) y ninguno tiene fuente N1.
- **Decisión humana requerida:** 49 de los 52 términos fueron aprobados por ianache (Functional Analysis) el 2026-10-10. Sumilla, Competencia y Asignación volvieron a borrador porque cambió su definición el mismo día. El Jefe de Ingeniería, responsable de los términos, no ha confirmado la aprobación. Hay 5 preguntas abiertas (GQ-03, GQ-04, GQ-06, GQ-10 y GQ-11 quedaron cerradas).

## Lista de calidad

- [x] Cada definición tiene al menos una fuente N1 o N2 con localizador
- [x] Sinónimos y formas completas respaldados por una fuente
- [x] Sin conocimiento propio del modelo como fuente
- [x] `glossary.py check` sin errores (39 términos revisados, 0 errores, 2026-10-10)
- [x] `index.md` y `changelog.md` actualizados
- [ ] Validación humana registrada
