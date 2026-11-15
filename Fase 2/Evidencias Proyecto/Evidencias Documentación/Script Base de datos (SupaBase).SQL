CREATE TABLE public.adopcion (
  id_adopcion bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  fecha_inicio date NOT NULL,
  fecha_termino date,
  id_animal bigint NOT NULL,
  id_usuario bigint NOT NULL,
  CONSTRAINT adopcion_pkey PRIMARY KEY (id_adopcion),
  CONSTRAINT adopcion_animal_fk FOREIGN KEY (id_animal) REFERENCES public.animal(id_animal),
  CONSTRAINT adopcion_usuario_fk FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario)
);
CREATE TABLE public.animal (
  id_animal bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  nombre character varying,
  edad_aprox smallint NOT NULL,
  sexo character varying NOT NULL CHECK (sexo::text = ANY (ARRAY['macho'::character varying, 'hembra'::character varying, 'desconocido'::character varying]::text[])),
  peso numeric NOT NULL,
  descripcion text NOT NULL,
  lugar_rescate text NOT NULL,
  condicion text NOT NULL CHECK (condicion = ANY (ARRAY['sano'::character varying::text, 'en_tratamiento'::character varying::text, 'grave'::character varying::text])),
  especie text NOT NULL CHECK (especie = ANY (ARRAY['perro'::character varying::text, 'gato'::character varying::text, 'hamster'::character varying::text, 'otro'::character varying::text])),
  microchip boolean NOT NULL DEFAULT false,
  foto_url text,
  fecha_ingreso date NOT NULL,
  fecha_salida date,
  comportamiento text NOT NULL,
  id_raza bigint NOT NULL,
  id_rescate bigint NOT NULL,
  id_estado bigint NOT NULL,
  CONSTRAINT animal_pkey PRIMARY KEY (id_animal),
  CONSTRAINT animal_raza_fk FOREIGN KEY (id_raza) REFERENCES public.raza(id_raza),
  CONSTRAINT animal_rescate_fk FOREIGN KEY (id_rescate) REFERENCES public.rescate(id_rescate),
  CONSTRAINT animal_estado_fk FOREIGN KEY (id_estado) REFERENCES public.estado(id_estado)
);
CREATE TABLE public.casa_temporal (
  id_casa bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  poblacion text NOT NULL,
  calle text NOT NULL,
  num_casa smallint NOT NULL,
  cant_persona smallint NOT NULL,
  cant_habitacion smallint NOT NULL,
  patio boolean NOT NULL DEFAULT false,
  metro_c smallint NOT NULL,
  evidencia text NOT NULL,
  observacion text,
  fecha_ingreso date NOT NULL,
  id_usuario bigint NOT NULL,
  id_estado bigint NOT NULL,
  CONSTRAINT casa_temporal_pkey PRIMARY KEY (id_casa),
  CONSTRAINT casa_temporal_estado_fk FOREIGN KEY (id_estado) REFERENCES public.estado(id_estado),
  CONSTRAINT casa_temporal_usuario_fk FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario)
);
CREATE TABLE public.comentario (
  id_comentario bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  contenido text NOT NULL,
  fecha date NOT NULL,
  id_usuario bigint NOT NULL,
  id_estado bigint NOT NULL,
  id_publicacion bigint NOT NULL,
  CONSTRAINT comentario_pkey PRIMARY KEY (id_comentario),
  CONSTRAINT comentario_estado_fk FOREIGN KEY (id_estado) REFERENCES public.estado(id_estado),
  CONSTRAINT comentario_publicacion_fk FOREIGN KEY (id_publicacion) REFERENCES public.publicacion(id_publicacion),
  CONSTRAINT comentario_usuario_fk FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario)
);
CREATE TABLE public.devolucion_adopcion (
  id_dev bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  fecha_devolucion date NOT NULL,
  motivo text NOT NULL,
  condicion_animal text NOT NULL,
  observacion text,
  requiere_tratamiento boolean NOT NULL DEFAULT false,
  fecha_evaluacion date,
  id_adopcion bigint NOT NULL,
  id_estado bigint NOT NULL,
  CONSTRAINT devolucion_adopcion_pkey PRIMARY KEY (id_dev),
  CONSTRAINT dev_adopcion_adopcion_fk FOREIGN KEY (id_adopcion) REFERENCES public.adopcion(id_adopcion),
  CONSTRAINT devolucion_adopcion_estado_fk FOREIGN KEY (id_estado) REFERENCES public.estado(id_estado)
);
CREATE TABLE public.donacion (
  id_donacion bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  tipo_donacion character varying NOT NULL CHECK (tipo_donacion::text = ANY (ARRAY['Alimentos y Nutrición'::character varying, 'Limpieza e Higiene'::character varying, 'Confort y Descanso'::character varying, 'Salud y Bienestar'::character varying, 'Aportes Económicos'::character varying, 'otro'::character varying]::text[])),
  cantidad numeric NOT NULL,
  fecha_donacion date NOT NULL,
  descripcion text NOT NULL,
  id_usuario bigint NOT NULL,
  id_necesidad bigint,
  CONSTRAINT donacion_pkey PRIMARY KEY (id_donacion),
  CONSTRAINT donacion_usuario_fk FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario),
  CONSTRAINT donacion_id_necesidad_fkey FOREIGN KEY (id_necesidad) REFERENCES public.necesidad(id_necesidad)
);
CREATE TABLE public.estado (
  id_estado bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  tipo_estado character varying NOT NULL,
  nombre character varying NOT NULL,
  CONSTRAINT estado_pkey PRIMARY KEY (id_estado)
);
CREATE TABLE public.evaluacion_animal (
  id_evaluacion bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  fecha date NOT NULL,
  estado_salud text NOT NULL CHECK (estado_salud = ANY (ARRAY['sano'::character varying::text, 'en_tratamiento'::character varying::text, 'grave'::character varying::text])),
  necesita_tratamiento boolean NOT NULL DEFAULT false,
  observacion text NOT NULL,
  id_animal bigint NOT NULL,
  rut_personal character varying NOT NULL,
  CONSTRAINT evaluacion_animal_pkey PRIMARY KEY (id_evaluacion),
  CONSTRAINT evaluacion_animal_animal_fk FOREIGN KEY (id_animal) REFERENCES public.animal(id_animal),
  CONSTRAINT ev_animal_veterinario_fk FOREIGN KEY (rut_personal) REFERENCES public.veterinario(rut_personal)
);
CREATE TABLE public.hogar_animal (
  id_asignacion bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  fecha_ingreso date NOT NULL,
  fecha_salida date,
  id_casa bigint NOT NULL,
  id_animal bigint NOT NULL,
  CONSTRAINT hogar_animal_pkey PRIMARY KEY (id_asignacion),
  CONSTRAINT hogar_animal_animal_fk FOREIGN KEY (id_animal) REFERENCES public.animal(id_animal),
  CONSTRAINT hogar_animal_casa_temporal_fk FOREIGN KEY (id_casa) REFERENCES public.casa_temporal(id_casa)
);
CREATE TABLE public.necesidad (
  id_necesidad bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  tipo_necesidad character varying NOT NULL CHECK (tipo_necesidad::text = ANY (ARRAY['Alimentos y Nutrición'::character varying, 'Limpieza e Higiene'::character varying, 'Confort y Descanso'::character varying, 'Salud y Bienestar'::character varying, 'Aportes Económicos'::character varying, 'otro'::character varying]::text[])),
  descripcion text NOT NULL,
  saciada boolean NOT NULL DEFAULT false,
  fecha date NOT NULL,
  fecha_cambio date,
  CONSTRAINT necesidad_pkey PRIMARY KEY (id_necesidad)
);
CREATE TABLE public.personal (
  rut_personal character varying NOT NULL,
  rol character varying NOT NULL CHECK (rol::text = ANY (ARRAY['cuidador'::character varying, 'administrativo'::character varying, 'coordinador'::character varying, 'veterinario'::character varying, 'admin'::character varying]::text[])),
  fecha_ingreso date NOT NULL,
  fecha_salida date,
  telefono_emergencia integer NOT NULL,
  direccion character varying NOT NULL,
  id_usuario bigint,
  id_estado bigint,
  id_solicitud_vol bigint,
  CONSTRAINT personal_pkey PRIMARY KEY (rut_personal),
  CONSTRAINT personal_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario),
  CONSTRAINT personal_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES public.estado(id_estado),
  CONSTRAINT personal_id_solicitud_vol_fkey FOREIGN KEY (id_solicitud_vol) REFERENCES public.solicitud_voluntariado(id_solicitud_vol)
);
CREATE TABLE public.publicacion (
  id_publicacion bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  categoria character varying NOT NULL CHECK (categoria::text = ANY (ARRAY['rescate'::character varying, 'encontrado'::character varying, 'perdido'::character varying, 'adopcion'::character varying, 'cuidados'::character varying, 'solicitud_ayuda'::character varying, 'caso_urgente'::character varying]::text[])),
  titulo character varying NOT NULL,
  contenido text NOT NULL,
  ubicacion character varying NOT NULL,
  fecha_publicacion date NOT NULL,
  id_estado bigint NOT NULL,
  CONSTRAINT publicacion_pkey PRIMARY KEY (id_publicacion),
  CONSTRAINT publicacion_estado_fk FOREIGN KEY (id_estado) REFERENCES public.estado(id_estado)
);
CREATE TABLE public.raza (
  id_raza bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  nomb_raza character varying NOT NULL,
  CONSTRAINT raza_pkey PRIMARY KEY (id_raza)
);
CREATE TABLE public.refugio (
  id_refugio bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  nombre character varying NOT NULL,
  direccion text NOT NULL,
  telefono integer NOT NULL,
  correo character varying NOT NULL,
  latitud numeric NOT NULL,
  longitud numeric NOT NULL,
  CONSTRAINT refugio_pkey PRIMARY KEY (id_refugio)
);
CREATE TABLE public.rescate (
  id_rescate bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  fecha_rescate date NOT NULL,
  lugar_rescate text NOT NULL,
  descripcion text NOT NULL,
  condicion_inicial text NOT NULL CHECK (condicion_inicial = ANY (ARRAY['sano'::character varying::text, 'en_tratamiento'::character varying::text, 'grave'::character varying::text])),
  observacion text,
  id_estado bigint NOT NULL,
  rut_personal character varying NOT NULL,
  CONSTRAINT rescate_pkey PRIMARY KEY (id_rescate),
  CONSTRAINT rescate_estado_fk FOREIGN KEY (id_estado) REFERENCES public.estado(id_estado),
  CONSTRAINT rescate_personal_fk FOREIGN KEY (rut_personal) REFERENCES public.personal(rut_personal)
);
CREATE TABLE public.seguimiento_adopcion (
  id_seg_adop bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  llamada boolean NOT NULL DEFAULT false,
  visita boolean NOT NULL DEFAULT false,
  anotacion text,
  evidencia text,
  fecha date NOT NULL,
  id_adopcion bigint NOT NULL,
  id_estado bigint NOT NULL,
  CONSTRAINT seguimiento_adopcion_pkey PRIMARY KEY (id_seg_adop),
  CONSTRAINT seg_adopcion_adopcion_fk FOREIGN KEY (id_adopcion) REFERENCES public.adopcion(id_adopcion),
  CONSTRAINT seguimiento_adopcion_estado_fk FOREIGN KEY (id_estado) REFERENCES public.estado(id_estado)
);
CREATE TABLE public.solicitud_adopcion (
  id_solicitud_ad bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  fecha_solicitud date NOT NULL,
  motivo text NOT NULL,
  observacion text,
  fecha_respuesta date,
  id_animal bigint NOT NULL,
  id_usuario bigint NOT NULL,
  id_estado bigint NOT NULL,
  respuesta text NOT NULL DEFAULT ''::text,
  rut_personal_respuesta character varying,
  CONSTRAINT solicitud_adopcion_pkey PRIMARY KEY (id_solicitud_ad),
  CONSTRAINT solicitud_adopcion_animal_fk FOREIGN KEY (id_animal) REFERENCES public.animal(id_animal),
  CONSTRAINT solicitud_adopcion_estado_fk FOREIGN KEY (id_estado) REFERENCES public.estado(id_estado),
  CONSTRAINT solicitud_adopcion_usuario_fk FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario),
  CONSTRAINT solicitud_adopcion_rut_personal_respuesta_fkey FOREIGN KEY (rut_personal_respuesta) REFERENCES public.personal(rut_personal)
);
CREATE TABLE public.solicitud_hogar_temporal (
  id_solicitud_hog bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  fecha_solicitud date NOT NULL,
  motivo text NOT NULL,
  observacion text,
  fecha_respuesta date,
  id_casa bigint NOT NULL,
  id_estado bigint NOT NULL,
  rut_personal character varying,
  CONSTRAINT solicitud_hogar_temporal_pkey PRIMARY KEY (id_solicitud_hog),
  CONSTRAINT soli_hogar_casa_temporal_fk FOREIGN KEY (id_casa) REFERENCES public.casa_temporal(id_casa),
  CONSTRAINT soli_hogar_estado_fk FOREIGN KEY (id_estado) REFERENCES public.estado(id_estado),
  CONSTRAINT solicitud_hogar_temporal_rut_personal_fkey FOREIGN KEY (rut_personal) REFERENCES public.personal(rut_personal)
);
CREATE TABLE public.solicitud_voluntariado (
  id_solicitud_vol bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  fecha_solicitud date NOT NULL,
  motivacion text NOT NULL,
  disponibilidad text NOT NULL,
  experiencia text NOT NULL,
  observacion text,
  fecha_respuesta date,
  id_usuario bigint NOT NULL,
  id_estado bigint NOT NULL,
  CONSTRAINT solicitud_voluntariado_pkey PRIMARY KEY (id_solicitud_vol),
  CONSTRAINT soli_volun_estado_fk FOREIGN KEY (id_estado) REFERENCES public.estado(id_estado),
  CONSTRAINT soli_volun_usuario_fk FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario)
);
CREATE TABLE public.tratamiento (
  id_tratamiento bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  fecha_inicio date NOT NULL,
  fecha_termino date,
  tipo_tratamiento character varying NOT NULL CHECK (tipo_tratamiento::text = ANY (ARRAY['vacuna'::character varying, 'cirugia'::character varying, 'control'::character varying, 'desparasitacion'::character varying, 'otro'::character varying]::text[])),
  detalle text NOT NULL,
  observacion text,
  diagnostico text NOT NULL,
  costo integer NOT NULL,
  id_estado bigint NOT NULL,
  rut_personal character varying NOT NULL,
  id_animal bigint NOT NULL,
  CONSTRAINT tratamiento_pkey PRIMARY KEY (id_tratamiento),
  CONSTRAINT tratamiento_estado_fk FOREIGN KEY (id_estado) REFERENCES public.estado(id_estado),
  CONSTRAINT tratamiento_veterinario_fk FOREIGN KEY (rut_personal) REFERENCES public.veterinario(rut_personal),
  CONSTRAINT tratamiento_id_animal_fkey FOREIGN KEY (id_animal) REFERENCES public.animal(id_animal)
);
CREATE TABLE public.usuario (
  id_usuario bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  p_nombre character varying NOT NULL,
  s_nombre character varying NOT NULL,
  ap_paterno character varying NOT NULL,
  ap_materno character varying NOT NULL,
  correo character varying UNIQUE,
  genero character varying NOT NULL,
  fecha_nacimiento date NOT NULL,
  telefono numeric,
  supabase_uid uuid UNIQUE,
  CONSTRAINT usuario_pkey PRIMARY KEY (id_usuario),
  CONSTRAINT fk_usuario_supabase FOREIGN KEY (supabase_uid) REFERENCES auth.users(id)
);
CREATE TABLE public.vacuna (
  id_vacuna bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  nomb_vacuna text NOT NULL,
  descripcion text NOT NULL,
  CONSTRAINT vacuna_pkey PRIMARY KEY (id_vacuna)
);
CREATE TABLE public.vacuna_animal (
  id_vacuna_animal bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  fecha_aplicacion date NOT NULL,
  fecha_prox_dosis date,
  aplicada boolean NOT NULL DEFAULT false,
  observacion text NOT NULL,
  id_animal bigint NOT NULL,
  id_vacuna bigint NOT NULL,
  CONSTRAINT vacuna_animal_pkey PRIMARY KEY (id_vacuna_animal),
  CONSTRAINT vacuna_animal_animal_fk FOREIGN KEY (id_animal) REFERENCES public.animal(id_animal),
  CONSTRAINT vacuna_animal_vacuna_fk FOREIGN KEY (id_vacuna) REFERENCES public.vacuna(id_vacuna)
);
CREATE TABLE public.veterinario (
  rut_personal character varying NOT NULL,
  especialidad text NOT NULL,
  experiencia smallint NOT NULL,
  CONSTRAINT veterinario_pkey PRIMARY KEY (rut_personal),
  CONSTRAINT veterinario_personal_fk FOREIGN KEY (rut_personal) REFERENCES public.personal(rut_personal)
);
CREATE TABLE public.django_migrations (
  id bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  app character varying NOT NULL,
  name character varying NOT NULL,
  applied timestamp with time zone NOT NULL,
  CONSTRAINT django_migrations_pkey PRIMARY KEY (id)
);
CREATE TABLE public.django_session (
  session_key character varying NOT NULL,
  session_data text NOT NULL,
  expire_date timestamp with time zone NOT NULL,
  CONSTRAINT django_session_pkey PRIMARY KEY (session_key)
);
CREATE TABLE public.django_content_type (
  id integer GENERATED ALWAYS AS IDENTITY NOT NULL,
  app_label character varying NOT NULL,
  model character varying NOT NULL,
  CONSTRAINT django_content_type_pkey PRIMARY KEY (id)
);
CREATE TABLE public.auth_permission (
  id integer GENERATED ALWAYS AS IDENTITY NOT NULL,
  name character varying NOT NULL,
  content_type_id integer NOT NULL,
  codename character varying NOT NULL,
  CONSTRAINT auth_permission_pkey PRIMARY KEY (id),
  CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id)
);
CREATE TABLE public.auth_group (
  id integer GENERATED ALWAYS AS IDENTITY NOT NULL,
  name character varying NOT NULL UNIQUE,
  CONSTRAINT auth_group_pkey PRIMARY KEY (id)
);
CREATE TABLE public.auth_group_permissions (
  id bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  group_id integer NOT NULL,
  permission_id integer NOT NULL,
  CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id),
  CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id),
  CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id)
);
CREATE TABLE public.auth_user (
  id integer GENERATED ALWAYS AS IDENTITY NOT NULL,
  password character varying NOT NULL,
  last_login timestamp with time zone,
  is_superuser boolean NOT NULL,
  username character varying NOT NULL UNIQUE,
  first_name character varying NOT NULL,
  last_name character varying NOT NULL,
  email character varying NOT NULL,
  is_staff boolean NOT NULL,
  is_active boolean NOT NULL,
  date_joined timestamp with time zone NOT NULL,
  CONSTRAINT auth_user_pkey PRIMARY KEY (id)
);
CREATE TABLE public.auth_user_groups (
  id bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  user_id integer NOT NULL,
  group_id integer NOT NULL,
  CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id),
  CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id),
  CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id)
);
CREATE TABLE public.auth_user_user_permissions (
  id bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  user_id integer NOT NULL,
  permission_id integer NOT NULL,
  CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id),
  CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id),
  CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id)
);
CREATE TABLE public.django_admin_log (
  id integer GENERATED ALWAYS AS IDENTITY NOT NULL,
  action_time timestamp with time zone NOT NULL,
  object_id text,
  object_repr character varying NOT NULL,
  action_flag smallint NOT NULL CHECK (action_flag >= 0),
  change_message text NOT NULL,
  content_type_id integer,
  user_id integer NOT NULL,
  CONSTRAINT django_admin_log_pkey PRIMARY KEY (id),
  CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id),
  CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id)
);
CREATE TABLE public.mod_foro_publicacion (
  id bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  titulo character varying NOT NULL,
  contenido text NOT NULL,
  fecha_creacion timestamp with time zone NOT NULL,
  autor_id bigint NOT NULL,
  CONSTRAINT mod_foro_publicacion_pkey PRIMARY KEY (id),
  CONSTRAINT mod_foro_publicacion_autor_id_dcf783c6_fk_usuario_id_usuario FOREIGN KEY (autor_id) REFERENCES public.usuario(id_usuario)
);
CREATE TABLE public.mod_foro_comentario (
  id bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  contenido text NOT NULL,
  fecha_creacion timestamp with time zone NOT NULL,
  autor_id bigint NOT NULL,
  publicacion_id bigint NOT NULL,
  CONSTRAINT mod_foro_comentario_pkey PRIMARY KEY (id),
  CONSTRAINT mod_foro_comentario_autor_id_a639dc54_fk_usuario_id_usuario FOREIGN KEY (autor_id) REFERENCES public.usuario(id_usuario),
  CONSTRAINT mod_foro_comentario_publicacion_id_0a57f710_fk_mod_foro_ FOREIGN KEY (publicacion_id) REFERENCES public.mod_foro_publicacion(id)
);
CREATE TABLE public.publicacion_personal_foro (
  id_publicacion bigint NOT NULL,
  id_usuario bigint NOT NULL,
  CONSTRAINT publicacion_personal_foro_pkey PRIMARY KEY (id_publicacion),
  CONSTRAINT publicacion_personal_id_publicacion_c0ad86f7_fk_publicaci FOREIGN KEY (id_publicacion) REFERENCES public.publicacion(id_publicacion),
  CONSTRAINT publicacion_personal_id_usuario_43342f0f_fk_usuario_i FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario)
);