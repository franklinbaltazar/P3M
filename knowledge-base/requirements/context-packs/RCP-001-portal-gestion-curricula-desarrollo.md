---
okf_version: "0.2"
id: "RCP-001"               # único por tipo de documento (decisión D-01)
title: "P3M (People, Product and Project Management) del Área de Desarrollo"
status: "APPROVED"
date: "2026-10-10"
authors:
  - name: "ianache"
    role: "Functional Analysis"
verified:
  by: "ianache (Functional Analysis)"
  at: "2026-10-12T18:00:00-05:00"
tags:
  - "capacitacion"
  - "curricula"
  - "competencias"
  - "gestion-de-personal"
  - "portafolio-proyectos"
  - "gitlab"
domain: "talent-development"
impact_level: "MEDIUM"      # PROVISIONAL: no evaluado
---

# Requirement Context Pack: P3M

## 1. Metadata

- Producto o proceso: P3M y entrenamiento (nombre por confirmar)
- Código o iniciativa: RCP-001
- Responsable funcional: Jefe de Ingeniería (D-03), rol de usuario asignado en Keycloak; por defecto, el usuario ianache (D-95)
- Fecha: 2026-10-10
- Pregunta de trabajo: ¿Qué necesita resolver el portal para gestionar la currícula de entrenamiento, el desarrollo de competencias y la asignación de colaboradores a proyectos, y qué falta definir antes de escribir User Stories?
- Estado: Aprobado (2026-10-10)

Fuentes (todas son declaraciones del usuario, no contrastadas con documentación):
- S-01: solicitud inicial.
- S-02: respuestas a V-02, V-03 y G-01 a G-04.
- S-03: respuestas a E-08, E-09, N-01, N-02, N-04 a N-06, G-05 a G-12.
- S-04: respuestas a G-07, G-09 y G-12.
- S-05: respuestas a G-15, G-16 y G-17.
- S-06: respuestas a G-18 a G-21.
- S-07: confirmación de las hipótesis H-09, H-10 y H-11.
- S-08: descarte de G-16 y respuestas a G-23, G-24 y G-25.
- S-09: confirmación de H-08 y respuestas a N-09 y G-13.
- S-10: respuestas a N-10 y N-11.
- S-11: respuestas a N-12, G-29 y G-30, y confirmación de H-14.
- S-12: respuestas a G-31 y G-32.
- S-13: respuestas a N-13 y G-26.
- S-14: confirmación de las hipótesis y supuestos, precisión de H-12 y respuestas a las preguntas abiertas de valoración, promoción en el curso, evidencias y codificador de motivos.
- S-15: respuesta a US-002-Q1 (quién define perfiles de competencias, cursos y ediciones).
- S-16: precisión del alcance del Jefe de Ingeniería y respuestas a US-011-Q1, US-002-Q2, US-002-Q3, US-003-Q1, US-006-Q1 y US-007-Q1.
- S-17: respuestas a las contradicciones de competencias y evidencias, a la terminología «requerida» y a la pertenencia de competencias a perfiles.
- S-18: respuestas a US-014-Q1, G-14, US-018-Q1, US-020-Q1 y US-023-Q1 (quién mantiene el portafolio y el codificador, jefe de proyecto con historial, consulta automática a GitLab, evidencias de solicitud de promoción) y su ampliación posterior (carga automática con consola de logs y delta, codificador vacío, registro y evaluación de la solicitud de promoción).

## 2. Objetivo y alcance

### Objetivo de negocio

Que el Área de Desarrollo de COMSATEL gestione de forma centralizada el entrenamiento de sus colaboradores y su progresión profesional. Los cursos desarrollan las competencias de cada rol. El logro de esas competencias se sustenta con evidencias (certificados de cursos o tareas y entregables de proyectos), y esas evidencias respaldan el paso entre niveles (L1–L4) y entre seniority (Junior → Semisenior → Senior). Además, el área registra a los colaboradores, los asigna a proyectos de su portafolio según el rol/nivel requerido y visualiza la ejecución de esos proyectos con datos de GitLab. *(Reformulación del agente sobre S-01 a S-06; pendiente de validación.)*

### Incluido

- Catálogo oficial de roles, mantenido desde el portal (D-06, D-10).
- Competencias por rol, con escala de logro N1–N3 y evidencias que sustentan su cumplimiento. Cada rol se vincula a un perfil de competencias, y el rol/nivel selecciona de cada competencia el nivel mínimo exigido (D-07, D-11, D-12, D-31).
- Cursos internos virtuales, presenciales o híbridos, con ediciones. Cada curso tiene objetivos, y cada objetivo se vincula a una competencia y al nivel objetivo a desarrollar. Las evidencias se evalúan con una rúbrica definida por el curso. Cada edición tiene número, fecha y cupo, y el colaborador se auto-enrola en ella (D-09, D-13, D-38, D-43).
- Evidencias con estados Pendiente y Validada. En el curso se define cuáles son obligatorias (deben estar 100% validadas para certificar la edición) y cuáles deseables (no limitan). Las de curso las valida el instructor y las de proyecto, el jefe de proyecto (D-42, D-44).
- El colaborador puede desenrolarse de una edición. Al llegar al cupo no se admiten más enrolamientos (D-45).
- Gestión de usuarios y roles del portal mediante Keycloak, que mantiene el IdM (D-38).
- Registro por curso del avance, la evaluación y el certificado de cada colaborador (D-08, D-13).
- Progresión de nivel y de seniority, basada en evidencias de cursos (evaluadas por el instructor) y evidencias de proyectos (issues cerrados de GitLab que aporta el colaborador). El Evaluador (instructor de la edición del curso) promociona o no al colaborador en el curso. El Jefe de Ingeniería toma esos resultados y las evidencias de proyecto, que valida el jefe de proyecto, y decide con criterio libre la promoción de nivel y seniority, según el cumplimiento del siguiente rol/nivel en su nivel mínimo (D-14, D-35, D-39, D-40, D-42).
- Registro de colaboradores: nombres, apellido paterno, apellido materno, fecha de ingreso a Comsatel, rol/nivel (S-01).
- Portafolio: productos (software que desarrollan los colaboradores) y proyectos de cada producto, con código, nombre, fechas, costo y esfuerzo estimados (D-18).
- Un proyecto es un conjunto de milestones de GitLab (D-27). Al registrar un proyecto de un producto, el usuario elige entre los milestones registrados cuáles le corresponden (D-34). Cada producto se vincula a un proyecto de GitLab con `project_id` (D-22).
- Las user stories y los sprints no se crean en el portal: se obtienen de GitLab (D-32).
- Asignación de colaboradores a proyectos, que realiza el Jefe de Ingeniería (D-37), según el rol/nivel requerido. Se verifica el nivel mínimo de cada competencia del perfil del rol/nivel. Si no se cumple, el portal advierte y la excepción la aprueba solo el Jefe de Ingeniería (D-19, D-24, D-31).
- Visualización, solo de lectura, de milestones e issues de GitLab, sincronizada de forma automática, cada 30 segundos por defecto (D-25, D-26, D-69).

### Excluido

- Planilla (D-04).
- Integración con otros sistemas distintos de GitLab y Keycloak: no se declaró ninguna. Ver G-11.
- Otras exclusiones no declaradas. Ver V-03.

### Restricciones conocidas

- Población objetivo: colaboradores del Área de Desarrollo de COMSATEL.
- El portal es un sistema independiente (D-09) que se integra con GitLab para visualizar milestones e issues (D-25, D-26) y con Keycloak para usuarios y roles (D-38).
- Datos personales de empleados: solo el Jefe de Ingeniería o un ADMIN los registra y modifica (D-15). Cualquier usuario autenticado puede consultarlos (D-20).
- La información de GitLab se consulta de forma automática, cada 30 segundos por defecto (D-69). Las funcionalidades leen la copia local y no consultan GitLab directamente.

## 3. Resumen del contexto

COMSATEL necesita para el Área de Desarrollo un portal con cuatro bloques relacionados. El primero es un catálogo de roles, mantenido por el Jefe de Ingeniería o un ADMIN. El segundo son las competencias de cada rol, con escala de logro y las evidencias que las sustentan. El tercero son los cursos internos, que desarrollan competencias y evalúan evidencias con una rúbrica propia. El cuarto es el registro de colaboradores y el portafolio de productos y proyectos, donde un proyecto es un conjunto de milestones de GitLab y cada producto se vincula a un proyecto de GitLab. El instructor del curso o el jefe de proyecto aprueban las evidencias. Con certificaciones y evidencias de proyecto, un colaborador pasa de nivel (L1→L4) y de seniority. Cada rol se vincula a un perfil de competencias con niveles de logro N1–N3, y el rol/nivel selecciona el nivel mínimo de cada competencia. Para asignar a un colaborador a un proyecto se verifica ese mínimo, y el Jefe de Ingeniería puede aprobar excepciones. El portal solo visualiza milestones e issues de GitLab (lectura, sincronización cada hora) y no crea user stories ni sprints. Una evidencia de proyecto es una referencia a un issue de GitLab cerrado, etiquetado como Task o UserStory, que aporta el colaborador. Los cursos tienen ediciones, cada una con un instructor que actúa como Evaluador (rol asignado en Keycloak). Cada curso define objetivos vinculados a una competencia y a un nivel objetivo. El Evaluador promociona al colaborador en el curso. El Jefe de Ingeniería toma esos resultados y las evidencias de proyecto que aporta el colaborador y decide la promoción al siguiente nivel del rol. El Jefe de Ingeniería también asigna a los colaboradores a los proyectos. Aprobar un curso acredita el logro de los objetivos del curso, pero no acredita por sí solo el nivel de una competencia. Aún no está definido cómo se registra el nivel actual de cada competencia de un colaborador.

## 4. Registro de evidencia

| ID | Hallazgo | Fuente | Tipo | Confianza |
|---|---|---|---|---|
| E-01 | El portal gestiona currícula de entrenamiento de colaboradores del Área de Desarrollo | S-01 | Hecho | Alta |
| E-02 | Se diseñan cursos para cubrir el desarrollo de competencias según rol y nivel | S-01 | Hecho | Alta |
| E-03 | Los niveles son L1–L4 y las categorías Junior, Semisenior, Senior | S-01 | Hecho | Alta |
| E-04 | Por colaborador se registra: nombres, apellido paterno, apellido materno, fecha de ingreso, rol/nivel | S-01 | Hecho | Alta |
| E-05 | Existe un portafolio de productos y dentro de cada producto hay proyectos | S-01 | Hecho | Alta |
| E-06 | Los colaboradores se asignan a proyectos según el rol/nivel requerido por el proyecto | S-01 | Hecho | Alta |
| E-07 | Cada seniority contiene niveles L1–L4, que expresan niveles de desarrollo de competencias | S-02 (G-01) | Decisión humana | Alta |
| E-08 | El portal es un sistema independiente | S-03 | Decisión humana | Media (ver E-31 y G-11) |
| E-09 | Los cursos son internos | S-03 | Decisión humana | Alta |
| E-10 | Existe un catálogo oficial de roles, mantenido por la plataforma y no predefinido. Lo mantienen el Jefe de Ingeniería o un ADMIN. No hay conjunto inicial para cargar | S-02 (G-02), S-03 (N-02) | Decisión humana | Alta |
| E-11 | Una competencia define lo esperado de un rol/nivel y combina conocimiento, habilidad y actitud | S-02 (G-03) | Decisión humana | Alta |
| E-12 | Por curso se registran avance, evaluación y certificado. La certificación sustenta la escalada de nivel y de seniority | S-02 (G-04) | Decisión humana | Alta |
| E-13 | Planilla está fuera del alcance | S-02 (V-03) | Decisión humana | Alta |
| E-14 | El responsable funcional es el Jefe de Ingeniería | S-02 (V-02) | Decisión humana | Alta |
| E-15 | El paso entre niveles y entre seniority (L4 Junior → L1 Semisenior, L4 Semisenior → L1 Senior) se basa en certificaciones de cursos y en evidencias de proyectos (tareas y entregables) | S-03 (N-01) | Decisión humana | Alta |
| E-16 | Cada competencia, para un rol/nivel, define las evidencias que sustentan su cumplimiento | S-03 (N-01) | Decisión humana | Alta |
| E-17 | Las competencias se definen por rol y tienen escala de logro | S-03 (N-04) | Decisión humana | Alta |
| E-18 | La certificación es una forma de evidencia del logro de una competencia de un rol/nivel. La aprueba el instructor del curso. Si la evidencia es una tarea o entregable de un proyecto donde participa el colaborador, la aprueba el jefe de proyecto | S-03 (N-05) | Decisión humana | Alta (confirmada para el jefe de proyecto en E-56) |
| E-19 | Quien dicta el curso evalúa y emite el certificado. Cada curso define las competencias que desarrolla y las evidencias que evalúa con una rúbrica definida para el curso | S-03 (N-06) | Decisión humana | Alta |
| E-20 | Los colaboradores los registra y modifica el Jefe de Ingeniería o cualquier usuario con perfil ADMIN | S-03 (G-12) | Decisión humana | Alta |
| E-21 | Los cursos son virtuales, presenciales o híbridos. La modalidad no cambia el tratamiento | S-03 (G-05) | Decisión humana | Alta |
| E-22 | El volumen de datos no es relevante | S-03 (G-10) | Decisión humana | Alta |
| E-23 | Un producto es software desarrollado por los colaboradores. Se conoce su código y nombre | S-04 (G-07) | Decisión humana | Alta |
| E-24 | De un proyecto se conoce: código, nombre, fechas estimadas de inicio y fin, costo estimado, esfuerzo estimado y alcance (conjunto de user stories) | S-04 (G-07) | Decisión humana | Alta |
| E-25 | El desarrollo del proyecto se organiza en sprints. De cada sprint se conocen las user stories asignadas, las tareas de planning por user story y las fechas estimadas de inicio y fin | S-04 (G-07) | Decisión humana | Media (ver G-22) |
| E-26 | La asignación a un proyecto requiere tener las competencias según el nivel de desarrollo: N1 no desarrollada, N2 en desarrollo, N3 desarrollada | S-04 (G-09) | Decisión humana | Alta |
| E-27 | Cualquier usuario autenticado puede consultar los datos personales de los colaboradores | S-04 (G-12) | Decisión humana | Alta |
| E-28 | El nivel mínimo de competencia para asignar es N2 (en desarrollo). Reemplaza el N1 de S-05. El N2 fue solo un ejemplo (E-63). Si no se cumple, el portal advierte, y la excepción consiste en que la aprueba el Jefe de Ingeniería, único que puede hacerlo | S-05 (G-15), S-06 (G-18) | Decisión humana | Alta |
| E-29 | Las user stories y los sprints se pueden crear en el portal y también obtener de GitLab | S-05 (G-16) | Decisión humana | Descartada parcialmente: la creación en el portal se descartó (E-40) |
| E-30 | Un producto se vincula a un proyecto de GitLab mediante su `project_id`. En ese proyecto, los issues con label `UserStory` representan user stories y hay milestones | S-05 (G-16) | Decisión humana | Alta |
| E-31 | El portal visualiza la ejecución de sprints y user stories con información obtenida mediante integración con GitLab | S-05 (G-17) | Decisión humana | Alta |
| E-32 | El portal solo visualiza lo que existe en GitLab, al nivel de issue y milestone | S-06 (G-19) | Decisión humana | Alta |
| E-33 | De cada milestone se visualiza: id, nombre, tareas totales, tareas cerradas y % de avance | S-06 (G-20) | Decisión humana | Alta |
| E-34 | De cada issue se visualiza: id, título, esfuerzo estimado, status, esfuerzo spent y due date | S-06 (G-20) | Decisión humana | Alta |
| E-35 | La información de GitLab se sincroniza cada hora (valor inicial, S-06). Sustituido por E-93: consulta automática cada 30 segundos por defecto | S-06 (G-20), S-18 | Decisión humana | Alta |
| E-36 | Un proyecto es un conjunto de milestones | S-06 (G-21) | Decisión humana | Alta |
| E-37 | Un milestone de GitLab equivale a un sprint del portal | S-07 (H-09) | Decisión humana | Alta |
| E-38 | La integración con GitLab es de solo lectura | S-07 (H-10) | Decisión humana | Alta |
| E-39 | Los proyectos del portafolio existen en el portal y están vinculados a milestones de GitLab | S-07 (H-11) | Decisión humana | Alta |
| E-40 | Se descarta que las user stories y los sprints se creen en el portal (G-16 descartada) | S-08 | Decisión humana | Alta |
| E-41 | Un rol se vincula a un perfil de competencias con niveles de logro N1, N2 y N3. En la práctica, el rol/nivel selecciona de cada competencia el nivel mínimo | S-08 (G-23) | Decisión humana | Alta |
| E-42 | El portal accede a GitLab (respuesta "sí" a credenciales de servicio y permisos de solo lectura) | S-08 (G-24) | Decisión humana | Media (respuesta breve; ver G-24) |
| E-43 | Al registrar un proyecto de un producto, el usuario selecciona entre los milestones registrados cuáles le corresponden | S-08 (G-25) | Decisión humana | Alta |
| E-44 | Una evidencia de proyecto referencia un issue de GitLab etiquetado como "Task" o "UserStory" y el issue debe estar en estado "Closed" | S-09 (H-08) | Decisión humana | Alta |
| E-45 | Las evidencias de cursos las evalúa el instructor. Las evidencias de proyectos las aporta el colaborador | S-09 (N-09) | Decisión humana | Alta |
| E-46 | Con esas evidencias, un Evaluador o el Jefe de Ingeniería determina la promoción al siguiente nivel correspondiente del rol | S-09 (N-09) | Decisión humana | Precisada por E-51 y E-52 |
| E-47 | El Jefe de Ingeniería asigna a los colaboradores a los proyectos | S-09 (G-13) | Decisión humana | Media (no queda claro si también define el rol/nivel requerido, ver G-28) |
| E-48 | El Evaluador es un rol que se asigna a los usuarios del portal a través de Keycloak, donde se mantiene el IdM | S-10 (N-10) | Decisión humana | Alta |
| E-49 | El Evaluador es el instructor asignado a la edición de un curso. Los cursos tienen ediciones | S-10 (N-10) | Decisión humana | Alta |
| E-50 | Un curso tiene objetivos. Cada objetivo se vincula a la competencia y al nivel objetivo que se desarrolla en el curso | S-10 (N-10) | Decisión humana | Alta |
| E-51 | La promoción en el curso la realiza el Evaluador | S-10 (N-11) | Decisión humana | Alta |
| E-52 | El Jefe de Ingeniería toma los resultados de promoción del curso del colaborador y las evidencias que el propio colaborador aporta (tareas o user stories que sustentan el nivel de logro de las competencias de su rol/nivel). Con ellos decide la promoción de nivel | S-10 (N-11) | Decisión humana | Alta |
| E-53 | La promoción de nivel o seniority es un criterio libre del Jefe de Ingeniería, basado en la valoración del cumplimiento del siguiente rol/nivel en su nivel mínimo | S-11 (N-12) | Decisión humana | Alta |
| E-54 | Aprobar un curso no acredita por sí solo el nivel objetivo de las competencias, pero sí el logro de los objetivos del curso | S-11 (N-12) | Decisión humana | Alta |
| E-55 | Los estados de una evidencia son Pendiente y Validada | S-11 (G-29) | Decisión humana | Alta |
| E-56 | El jefe de proyecto aprueba (valida) las evidencias del proyecto | S-11 (G-29) | Decisión humana | Alta |
| E-57 | Las competencias tienen evidencias obligatorias, que deben estar 100% validadas para certificar el curso, y deseables, que no limitan | S-11 (G-29) | Decisión humana | Alta (precisada por E-59) |
| E-58 | El colaborador se auto-enrola en las ediciones de curso. Una edición tiene número de edición, fecha y cupo. El avance, la evaluación y el certificado se registran por edición | S-11 (G-30, H-14) | Decisión humana | Alta |
| E-59 | La regla de certificación está confirmada: se certifica cuando el 100% de las evidencias obligatorias están Validadas. Lo obligatorio u opcional se define en el curso (curso → objetivo del curso → competencia y nivel objetivo) | S-12 (G-31) | Decisión humana | Alta |
| E-60 | Las evidencias del curso las valida el instructor del curso/edición | S-12 (G-31) | Decisión humana | Alta |
| E-61 | El curso tiene fecha de inicio y fin. Al llegar al cupo no se admite más enrolamiento. El colaborador puede desenrolarse | S-12 (G-32) | Decisión humana | Media (se dice "el curso" y no "la edición") |
| E-62 | La valoración del colaborador (su nivel actual en las competencias) la registra el Jefe de Ingeniería o un usuario con rol ADMIN | S-13 (N-13) | Decisión humana | Media (se interpreta que "lo" es la valoración, ver H-15) |
| E-63 | El nivel mínimo N2 era solo un ejemplo. El nivel mínimo lo define el rol/nivel por competencia | S-13 (G-26) | Decisión humana | Alta |
| E-64 | Si el colaborador no cumple el nivel mínimo, la asignación queda pendiente hasta que el Jefe de Ingeniería apruebe la excepción. Se registra el motivo, tomado de un codificador prestablecido (código y descripción), y quién aprobó | S-13 (G-26) | Decisión humana | Alta |
| E-65 | Un curso puede desarrollar más de una competencia | S-14 (H-01) | Decisión humana | Alta |
| E-66 | Un proyecto puede requerir varios roles/niveles con cantidades | S-14 (H-02) | Decisión humana | Alta |
| E-67 | Un colaborador puede estar asignado a más de un proyecto a la vez | S-14 (H-03) | Decisión humana | Alta |
| E-68 | Los perfiles del portal incluyen ADMIN, Jefe de Ingeniería, Evaluador (instructor de una edición) y colaborador, administrados en Keycloak | S-14 (H-04) | Decisión humana | Alta |
| E-69 | El jefe de proyecto es un colaborador asignado a ese proyecto | S-14 (H-06) | Decisión humana | Alta |
| E-70 | Un colaborador tiene un único rol/nivel vigente en cada momento | S-14 (A-01) | Decisión humana | Alta |
| E-71 | Un proyecto pertenece a un solo producto (relación Producto–Proyecto de 1 a N) | S-14 (A-02) | Decisión humana | Alta |
| E-72 | Un milestone tiene asignados issues etiquetados Task y UserStory. Sus tareas totales y cerradas son esos issues | S-14 (H-12) | Decisión humana | Alta |
| E-73 | La valoración registra el nivel actual de cada competencia del colaborador, con historial, y el portal muestra la brecha frente al siguiente nivel | S-14 (N-14, H-15) | Decisión humana | Alta |
| E-74 | La promoción en el curso y la certificación son el mismo resultado | S-14 (pregunta 2) | Decisión humana | Alta |
| E-75 | Debe existir una funcionalidad para mantener el codificador de motivos de excepción | S-14 (G-33) | Decisión humana | Alta |
| E-76 | Se diferencian la evidencia requerida (definida en el curso o la competencia) y la evidencia aportada (por un colaborador) | S-14 (pregunta 3) | Decisión humana | Alta |
| E-77 | Las "tareas de planning" son issues con label "Task" registrados en GitLab y vinculados a un issue con label "UserStory" durante el sprint planning | S-14 (pregunta 14) | Decisión humana | Alta |
| E-78 | El Jefe de Ingeniería define los perfiles de competencias, los cursos y las ediciones | S-15 (US-002-Q1) | Decisión humana | Alta |
| E-79 | El Jefe de Ingeniería define también el nivel mínimo, las evidencias requeridas y los objetivos | S-16 | Decisión humana | Alta |
| E-80 | El colaborador registra, en la edición de curso en que está enrolado y en el objetivo del curso, las referencias a issues cerrados (Task o UserStory) que son evidencias del logro del objetivo | S-16 (US-011-Q1) | Decisión humana | Alta |
| E-81 | Los roles y los perfiles de competencias siempre están en el catálogo. Se registran y mantienen en el catálogo del portal | S-16 (US-002-Q2) | Decisión humana | Alta |
| E-82 | Una competencia tiene código, nombre, tipo (conocimiento, habilidad o actitud) y la definición de cada nivel | S-16 (US-002-Q3) | Decisión humana | Alta (reemplaza la descripción como combinación de E-11, ver E-86) |
| E-83 | Un rol tiene, para las competencias asociadas a su perfil, el nivel mínimo esperado de la competencia | S-16 (US-003-Q1) | Decisión humana | Media (dice "rol" y no "rol/nivel") |
| E-84 | Los datos mínimos de un curso son código, nombre, sumilla y el listado de objetivos de aprendizaje | S-16 (US-006-Q1) | Decisión humana | Alta |
| E-85 | Cada objetivo de aprendizaje define una rúbrica: para cada nivel de logro, el nivel, la descripción observable del desempeño y las evidencias que se espera que muestre, indicando si cada evidencia es mandatoria/requerida u opcional | S-16 (US-006-Q1, US-007-Q1) | Decisión humana | Alta |
| E-86 | Las competencias tienen un tipo único: conocimiento, habilidad o actitud | S-17 (G-34) | Decisión humana | Alta |
| E-87 | Una rúbrica define los niveles de logro de la competencia, y cada nivel de logro define qué evidencias son requeridas para mostrar el logro del curso | S-17 (G-35) | Decisión humana | Alta |
| E-88 | «Requerida» es sinónimo de «mandatoria» | S-17 (G-36) | Decisión humana | Alta |
| E-89 | Una competencia general (por ejemplo, comunicación) puede estar en más de un perfil. Otras competencias son exclusivas de un perfil | S-17 (G-37) | Decisión humana | Alta |
| E-90 | Las evidencias se registran (1) en el contexto de la edición de un curso en que el colaborador está enrolado y (2) para solicitar promoción: el colaborador elige el perfil (rol y nivel) al que considera que debería evolucionar en su línea de carrera y aporta evidencia al Jefe de Ingeniería | S-18 (US-014-Q1) | Decisión humana | Alta |
| E-91 | La gestión de los proyectos de un producto incluye registrar a un colaborador con el rol «Jefe de Proyecto», con historial de cambios: la asignación al proyecto tiene vigencia desde y hasta | S-18 (G-14) | Decisión humana | Alta |
| E-92 | Productos, proyectos y codificadores (motivos de excepción) los mantiene el Jefe de Ingeniería o cualquier colaborador con rol de usuario ADMIN. Los roles de usuario son ADMIN, Instructor y Jefe de Ingeniería; los demás roles son puestos de la organización | S-18 (US-018-Q1, US-023-Q1, G-33 parcial) | Decisión humana | Alta |
| E-93 | El portal consulta GitLab de forma automática, cada 30 segundos por defecto, para obtener issues (Task, UserStory, Proyecto) y milestones. Las funcionalidades no consultan GitLab directamente | S-18 (US-020-Q1) | Decisión humana | Alta |
| E-94 | La carga desde GitLab es un proceso automático programado. El Jefe de Ingeniería y los usuarios con rol ADMIN ven una consola de logs de las cargas (fecha y hora de ejecución, estado exitosa o fallida) y pueden reintentarlas | S-18 (US-020) | Decisión humana | Alta |
| E-95 | La carga trae solo la información nueva (creada o actualizada) desde la ejecución más reciente, el «delta de cambio», para reducir la transferencia entre GitLab y el portal | S-18 (US-020) | Decisión humana | Alta |
| E-96 | El codificador de motivos de excepción parte sin ningún valor registrado. Lo mantiene el Jefe de Ingeniería o un ADMIN y no se puede retirar un motivo ya usado | S-18 (US-023) | Decisión humana | Alta |
| E-97 | La solicitud de promoción a un nuevo rol/nivel la registra el colaborador y la evalúa el Jefe de Ingeniería, quien valora todas las evidencias aportadas | S-18 (US-014) | Decisión humana | Alta |

## 5. Hechos confirmados

- El portal es un sistema independiente para el Área de Desarrollo de COMSATEL (E-01, E-08), que se integra con GitLab (E-31).
- Gestiona un catálogo de roles que mantiene el Jefe de Ingeniería o un ADMIN, sin conjunto inicial (E-10).
- Las competencias se definen por rol, con escala de logro, y combinan conocimiento, habilidad y actitud. Cada una define las evidencias que la sustentan (E-11, E-16, E-17).
- Los cursos son internos, virtuales, presenciales o híbridos. Cada curso define las competencias que desarrolla y las evidencias que evalúa con una rúbrica propia. Quien lo dicta evalúa y emite el certificado (E-09, E-19, E-21).
- Una evidencia puede ser un certificado o una tarea/entregable de proyecto. La aprueba el instructor o el jefe de proyecto, respectivamente (E-18).
- El paso entre niveles y entre seniority se basa en certificaciones y evidencias de proyectos (E-15). Cada seniority contiene niveles L1–L4 (E-07).
- El Jefe de Ingeniería o un ADMIN registra y modifica colaboradores. Cualquier usuario autenticado puede consultarlos (E-20, E-27).
- Un producto tiene código y nombre. Un proyecto tiene código, nombre, fechas, costo y esfuerzo estimados, y es un conjunto de milestones (E-23, E-24, E-36).
- Cada producto se vincula a un proyecto de GitLab por `project_id`. Los issues con label `UserStory` son user stories (E-30).
- Cada rol se vincula a un perfil de competencias con niveles N1 no desarrollada, N2 en desarrollo, N3 desarrollada. El rol/nivel selecciona de cada competencia el nivel mínimo (E-26, E-41).
- La asignación a un proyecto verifica ese mínimo. Si no se cumple, el portal advierte y la asignación queda pendiente hasta que el Jefe de Ingeniería apruebe la excepción. El N2 era solo un ejemplo (E-28, E-63, E-64).
- De la excepción se registran el motivo, tomado de un codificador prestablecido (código y descripción), y quién la aprobó (E-64).
- La valoración del colaborador la registra el Jefe de Ingeniería o un ADMIN (E-62). Registra el nivel actual de cada competencia, con historial, y el portal muestra la brecha frente al siguiente nivel (E-73).
- La promoción en el curso y la certificación son el mismo resultado (E-74).
- Debe existir una funcionalidad para mantener el codificador de motivos de excepción (E-75).
- Se diferencian la evidencia requerida (definida en el curso o la competencia) y la evidencia aportada por un colaborador (E-76).
- Un curso puede desarrollar varias competencias, un proyecto puede requerir varios roles/niveles con cantidades y un colaborador puede estar asignado a varios proyectos a la vez (E-65, E-66, E-67).
- Un colaborador tiene un único rol/nivel vigente, un proyecto pertenece a un solo producto y el jefe de proyecto es un colaborador asignado al proyecto (E-70, E-71, E-69).
- Un milestone tiene asignados issues etiquetados Task y UserStory (E-72). Las "tareas de planning" son issues Task de GitLab vinculados a un issue UserStory durante el sprint planning (E-77).
- El Jefe de Ingeniería define los perfiles de competencias, los cursos y las ediciones, y también el nivel mínimo, las evidencias requeridas y los objetivos (E-78, E-79).
- Los roles y los perfiles de competencias están siempre en el catálogo del portal (E-81). Una competencia tiene código, nombre, tipo (conocimiento, habilidad o actitud) y la definición de cada nivel (E-82). El rol tiene el nivel mínimo de las competencias asociadas a su perfil (E-83).
- Un curso tiene código, nombre, sumilla y objetivos de aprendizaje (E-84). Cada objetivo define una rúbrica por nivel de logro, con la descripción observable del desempeño y las evidencias esperadas, mandatorias u opcionales (E-85).
- El colaborador registra, en la edición en que está enrolado y en el objetivo del curso, referencias a issues cerrados (Task o UserStory) como evidencias del logro del objetivo (E-80).
- Las competencias tienen un tipo único (E-86). Las evidencias que muestran el logro se definen en la rúbrica: cada nivel de logro define qué evidencias son requeridas (E-87). «Requerida» es sinónimo de «mandatoria» (E-88), así que desde D-63 el término general de la rúbrica es «evidencia esperada» (obligatoria u opcional). Una competencia general puede estar en más de un perfil y otras son exclusivas (E-89).
- Una evidencia de proyecto es una referencia a un issue de GitLab cerrado, con label Task o UserStory, aportada por el colaborador (E-44, E-45).
- Los cursos tienen ediciones. El Evaluador es el instructor de la edición y es un rol que se asigna en Keycloak (E-48, E-49).
- Cada curso tiene objetivos, y cada uno se vincula a una competencia y a un nivel objetivo (E-50).
- El Evaluador promociona al colaborador en el curso (E-51). Aprobar un curso acredita el logro de sus objetivos, pero no el nivel de una competencia por sí solo (E-54).
- El Jefe de Ingeniería toma esos resultados y las evidencias de proyecto que aporta el colaborador y decide con criterio libre la promoción, según el cumplimiento del siguiente rol/nivel en su nivel mínimo (E-52, E-53).
- Las evidencias tienen estados Pendiente y Validada. El jefe de proyecto valida las de proyecto (E-55, E-56).
- Cada curso define sus evidencias obligatorias (100% validadas para certificar) y deseables, vinculadas a sus objetivos y a la competencia y nivel objetivo (E-57, E-59). Las evidencias de curso las valida el instructor (E-60).
- El curso tiene fecha de inicio y fin. Al llegar al cupo no se admite más enrolamiento, y el colaborador puede desenrolarse (E-61).
- El colaborador se auto-enrola en ediciones de curso (número de edición, fecha, cupo). Avance, evaluación y certificado se registran por edición (E-58).
- El Jefe de Ingeniería asigna a los colaboradores a los proyectos (E-47).
- Las user stories y sprints no se crean en el portal (E-40). El usuario elige, al registrar un proyecto, los milestones que le corresponden (E-43).
- El portal solo visualiza milestones e issues de GitLab (E-32), con los campos de E-33 y E-34, sincronizados de forma automática cada 30 segundos por defecto (E-93).
- Un milestone de GitLab equivale a un sprint del portal (E-37). La integración con GitLab es de solo lectura (E-38).
- Los proyectos del portafolio existen en el portal y se vinculan a milestones de GitLab (E-39).
- Planilla queda fuera del alcance (E-13). El responsable funcional es el Jefe de Ingeniería (E-14).

## 6. Supuestos e hipótesis

| ID | Tipo | Enunciado |
|---|---|---|
| A-01 | Confirmado (D-48) | "Rol/nivel" es un par (rol, nivel) y un colaborador tiene un único par vigente en cada momento. |
| A-02 | Confirmado (D-48) | La relación Producto–Proyecto es 1 a N: un proyecto pertenece a un solo producto. |
| H-01 | Confirmada (D-48) | Un curso puede desarrollar más de una competencia. |
| H-02 | Confirmada (D-48) | Un proyecto puede requerir varios roles/niveles con cantidades (por ejemplo, 2 × Senior L4). |
| H-03 | Confirmada (D-48) | Un colaborador puede estar asignado a más de un proyecto a la vez. |
| H-04 | Confirmada (D-48) | Los perfiles del portal incluyen ADMIN, Jefe de Ingeniería, Evaluador (instructor de una edición) y colaborador, administrados en Keycloak. |
| H-05 | Confirmada (D-31) | La escala de logro de una competencia (por rol) permite determinar lo esperado en cada rol/nivel: el rol/nivel selecciona el nivel mínimo N de cada competencia. |
| H-06 | Confirmada (D-48) | Una persona con rol "jefe de proyecto" es un colaborador asignado a ese proyecto. |
| H-07 | Confirmada (D-31) | La escala N1–N3 (E-26) es la escala de logro de una competencia (E-17) y es distinta de los niveles L1–L4. La notación similar puede inducir a confusión. |
| H-08 | Confirmada (D-35) | La evidencia de proyecto es un issue de GitLab con label "Task" o "UserStory", en estado "Closed". |
| H-09 | Confirmada (D-28) | Un milestone de GitLab equivale a un sprint del portal. |
| H-10 | Confirmada (D-29) | La integración con GitLab es de solo lectura: el portal no escribe en GitLab. |
| H-11 | Confirmada (D-30) | Los proyectos del portafolio existen en el portal y se vinculan a milestones de GitLab. |
| H-12 | Confirmada y precisada (D-48) | Las "tareas totales" y "tareas cerradas" de un milestone (E-33) son sus issues totales y cerrados. El milestone tiene asignados issues etiquetados Task y UserStory (E-72). |
| H-13 | Descartada (D-41) | Aprobar un curso acredita el nivel objetivo de la competencia de cada objetivo. Solo acredita el logro de los objetivos del curso. |
| H-14 | Confirmada (D-43) | Un colaborador se inscribe en una edición de un curso. El avance, la evaluación y el certificado se registran por edición. |
| H-15 | Confirmada (D-49) | La valoración de cumplimiento registra el nivel actual (N1, N2 o N3) de cada competencia del colaborador, y de ella se compara el siguiente rol/nivel en su nivel mínimo (E-53, E-62, E-73). |

## 7. Vacíos y preguntas abiertas

### Preguntas cerradas

| ID | Resolución |
|---|---|
| G-01 | D-05 |
| G-02 | D-06 |
| G-03 | D-07 |
| G-04 | D-08 |
| N-01 | D-14 (queda N-09) |
| N-02 | D-10 |
| N-03 | D-13 (queda H-01) |
| N-04 | D-12 (queda N-07) |
| N-05 | D-13 (quedan N-08 y N-09) |
| N-06 | D-13 |
| N-08 | D-35 |
| N-09 | D-36, precisada por D-39 |
| N-10 | D-38 (queda N-12) |
| N-11 | D-39 |
| N-12 | D-40, D-41 (queda N-13) |
| G-29 | D-42 |
| G-30 | D-43 |
| G-31 | D-44 |
| G-32 | D-45 |
| N-13 | D-46 (queda N-14) |
| G-26 | D-47 (queda G-33, reducida) |
| N-14 | D-49 |
| Tareas de planning (E-25, E-61 aparte) | D-53 |
| G-13 | D-37 (queda G-28) |
| G-05 | D-16. Solo se respondió la modalidad |
| G-07 | D-18 |
| G-09 | D-19 |
| G-10 | D-17 |
| G-15 | D-24 |
| G-16 | Descartada (D-32) |
| G-22 | D-32 |
| N-07 | D-31 |
| G-17 | D-23 |
| G-18 | D-24 |
| G-23 | D-31 (queda G-26) |
| G-24 | D-33 |
| G-25 | D-34 |
| G-19 | D-25 |
| G-20 | D-26 |
| G-21 | D-27 |
| E-08 / E-09 | D-09 |

### Preguntas abiertas

| ID | Pregunta | Destinatario | Prioridad | Estado |
|---|---|---|---|---|
| G-28 | El Jefe de Ingeniería asigna colaboradores a proyectos. ¿También define el rol/nivel (y cantidades) que requiere cada proyecto? | Negocio | Baja | Cerrada (D-99) |
| G-33 | Existe una funcionalidad para mantener el codificador de motivos de excepción (D-51). ¿Quién puede mantenerlo? **Cerrada en parte: Jefe de Ingeniería o ADMIN (D-67).** Siguen abiertas: valores iniciales, estados de una asignación además de Pendiente y qué pasa si se rechaza la excepción. | Negocio | Media | Cerrada: el codificador parte vacío y no se retira un motivo usado (D-72). Siguen abiertos los estados de una asignación y el rechazo de la excepción |
| G-34 | Contradicción: una competencia es una "combinación de conocimiento, habilidad y actitud" (E-11) y a la vez tiene un "tipo" (conocimiento, habilidad o actitud, E-82). ¿Cuál es la regla? ¿Cada competencia es de un solo tipo? | Negocio | Media | Cerrada (D-61 a D-63) |
| G-35 | Contradicción: cada competencia define las evidencias que la sustentan (E-16), pero las evidencias esperadas se definen en la rúbrica de cada objetivo del curso (E-85). ¿Siguen existiendo evidencias a nivel de competencia o solo a nivel de objetivo? | Negocio | Media | Cerrada (D-61 a D-63) |
| G-36 | Terminología: se dijo "mandatoria/requerida u opcional". En este pack "evidencia requerida" cubre las obligatorias y las deseables. ¿"Requerida" es sinónimo de "mandatoria"? | Negocio | Baja | Cerrada (D-61 a D-63) |
| G-37 | Cerrada en parte (D-64): una competencia general puede estar en más de un perfil. Queda por definir qué es la "sumilla" de un curso y cómo se distingue una competencia general de una exclusiva | Negocio | Baja | Cerrada (D-97, D-98) |
| G-27 | (a) Cerrada: el portal muestra «datos al <fecha y hora de la última carga exitosa>» (D-112). (b) Cerrada: un milestone pertenece a un único proyecto (D-109). | ARQ / Negocio | Baja | Cerrada |
| G-12 | Parcial (D-15, D-20). ¿Qué política de datos personales aplica a la consulta abierta a todo usuario autenticado? La autenticación es con Keycloak (D-38). | Negocio / ARQ | Media | Abierta |
| G-14 | ¿Cómo se identifica al jefe de proyecto de cada proyecto y cómo llega al portal (se registra, se toma de GitLab)? | Negocio | Media | Cerrada: se registra en el portal con historial y vigencia (D-66) |
| G-11 | Parcial (D-25, D-26, D-38: integración con GitLab y Keycloak). ¿Hay otras integraciones, como carga de colaboradores desde otro sistema? ¿Los colaboradores registrados en el portal se corresponden con usuarios de Keycloak y cómo se vinculan? | ARQ | Media | Abierta |
| G-06 | Parcial (D-14). ¿Se conserva el historial de cambios de nivel y seniority de cada colaborador? | Negocio | Media | Cerrada (D-92) |
| G-08 | ¿La asignación a proyecto tiene fechas, porcentaje de dedicación o historial? | Negocio | Media | Cerrada (D-93) |
| V-03 | Parcial (D-04). ¿Hay otras exclusiones, como evaluación de desempeño? | Negocio | Media | Cerrada (D-94): la evaluación de desempeño queda dentro del alcance. Definida en D-101 a D-104 |
| V-02 | Resuelta en rol (D-03). ¿Cuál es el nombre del Jefe de Ingeniería? ¿Hay un sponsor distinto? | Negocio | Baja | Cerrada (D-95) |
| V-01 | Parcial (D-01, D-02). Faltan los valores válidos de `status`, `domain` e `impact_level`; hoy siguen el ejemplo Q-01 (`02-AI-Centric/Laboratorios`) | AF | Baja | Cerrada (D-96): valores propuestos en el anexo A |

## 8. Mapa funcional

### Actores

- Colaborador del Área de Desarrollo: se auto-enrola en ediciones de curso, aporta evidencias y es asignado a proyectos. *(Hecho)*
- Jefe de Ingeniería: responsable funcional. Registra y modifica colaboradores, mantiene el catálogo de roles, asigna colaboradores a proyectos, aprueba las excepciones de asignación y decide la promoción de nivel y seniority con los resultados de cursos y las evidencias de proyecto. *(Hecho)*
- Evaluador: instructor asignado a una edición de curso. Rol asignado en Keycloak. Promociona a los colaboradores en el curso. *(Hecho)*
- Usuario con perfil ADMIN: puede registrar colaboradores y mantener el catálogo de roles. *(Hecho)*
- Instructor del curso (el mismo Evaluador): dicta la edición, evalúa y emite certificados. *(Hecho)*
- Jefe de proyecto: valida (aprueba) las evidencias de proyecto. *(Hecho)*
- Keycloak: sistema externo que mantiene el IdM y los roles de usuarios. *(Hecho)*
- Usuario autenticado: consulta datos de colaboradores. *(Hecho)*
- GitLab: sistema externo, fuente de milestones e issues. *(Hecho)*

### Procesos y estados

1. Mantener el catálogo de roles (Jefe de Ingeniería o ADMIN). *(Hecho)*
2. Definir el perfil de competencias de cada rol, con niveles N1–N3, evidencias aceptadas y nivel mínimo por rol/nivel. *(Hecho)*
3. Definir un curso con sus objetivos, cada uno vinculado a una competencia y a un nivel objetivo, las evidencias que evalúa y la rúbrica. *(Hecho)*
4. Crear ediciones del curso con un instructor asignado, que actúa como Evaluador. Dictar la edición, registrar avance y evaluación, emitir certificado y promocionar al colaborador. El colaborador se auto-enrola en la edición. *(Hecho)*
5. Aportar evidencias de proyecto (el colaborador referencia un issue de GitLab cerrado con label Task o UserStory). El jefe de proyecto la valida y pasa de Pendiente a Validada. *(Hecho)*
6. Decidir la promoción al siguiente nivel del rol: el Jefe de Ingeniería toma los resultados de promoción en cursos y las evidencias de proyecto que aporta el colaborador, con criterio libre y según el cumplimiento del siguiente rol/nivel en su nivel mínimo. La valoración la registra el Jefe de Ingeniería o un ADMIN, con historial, y el portal muestra la brecha frente al siguiente nivel. *(Hecho)*
7. Registrar y mantener colaboradores (Jefe de Ingeniería o ADMIN). *(Hecho)*
8. Mantener portafolio: productos con `project_id` de GitLab y proyectos como conjuntos de milestones, que el usuario selecciona entre los registrados. *(Hecho)*
9. Asignar colaboradores a proyectos según rol/nivel, advirtiendo si no llegan al nivel mínimo de las competencias del perfil. Si no se cumple, la asignación queda pendiente. El Jefe de Ingeniería aprueba la excepción y se registran el motivo (codificador) y quién aprobó. *(Hecho; detalle en G-28 y G-33)*
10. Consultar automáticamente (cada 30 s por defecto) milestones e issues desde GitLab y mostrar la ejecución. *(Hecho; acceso en G-24)*
11. Estados de curso, evidencia, asignación y excepción: de curso, asignación y excepción: no definidos. *(Vacío: G-26)* Los estados de evidencia son Pendiente y Validada.

### Datos relevantes

| Concepto | Atributos conocidos | Atributos por confirmar |
|---|---|---|
| Colaborador | nombres, apellido paterno, apellido materno, fecha de ingreso, rol/nivel | identificador, correo, estado activo/inactivo |
| Rol | nombre, pertenece al catálogo oficial. Se vincula a un perfil de competencias, que también se registra en el catálogo. Tiene el nivel mínimo esperado de las competencias asociadas | descripción |
| Nivel | seniority (Junior/Semisenior/Senior) y nivel L1–L4 dentro de cada seniority | historial (G-06) |
| Competencia | código, nombre, tipo único (conocimiento, habilidad o actitud) y la definición de cada nivel de logro (N1 no desarrollada, N2 en desarrollo, N3 desarrollada). Una competencia general puede estar en más de un perfil y las demás son exclusivas de uno | cómo se distingue una competencia general de una exclusiva |
| Perfil de competencias / nivel mínimo | el rol/nivel selecciona de cada competencia del perfil el nivel mínimo N exigido (D-31) | si el nivel mínimo se define para cada combinación seniority–L1–L4 (G-26) |
| Evidencia esperada | la define el Jefe de Ingeniería en la rúbrica de cada objetivo, por nivel de logro. Es obligatoria (mandatoria o requerida) u opcional (deseable). La obligatoria debe estar 100% validada para certificar | |
| Evidencia aportada | la aporta un colaborador contra un objetivo del curso. Es una referencia a un issue de GitLab con label Task o UserStory en estado Closed. De curso: la registra en la edición en que está enrolado y la valida el instructor. De proyecto: la valida el jefe de proyecto. Estados Pendiente y Validada | |
| Valoración de cumplimiento | la registra el Jefe de Ingeniería o un ADMIN: nivel actual (N1–N3) de cada competencia del colaborador, con historial | |
| Brecha de cumplimiento | se muestra la diferencia entre el nivel actual y el nivel mínimo del siguiente rol/nivel. Se calcula, no se registra | |
| Curso | código, nombre, sumilla y objetivos de aprendizaje. Interno, modalidad virtual/presencial/híbrido. Cada objetivo se vincula a una competencia y a un nivel objetivo N, y define una rúbrica por nivel de logro con descripción observable del desempeño y evidencias esperadas (mandatorias u opcionales) | definición de "sumilla" |
| Edición de curso | pertenece a un curso. Número de edición, fecha, cupo. Tiene un instructor asignado, que actúa como Evaluador. Fecha de inicio y fin (E-61). El colaborador se auto-enrola y puede desenrolarse. Al llegar al cupo no se admite más enrolamiento | |
| Avance / Evaluación / Certificado / Promoción en el curso | se registran por colaborador y curso (probablemente por edición, H-14). Los emite y decide el Evaluador | criterio de aprobación (rúbrica del curso). Aprobar acredita los objetivos del curso, no el nivel de una competencia (D-41) |
| Producto | código, nombre, `project_id` del proyecto de GitLab | responsable |
| Proyecto | código, nombre, fechas estimadas de inicio y fin, costo estimado, esfuerzo estimado. Es un conjunto de milestones que el usuario elige al registrarlo. Pertenece a un producto, requiere rol/nivel y tiene jefe de proyecto | un milestone en más de un proyecto (G-27), cantidad por rol (H-02) |
| Milestone (GitLab) | id, nombre, tareas totales, tareas cerradas, % de avance. Equivale a un sprint del portal (D-28) | fechas |
| Issue (GitLab) | id, título, esfuerzo estimado, status, esfuerzo spent, due date. Los de label `UserStory` son user stories | label y milestone al que pertenecen |
| User story / Sprint / Tarea de planning | se obtienen de GitLab (user story = issue `UserStory`, sprint = milestone, tarea de planning = issue `Task` vinculado a una user story durante el sprint planning). No se crean en el portal (D-32, D-53) | |
| Asignación | une colaborador y proyecto. Si faltan competencias al nivel mínimo del rol/nivel, el portal advierte y la asignación queda pendiente hasta que el Jefe de Ingeniería apruebe la excepción | fechas, dedicación, historial (G-08), otros estados (G-33) |
| Excepción de asignación | se registran el motivo, tomado de un codificador prestablecido, y quién aprobó | estados y rechazo (G-33) |
| Motivo de excepción (codificador) | código y descripción, prestablecidos. Existe una funcionalidad para mantenerlo | quién lo mantiene y sus valores (G-33) |

### Dependencias y consumidores

- Rol/nivel es el eje común: currícula, colaborador y proyecto.
- Las evidencias de proyecto conectan el portafolio con el desarrollo de competencias.
- GitLab (instancia de la empresa): fuente de milestones e issues, vinculada por producto con `project_id`. Sincronización automática de solo lectura (30 s por defecto) (E-30, E-32, E-35).
- Keycloak: mantiene el IdM y asigna roles a los usuarios del portal, entre ellos el de Evaluador (E-48).
- Otras dependencias externas: ninguna declarada (G-11).
- Consumidores de reportes (jefatura): no confirmados.

## 9. Riesgos y restricciones funcionales

- R-01: Los niveles N1–N3 y L1–L4 se parecen en notación pero son conceptos distintos (D-31). Conviene usar nombres distintos en la documentación y la interfaz para evitar confusiones.
- R-02: Datos personales de empleados, consultables por cualquier usuario autenticado (D-20). Falta la política aplicable y confirmar la autenticación (G-12, G-11).
- R-03: La promoción de nivel y seniority es un criterio libre del Jefe de Ingeniería (D-40). Hay riesgo de decisiones inconsistentes y difíciles de justificar si no se consulta el historial de valoraciones que las sustenta (D-49). El portal lo conserva y muestra la brecha, lo que reduce el riesgo.
- R-04: Alcance amplio: roles/competencias, cursos y evidencias, personal, proyectos e integración con GitLab. Conviene dividir en épicas antes de pasar a User Stories.
- R-05: Solo existen declaraciones del usuario como fuente. Las hipótesis pueden estar equivocadas.
- R-06: Resuelto: la tensión entre E-11 y E-17 se concilia con D-31 (competencias por perfil de rol, con nivel mínimo por rol/nivel).
- R-07: Resuelto: el portal no crea user stories ni sprints (D-32). Las "tareas de planning" de E-25 quedaron sin contraparte (H-08, H-12).
- R-08: La integración con GitLab requiere acceso a la instancia privada de la empresa. Se confirmó acceso de solo lectura (D-33). Faltan detalles de implementación (credenciales, errores de sincronización: G-27).
- R-09: Los datos de GitLab se actualizan cada 30 segundos por defecto (E-93). Las decisiones pueden basarse en datos con ese retraso. El intervalo es configurable.

## 10. Decisiones y validación humana

| Decisión o validación | Responsable | Evidencia | Fecha |
|---|---|---|---|
| Aprobación del contexto | Pendiente | — | — |
| D-01: Los ID OKF son únicos por tipo de documento | ianache | Mensaje del usuario | 2026-10-10 |
| D-02: El formato es Google OKF v0.2 | ianache | Mensaje del usuario | 2026-10-10 |
| D-03: El responsable funcional es el Jefe de Ingeniería | ianache | S-02 | 2026-10-10 |
| D-04: Planilla está fuera del alcance | ianache | S-02 | 2026-10-10 |
| D-05: Cada seniority contiene niveles L1–L4 | ianache | S-02 | 2026-10-10 |
| D-06: El catálogo oficial de roles lo mantiene la plataforma y no está predefinido | ianache | S-02 | 2026-10-10 |
| D-07: Una competencia define lo esperado de un rol/nivel y combina conocimiento, habilidad y actitud | ianache | S-02 | 2026-10-10 |
| D-08: Se registran avance, evaluación y certificado por curso | ianache | S-02 | 2026-10-10 |
| D-09: El portal es un sistema independiente. Los cursos son internos | ianache | S-03 | 2026-10-10 |
| D-10: El catálogo de roles lo mantienen el Jefe de Ingeniería o un ADMIN, sin carga inicial | ianache | S-03 | 2026-10-10 |
| D-11: Cada competencia define las evidencias que sustentan su cumplimiento | ianache | S-03 | 2026-10-10 |
| D-12: Las competencias se definen por rol y tienen escala de logro | ianache | S-03 | 2026-10-10 |
| D-13: El instructor evalúa y emite certificados. Cada curso define competencias, evidencias y rúbrica. Instructor o jefe de proyecto aprueban la evidencia según su origen | ianache | S-03 | 2026-10-10 |
| D-14: El paso entre niveles y seniority se basa en certificaciones y evidencias de proyectos | ianache | S-03 | 2026-10-10 |
| D-15: Jefe de Ingeniería o ADMIN registran y modifican colaboradores | ianache | S-03 | 2026-10-10 |
| D-16: La modalidad de curso (virtual, presencial, híbrido) no cambia su tratamiento | ianache | S-03 | 2026-10-10 |
| D-17: El volumen de datos no es relevante | ianache | S-03 | 2026-10-10 |
| D-18: Producto (código, nombre) y proyecto (código, nombre, fechas, costo y esfuerzo estimados, alcance, sprints) | ianache | S-04 | 2026-10-10 |
| D-19: La asignación a un proyecto requiere competencias según la escala N1 no desarrollada, N2 en desarrollo, N3 desarrollada | ianache | S-04 | 2026-10-10 |
| D-20: Cualquier usuario autenticado puede consultar los datos personales de los colaboradores | ianache | S-04 | 2026-10-10 |
| D-21: *(reemplazada por D-24)* | — | — | — |
| D-22: *(parcialmente reemplazada por D-32)* El producto se vincula a un proyecto de GitLab por `project_id`. La creación de user stories y sprints en el portal se descartó | ianache | S-05 | 2026-10-10 |
| D-23: El portal visualiza la ejecución de sprints y user stories con información de GitLab por integración | ianache | S-05 | 2026-10-10 |
| D-24: El nivel mínimo de competencia para asignar es N2. Si no se cumple, el portal advierte y el Jefe de Ingeniería aprueba la excepción | ianache | S-06 | 2026-10-10 |
| D-25: El portal solo visualiza lo que existe en GitLab, a nivel de issue y milestone *(en tensión con D-22, ver G-22)* | ianache | S-06 | 2026-10-10 |
| D-26: Se visualizan los campos de milestone e issue de E-33 y E-34, con sincronización automática (30 s por defecto) | ianache | S-06 | 2026-10-10 |
| D-27: Un proyecto es un conjunto de milestones | ianache | S-06 | 2026-10-10 |
| D-28: Un milestone de GitLab equivale a un sprint del portal (confirma H-09) | ianache | S-07 | 2026-10-10 |
| D-29: La integración con GitLab es de solo lectura (confirma H-10) | ianache | S-07 | 2026-10-10 |
| D-30: Los proyectos del portafolio existen en el portal y se vinculan a milestones de GitLab (confirma H-11) | ianache | S-07 | 2026-10-10 |
| D-31: Cada rol se vincula a un perfil de competencias con niveles N1–N3. El rol/nivel selecciona de cada competencia el nivel mínimo (confirma H-05 y H-07) | ianache | S-08 | 2026-10-10 |
| D-32: Las user stories y sprints no se crean en el portal; se obtienen de GitLab (G-16 descartada) | ianache | S-08 | 2026-10-10 |
| D-33: El portal accede a GitLab con credenciales de servicio de solo lectura (respuesta "sí") | ianache | S-08 | 2026-10-10 |
| D-34: Al registrar un proyecto de un producto, el usuario selecciona entre los milestones registrados cuáles le corresponden | ianache | S-08 | 2026-10-10 |
| D-35: La evidencia de proyecto referencia un issue de GitLab con label Task o UserStory, en estado Closed (confirma H-08) | ianache | S-09 | 2026-10-10 |
| D-36: Con las evidencias de cursos (evaluadas por el instructor) y de proyectos (aportadas por el colaborador), un Evaluador o el Jefe de Ingeniería determina la promoción al siguiente nivel del rol | ianache | S-09 | 2026-10-10 |
| D-37: El Jefe de Ingeniería asigna a los colaboradores a los proyectos | ianache | S-09 | 2026-10-10 |
| D-38: El Evaluador es un rol asignado en Keycloak (IdM) y corresponde al instructor de una edición de curso. Los cursos tienen ediciones y objetivos, y cada objetivo se vincula a una competencia y a un nivel objetivo | ianache | S-10 | 2026-10-10 |
| D-39: El Evaluador promociona al colaborador en el curso. El Jefe de Ingeniería toma esos resultados y las evidencias de proyecto que aporta el colaborador y decide la promoción de nivel (precisa D-36) | ianache | S-10 | 2026-10-10 |
| D-40: La promoción de nivel o seniority es un criterio libre del Jefe de Ingeniería, basado en la valoración del cumplimiento del siguiente rol/nivel en su nivel mínimo | ianache | S-11 | 2026-10-10 |
| D-41: Aprobar un curso no acredita por sí solo el nivel objetivo de las competencias, pero sí el logro de los objetivos del curso (descarta H-13) | ianache | S-11 | 2026-10-10 |
| D-42: Las evidencias tienen estados Pendiente y Validada. El jefe de proyecto valida las evidencias de proyecto. Las competencias tienen evidencias obligatorias (100% validadas para certificar el curso) y deseables | ianache | S-11 | 2026-10-10 |
| D-43: El colaborador se auto-enrola en una edición de curso (número de edición, fecha, cupo). Avance, evaluación y certificado se registran por edición (confirma H-14) | ianache | S-11 | 2026-10-10 |
| D-44: Regla de certificación confirmada. Lo obligatorio u opcional se define en el curso (curso → objetivo → competencia/nivel objetivo). Las evidencias del curso las valida el instructor de la edición | ianache | S-12 | 2026-10-10 |
| D-45: El curso tiene fecha de inicio y fin. Al llegar al cupo no se admite más enrolamiento. El colaborador puede desenrolarse | ianache | S-12 | 2026-10-10 |
| D-46: La valoración del colaborador la registra el Jefe de Ingeniería o un usuario con rol ADMIN | ianache | S-13 | 2026-10-10 |
| D-47: El N2 era solo un ejemplo. Si no se cumple el nivel mínimo del rol/nivel, la asignación queda pendiente hasta que el Jefe de Ingeniería apruebe la excepción. Se registran el motivo (codificador prestablecido de código y descripción) y quién aprobó | ianache | S-13 | 2026-10-10 |
| D-48: Se confirman las hipótesis H-01 a H-04, H-06, H-12 (precisada: el milestone tiene asignados issues Task y UserStory) y H-15, y los supuestos A-01 y A-02 | ianache | S-14 | 2026-10-10 |
| D-49: La valoración registra el nivel actual de cada competencia del colaborador, con historial, y el portal muestra la brecha frente al siguiente nivel | ianache | S-14 | 2026-10-10 |
| D-50: La promoción en el curso y la certificación son el mismo resultado | ianache | S-14 | 2026-10-10 |
| D-51: Debe existir una funcionalidad para mantener el codificador de motivos de excepción | ianache | S-14 | 2026-10-10 |
| D-52: Se diferencian la evidencia requerida y la evidencia aportada | ianache | S-14 | 2026-10-10 |
| D-53: Las "tareas de planning" son issues Task de GitLab vinculados a un issue UserStory durante el sprint planning | ianache | S-14 | 2026-10-10 |
| D-54: El Jefe de Ingeniería define los perfiles de competencias, los cursos y las ediciones | ianache | S-15 | 2026-10-10 |
| D-55: El Jefe de Ingeniería define también el nivel mínimo, las evidencias requeridas y los objetivos | ianache | S-16 | 2026-10-10 |
| D-56: El colaborador registra, en la edición en que está enrolado y en el objetivo del curso, referencias a issues cerrados (Task o UserStory) como evidencias del logro del objetivo | ianache | S-16 | 2026-10-10 |
| D-57: Los roles y los perfiles de competencias siempre están en el catálogo del portal | ianache | S-16 | 2026-10-10 |
| D-58: Una competencia tiene código, nombre, tipo (conocimiento, habilidad o actitud) y la definición de cada nivel | ianache | S-16 | 2026-10-10 |
| D-59: El rol tiene el nivel mínimo esperado de las competencias asociadas a su perfil | ianache | S-16 | 2026-10-10 |
| D-60: Un curso tiene código, nombre, sumilla y objetivos de aprendizaje, y cada objetivo define una rúbrica por nivel de logro con descripción observable y evidencias esperadas, mandatorias u opcionales | ianache | S-16 | 2026-10-10 |
| D-61: Las competencias tienen un tipo único (conocimiento, habilidad o actitud). Reemplaza la descripción como combinación | ianache | S-17 | 2026-10-10 |
| D-62: Las evidencias que muestran el logro se definen en la rúbrica: cada nivel de logro define las evidencias requeridas. Las competencias no definen evidencias por sí solas | ianache | S-17 | 2026-10-10 |
| D-63: «Requerida» es sinónimo de «mandatoria». El término general es «evidencia esperada» (obligatoria u opcional) | ianache | S-17 | 2026-10-10 |
| D-64: Una competencia general puede estar en más de un perfil. Otras son exclusivas de un perfil | ianache | S-17 | 2026-10-10 |
| D-65: Las evidencias se registran en el contexto de la edición de un curso en que el colaborador está enrolado, y también para solicitar promoción al Jefe de Ingeniería, eligiendo el perfil (rol y nivel) al que el colaborador considera que debería evolucionar | ianache | S-18 | 2026-10-10 |
| D-66: El jefe de proyecto se registra en el portal como un colaborador con el rol «Jefe de Proyecto» en el proyecto, con historial de cambios y vigencia desde y hasta | ianache | S-18 | 2026-10-10 |
| D-67: Productos, proyectos y codificadores (motivos de excepción) los mantiene el Jefe de Ingeniería o un colaborador con rol de usuario ADMIN | ianache | S-18 | 2026-10-10 |
| D-68: Los roles de usuario del portal son ADMIN, Instructor (Evaluador) y Jefe de Ingeniería. Los demás roles (por ejemplo, Jefe de Proyecto, roles de la currícula) son puestos dentro de la organización | ianache | S-18 | 2026-10-10 |
| D-69: El portal consulta GitLab de forma automática, cada 30 segundos por defecto, para obtener issues (Task, UserStory, Proyecto) y milestones. Las funcionalidades no consultan GitLab directamente. Reemplaza la sincronización cada hora (D-26) | ianache | S-18 | 2026-10-10 |
| D-70: La carga desde GitLab es un proceso automático programado. El Jefe de Ingeniería y los usuarios con rol ADMIN ven una consola de logs de cargas (fecha y hora, estado exitosa o fallida) y pueden reintentar | ianache | S-18 | 2026-10-10 |
| D-71: La carga trae solo lo creado o actualizado desde la ejecución más reciente (delta de cambio) | ianache | S-18 | 2026-10-10 |
| D-72: El codificador de motivos parte vacío y no se puede retirar un motivo usado | ianache | S-18 | 2026-10-10 |
| D-73: La solicitud de promoción la registra el colaborador y la evalúa el Jefe de Ingeniería, quien valora todas las evidencias | ianache | S-18 | 2026-10-10 |
| D-74: El registro de colaboradores y las relaciones entre ellos se alinean con el Universal Data Model (UDM), usando sus construcciones de Party, relationship y contacts, entre otras | ianache | S-18 | 2026-10-10 |
| D-75: Los milestones e issues de un proyecto (la ejecución) los ven el Jefe de Ingeniería y los usuarios con rol ADMIN | ianache | S-18 | 2026-10-10 |
| D-76: Un colaborador puede reportar a otro colaborador (relación «reporta a», entre partes del UDM) | ianache | S-18 | 2026-10-10 |
| D-77: De un colaborador se registran datos de contacto de tipo correo, teléfono y dirección | ianache | S-18 | 2026-10-10 |
| D-78: COMSATEL y el Área de Desarrollo se registran como organizaciones. El Área de Desarrollo «es parte de» COMSATEL. Habrá otras organizaciones, como los proveedores que proporcionan colaboradores | ianache | S-18 | 2026-10-10 |
| D-79: De la persona (Party) se guarda el GUID que Keycloak asigna al usuario definido para ella | ianache | S-18 | 2026-10-10 |
| D-80: Cuando un usuario (colaborador, Jefe de Ingeniería o ADMIN) inicia sesión, el portal obtiene la información del usuario autenticado y lo registra como «usuario» con datos básicos: GUID de Keycloak, username, correo electrónico y los roles de usuario asignados en Keycloak (colaborador, Jefe de Ingeniería o ADMIN) | ianache | S-18 | 2026-10-10 |
| D-81: Los datos de contacto obligatorios de un colaborador son teléfono y correo electrónico | ianache | S-18 | 2026-10-10 |
| D-82: La relación «reporta a» entre colaboradores tiene vigencia y un colaborador tiene un solo jefe | ianache | S-18 | 2026-10-10 |
| D-83: El vínculo entre un colaborador y una organización es una relación de tipo «membership» (miembro de) | ianache | S-18 | 2026-10-10 |
| D-84: Un colaborador se vincula siempre a un «usuario» proveniente de Keycloak. El usuario es la identidad que le permite al colaborador ingresar al portal | ianache | S-18 | 2026-10-10 |
| D-85: La persona (Party) se vincula al «usuario», y el usuario es quien mantiene el GUID de Keycloak. Corrige D-79 | ianache | S-18 | 2026-10-10 |
| D-86: El Instructor también es un rol de usuario. Los roles de usuario son colaborador, Instructor, Jefe de Ingeniería y ADMIN. Corrige D-80 y D-68 | ianache | S-18 | 2026-10-10 |
| D-87: Un colaborador puede tener más de un dato de contacto. Normalmente se usará uno, pero se deja abierto a varios | ianache | S-18 | 2026-10-10 |
| D-88: La membresía de un colaborador a una organización tiene vigencia. Por ejemplo, un colaborador de un proveedor puede pasar a ser miembro definitivo de COMSATEL. Colaborador y organización pueden tener una relación vigente en el tiempo | ianache | S-18 | 2026-10-10 |
| D-89: La asignación de un colaborador a un proyecto tiene vigencia (desde y hasta), como la del jefe de proyecto | ianache | S-18 | 2026-10-10 |
| D-90: La membresía vigente (fecha hasta abierta) de un colaborador a una organización, sea un proveedor o COMSATEL, es como máximo una. Un colaborador no puede tener vigentes membresías a más de una organización a la vez | ianache | S-18 | 2026-10-10 |
| D-91: La fecha de inicio y fin corresponde a la edición del curso, no al curso. Aclara D-45 y E-61, que la atribuían al curso | ianache | S-18 | 2026-10-10 |
| D-92: Se conserva el historial de cambios de nivel y seniority de cada colaborador | ianache | S-18 | 2026-10-10 |
| D-93: La asignación a un proyecto incluye un porcentaje de dedicación (un colaborador puede participar en más de un proyecto a la vez) y se mantiene el historial de asignaciones | ianache | S-18 | 2026-10-10 |
| D-94: La evaluación de desempeño del colaborador debe quedar dentro del alcance. Amplía D-04 | ianache | S-18 | 2026-10-10 |
| D-95: «Jefe de Ingeniería» es un rol de usuario que se asigna en Keycloak. Por defecto, el usuario ianache | ianache | S-18 | 2026-10-10 |
| D-96: Los valores posibles de `status`, `domain` e `impact_level` del formato se proponen según buenas prácticas y se documentan en el anexo A de este pack | ianache | S-18 | 2026-10-10 |
| D-97: La sumilla de un curso es un texto que resume el curso | ianache | S-18 | 2026-10-10 |
| D-98: La competencia tiene un indicador que define si es general o específica (exclusiva de un rol) | ianache | S-18 | 2026-10-10 |
| D-99: Los roles/niveles y las cantidades que requiere cada proyecto los registra el Jefe de Proyecto designado al proyecto, no el Jefe de Ingeniería | ianache | S-18 | 2026-10-10 |
| D-100: Una carga fallida de GitLab se reintenta 3 veces con una estrategia de esperas incrementales y se usa un circuit breaker para no saturar a GitLab | ianache | S-18 | 2026-10-10 |
| D-101: La evaluación de desempeño usa la información de evaluación de los cursos y las evidencias que el colaborador aporta sobre su desempeño en los proyectos. De ella se decide si hay un cambio de rol/nivel según el cumplimiento de los requisitos de las competencias del nuevo rol/nivel con las evidencias disponibles. La realiza el Jefe de Ingeniería | ianache | S-18 | 2026-10-10 |
| D-102: La evaluación de desempeño es semestral. El Jefe de Ingeniería puede realizarla a demanda, por criterio propio o a solicitud del colaborador | ianache | S-18 | 2026-10-10 |
| D-103: El resultado de la evaluación de desempeño usa la escala supera, cumple, parcial o no cumple | ianache | S-18 | 2026-10-10 |
| D-104: La evaluación de desempeño es un insumo para la promoción | ianache | S-18 | 2026-10-10 |
| D-105: La evaluación de desempeño registra el resultado, el periodo, los comentarios, las evidencias consideradas, la fecha y hora del registro y el usuario que la registra | ianache | S-18 | 2026-10-10 |
| D-106: La evaluación de desempeño es obligatoria para promover al colaborador a un nuevo rol/nivel | ianache | S-18 | 2026-10-10 |
| D-107: Se conserva el historial de evaluaciones de desempeño de cada colaborador | ianache | S-18 | 2026-10-10 |
| D-108: La evaluación de desempeño considera las certificaciones y las evidencias validadas del colaborador | ianache | S-18 | 2026-10-10 |
| D-109: Un milestone pertenece a un único proyecto | ianache | S-18 | 2026-10-10 |
| D-110: Los logs de carga de GitLab se retienen por siempre | ianache | S-18 | 2026-10-10 |
| D-111: Ante fallas de GitLab se usa un circuit breaker como patrón para no saturarlo, aplicando las mejores prácticas de reintentos. Los parámetros se documentan en el anexo B | ianache | S-18 | 2026-10-10 |
| D-112: Si GitLab no responde, el portal muestra el aviso «datos al <fecha y hora de la última carga exitosa>», en formato UTC-05 | ianache | S-18 | 2026-10-10 |
| D-113: La suma de los porcentajes de dedicación de un colaborador tiene un tope máximo de 100 %. No se debe permitir sobreasignar a un colaborador | ianache | S-18 | 2026-10-10 |
| D-114: La primera carga de GitLab es completa, porque no hay fecha de carga previa. Si no hay cambios desde la carga previa, se registra la situación como «sin cambios desde carga previa» | ianache | S-18 | 2026-10-10 |
| D-115: Los usuarios ingresan al portal de forma segura, con el portal integrado a Keycloak mediante un componente BFF con el protocolo PKCE, sin comprometer datos sensibles en el navegador. La aplicación es un SPA en Angular y el BFF es Next.js | ianache | S-18 | 2026-10-10 |
| D-116: El portal soporta el cierre de sesión a demanda o por vencimiento del tiempo de sesión, controlado por Keycloak. La cookie que controla el BFF con el SPA y la sesión en Keycloak deben estar alineadas | ianache | S-18 | 2026-10-10 |
| D-117: La arquitectura incluye micro UI en Angular y un catálogo de componentes UI reutilizables basado en «Atomic Design» | ianache | S-18 | 2026-10-10 |
| D-118: La base de datos es MySQL 8.x, el BFF usa Redis para el caching de datos y los microservicios se desarrollan en Python con FastAPI | ianache | S-18 | 2026-10-10 |
| D-119: Los parámetros y los datos sensibles se mantienen en HashiCorp Vault | ianache | S-18 | 2026-10-11 |
| D-120: La integración entre el BFF y los microservicios usa un protocolo de confianza | ianache | S-18 | 2026-10-11 |
| D-121: Las API de los microservicios se exponen a terceros a través de un API Gateway basado en Kong o KrakenD, en su variante OSS, integrado con Keycloak para obtener un token JWT | ianache | S-18 | 2026-10-11 |
| D-122: La integración entre el BFF y los microservicios no usa token JWT: usa un protocolo para el consumo seguro. Aclara D-120 | ianache | S-18 | 2026-10-11 |
| D-123: Los microservicios quedan preparados para que otras aplicaciones, además del Portal, los consuman de forma segura a través del API Gateway con token JWT | ianache | S-18 | 2026-10-11 |
| D-124: En Vault, bajo `secret/ppm/*`, se guardan las credenciales de acceso a la base de datos MySQL, el usuario y la contraseña de Redis, el PAT de GitLab y la URL base de GitLab (ruta actualizada en D-127) | ianache | S-18 | 2026-10-11 |
| D-125: La plataforma está completamente contenerizada | ianache | S-18 | 2026-10-11 |
| D-126: La solución se denomina P3M (People, Product and Project Management), porque no gestiona solo la capacitación. Reemplaza los nombres «portal de gestión de currícula» y «PPM» | ianache | S-18 | 2026-10-11 |
| D-127: La ruta de secretos en Vault pasa de `secret/ppm/*` a `secret/p3m/*`, por el nuevo nombre de la solución. Actualiza D-124 | ianache | S-18 | 2026-10-11 |
| D-128: Los requisitos arquitectónicamente significativos se denominan ASR (Architecturally Significant Requirements), conforme al skill asr-discovery, y no ARS. Cada uno es un candidato con disposición humana pendiente | ianache | S-18 | 2026-10-11 |
| D-129: El modelo conceptual se alinea con los conceptos de Party Management del UDM (parte, persona, organización, rol de la parte, relación entre partes y mecanismos de contacto). Se detectó un desvío conceptual entre el modelo y el UDM | ianache | S-18 | 2026-10-11 |
| D-130: Existen plazas por organización, así que se modela la plaza (Position del UDM). El rol/nivel (por ejemplo Developer, Junior, Nivel 2) es el tipo de puesto (Position Type) de la plaza | ianache | S-18 | 2026-10-11 |
| D-131: El colaborador ocupa una plaza durante un periodo con vigencia desde y hasta (Position Fulfillment del UDM). Su rol/nivel es el de la plaza que ocupa y el historial de cambios son sus ocupaciones | ianache | S-18 | 2026-10-11 |
| D-132: Al vencer la sesión se muestra al usuario un mensaje emergente (popup) sobre el vencimiento. El cierre de sesión es global. El trabajo en curso se pierde con el cierre de la sesión | ianache | S-18 | 2026-10-11 |
| D-133: Los datos personales se retienen igual que los logs: por siempre | ianache | S-19 | 2026-10-11 |
| D-134: Un proyecto puede tener varios jefes de proyecto a lo largo del tiempo, pero solo uno vigente a la vez. Un colaborador puede ser jefe de varios proyectos | ianache | S-19 | 2026-10-11 |
| D-135: La evidencia aportada es una referencia (URL) a un issue de GitLab. La certificación de curso es un resultado emitido por el Evaluador, no una evidencia aportada | ianache | S-19 | 2026-10-11 |
| D-136: Una plaza la ocupa como máximo un colaborador a la vez. Si se requieren dos developers senior se registran como dos plazas | ianache | S-19 | 2026-10-11 |
| D-137: Un usuario de Keycloak sin colaborador registrado y sin los roles de usuario Jefe de Ingeniería, ADMIN o Instructor es enviado al login | ianache | S-19 | 2026-10-11 |
| D-138: El Evaluador (instructor) y el jefe de proyecto son roles de la parte con vigencia, igual que el colaborador | ianache | S-19 | 2026-10-11 |
| D-139: Los roles/niveles requeridos por un proyecto los define cualquier usuario con rol de usuario Jefe de Ingeniería o ADMIN. Reemplaza lo dicho en E-121 (los registraba el jefe de proyecto designado) | ianache | S-19 | 2026-10-11 |
| D-140: Por cada evidencia esperada y enrolamiento el colaborador registra una sola evidencia aportada, que puede reemplazar mientras esté Pendiente. No existe el estado Rechazada | ianache | S-19 | 2026-10-11 |
| D-141: Al promover de nivel, la plaza cambia de rol/nivel y el colaborador sigue en la misma plaza. El historial de rol/nivel lo conserva la plaza | ianache | S-19 | 2026-10-11 |
| D-142: Estados de la asignación: pendiente, vigente y finalizada. De la solicitud de promoción: registrada, evaluada y decidida. De la carga de GitLab: programada, ejecutando, completada, fallida y sin cambios | ianache | S-19 | 2026-10-11 |
| D-143: La evidencia de proyecto se liga solo por la URL del issue de GitLab; no se liga además a un proyecto, porque el issue ya pertenece a un milestone y por tanto a un proyecto | ianache | S-20 | 2026-10-11 |
| D-144: Cada rol tiene un único perfil de competencias | ianache | S-20 | 2026-10-11 |
| D-145: El nivel de desarrollo L1 a L4 es una posición dentro de cada seniority (por ejemplo, Junior L2), no una escala común | ianache | S-20 | 2026-10-11 |
| D-146: Una plaza no tiene más datos propios que su organización, su rol/nivel y su ocupación; está vacante cuando no tiene una ocupación vigente | ianache | S-20 | 2026-10-11 |
| D-147: Una organización es parte de, como máximo, una organización a la vez | ianache | S-20 | 2026-10-11 |
| D-148: La evidencia esperada tiene una descripción | ianache | S-20 | 2026-10-11 |
| D-149: Una persona no tiene dos veces el mismo tipo de rol de la parte con vigencias solapadas | ianache | S-20 | 2026-10-11 |
| D-150: Los datos de contacto son solo de las personas; las organizaciones no tienen datos de contacto | ianache | S-20 | 2026-10-11 |
| D-151: Quien se desenrola de una edición puede volver a enrolarse en la misma edición | ianache | S-20 | 2026-10-11 |
| D-152: En el enrolamiento se registran el avance del colaborador (un porcentaje), su nota y comentarios (un texto) | ianache | S-20 | 2026-10-11 |
| D-153: Una solicitud de promoción termina en cero o una promoción de nivel, y el Jefe de Ingeniería puede promover sin que exista una solicitud | ianache | S-20 | 2026-10-11 |
| D-154: El usuario de Keycloak se vincula con su persona por el correo que Keycloak entrega, la primera vez que inicia sesión; el correo vigente es único entre las personas | ianache | S-20 | 2026-10-11 |
| D-155: La nota va de 0 a 20. Una nota mayor o igual que 12 es solo informativa y no condiciona la certificación | ianache | S-20 | 2026-10-11 |
| D-156: El costo estimado de un proyecto se expresa en soles peruanos (PEN) y el esfuerzo estimado en horas-persona | ianache | S-20 | 2026-10-11 |
| D-157: Los usuarios no pueden crear cuentas ni hay registro libre ni auto-registro, ni en el login del portal ni en el flujo de login de Keycloak. Las identidades de Keycloak vienen de su conexión con Active Directory, que gestiona el equipo de infraestructura, y el correo es de solo lectura | ianache | S-20 | 2026-10-11 |
| D-158: El vínculo entre el usuario y su persona se fija una sola vez. Un vínculo equivocado, o un correo que cambia o se reutiliza, lo corrige el Jefe de Ingeniería, y queda registrado quién y cuándo | ianache | S-20 | 2026-10-11 |
| D-159: Un dato de contacto no se borra: se da de baja con fecha y responsable. La baja libera la dirección, por ejemplo cuando un correo se reutiliza | ianache | S-20 | 2026-10-11 |
| D-160: Toda parte (persona u organización) tiene datos de contacto. Reemplaza D-150, que decía que solo las personas los tienen | ianache | S-21 | 2026-10-12 |
| D-161: Los datos de contacto de una organización son de tipo correo, teléfono y dirección. Correo y teléfono son obligatorios | ianache | S-22 | 2026-10-12 |
| D-162: El correo vigente es único entre todas las partes (personas y organizaciones) | ianache | S-22 | 2026-10-12 |
| D-163: BR-003 se mantiene: cualquier usuario autenticado consulta los datos personales de los colaboradores. El riesgo se trata como parte de la deuda técnica DT-01 | ianache | S-23 | 2026-10-12 |
| D-164: Los nombres de los roles de usuario en Keycloak son ADMIN, COLABORADOR, INSTRUCTOR y JEFE_INGENIERIA (definidos por el responsable) | ianache | S-23 | 2026-10-12 |
| D-165: El ADMIN suple las seis capacidades que hoy son exclusivas del Jefe de Ingeniería (asignar, aprobar excepciones, decidir promociones, definir currícula y cursos, registrar la evaluación de desempeño y corregir el vínculo usuario-persona) | ianache | S-23 | 2026-10-12 |
| D-166: Los contactos, las plazas, las ocupaciones, los roles de la parte, las relaciones entre partes y las organizaciones los mantienen el Jefe de Ingeniería y el ADMIN | ianache | S-23 | 2026-10-12 |
| D-167: Una organización se registra con su Tax ID, su Business Name (razón social) y su Commercial Name (nombre comercial), además de sus datos de contacto | ianache | S-24 | 2026-10-12 |
| D-168: Una organización se puede dar de baja inactivándola; no se borra | ianache | S-24 | 2026-10-12 |

Fuentes de las decisiones D-133 a D-159 (no están en la lista de fuentes de la sección 2 para no cambiar la numeración de líneas que citan otros documentos):

- S-19: respuestas del responsable funcional durante el diseño de base de datos (DDP-001 sección 9 y DDM-001 sección 8): retención de datos personales, jefe de proyecto con vigencia, evidencia aportada como URL de GitLab, certificación como resultado emitido, una persona por plaza, acceso de usuarios sin colaborador, evaluador y jefe de proyecto como roles de la parte, quién define los roles/niveles requeridos, plaza que cambia de nivel y estados.
- S-20: respuestas del responsable funcional durante el diseño lógico y físico de la base de datos y la revisión del diseño (LDM-001, ICP-001, PDM-001 y RPT-DDR-001): perfil único por rol, posición del nivel de desarrollo, datos de la plaza, contactos de personas, enrolamiento con avance, nota y comentarios, solicitud y promoción, vínculo del usuario con la persona por el correo, escala de la nota, moneda y unidad del proyecto, y configuración de Keycloak.
- S-21: respuesta del responsable funcional del 2026-10-12 sobre los datos de contacto de las partes (OI-11 del handoff de base de datos).
- S-22: respuesta del responsable funcional del 2026-10-12 (RQ-36): tipos de contacto de las organizaciones, obligatoriedad y unicidad del correo.
- S-23: respuestas del responsable funcional del 2026-10-12 a las decisiones P5-D1 a P5-D7 de ADR-P5 (autorización por rol).
- S-24: respuesta del responsable funcional del 2026-10-12 a US-035-Q2 y US-035-Q3: datos de la organización y baja por inactivación.

Estado de validación: **aprobado** por ianache (Functional Analysis) el 2026-10-10, a solicitud expresa. Las decisiones D-01 a D-168 son declaraciones del usuario. Las preguntas abiertas siguen abiertas. Las decisiones D-133 a D-159 fueron verificadas por ianache el 2026-10-12. Las decisiones D-160 a D-166 (2026-10-12) se añadieron después y fueron verificadas por ianache el 2026-10-12.

## 11. Knowledge Candidates

| Candidato | Provenance | Verificador | Estado |
|---|---|---|---|
| Progresión profesional: seniority → niveles L1–L4 → competencias → evidencias | S-02, S-03 | Jefe de Ingeniería (pendiente) | Promovido a conocimiento canónico, en estado `draft`: glosario TRM-0004 a TRM-0008, TRM-0017, TRM-0024, TRM-0025 y TRM-0042; reglas BR-011 a BR-015, BR-029 a BR-031, BR-051 y BR-052; modelo IMD-001 (bloques 1 y 3) |
| Tipos de evidencia de competencia (certificado de curso, tarea/entregable de proyecto) y quién las valida | S-03, S-11, S-12 | Jefe de Ingeniería (pendiente) | Promovido a conocimiento canónico, en estado `draft`: glosario TRM-0017 a TRM-0022, TRM-0040 y TRM-0041; reglas BR-009, BR-010, BR-018 a BR-021 y BR-054; modelo IMD-001 (R-19 a R-27, R-46 y R-47) |
| Estructura Producto → Proyecto (conjunto de milestones) → Asignación de colaboradores | S-01, S-06 | Jefe de Ingeniería (pendiente) | Promovido a conocimiento canónico, en estado `draft`: glosario TRM-0029 a TRM-0031, TRM-0034 y TRM-0043; reglas BR-032 a BR-040 y BR-045 a BR-050; modelo IMD-001 (bloque 4) |
| Regla de asignación: el rol/nivel define el nivel mínimo de cada competencia del perfil. Si no se cumple, la asignación queda pendiente hasta que el Jefe de Ingeniería apruebe la excepción, con motivo del codificador y quién aprobó | S-06, S-08, S-13 | Jefe de Ingeniería (pendiente) | Promovido a conocimiento canónico, en estado `draft`: glosario TRM-0009, TRM-0035 y TRM-0039; reglas BR-014, BR-041 a BR-043 y BR-053; modelo IMD-001 (R-39 a R-45) |

Los candidatos se promovieron a pedido del responsable funcional (2026-10-10), con provenance en este pack. Siguen en estado `draft` porque ningún artefacto de `business/` tiene verificación humana asignada (`verified`). Para marcarlos como aprobados, el Jefe de Ingeniería debe aprobar los términos y reglas por nombre.

## 12. Handoff

### Qué puede usar el siguiente rol

- La lista de capacidades E-01 a E-89 como punto de partida del catálogo de requisitos.
- El mapa de datos de la sección 8 como borrador del modelo conceptual (skill `af-conceptual-model-designer`).
- El glosario GLS-001, el catálogo BRC-001 y el modelo IMD-001, ya generados a partir de este pack.

### Qué debe validar antes de continuar

- No quedan preguntas de prioridad Alta. Las de prioridad Media son G-33, G-11, G-12, G-14, G-06, G-08 y V-03, y las de prioridad Baja, G-27, G-28, G-37, V-01 y V-02.
- Todas las hipótesis están confirmadas, salvo H-13, que fue descartada. Los supuestos A-01 y A-02 están confirmados.
- Decidir si el trabajo se divide en épicas: (1) roles, competencias y cursos, (2) evidencias y progresión, (3) colaboradores, (4) portafolio y asignaciones, (5) integración con GitLab y visualización de la ejecución.

### Artefactos relacionados

- Glosario de negocio: [GLS-001](../../business/glossary/GLS-001-glosario-de-negocio.md) (46 términos, `draft`).
- Catálogo de reglas de negocio: [BRC-001](../../business/rules/BRC-001-reglas-de-negocio-portal-curricula.md) (64 reglas, `draft`).
- Modelo de información conceptual: [IMD-001](../../business/information-model/IMD-001-portal-curricula.md) (34 conceptos, 60 relaciones, `draft`).
- Siguiente: User Stories (`af-user-story-refiner`).

## Anexo A. Valores sugeridos del encabezado (V-01)

Propuesta según buenas prácticas, no tomada de la especificación OKF (no se consultó). Debe confirmarla quien mantiene el formato.

| Campo | Valores sugeridos | Uso |
|---|---|---|
| `status` | `draft`, `in-review`, `approved`, `deprecated` (en minúscula) | Alinea los paquetes de contexto con el glosario, que ya usa `draft`, `approved` y `deprecated`. Este pack usa hoy «DRAFT» y «APPROVED» |
| `domain` | Un valor en `kebab-case` por documento: `talent-development` (este pack), `project-portfolio`, `identity-access`, `integration` | El dominio de negocio principal. Debe salir de una lista controlada que mantenga el área |
| `impact_level` | `LOW`, `MEDIUM`, `HIGH`, `CRITICAL` | Criterios sugeridos: número de usuarios afectados, tratamiento de datos personales, dependencia de sistemas externos. Para este pack: `MEDIUM` provisional; subir a `HIGH` si G-12 confirma datos personales sensibles |

## Anexo B. Reintentos y circuit breaker de la carga de GitLab (D-111)

Parámetros propuestos según buenas prácticas para integraciones con una API externa. Son configurables y los confirma Arquitectura. No provienen de una norma consultada.

| Aspecto | Práctica propuesta |
|---|---|
| Reintentos | 3 por carga fallida (D-100), con espera exponencial más una variación aleatoria (jitter), por ejemplo 5 s, 15 s y 45 s |
| Qué se reintenta | Solo fallas transitorias: tiempos de espera, errores de red y respuestas 5xx, 429 o 408. No se reintentan los errores 4xx de petición o permisos (por ejemplo 401, 403 o 404) |
| Límite de velocidad | Si GitLab responde 429 con `Retry-After`, se respeta ese tiempo antes del siguiente intento |
| Circuit breaker | Tres estados: cerrado (normal), abierto (no se consulta a GitLab) y semiabierto (una consulta de prueba) |
| Apertura | Tras 5 cargas fallidas consecutivas, ya agotados sus reintentos |
| Tiempo abierto | 5 minutos, y luego pasa a semiabierto. Si la prueba funciona, se cierra. Si falla, vuelve a abrirse |
| Tiempo máximo por consulta | Un tiempo de espera máximo por consulta (por ejemplo 10 s), para no acumular cargas |
| Una sola carga a la vez | No se inicia una carga nueva mientras otra sigue en curso |
| Registro | Cada ejecución y cada cambio de estado del circuit breaker quedan en el log de cargas, que se retiene por siempre (D-110) |

## Anexo C. Restricciones de arquitectura declaradas (D-115 a D-125)

Son restricciones para quien diseñe la solución, no reglas de negocio. Las historias las citan como requisitos no funcionales.

| Restricción | Fuente |
|---|---|
| Aplicación SPA en Angular con un BFF en Next.js | D-115 |
| Autenticación con Keycloak a través del BFF usando PKCE, sin dejar datos sensibles en el navegador | D-115 |
| La sesión que controla el BFF mediante una cookie y la sesión de Keycloak se mantienen alineadas | D-116 |
| Micro UI en Angular | D-117 |
| Catálogo de componentes UI reutilizables basado en Atomic Design | D-117 |
| Base de datos MySQL 8.x | D-118 |
| Redis para el caching de datos en el BFF | D-118 |
| Microservicios en Python con FastAPI | D-118 |
| Parámetros y datos sensibles en HashiCorp Vault | D-119 |
| Integración BFF–microservicios con un protocolo de confianza (no se nombra cuál) | D-120 |
| API Gateway basado en Kong o KrakenD (OSS) integrado con Keycloak, con token JWT, para exponer las API a terceros | D-121 |
| El BFF consume los microservicios con un protocolo de consumo seguro, sin token JWT (no se nombra el protocolo) | D-122 |
| Los microservicios son consumibles de forma segura por otras aplicaciones, además del Portal, a través del API Gateway con JWT | D-123 |
| Vault `secret/p3m/*`: credenciales de MySQL, usuario y contraseña de Redis, PAT de GitLab y URL base de GitLab | D-124 |
| Plataforma completamente contenerizada | D-125 |

Preguntas de arquitectura pendientes (sin respuesta en las fuentes): qué datos se guardan en el caché del BFF y por cuánto tiempo, y si Redis guarda también la sesión del BFF. El modelo conceptual IMD-001 es la entrada de `data-model-designer`, que lo traducirá a MySQL 8.x. Este pack no diseña la solución técnica.
