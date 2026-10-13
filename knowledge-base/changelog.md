# Changelog de la base de conocimiento

## 2026-10-13 (respuestas a ADR-17: A-1 a A-5)

- **A-1:** la clase de arranque y la configuración de ensamblado van en el paquete raíz `com.comsatelglobal.p3m` (puede depender de las cuatro capas; ninguna capa depende de él).
- **A-2:** la seguridad (servidor de recursos OAuth2, filtros de token y rol) va en `presentation`.
- **A-3:** `application` usa interfaces y se inyectan las implementaciones; lo mismo para lo que `presentation` necesite de `infrastructure`. Precisa la regla 3. Por confirmar: dónde se declaran las interfaces que consume `presentation` (se asume `application`).
- **A-4 y A-5:** subpaquetes por contexto dentro de cada capa; pruebas ArchUnit obligatorias en el pipeline.
- **Diagramas en ADR-17 §3.4** (validados con el analizador de Mermaid 12): dependencias permitidas entre los paquetes (flowchart), inversión de control en un caso de uso (classDiagram) y recorrido de una solicitud (sequenceDiagram), más la estructura de paquetes de un servicio con dos contextos.
- **Nueva A-6:** considerar un plugin que genere las clases Java del API desde la especificación OpenAPI (API primero). Verificado: plugin de Maven 7.26.0, plugin de Gradle 7.14.0 (rezagado, favorece Maven en J-3); **falta comprobar la compatibilidad con Spring Boot 4 y Jackson 3**.

## 2026-10-13 (ADR-16 y ADR-17: microservicios en Java con Spring y arquitectura hexagonal)

- **ADR-16** nuevo: los microservicios del core backend pasan a **Java 24 con Spring Boot 4.0.8 y Spring Cloud 2025.1.3** (confirmado por ianache). **Reemplaza a ADR-07** (Python con FastAPI), que queda como histórico. Verificado en Maven Central: la última Spring Boot estable es la 4.1.1, pero el último tren estable de Spring Cloud (2025.1.3) está construido sobre Spring Boot 4.0.8 y el tren 2026.0 para Boot 4.1 aún es un hito; por eso se fijó la pareja 4.0.8 + 2025.1.3.
- **Riesgo registrado (J-1, sin resolver):** Java 24 no es LTS y su soporte público terminó cuando salió Java 25 (LTS); no recibe parches de seguridad. Se recomienda Java 25.
- **ADR-17** nuevo: arquitectura hexagonal con los paquetes `presentation`, `application`, `domain` e `infrastructure` bajo `com.comsatelglobal.p3m` y la matriz de dependencias estricta (presentation → application → domain; application puede usar infrastructure; el dominio solo por inversión de control). Cinco preguntas abiertas (A-1 a A-5) y propuesta de pruebas ArchUnit.
- **Afectados:** ADR-P3 (Celery Beat y Python) **requiere revisión**; notas en ADR-P2, ASR-16, DDM-001 §6, INF-P3M-001, EVA-001 (Spring Cloud Gateway pasa a ser candidato), API-ANL-001, API-PRP-005 y CAT-ADR-001.
- **Pendiente por la decisión:** RCP-001 (D-118) y DSP-001 aún citan Python y FastAPI; están verificados y no se tocaron: actualizarlos al verificarlos de nuevo. Los 5 repositorios `p3m-svc-*` generados en Python están **obsoletos** (`codebase/README.md`) y hay que regenerarlos en Java; se pueden reutilizar sus rutas, roles y contratos.

## 2026-10-13 (esqueletos de código y entorno local)

- **Repositorios en `codebase/`** (cada uno, independiente): `p3m-portal-web` (shell, 5 micro UI y la biblioteca `@comsatel/p3m-ui`), `p3m-bff`, 5 microservicios `p3m-svc-*` y `p3m-local` (Docker Compose). Generados desde SCR-001/002, API-PRP-001 a 006 y el modelo físico. Ver `codebase/README.md`.
- **Verificado de verdad:** la biblioteca y las 6 aplicaciones Angular compilan; el BFF compila y pasa 14 pruebas; los 5 servicios pasan 8 a 10 pruebas cada uno; en Docker Compose, MySQL 8.4 aplica con Flyway las migraciones de los 7 esquemas (51 tablas) y los permisos por tabla, y arrancan Keycloak, Vault, Redis y RabbitMQ. Con tokens reales de Keycloak se comprobó la validación por JWKS, los roles, el scope por contrato y la conexión a MySQL por SSL.
- **Biblioteca de componentes** `@comsatel/p3m-ui` por Atomic Design (9 átomos, 8 moléculas, 6 organismos, 2 plantillas), importada por el shell y por las 5 micro UI. Diferencias con el sistema de diseño: DatePicker sobre el `input` nativo, sin submenús *flyout* en el menú contraído.
- **SCRQ-1:** el esqueleto usa federación en tiempo de ejecución (opción A) en un único espacio de trabajo; sustituye mi recomendación de la opción B. Falta que lo confirme ianache o Arquitectura (ADR-04).
- **Respuestas a INF-Q01, 04 a 09, 11, 12, 14, 15 y 17** registradas en INF-P3M-001 (v0.1.3): INF-DEC-24 a 28. ADR-P7 lleva una enmienda: no hay DEV en OKE.
- **IA Design System aplicado** (DSC-001): 10 componentes, tokens nuevos y correcciones de accesibilidad. Dos hallazgos míos se retiran (DSA-3 y DSA-4) tras leer el código del sistema.
- **Fallo hallado y corregido con la prueba real:** al importar el realm de Keycloak con `clientScopes`, Keycloak no crea sus scopes estándar y los tokens salían sin `sub` ni roles; se definieron `basic`, `roles`, `profile`, `email` y `web-origins` con sus mapeadores.

## 2026-10-13 (pantallas y flujos de administración, SCRQ-5)

- **SCR-002** (11 pantallas, SCR-11 a SCR-21) y **FLW-002** (5 flujos) cubren lo que SCR-001 y FLW-001 no alcanzaban: currícula, cursos y ediciones, organización, plazas, relaciones, vínculo, productos, proyectos, motivos y valoración. Con ellos las 35 historias tienen pantalla.
- **Patrón común de mantenimiento** (lista, diálogo de alta, estado vacío, fin de vigencia, historial) en lugar de un diseño distinto por pantalla.
- **Hallazgos:** hace falta una lectura «personas por rol vigente» para elegir instructor (ADQ-7); un portal vacío exige un orden de configuración que las pantallas deben explicar; US-014 y US-015 no tienen pantalla propia (se asumen dentro de SCR-05 y SCR-06) y hay que confirmarlo. Siete preguntas abiertas (ADQ-1 a ADQ-7).

## 2026-10-13 (SCRQ-2 y SCRQ-4)

- **D-UX-9:** se confirman los flujos de usuario como requisito. FLW-001 cubre 5; faltan los de las pantallas que SCR-001 aún no especifica (SCRQ-5).
- **D-UX-10:** botones e inputs miden 6–8 px; DSC-001 propone `radius-md` de 12 a 6 px. SCR-001 propone además las micro UI (shell y 5; SCRQ-1 pendiente de elegir la opción de construcción).

## 2026-10-13 (decisiones de UX y datos)

- **Ocho decisiones de ianache** (D-UX-1 a D-UX-8, ver UXR-001 §7): ampliar la réplica de GitLab; derivar el siguiente rol/nivel de BR-031 (Senior L4 sin siguiente); lectura por mínimo privilegio; vista básica del colaborador solo con lo de US-005; pegar la URL del issue; contadores de pendientes sin bandeja; estado intermedio tras decidir una promoción; completar el Design System.
- **Propuestas de API:** API-PRP-000 a 0.4.0 y API-PRP-002, 003, 004, 005 y 006 actualizadas. Nuevos: CON-14 `SiguienteRolNivel` y `…/siguiente` en `svc-curricula`; BFF-V9 «mi progreso» y BFF-V10 «pendientes». Cobertura: 51 recursos y 14 contratos.
- **DSC-001:** especificación de los cambios al IA Design System, con valores candidatos calculados. **Sin aplicar:** modificar el artefacto necesita confirmación.
- **Pendiente (trabajo de datos, D-E):** migración Flyway en `p3m_gitlab`, ampliar ACL-02 y añadir CON-14 en ICP-001, que está aprobado y no se tocó. Registrar la lectura por rol en BRC-001.

## 2026-10-13 (flujos de usuario)

- **FLW-001** nuevo en `design/ux/`, con `user-flow-designer`: 5 flujos (sesión; enrolamiento y evidencias; validación y certificación; asignación y excepción; evaluación y promoción), cada uno con diagrama, camino feliz, excepciones, permisos y estados. Todo paso cita su criterio o se marca como inferido.
- **Hallazgos:** la promoción cambia la plaza de forma asíncrona (EVT-01), así que la interfaz necesita un estado intermedio (FLQ-3); no hay notificaciones definidas para que evaluador, jefe de proyecto o jefe de ingeniería sepan qué tienen pendiente (FLQ-2).

## 2026-10-13 (BQ-1: SCR-001 con el IA Design System)

- **Design System:** el indicado por ianache es el artefacto «IA Design System» de Comsatel (no hay uno con ese nombre en Claude Design; ahí solo existe «Modernist» y dos proyectos «Design System» vacíos). Se usó en solo lectura; no se modificó.
- **SCR-001 pasa a 0.2.0** con los tokens y componentes del sistema (15 componentes, tema claro), la navegación por rol y las brechas.
- **Brechas del sistema frente a P3M (DSG-1 a DSG-9):** sin Dialog, Alert, Progress, Tabs, Card, Textarea, FormField con error, estado vacío, Toast ni layout público.
- **Accesibilidad (DSA-1 a DSA-5):** placeholder 2,54:1, borde de campo 1,47:1, texto de Badge de estado entre 1,96 y 4,16:1 y encabezado de tabla 4,46:1, frente al 4,5:1 o 3:1 que exige WCAG 2.2 AA, criterio de prueba de DSP-001. UXQ-6 queda resuelta; SCRQ-3 y SCRQ-4 pendientes del dueño del sistema.

## 2026-10-12 (validación UX de las vistas del BFF)

- **UXR-001 y SCR-001** nuevos en `design/ux/`, con `ux-requirements-analyzer` y `ui-spec-writer`: se contrastaron las 6 vistas del BFF con los criterios de aceptación de 17 historias. `ui-spec-writer` pide flujos y Design System, que no existen, así que SCR-001 no define tokens ni diseño visual.
- **Resultado:** BFF-V1 se restringe a JI y ADM y se separa BFF-V7 (datos básicos, según US-005); se añade BFF-V8 (catálogo de ediciones); BFF-V3 y V5 amplían sus fuentes; BFF-V6 se retira. API-PRP-006 pasa a 0.2.0 y el resumen a 0.3.0.
- **Hallazgos nuevos:** UXQ-1 (la réplica de GitLab no guarda estimado, spent, due date, status ni totales por milestone, que US-024 muestra; bloquea US-024) y UXQ-2 (no hay forma de saber el «siguiente» rol/nivel para US-017).

## 2026-10-12 (H-01 decidida y propuesta del BFF)

- **H-01 decidida por ianache:** 5 microservicios (`svc-partes-identidad`, `svc-curricula`, `svc-formacion-progresion`, `svc-portafolio`, `svc-gitlab`). Registrada como enmienda sin verificar en ADR-P2 y en API-PRP-000 a 005; falta la revisión de un arquitecto. A-01 de API-ANL-001 queda sustituido.
- **H-02, propuesta:** [API-PRP-006](design/api-contracts/API-PRP-006-bff-portal.md) con las rutas del BFF (sesión, paso y 6 vistas compuestas inferidas). Falta validarla con UX; sigue impidiendo `READY_FOR_CONTRACT`.
- **Refinamiento aditivo v0.2.0** de API-PRP-001, 003 y 004: 5 lecturas que el BFF necesita (`GET /v1/usuarios`, `/v1/enrolamientos`, `/v1/evidencias`, `/v1/colaboradores/{id}/certificaciones`, `/v1/proyectos`). Cobertura: 50 recursos.

## 2026-10-12 (skill api-refiner y primeras propuestas de API)

- **Skill nuevo `api-refiner`** en `.claude/skills/`: convierte un OKF `API Requirements Analysis` en APIs (microservicios) recomendadas, una plantilla por API, o refina las existentes.
- **Prueba sobre API-ANL-001:** 5 propuestas `API-PRP-001` a `005` y un resumen `API-PRP-000` en `design/api-contracts/`, todas `draft` y `REQUIRES_REVIEW`. Cobertura verificada con script: 45 de 45 recursos, 13 de 13 contratos CON y 33 de 35 historias (US-027 y US-028 son del BFF), sin huérfanos ni duplicados. La agrupación es una recomendación pendiente (H-01); H-02 (catálogo de rutas del BFF) impide `READY_FOR_CONTRACT`.

## 2026-10-12 (cambio de destino de GitLab: proyecto 605 → 633)

- **Destino:** el responsable cambió el `project_id` a **633** (`comsatel/development/training/dev-juniors/p3m/collaboration`). El proyecto 605 se conserva intacto.
- **Creado en el 633:** Project Issue [#1](https://project.comsatel.com.pe/comsatel/development/training/dev-juniors/p3m/collaboration/-/issues/1), Milestone «Sprint 1 - P3M» (id 1755), 35 Issues de User Story (US-001 a US-035, 784 h de referencia en total; 212 h en el Sprint 1) y los labels que faltaban.
- **Actualizados:** DSP-001, SSP-001, TRC-SSP-001, los 35 archivos `management/user-stories/issues/`, los encabezados `gitlab_issue_*` de las 35 historias y MAPA-RESULTADOS-GESTION. MCP-DSP-001 lleva una nota (sus hechos sobre el 605 son históricos).
- **Pendiente:** US-029 a US-035 no están en el DSP-001; US-020 (46 h) supera la talla L y debe dividirse; los archivos de P3M no están publicados en `p3m/knowledge-base`, así que los Issues solo citan la ruta local.

## 2026-10-12 (análisis de API por dominio)

- **API-ANL-001** nuevo en `design/api-contracts/`: inventario de las API que requiere cada contexto DDD (CTX-01 a CTX-07), derivado de DDM-001, ICP-001, DSP-001 y las historias US-001 a US-035. `draft`, `REQUIRES_REVIEW`. Incluye 11 hallazgos (H-01 a H-11); los principales: ADR-P2 no enumera los microservicios, no hay catálogo de rutas del BFF y faltan convenciones de API en los ADR.

## 2026-10-12 (verificación de RCP-001, BRC-001 e IMD-001; historias actualizadas por BR-134)

- **Verificados por ianache:** RCP-001 (D-01 a D-168), BRC-001 (BR-001 a BR-137) e IMD-001. Al verificar BRC-001 se sumaron 3 líneas y se corrigieron los localizadores `BRC-001…:Lnn` de todos los archivos que los citan.
- **F-20 confirmada.** Los nombres de rol (ADMIN, COLABORADOR, INSTRUCTOR, JEFE_INGENIERIA) ya están definidos: OI-21 resuelto.
- **Nueve historias actualizadas** por BR-134 (el ADMIN suple al Jefe de Ingeniería): US-002, 003, 006, 007, 008, 017, 021, 022 y 026. Cada una pasa a `draft` y pierde `verified` hasta una nueva verificación (OI-22 resuelto en cuanto al contenido).

## 2026-10-12 (ADR-P5 aprobada: P5-D1 a P5-D7)

- **ADR-P5 aprobada** por ianache, con su anexo: el BFF reenvía el token del usuario además del JWT de máquina (P5-D1 = A; nota en ADR-P9 sin cambiar su decisión); rol más condición del recurso; BR-003 se mantiene con el riesgo dentro de DT-01.
- **RCP-001 D-163 a D-166; BRC-001 BR-134 y BR-135** (135 reglas, 175 evidencias, 12 contradicciones; C-12): el ADMIN suple las seis capacidades exclusivas del Jefe de Ingeniería; el Jefe de Ingeniería y el ADMIN mantienen contactos, plazas, ocupaciones, roles de la parte, relaciones y organizaciones. RCP-001, BRC-001 e IMD-001 siguen en `draft`.
- **Nombres de rol** ADMIN, COLABORADOR, INSTRUCTOR, JEFE_INGENIERIA (supuesto, sin contrastar con Keycloak). Cambio F-20 en `ck_usuario_rol` de `p3m_identidad` (checksum 1916221164); ICP-001 y LDM-001 actualizados. Ciclo completo sin fallas.
- **Historias** US-029, 030, 031, 032, 034 y 035 pasan a READY (el actor ya tiene fuente); US-033 admite al ADMIN. Siguen desfasadas respecto de BR-134 las historias aprobadas US-002, 003, 006, 007, 008, 017, 021, 022 y 026 (OI-22).
- Handoff regenerado: OI-04, OI-18 y OI-20 resueltos; nuevos OI-21 y OI-22.

## 2026-10-12 (RQ-36, F-19, ADR-P4 y US-035)

- **RQ-36 cerrada (D-161, D-162):** los contactos de una organización son correo, teléfono y dirección, con correo y teléfono obligatorios, y el correo vigente es único entre **todas** las partes. RCP-001, BRC-001 (BR-132, BR-133; 133 reglas, 172 evidencias) e IMD-001 (IM-Q31 cerrada) los recogen y siguen en `draft`. Se interpretó «correo único» como único entre todas las partes, no solo entre organizaciones; ianache lo puede corregir.
- **F-19 confirmada.** `correo_unico` ya no distingue el tipo de parte; checksum de `p3m_partes` 1242511565 (antes -656918459). Ciclo completo sin fallas.
- **ADR-P4 aprobada** por ianache, con el aplazamiento de la política de datos personales (DT-01) como decisión. DT-01 sigue abierta.
- **US-035** (registrar las organizaciones, CONDITIONAL, draft) nueva; US-029 pierde la pregunta Q1 y gana el criterio de correo único; US-030-Q1 cerrada.
- Handoff regenerado (33 historias).

## 2026-10-12 (D-160: toda parte tiene datos de contacto)

- **Decisión de ianache:** persona y organización tienen datos de contacto. Reemplaza D-150/BR-121 con D-160/BR-131 (RCP-001, BRC-001, IMD-001). Esos tres vuelven a `draft` y necesitan nueva verificación.
- **Base de datos:** `dato_de_contacto` pasa a `parte_id` y `tipo_parte` con FK compuesta (F-19, pendiente de tu confirmación); checksum de `p3m_partes` -656918459. LDM-001, DDM-001, PDM-001 (D-H44), ICP-001, WP-DB-001 y RPT-DDR-001 actualizados. Ciclo completo con 115 pruebas de restricciones OK.
- **Historias:** US-029 pierde el conflicto y gana AC-7 (contactos de organización); US-004 cita BR-131. Sigue abierta US-029-Q1 (RQ-36: tipos y obligatoriedad para organizaciones).
- **K-31:** el fallo intermitente tenía causa conocida: el ciclo solo sembraba el rol/nivel requerido para uno de los dos proyectos, y si ganaba el bloqueo la sesión del otro fallaba por clave foránea (error 1452), no por interbloqueo. Corregido en `ciclo_completo.sh`; el protocolo K-47 no cambia.

## 2026-10-12 (OI-11: funcionalidades de mantenimiento de la parte, y detalle de ADR-P5)

- **Historias nuevas, en `draft`:** US-029 (datos de contacto de las partes, CONDITIONAL), US-030 (plazas, CONDITIONAL), US-031 (ocupaciones de plaza, CONDITIONAL), US-032 (roles de la parte, CONDITIONAL), US-033 (corregir el vínculo usuario–persona, READY) y US-034 (relaciones entre partes, CONDITIONAL). Las pidió el responsable funcional.
  - **Conflicto sin resolver:** el responsable indicó «contactos de las Party (Person u Organization)», pero BR-121 dice que solo las personas tienen contactos. Se recoge en US-029-Q1 y no se cambió BRC-001.
  - **Hipótesis de actor:** ninguna regla dice quién mantiene contactos, plazas, ocupaciones, roles y relaciones; las historias suponen Jefe de Ingeniería o ADMIN (BR-002 por analogía). Solo US-033 tiene actor sostenido (BR-129).
  - **Falta** una historia que registre las organizaciones (BR-072).
- **`architecture/adr/ADR-P5-anexo-mapa-rol-permiso-propuesta.md`** (nuevo, `draft`): detalle de ADR-P5 con el mapa rol-permiso derivado de BRC-001 y seis brechas. La más importante: ADR-P5 pide validar el rol del usuario en cada servicio y ADR-P9 hace que el BFF llame con un JWT de máquina, así que el servicio no recibe la identidad del usuario. **No modifica ADR-P5, que sigue sin aprobarse.**
- **Handoff de base de datos** (`architecture/handoffs/db-p3m/`) regenerado: 32 historias, 20 elementos abiertos, ADR aprobados reflejados, OI-18 (ADR-P5 frente a ADR-P9) y OI-19 (contactos de organizaciones) nuevos. Recomendación sin cambios: READY_WITH_OBSERVATIONS, decisión del Solution Architect pendiente.
- **Seguridad** aceptó el aplazamiento de datos personales (DT-01), según ianache; no consta el nombre del aceptante ni una referencia.

## 2026-10-12 (aprobaciones del responsable funcional)

- **ADR aprobados por ianache:** ADR-P2, ADR-P3, ADR-P6, ADR-P7, ADR-P9, ADR-DB-001, ADR-DB-002 y ADR-DB-003. Lo hace en su rol de responsable funcional; sigue sin constar la revisión de un arquitecto distinto. **ADR-P5 no se aprobó:** sigue en revisión (propuesta de mapa rol-permiso). ADR-P4 sigue pendiente.
- **Verificación aprobada por ianache:** IMD-001, BRC-001 (BR-001 a BR-130), RCP-001 (D-133 a D-159) y las historias US-004, US-009, US-010, US-019, US-021 y US-025. Pasan a `approved`. Las preguntas abiertas no bloquearon la verificación.

## 2026-10-12 (handoff de la base de datos a desarrollo)

- **`architecture/handoffs/db-p3m/`** (nuevo, `draft`): Development Context Pack, `pack.yaml`, mapa de trazabilidad, evaluación READY_FOR_DEV, informe de traspaso y elementos abiertos, generados con architecture-development-handoff. Alcance: 26 historias, 7 esquemas, 16 reglas de arquitectura (`PROPOSED`), 16 criterios de aptitud y 17 elementos abiertos. **Recomendación: READY_WITH_OBSERVATIONS.** La decisión humana del Solution Architect está pendiente.
- **index.md:** se añade la sección «Diseño de base de datos» con los artefactos de `data/`, que no estaban indexados, y el handoff.

## 2026-10-12 (cierre de la revisión del diseño de base de datos)

- **INF-P3M-001 0.1.2:** INF-DEC-23, dos clases de falla (opción A elegida por ianache). El 99,9 % de disponibilidad rige las fallas normales, con una réplica de MySQL con conmutación automática y replicación semisíncrona o de grupo; el RTO de 4 h y el RPO de 1 h rigen el desastre. Se alinean las secciones que aún decían `UNKNOWN` para RTO y RPO.
- **RPT-DDR-001:** `DATABASE_DESIGN_APPROVED` pasa a `PASSED` con riesgos residuales aceptados (R-10 como DT-04, R-05 como DT-01, R-03 como DT-03 y la carga parcial como DT-02). No significa que la recuperación esté verificada. No cubre la verificación humana de IMD-001, BRC-001, RCP-001 ni las historias, que siguen en `draft`.

## 2026-10-12 (aprobación del diseño de base de datos y localizadores)

- **Aprobación humana (D-H36):** ianache aprueba el diseño de base de datos (DDP-001 a PDM-001 y los scripts de `flyway/`). El gate `DATABASE_DESIGN_APPROVED` sigue en `REQUIRES_REVIEW` por R-10 (evidencia operativa). La aprobación no verifica IMD-001, BRC-001, RCP-001 ni las historias, que siguen en `draft`.
- **Historias:** se corrigieron 18 localizadores de línea hacia BRC-001 que estaban desfasados tres líneas (US-017, US-020, US-024, US-026, US-027, US-028). Solo cambian los números de línea, no el texto de las reglas.

## 2026-10-12 (historias afectadas por las decisiones del diseño de base de datos)

- **US-004, US-009, US-010, US-019, US-021 y US-025** actualizadas con af-user-story-refiner. Pasan a `draft` y pierden `verified`: la verificación del 2026-10-10 corresponde a la versión anterior. Siguen en estado de preparación READY.
  - **US-004:** el historial de rol/nivel lo conserva la plaza (BR-110); datos de contacto, baja y correo único quedan para una historia aparte; G-06 cerrada y G-11 cerrada en parte.
  - **US-009:** AC-4, volver a enrolarse (BR-122); el enrolamiento lleva avance, nota y comentarios (BR-123); el usuario sin colaborador vuelve al login (BR-107).
  - **US-010:** se registra BR-122; pregunta nueva US-010-Q2 sobre si el desenrolamiento borra el registro (BR-101).
  - **US-019:** los roles/niveles requeridos los define el Jefe de Ingeniería o un ADMIN (BR-109); costo en soles y esfuerzo en horas-persona (BR-127); un solo jefe de proyecto vigente (BR-102); RQ-32 abierta.
  - **US-021:** AC-8 con los estados de la asignación (BR-111); G-08 cerrada y retirada de las exclusiones; BR-046 actualizada.
  - **US-025:** AC-3 a AC-5, vínculo del usuario con la persona por el correo (BR-125), caso sin persona ni rol (BR-107) y vínculo fijo (BR-129); sin registro libre (BR-128); US-025-Q2 nueva.
- **RCP-001:** las fuentes S-19 y S-20 se describen después de la tabla de decisiones y no en la lista de la sección 2, para no desplazar las líneas que citan otros documentos. Se corrigieron los localizadores de EVD-2026-0143 a EVD-2026-0169 en BRC-001.
- **BRC-001:** BR-122 pierde el matiz «mientras haya cupo», que no estaba en la decisión.
- **Pendiente:** los issues de GitLab de US-004 (#17), US-019 (#19) y US-025 (#21) y la trazabilidad del sprint (TRC-SSP-001) reflejan la versión anterior. 21 localizadores de línea de BRC-001 en US-017, US-019, US-020, US-021, US-024, US-026, US-027 y US-028 estaban desfasados tres líneas; se corrigieron los de las historias actualizadas.

## 2026-10-12 (registro de las decisiones del diseño de base de datos, RPT-DDR-001 R-06)

- **RCP-001:** D-143 a D-159 y fuente S-20: evidencia de proyecto solo por URL, un perfil por rol, nivel de desarrollo dentro del seniority, datos de la plaza, una organización es parte de una sola, descripción de la evidencia esperada, roles sin solapes, contactos solo de personas, re-enrolamiento, enrolamiento con avance, nota y comentarios, solicitud y promoción, vínculo del usuario con la persona por el correo, nota de 0 a 20, costo en soles y esfuerzo en horas-persona, sin registro libre de cuentas, vínculo fijo con corrección del Jefe de Ingeniería, y baja de contactos.
- **BRC-001:** BR-114 a BR-130 nuevas (130 reglas), EVD-2026-0153 a EVD-2026-0169. RQ-03, RQ-05, RQ-07 y RQ-08 cerradas; RQ-02, RQ-04, RQ-22 y RQ-30 cerradas en parte; RQ-33 y RQ-34 actualizadas; RQ-35 nueva (issues «Proyecto» y campos de BR-038, deuda técnica DT-03).
- **IMD-001:** R-91 nueva (solicitud y promoción). R-01, R-04 y R-06 pasan a FACT; R-80, R-82 y R-83 se precisan. IM-Q6, IM-Q9 y IM-Q26 cerradas; IM-Q28 parcial. Las citas de decisiones de diseño pasan a citar reglas BR-101 a BR-130. El modelo sigue en `draft`.
- **Fuera del registro de negocio** (solo en los documentos de diseño): la fila de bloqueo por colaborador, la regla del evento de promoción obsoleto, los identificadores y las decisiones de diseño físico.

## 2026-10-11 (diseño de base de datos: decisiones D-H1 a D-H13 en el modelo conceptual)

- **IMD-001:** R-24 retirada (la certificación es un resultado emitido, no una evidencia aportada). R-39, R-46, R-55, R-83, R-85 y R-86 actualizadas. R-88 a R-90 nuevas (evaluador y jefe de proyecto como roles de la parte; la promoción cambia el rol/nivel de la plaza). Estados de Asignación, Solicitud de promoción y Carga. IM-Q2, Q8, Q10, Q11 y Q19 cerradas, IM-Q27 y Q29 parciales, IM-Q30 nueva. El modelo vuelve a `draft` y pierde `verified`.
- **RCP-001:** D-133 a D-142 y fuente S-19 (retención de datos personales, jefe de proyecto vigente, evidencia como URL, certificación como resultado emitido, una persona por plaza, acceso sin colaborador, roles de la parte, quién define los roles/niveles, plaza que cambia de nivel, estados). Las decisiones D-H6, D-H9 y D-H10 son de diseño de dominio y quedan solo en DDP-001 y DDM-001.
- **BRC-001:** BR-101 a BR-113 nuevas (113 reglas), EVD-2026-0143 a EVD-2026-0152, BR-046 y BR-079 ajustadas, contradicciones C-09 y C-10, RQ-30 cerrada en parte y RQ-32 a RQ-34 nuevas. El catálogo vuelve a `draft` y pierde `verified`.

## 2026-10-11 (RQ-29: aviso, cierre global y trabajo en curso)

- **RCP-001:** D-132. **BRC-001:** BR-098 a BR-100 nuevas (100 reglas), EVD-2026-0142, RQ-29 cerrada en parte y RQ-31 nueva (tiempo de sesión, anticipación del aviso, renovación y alcance del cierre global). **US-028:** AC-4 a AC-6. Se actualizaron las referencias de ASR-02, ADR-03, INF-P3M-001 y DSP-001 a RQ-31. US-028 conserva su estado `draft`.

## 2026-10-11 (DSP-001)

- **DSP-001** (nuevo, `REQUIRES_REVIEW`, alcance `DRAFT`): alcance candidato de desarrollo con 28 historias, 108 criterios y 9 olas por dependencia, exclusiones, restricciones de arquitectura y bloqueos. Las URL de las fuentes quedan pendientes (`PENDIENTE-URL-BASE/`). No se asignó Sprint.

## 2026-10-11 (plazas por organización, Position del UDM)

- **RCP-001:** D-130 y D-131. **BRC-001:** BR-097 nueva, BR-047 y BR-079 ajustadas, EVD-2026-0140 y EVD-2026-0141, RQ-30 nueva. **GLS-001:** términos nuevos TRM-0063 (Plaza) y TRM-0064 (Ocupación de plaza), nota de TRM-0006. **IMD-001:** conceptos Plaza y Ocupación de plaza, el rol/nivel pasa a ser el tipo de puesto, R-08 retirada y R-84 a R-87 nuevas, IM-Q25 cerrada e IM-Q28 e IM-Q29 nuevas. Se actualizó el texto de BR-047 y BR-079 en las historias que lo citan.

## 2026-10-11 (el modelo conceptual se alinea con Party Management del UDM)

- **RCP-001:** D-129. **IMD-001:** conceptos nuevos Parte, Persona, Rol de la parte y Relación entre partes; «reporta a», «membership» y «es parte de» pasan a ser tipos de la relación entre partes; los contactos cuelgan de la persona y el usuario identifica a la persona. R-65 a R-69 retiradas y R-76 a R-83 nuevas. La sección 5.1 documenta la correspondencia y los desvíos corregidos. Preguntas nuevas IM-Q25 a IM-Q27.
- **GLS-001:** términos nuevos TRM-0059 a TRM-0062 (`draft`, `gap` hasta consultar una fuente N1 del UDM). Notas de TRM-0002, TRM-0050, TRM-0051 y TRM-0052 actualizadas.

## 2026-10-11 (ARS pasa a ASR y ruta de Vault)

- **RCP-001:** D-127 (la ruta de Vault pasa a `secret/p3m/*`) y D-128 (ARS se llama ASR).
- **ASR:** `architecture/ars/` y CAT-ARS-001 se reemplazan por `architecture/asr/asr-catalog.md` y 20 archivos `asr-NN.md`, conforme al skill asr-discovery (catálogo y un archivo por candidato). Cada ASR es un candidato con disposición humana pendiente; se separan las restricciones de los candidatos. Los IDs pasan de ARS-NN a ASR-NN y se actualizaron los enlaces de los ADR, EVA-001, INF-P3M-001 y el índice. Las entradas anteriores de este changelog conservan el nombre «ARS».
- **Vault:** `secret/ppm/*` pasa a `secret/p3m/*` en los ADR, el catálogo de ADR y el documento de infraestructura. INF-Q16 cerrada.

## 2026-10-11 (la solución pasa a llamarse P3M)

- **RCP-001:** D-126. La solución se llama **P3M (People, Product and Project Management)**, porque no es solo capacitación. Se reemplazaron los nombres «portal de gestión de currícula» y «PPM» en títulos, descripciones y textos de 67 archivos. Las entradas anteriores de este changelog conservan el nombre de su época.
- **Nombres de archivo e IDs sin cambios:** `RCP-001-portal-gestion-curricula-desarrollo.md`, `BRC-001-…-portal-curricula.md` e `IMD-001-portal-curricula.md` conservan su nombre para no romper los enlaces y los IDs permanentes. Se renombró solo el archivo recién creado de infraestructura a `INF-P3M-001`.
- **Glosario:** la definición de TRM-0001 (Portal) cambió, así que vuelve a `draft` y pierde `verified`. P3M es su sinónimo.
- **Pendiente:** la ruta `secret/ppm/*` de Vault se mantiene hasta decidir si pasa a `secret/p3m/*` (INF-Q16).

## 2026-10-11 (arquitectura de infraestructura)

- **INF-P3M-001** (nuevo, `REQUIRES_REVIEW`): arquitectura de infraestructura lógica del portal, con 21 decisiones INF-DEC (algunas pendientes), 3 diagramas, 6 zonas de red y su tabla de flujos, 13 riesgos, pruebas de verificación y 15 preguntas abiertas (INF-Q01 a INF-Q15). No se inventaron cifras de disponibilidad, RTO/RPO, capacidad ni costos.

## 2026-10-11 (ARS y ADR en archivos independientes)

- Se separaron los 20 ARS en `architecture/ars/` y las 26 decisiones (15 tomadas y 11 pendientes) en `architecture/adr/`, un archivo por elemento y en OKF v0.2. Los catálogos CAT-ARS-001 y CAT-ADR-001 quedan como índices con enlaces. El contenido no cambió.

## 2026-10-11 (evaluación del API Gateway y secretos, protocolo y contenedores)

- **RCP-001:** D-122 a D-125 y anexo C ampliado. **BRC-001:** RQ-09 cerrada (PAT de GitLab y URL base en Vault).
- **EVA-001** (nuevo, `draft`): evaluación de Kong OSS y KrakenD CE para el ADR-14, con criterios, puntuación, recomendación (KrakenD CE) y una prueba de concepto.
- **CAT-ARS-001:** ARS-17 a ARS-19 ajustados y ARS-20 nuevo (contenerización). 20 ARS. **CAT-ADR-001:** ADR-12 a ADR-14 ajustados, ADR-15 nuevo (contenedores) y ADR-P7 a ADR-P11 acotados. 15 decididos y 11 pendientes.

## 2026-10-11 (Vault, protocolo de confianza y API Gateway)

- **RCP-001:** D-119 a D-121 y anexo C ampliado.
- **CAT-ARS-001:** ARS-17 (Vault), ARS-18 (protocolo de confianza BFF–microservicios) y ARS-19 (API Gateway con JWT de Keycloak). 19 ARS y 11 vacíos.
- **CAT-ADR-001:** ADR-12, ADR-13 y ADR-14, y pendientes ADR-P8 a ADR-P11 (elegir Kong o KrakenD, protocolo de confianza, terceros y API expuestas, gestión de secretos). 14 decididos y 11 pendientes. Son restricciones de arquitectura: no cambian reglas, glosario, modelo ni historias.

## 2026-10-11 (ARS y ADR)

- **CAT-ARS-001** (nuevo, `draft`): 16 requisitos arquitectónicamente significativos, con su atributo de calidad, fuente y estado, y 8 vacíos que condicionan la arquitectura.
- **CAT-ADR-001** (nuevo, `draft`): 11 decisiones de arquitectura tomadas (ADR-01 a ADR-11) y 7 pendientes (ADR-P1 a ADR-P7). No se inventaron alternativas ni motivos que las fuentes no dan.
- **index.md:** sección Arquitectura y cifras de BRC-001 e IMD-001 al día.

## 2026-10-11 (pila tecnológica)

- **RCP-001:** D-118 y anexo C ampliado: MySQL 8.x, Redis para el caching en el BFF y microservicios en Python con FastAPI. Son restricciones de arquitectura, no reglas de negocio: no cambian reglas, glosario, modelo conceptual ni historias.

## 2026-10-11 (ingreso seguro, cierre de sesión y arquitectura)

- **RCP-001:** D-115 a D-117 y anexo C con las restricciones de arquitectura (SPA Angular, BFF Next.js, PKCE, micro UI, Atomic Design). **BRC-001:** BR-095 y BR-096 nuevas (96 reglas, 121 evidencias), RQ-29 nueva. **GLS-001:** términos nuevos BFF, PKCE, SPA, Atomic Design y Micro UI (58 en total, `draft`) y GQ-12 (forma completa de BFF, PKCE y SPA). **US-027** (ingreso) y **US-028** (cierre de sesión) nuevas, READY y en `draft`. **US-025** ahora depende de US-027. El modelo conceptual no cambia: son aspectos técnicos de la arquitectura, no conceptos de negocio.

## 2026-10-10 (aviso de datos, tope de dedicación y primera carga)

- **RCP-001:** D-112 a D-114, G-27 cerrada. **BRC-001:** BR-092 a BR-094 nuevas (94 reglas, 118 evidencias), RQ-27 cerrada y RQ-09 parcial (faltan las credenciales de solo lectura). **IMD-001:** IM-Q23 cerrada. **TRM-0034 y TRM-0047** actualizados. **US-020, US-021 y US-024** actualizadas. US-020-Q2 cerrada.

## 2026-10-10 (IM-Q24, RQ-19 y G-27 parcial)

- **RCP-001:** D-108 a D-111 y anexo B (reintentos y circuit breaker según buenas prácticas). **BRC-001:** BR-090 y BR-091 nuevas, BR-082 y BR-083 ajustadas (91 reglas, 115 evidencias), RQ-19 cerrada. **IMD-001:** R-36, R-72 y R-73 en FACT, IM-Q4 e IM-Q24 cerradas. **US-019, US-020 y US-026** actualizadas. Siguen abiertas RQ-09 (qué muestra el portal si GitLab no responde) y RQ-27 (tope de dedicación), que no respondiste.

## 2026-10-10 (RQ-28: datos, obligatoriedad e historial de la evaluación de desempeño)

- **RCP-001:** D-105 a D-107. **BRC-001:** BR-087 a BR-089 nuevas (89 reglas), 111 evidencias, RQ-28 cerrada. **TRM-0053** (`draft`) y **IMD-001** (R-71, R-74, nueva R-75; 75 relaciones) actualizados. **US-026** (AC-6 y AC-7) y **US-017** (nuevo criterio: no se promueve sin evaluación) actualizadas. US-017 conserva `verified`; conviene revalidarla.

## 2026-10-10 (RQ-26: evaluación de desempeño)

- **RCP-001:** D-101 a D-104. **BRC-001:** BR-083 a BR-086 nuevas (86 reglas), 108 evidencias, RQ-26 cerrada y RQ-28 nueva. **GLS-001:** término TRM-0053 (53 en total; `draft`), GQ-11 cerrada. **IMD-001:** concepto EVALUACION_DE_DESEMPENO y R-70 a R-74 (74 relaciones), IM-Q22 cerrada e IM-Q24 nueva. **US-026** nueva (READY, `draft`).

## 2026-10-10 (RQ-19: reintentos de la carga de GitLab)

- **RCP-001:** D-100. **BRC-001:** BR-082 nueva (82 reglas), EVD-2026-0122 (104 evidencias), RQ-19 acotada. **TRM-0047** (solo Notas), **IMD-001** y **US-020** (AC-6) actualizados. Sigue abierto: retención de logs, qué muestra el portal si GitLab no responde y los parámetros del circuit breaker.

## 2026-10-10 (G-28: quién registra los roles/niveles de un proyecto)

- **RCP-001:** D-99, G-28 cerrada. **BRC-001:** BR-046 ajustada, EVD-2026-0121 (103 evidencias), RQ-10 cerrada. **IMD-001:** R-39. **US-019:** AC-3 con el Jefe de Proyecto como quien registra, y propuesta de división. RQ-19 se mantiene abierta: trata de reintentos y logs de la carga de GitLab, no de G-28.

## 2026-10-10 (G-06, G-08, V-01, V-02, V-03 y RQ-17)

- **RCP-001:** D-92 a D-98 y anexo A con los valores sugeridos de `status`, `domain` e `impact_level` (V-01). G-06, G-08, V-01, V-02 y V-03 cerradas. Nueva G-38 pendiente: definir la evaluación de desempeño.
- **BRC-001:** 81 reglas (BR-079 a BR-081 nuevas; BR-057 y BR-059 ajustadas), 102 evidencias. RQ-14 y RQ-17 cerradas, RQ-26 y RQ-27 nuevas.
- **GLS-001:** las definiciones de Sumilla, Competencia y Asignación cambiaron, por eso esos 3 términos vuelven a `draft` y pierden `verified`. TRM-0002 y TRM-0026 actualizados en Notas. GQ-09 cerrada y GQ-11 nueva (evaluación de desempeño).
- **IMD-001:** R-08 con historial, concepto Asignación con porcentaje, Competencia con indicador, IM-Q22 e IM-Q23.
- **US-002, US-004, US-006 y US-021** actualizadas. Conservan su `verified`, pero conviene revalidarlas.

## 2026-10-10 (C-05: fechas de la edición)

- **RCP-001:** D-91. **BRC-001:** C-05 resuelta (no quedan contradicciones abiertas), RQ-12 cerrada, EVD-2026-0114 (96 evidencias). **GLS-001:** GQ-05 cerrada y nota de TRM-0013 actualizada (la definición no cambia). **US-008:** supuesto S-1 confirmado y RQ-12 cerrada. Los artefactos ya aprobados conservan su `verified`; se recomienda revalidar US-008 y BRC-001.

## 2026-10-10 (aprobación)

- Por solicitud expresa de ianache (Functional Analysis), se marcan como aprobados (`status: approved` y `verified`) los 52 términos del glosario y su catálogo GLS-001, el catálogo de reglas BRC-001, el modelo IMD-001, las 25 User Stories y el pack RCP-001. Las preguntas abiertas y la contradicción C-05 siguen abiertas. El Jefe de Ingeniería, responsable funcional, no figura como aprobador.

## 2026-10-10 (una sola membresía vigente)

- **RCP-001:** D-90. **BRC-001:** BR-076 ajustada, 95 evidencias, RQ-25 cerrada. **GLS-001:** TRM-0050 actualizado. **IMD-001:** R-68 con una membresía vigente como máximo, IM-Q21 cerrada.

## 2026-10-10 (varios contactos y vigencia de la membresía y de la asignación)

- **RCP-001:** D-87 a D-89. **BRC-001:** 78 reglas (BR-078 nueva; BR-070 y BR-076 ajustadas), 94 evidencias. RQ-24 cerrada y RQ-25 nueva.
- **GLS-001:** TRM-0034, TRM-0050 y TRM-0051 actualizados. **IMD-001:** R-66 y R-68 ajustadas (R-68 pasa a N : M en el tiempo), concepto Asignación con vigencia, IM-Q20 cerrada e IM-Q21 nueva. **US-021** agrega el criterio de vigencia (AC-5).

## 2026-10-10 (colaborador siempre con usuario, GUID en el usuario, Instructor como rol de usuario)

- **RCP-001:** D-84 a D-86. **BRC-001:** 77 reglas (BR-077 nueva; BR-062, BR-073, BR-074 y BR-075 ajustadas), 91 evidencias. C-08 resuelta, RQ-23 cerrada y RQ-22 acotada.
- **GLS-001:** TRM-0052, TRM-0016 y TRM-0037 actualizados. **IMD-001:** R-69 pasa a 1 : 0..1 y el usuario mantiene el GUID, IM-Q19 acotada. **US-025** actualizada con el rol Instructor.

## 2026-10-10 (contactos obligatorios, «reporta a» y membresía)

- **RCP-001:** D-81 a D-83. **BRC-001:** 76 reglas (BR-076 nueva; BR-070, BR-071 y BR-072 ajustadas), 88 evidencias. RQ-21 cerrada y RQ-24 nueva. **GLS-001:** TRM-0050, TRM-0051 y TRM-0002 actualizados. **IMD-001:** R-65, R-66 y R-68 ajustadas, IM-Q18 cerrada e IM-Q20 nueva.

## 2026-10-10 (registro del usuario al iniciar sesión)

- **RCP-001:** D-80. **BRC-001:** 75 reglas (BR-074 y BR-075 nuevas), 85 evidencias. Contradicción C-08 abierta (el Instructor como rol de usuario) y preguntas RQ-22 y RQ-23.
- **GLS-001:** término nuevo TRM-0052 (Usuario), 52 en total. **IMD-001:** concepto USUARIO y relación R-69 (69 en total), IM-Q19.
- **US-025** (nueva, READY): registrar al usuario autenticado al iniciar sesión.

## 2026-10-10 (colaboradores, contactos, organizaciones y GUID alineados con UDM)

- **RCP-001:** D-76 a D-79.
- **BRC-001:** 73 reglas (BR-070 a BR-073 nuevas), 84 evidencias. RQ-20 cerrada y RQ-21 nueva.
- **GLS-001:** términos nuevos TRM-0050 (Organización) y TRM-0051 (Dato de contacto), 51 en total. TRM-0002 y TRM-0037 actualizados.
- **IMD-001:** conceptos ORGANIZACION y DATO_DE_CONTACTO, relaciones R-65 a R-68 (68 en total). IM-Q14 a IM-Q17 cerradas e IM-Q18 nueva. Sección 5.1 actualizada.

## 2026-10-10 (quién ve la ejecución de GitLab)

- **RCP-001:** D-75. **BRC-001:** BR-069 (69 reglas, 80 evidencias). **US-024** pasa a READY: la ejecución la ven el Jefe de Ingeniería y los ADMIN. Con esto, las 24 historias están READY (a la espera de validación humana). Ninguna tiene `verified`.

## 2026-10-10 (alineación del registro de colaboradores con el UDM)

- **RCP-001:** decisión D-74.
- **GLS-001:** término nuevo TRM-0049 (UDM, `gap` hasta consultar una fuente N1) y pregunta GQ-10. 49 términos.
- **IMD-001:** sección 5.1 con la correspondencia entre conceptos del portal y construcciones del UDM, y preguntas IM-Q14 a IM-Q17 (relaciones entre colaboradores, contactos, organización e identificadores). Sin cambios en conceptos ni relaciones.
- **BRC-001:** pregunta RQ-20. Sin reglas nuevas, porque no hay una fuente que defina qué datos adicionales se registran.

## 2026-10-10 (carga automática de GitLab, codificador vacío y solicitud de promoción)

- **RCP-001:** E-94 a E-97 y D-70 a D-73. G-33 cerrada. Las citas cortas de línea al pack se desplazaron y se corrigieron.
- **BRC-001:** 68 reglas (BR-065 a BR-068 nuevas), 79 evidencias. RQ-18 cerrada y RQ-19 nueva.
- **GLS-001:** términos nuevos TRM-0047 (Carga automática de GitLab) y TRM-0048 (Solicitud de promoción), 48 en total. `glossary.py check`: 0 errores.
- **IMD-001:** conceptos SOLICITUD_DE_PROMOCION y CARGA_DE_GITLAB, relaciones R-60 a R-64 (64 en total). `check_model.py`: 0 errores y 0 avisos.
- **US-020** se redefine como la carga automática con consola de logs y reintento (READY). Lo que era la visualización de milestones e issues pasa a **US-024** (NOT READY: no se dijo quién la ve). **US-023** y **US-014** quedan sin preguntas bloqueantes. Ninguna historia tiene `verified`.

## 2026-10-10 (respuestas sobre quién mantiene el portafolio, jefe de proyecto y GitLab)

- **RCP-001:** fuente S-18, evidencias E-90 a E-93 y decisiones D-65 a D-69. Productos, proyectos y codificadores los mantiene el Jefe de Ingeniería o un ADMIN. Los roles de usuario son ADMIN, Instructor y Jefe de Ingeniería. El jefe de proyecto se registra con historial y vigencia. Las evidencias también sustentan una solicitud de promoción. GitLab se consulta de forma automática cada 30 s por defecto (reemplaza la sincronización horaria, D-26). G-14 cerrada y G-33 cerrada en parte. Las citas de línea al pack se desplazaron una fila y se actualizaron.
- **BRC-001:** 64 reglas (BR-061 a BR-064 nuevas, BR-039 reescrita) y 75 evidencias. RQ-04 parcial y RQ-18 nueva.
- **GLS-001:** TRM-0027, TRM-0028, TRM-0036 y TRM-0039 actualizados. `glossary.py check`: 0 errores.
- **IMD-001:** R-55 y R-58 ajustadas, R-60 nueva (60 relaciones), IM-Q13 nueva. `check_model.py`: 0 errores y 0 avisos.
- **US-014, US-015, US-018, US-019, US-023:** pasan a READY. US-014 agrega la solicitud de promoción (AC-3) y US-019 agrega el registro del jefe de proyecto (AC-4). **US-020** sigue NOT READY: la consulta es automática, pero no se dijo qué usuarios ven la ejecución (US-020-Q1). Ninguna historia tiene `verified`.

## 2026-10-10 (segunda tanda de User Stories)

- **US-014 a US-023** (`requirements/user-stories/`): 10 historias nuevas en `draft`, sobre evidencias de proyecto, valoración, promoción de nivel, productos, proyectos, GitLab, asignación y excepciones. Preparación: 4 READY (US-016, US-017, US-021, US-022), 2 CONDITIONAL (US-014, US-015) y 4 NOT READY (US-018, US-019, US-020, US-023). Las NOT READY esperan quién mantiene el portafolio y el codificador (US-018-Q1, US-020-Q1 y US-023-Q1). No se asignó `verified` a ninguna.

## 2026-10-10 (tipo único, evidencias en la rúbrica y «evidencia esperada»)

- **RCP-001:** E-86 a E-89 y decisiones D-61 a D-64. La competencia tiene un tipo único. Las evidencias se definen en la rúbrica. «Requerida» es sinónimo de «mandatoria». Una competencia general puede estar en más de un perfil. G-34, G-35 y G-36 cerradas, G-37 en parte.
- **GLS-001:** el término TRM-0040 pasa de «Evidencia requerida» a **«Evidencia esperada»** (mismo ID, archivo nuevo `TRM-0040-evidencia-esperada.md`), y «requerida» queda como sinónimo de Evidencia obligatoria. GQ-10 y GQ-11 cerradas. `glossary.py check`: 0 errores.
- **BRC-001:** 60 reglas (BR-060 nueva; BR-015, BR-056 y BR-058 reescritas) y 89 evidencias. C-06 y C-07 resueltas. RQ-15 y RQ-16 cerradas.
- **IMD-001:** R-02 pasa a N:M, R-22 retirada, el concepto EVIDENCIA_REQUERIDA pasa a EVIDENCIA_ESPERADA. IM-Q12 cerrada. `check_model.py`: 0 errores y 0 avisos.
- **User Stories:** US-002 (competencia general en varios perfiles) y US-007 actualizadas. Las 13 siguen READY.

## 2026-10-10 (rúbricas, evidencias como issues y competencias con tipo)

- **RCP-001:** E-79 a E-85, decisiones D-55 a D-60 y preguntas G-34 a G-37. El Jefe de Ingeniería define también el nivel mínimo, las evidencias requeridas y los objetivos. El colaborador registra evidencias de curso como referencias a issues cerrados. Un curso tiene código, nombre, sumilla y objetivos, y cada objetivo define una rúbrica por nivel de logro.
- **GLS-001:** 46 términos (nuevos: Tipo de competencia, Rúbrica y Sumilla, esta última en `gap`). GQ-09 a GQ-11 abiertas. `glossary.py check`: 0 errores.
- **BRC-001:** 59 reglas (BR-056 a BR-059 nuevas) y 85 evidencias. Contradicciones nuevas C-06 y C-07 y preguntas RQ-15 a RQ-17.
- **IMD-001:** 34 conceptos y 59 relaciones. Nuevo concepto Rúbrica. IM-Q5 cerrada e IM-Q12 abierta. `check_model.py`: 0 errores y 0 avisos. Los 4 diagramas se renderizaron.
- **User Stories:** US-007 se rehízo como «Definir la rúbrica de cada objetivo de un curso» (nuevo archivo, mismo ID). US-013 nueva («Registrar evidencias del logro de un objetivo en una edición»). US-002, US-003, US-006 y US-011 actualizadas. Las 13 historias quedan READY.

## 2026-10-10 (Jefe de Ingeniería define perfiles, cursos y ediciones)

- **RCP-001:** se agregó E-78 y la decisión D-54: el Jefe de Ingeniería define los perfiles de competencias, los cursos y las ediciones.
- **BRC-001:** nueva regla BR-055 (55 reglas y 78 evidencias). **GLS-001:** se actualizó el término Jefe de Ingeniería. **IMD-001:** se agregó BR-055 a la sección 6. Verificadores en 0 errores.
- **US-002, US-003, US-006, US-007 y US-008** pasan de NOT READY a READY: el actor ya está respaldado (BR-055) y se cerró US-002-Q1. US-003 y US-007 llevan el supuesto S-1 (el nivel mínimo y las evidencias requeridas forman parte del perfil y del curso). Cada una gana un criterio de permiso. US-011 queda CONDITIONAL.

## 2026-10-10 (User Stories)

- **US-001 a US-012** (`requirements/user-stories/`): primera tanda de 12 User Stories en estado `draft`, sobre roles, competencias, colaboradores, cursos, ediciones, enrolamiento, evidencias y certificación. Preparación: 6 READY (US-001, US-004, US-005, US-009, US-010, US-012), 1 CONDITIONAL (US-011) y 5 NOT READY (US-002, US-003, US-006, US-007, US-008). Las 5 NOT READY esperan la respuesta a US-002-Q1 (quién define perfiles, cursos y ediciones). No se asignó `verified` a ninguna.

## 2026-10-10 (segunda actualización)

- **RCP-001:** se confirmaron todas las hipótesis (salvo H-13, descartada) y los supuestos A-01 y A-02. Se agregaron E-65 a E-77 y las decisiones D-48 a D-53. Se cerraron las preguntas N-14 y las de valoración, promoción en el curso, evidencias y tareas de planning.
- **TRM-0040 a TRM-0043** (glosario): nuevos términos Evidencia requerida, Evidencia aportada, Brecha de cumplimiento y Tarea de planning. Se actualizaron las definiciones de Evidencia, Valoración de cumplimiento, Certificación de curso, Promoción en el curso, Sprint y otras. `glossary.py check`: 0 errores. GQ-03, GQ-04 y GQ-06 cerradas.
- **BRC-001** (reglas): 54 reglas (BR-045 a BR-054 nuevas, IDs anteriores estables) y 77 evidencias. 4 de 5 contradicciones resueltas. RQ-01, RQ-11 y RQ-13 cerradas.
- **IMD-001** (modelo): 33 conceptos y 55 relaciones. La valoración pasa a concepto registrado, se separan la evidencia requerida y la aportada, se agrega la tarea de planning y la promoción en el curso se fusiona con la certificación. R-17, R-18 y R-32 retiradas. `check_model.py`: 0 errores y 0 avisos. Los 4 diagramas se renderizaron con mermaid-cli.

## 2026-10-10

- **RCP-001** (requisitos): creado el Requirement Context Pack del portal de gestión de currícula, con 64 evidencias y 47 decisiones del responsable funcional. Se movió a `requirements/context-packs/`.
- **GLS-001 / TRM-0001 a TRM-0039** (glosario): creados 39 términos en estado `draft`, con fuente N2 (RCP-001). `glossary.py check`: 0 errores. Ningún término está aprobado.
- **BRC-001** (reglas): creado el catálogo con 44 reglas (BR-001 a BR-044) y 64 evidencias (EVD-2026-0001 a EVD-2026-0064). Estado: CONDITIONAL.
- **IMD-001** (modelo conceptual): creado el modelo con 29 conceptos y 45 relaciones en 4 diagramas. `check_model.py`: 0 errores y 0 avisos. Los 4 diagramas se renderizaron con mermaid-cli. Estado: CONDITIONAL.
- **Promoción de conocimiento:** los 4 Knowledge Candidates del RCP-001 se promovieron a conocimiento canónico (estado `draft`) a pedido del responsable funcional. No se asignó `verified` a ningún artefacto.
