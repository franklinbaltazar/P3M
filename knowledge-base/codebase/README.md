Colocar en esta carpeta git clone de los diferentes componentes de toda la solucion.

Cada componente es un repositorio independiente de GitLab (esta carpeta está ignorada por el repositorio de la base de conocimiento). Esqueletos generados el 2026-10-13 desde `design/` y `data/`:

| Carpeta | Qué es | Stack | Diseño de origen |
|---|---|---|---|
| `p3m-local/` | Entorno local: todos los componentes en Docker Compose (QA, PRE y PROD van en Kubernetes 1.33.x sobre Oracle OKE) | Docker Compose | INF-P3M-001 (INF-DEC-24 a 28) |
| `p3m-portal-web/` | Shell y 5 micro UI con la biblioteca `@comsatel/p3m-ui` | Angular 22, Native Federation | SCR-001, SCR-002, FLW-001, FLW-002 |
| `p3m-bff/` | BFF: sesión, PKCE con Keycloak, paso y vistas compuestas | Next.js 16, TypeScript | API-PRP-006 |
| `p3m-svc-partes-identidad/` | CTX-01 Partes y organización y CTX-02 Identidad de acceso | **Python/FastAPI: OBSOLETO** (ADR-16 → Java 24, Spring Boot 4.0.8) | API-PRP-001 |
| `p3m-svc-curricula/` | CTX-03 Currícula | **Python/FastAPI: OBSOLETO** | API-PRP-002 |
| `p3m-svc-formacion-progresion/` | CTX-04 Formación y CTX-05 Progresión | **Python/FastAPI: OBSOLETO** | API-PRP-003 |
| `p3m-svc-portafolio/` | CTX-06 Portafolio y asignación | **Python/FastAPI: OBSOLETO** | API-PRP-004 |
| `p3m-svc-gitlab/` | CTX-07 Integración GitLab (más proceso de carga programada) | **Python/FastAPI y Celery: OBSOLETO** | API-PRP-005 |

**Cambio del 2026-10-13:** ADR-16 y ADR-17 establecen que los microservicios son **Java 24 con Spring Boot 4.0.8 y Spring Cloud 2025.1.3**, con arquitectura hexagonal (`com.comsatelglobal.p3m.{presentation,application,domain,infrastructure}`). Los cinco repositorios `p3m-svc-*` de esta carpeta son esqueletos **Python que ya no rigen** y hay que regenerarlos en Java. Sirven de referencia de rutas, roles y contratos (la tabla `Contrato` de cada README).

Los esquemas y las migraciones de MySQL están en `data/flyway/` de la base de conocimiento; `p3m-local` los usa.

Para levantar todo: `cd p3m-local && docker compose up -d --build` y abrir http://localhost:8080.
