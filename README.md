# 🐾 Huellas de Esperanza

Sistema web integral para la gestión de refugios de animales en situación de calle, desarrollado para centralizar el registro, rescate, adopción y apoyo comunitario hacia animales sin hogar. El sistema permite administrar todo el ciclo de vida de un animal ingresado al refugio —desde su rescate hasta su adopción o reubicación en un hogar temporal—, incluyendo la gestión de donaciones, participación comunitaria, atención veterinaria y generación de reportes operativos.

---

## 🚀 Características Principales

### Módulos Funcionales
- **Módulo 1: Refugio:** Registro e inscripción de animales rescatados, con información general, estado de salud, ubicación geográfica (mapa) y seguimiento de su situación dentro del refugio.
- **Módulo 2: Adopción:** Catálogo de animales disponibles para adopción, formulario de postulación y seguimiento completo del proceso de evaluación, aprobación y eventual devolución.
- **Módulo 3: Donación:** Gestión de aportes financieros, de alimentos e insumos realizados por la comunidad, con registro de donantes y trazabilidad de los recursos recibidos.
- **Módulo 4: Hogares Temporales:** Registro de personas dispuestas a acoger animales de forma transitoria, gestión de ubicaciones disponibles y flujos de asignación de acogida.
- **Módulo 5: Foro:** Espacio comunitario de publicaciones, avisos de rescate y comentarios interactivos, donde los usuarios y el refugio pueden coordinar ayuda mutua.
- **Módulo 6: Información y Reportes:** Panel analítico y estadísticas de rescate, adopción y participación comunitaria orientada a apoyar la toma de decisiones del refugio.

### Funcionalidades Adicionales
- Autenticación segura y gestión de perfiles de usuario (Roles: Externos/Comunidad e Internos/Refugio).
- Gestión avanzada de perfiles de veterinarios y control de tratamientos médicos.
- Integración nativa con **Supabase Storage** para la gestión segura de archivos multimedia y evidencias fotográficas de los animales.
- Vistas interactivas de mapas para la ubicación exacta de rescates y refugios.
- Diseño responsivo adaptado para dispositivos móviles y equipos de escritorio mediante Bootstrap.

---

## 🛠️ Stack Tecnológico

### Backend & Lógica
- **Python 3.x** como lenguaje principal de programación.
- **Django 6.1.1** como Framework web full-stack.
- **Gunicorn** como servidor WSGI para producción dentro del contenedor.

### Base de Datos & Almacenamiento
- **PostgreSQL** alojado en la nube mediante **Supabase Cloud**.
- **Supabase Auth** para control de accesos.
- **Supabase Storage** para almacenamiento de evidencias y fotos multimedia.

### Frontend & Estilos
- **HTML5 y Django Templates** para la renderización de vistas.
- **CSS3 y Bootstrap** para el diseño de interfaces responsivas.
- **JavaScript** para validaciones dinámicas del lado del cliente y accesibilidad en formularios (combobox con búsqueda).

---

## 👥 Integrantes
**Portafolio de Título - Ingeniería Informática / Software (Duoc UC)**
- Javier San Martín Burgos
- Ítalo Zapata Canales

---

## 📚 Documentación Adicional
El proyecto cuenta con documentación formal de gestión y ingeniería de software adjunta en el repositorio:
- Product Backlog y Sprint Backlog (Sprints 1 al 6)
- Plantilla de Retrospectivas (Registros, Qué salió bien, Mejorar y Seguimiento)
- Manual Técnico y de Despliegue
- Diagramas de Arquitectura y Modelo de Datos Relacional (MER)

---

## 📐 Arquitectura
El sistema sigue una arquitectura monolítica modular contenerizada:
- **Capa de Presentación:** Plantillas HTML con Bootstrap y componentes dinámicos en JavaScript.
- **Capa de Negocio (Django Views & Forms):** Controladores y formularios de validación divididos por módulos funcionales.
- **Capa de Modelos (Django ORM):** Definición de la lógica de datos integrada con PostgreSQL.
- **Capa de Datos Externa (Supabase):** Servicios de base de datos relacional y almacenamiento de archivos en la nube.

---

## 🔄 Metodología
El proyecto fue desarrollado utilizando la metodología ágil **Scrum**, adaptada a un ciclo de trabajo de 12 semanas y estructurada en **6 Sprints**:
1. **Sprint 1:** Planificación, levantamiento de requerimientos y diseño base de la arquitectura.
2. **Sprint 2:** Desarrollo del Módulo de Refugio y Módulo de Adopción.
3. **Sprint 3:** Desarrollo del Módulo de Hogares Temporales y Foro Comunitario.
4. **Sprint 4:** Desarrollo del Módulo de Donaciones y Panel de Estadísticas/Reportes.
5. **Sprint 5:** Integración general de los módulos y ejecución de pruebas cruzadas (QA cruzado).
6. **Sprint 6:** Pruebas finales, contenerización con Docker, elaboración del Manual Técnico y cierre del proyecto.

---

## Levantar con Docker

Requisitos: Docker Desktop (o Docker Engine) con Docker Compose v2.

1. Crear el archivo de variables local y editarlo:

   ```powershell
   Copy-Item .env.example .env
   ```

2. Configurar `DATABASE_URL` con una base PostgreSQL accesible que ya tenga el
   esquema del proyecto. Generar una clave propia para Django y reemplazar
   `DJANGO_SECRET_KEY`:

   ```powershell
   python -c "import secrets; print(secrets.token_urlsafe(50))"
   ```

   No usar los valores de ejemplo en producción. 

3. Construir e iniciar la aplicación:

   ```powershell
   docker compose up --build
   ```

   Django aplica las migraciones pendientes y luego inicia Gunicorn. La
   aplicación queda disponible en
   [http://localhost:8000](http://localhost:8000). Para cambiar el puerto del
   host, ajustar `APP_PORT` en `.env`.

El contenedor web utiliza la base PostgreSQL externa indicada en `.env`; no
crea ni borra esa base. El esquema debe estar inicializado, ya que algunas
migraciones del proyecto modifican tablas existentes.

Para detener el contenedor:

```powershell
docker compose down
```

## Variables de entorno

| Variable | Uso | Valor local de ejemplo |
| --- | --- | --- |
| `DJANGO_SECRET_KEY` | Clave secreta de Django; generar una propia. | — |
| `DJANGO_DEBUG` | Activa el modo de depuración. Mantener `false` en producción. | `true` |
| `DJANGO_ALLOWED_HOSTS` | Hosts permitidos por Django, separados por comas. | `localhost,127.0.0.1` |
| `APP_PORT` | Puerto publicado en el equipo anfitrión. | `8000` |
| `DATABASE_URL` | URL completa de la base PostgreSQL existente. | — |
| `DATABASE_SSLMODE` | Modo SSL para conectarse a PostgreSQL. | `require` |
| `SUPABASE_URL` | URL del proyecto Supabase; opcional. | vacío |
| `SUPABASE_KEY` | Clave pública de Supabase; opcional. | vacío |
| `SUPABASE_SECRET_KEY` | Clave de servidor para Supabase Storage; opcional y sensible. | vacío |

Supabase Storage necesita las tres variables `SUPABASE_*`; si se dejan vacías,
la aplicación puede iniciar, pero las funciones que dependen de Storage no
estarán configuradas.
