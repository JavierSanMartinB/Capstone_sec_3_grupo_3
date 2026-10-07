CREATE TABLE adopcion (
    id_adopcion   VARCHAR2(15) NOT NULL,
    fecha_inicio  DATE NOT NULL,
    fecha_termino DATE NOT NULL,
    id_animal     VARCHAR2(15) NOT NULL,
    id_usuario    NUMBER NOT NULL
);

ALTER TABLE adopcion ADD CONSTRAINT adopcion_pk PRIMARY KEY ( id_adopcion );

CREATE TABLE animal (
    id_animal      VARCHAR2(15) NOT NULL,
    nombre         VARCHAR2(20) NOT NULL,
    edad_aprox     NUMBER(3) NOT NULL,
    sexo           VARCHAR2(50) NOT NULL,
    peso           FLOAT(3) NOT NULL,
    descripcion    CLOB NOT NULL,
    lugar_rescate  VARCHAR2(50) NOT NULL,
    condicion      VARCHAR2(50) NOT NULL,
    especie        VARCHAR2(50) NOT NULL,
    microchip      CHAR(1) NOT NULL,
    foto_url       CLOB NOT NULL,
    fecha_ingreso  DATE NOT NULL,
    fecha_salida   DATE NOT NULL,
    comportamiento VARCHAR2(50) NOT NULL,
    id_raza        VARCHAR2(15) NOT NULL,
    id_rescate     VARCHAR2(15) NOT NULL
);

ALTER TABLE animal ADD CONSTRAINT animal_pk PRIMARY KEY ( id_animal );

CREATE TABLE casa_temporal (
    id_casa         NUMBER NOT NULL,
    poblacion       VARCHAR2(50) NOT NULL,
    calle           VARCHAR2(50) NOT NULL,
    num_casa        NUMBER(4) NOT NULL,
    cant_persona    NUMBER(2) NOT NULL,
    cant_habitacion NUMBER(2) NOT NULL,
    patio           CHAR(1) NOT NULL,
    metro_c         NUMBER(3) NOT NULL,
    evidencia       CLOB NOT NULL,
    observacion     VARCHAR2(50) NOT NULL,
    fecha_ingreso   DATE NOT NULL,
    id_usuario      NUMBER NOT NULL,
    id_estado       VARCHAR2(15) NOT NULL
);

ALTER TABLE casa_temporal ADD CONSTRAINT casa_temporal_pk PRIMARY KEY ( id_casa );

CREATE TABLE comentario (
    id_comentario  VARCHAR2(15) NOT NULL,
    contenido      CLOB NOT NULL,
    fecha          DATE NOT NULL,
    id_usuario     NUMBER NOT NULL,
    id_estado      VARCHAR2(15) NOT NULL,
    id_publicacion VARCHAR2(15) NOT NULL
);

ALTER TABLE comentario ADD CONSTRAINT comentario_pk PRIMARY KEY ( id_comentario );

CREATE TABLE devolucion_adopcion (
    id_dev               VARCHAR2(15) NOT NULL,
    fecha_devolucion     DATE NOT NULL,
    motivo               VARCHAR2(50) NOT NULL,
    condicion_animal     CLOB NOT NULL,
    observacion          CLOB NOT NULL,
    requiere_tratamiento CHAR(1) NOT NULL,
    fecha_evaluacion     DATE NOT NULL,
    id_adopcion          VARCHAR2(15) NOT NULL,
    id_estado            VARCHAR2(15) NOT NULL
);

ALTER TABLE devolucion_adopcion ADD CONSTRAINT devolucion_adopcion_pk PRIMARY KEY ( id_dev );

CREATE TABLE donacion (
    id_donacion    VARCHAR2(15) NOT NULL,
    tipo_donacion  VARCHAR2(50) NOT NULL,
    cantidad       NUMBER(4) NOT NULL,
    fecha_donacion DATE NOT NULL,
    descripcion    VARCHAR2(100) NOT NULL,
    id_usuario     NUMBER NOT NULL
);

ALTER TABLE donacion ADD CONSTRAINT donacion_pk PRIMARY KEY ( id_donacion );

CREATE TABLE estado (
    id_estado   VARCHAR2(15) NOT NULL,
    tipo_estado VARCHAR2(50) NOT NULL,
    nombre      VARCHAR2(20) NOT NULL
);

ALTER TABLE estado ADD CONSTRAINT estado_pk PRIMARY KEY ( id_estado );

CREATE TABLE evaluacion_animal (
    id_evaluacion        VARCHAR2(15) NOT NULL,
    fecha                DATE NOT NULL,
    estado_salud         VARCHAR2(50) NOT NULL,
    necesita_tratamiento CHAR(1) NOT NULL,
    observacion          VARCHAR2(50) NOT NULL,
    id_animal            VARCHAR2(15) NOT NULL,
    rut_personal         VARCHAR2(10) NOT NULL
);

ALTER TABLE evaluacion_animal ADD CONSTRAINT evaluacion_animal_pk PRIMARY KEY ( id_evaluacion );

CREATE TABLE hogar_animal (
    id_asignacion VARCHAR2(15) NOT NULL,
    fecha_ingreso DATE NOT NULL,
    fecha_salida  DATE NOT NULL,
    id_casa       NUMBER NOT NULL,
    id_animal     VARCHAR2(15) NOT NULL
);

ALTER TABLE hogar_animal ADD CONSTRAINT hogar_animal_pk PRIMARY KEY ( id_asignacion );

CREATE TABLE necesidad (
    id_necesidad   VARCHAR2(15) NOT NULL,
    tipo_necesidad VARCHAR2(50) NOT NULL,
    descripcion    VARCHAR2(100) NOT NULL,
    saciada        CHAR(1) NOT NULL,
    fecha          DATE NOT NULL,
    fecha_cambio   DATE NOT NULL
);

ALTER TABLE necesidad ADD CONSTRAINT necesidad_pk PRIMARY KEY ( id_necesidad );

CREATE TABLE personal (
    rut_personal        VARCHAR2(10) NOT NULL,
    rol                 VARCHAR2(50) NOT NULL,
    fecha_ingreso       DATE NOT NULL,
    fecha_salida        DATE NOT NULL,
    telefono            NUMBER(9) NOT NULL,
    telefono_emergencia NUMBER(9) NOT NULL,
    direccion           VARCHAR2(100) NOT NULL
);

ALTER TABLE personal ADD CONSTRAINT personal_pk PRIMARY KEY ( rut_personal );

CREATE TABLE publicacion (
    id_publicacion    VARCHAR2(15) NOT NULL,
    categoria         VARCHAR2(30) NOT NULL,
    titulo            VARCHAR2(30) NOT NULL,
    contenido         CLOB NOT NULL,
    ubicacion         VARCHAR2(150) NOT NULL,
    fecha_publicacion DATE NOT NULL,
    id_estado         VARCHAR2(15) NOT NULL
);

ALTER TABLE publicacion ADD CONSTRAINT publicacion_pk PRIMARY KEY ( id_publicacion );

CREATE TABLE raza (
    id_raza   VARCHAR2(15) NOT NULL,
    nomb_raza VARCHAR2(50) NOT NULL
);

ALTER TABLE raza ADD CONSTRAINT raza_pk PRIMARY KEY ( id_raza );

CREATE TABLE refugio (
    id_refugio VARCHAR2(15) NOT NULL,
    nombre     VARCHAR2(30) NOT NULL,
    direccion  VARCHAR2(50) NOT NULL,
    telefono   NUMBER(9) NOT NULL,
    correo     VARCHAR2(50) NOT NULL,
    latitud    NUMBER(9, 6) NOT NULL,
    longitud   NUMBER(9, 6) NOT NULL
);

ALTER TABLE refugio ADD CONSTRAINT refugio_pk PRIMARY KEY ( id_refugio );

CREATE TABLE rescate (
    id_rescate        VARCHAR2(15) NOT NULL,
    fecha_rescate     DATE NOT NULL,
    lugar_rescate     VARCHAR2(100) NOT NULL,
    descripcion       VARCHAR2(100) NOT NULL,
    condicion_inicial VARCHAR2(50) NOT NULL,
    observacion       VARCHAR2(50) NOT NULL,
    id_estado         VARCHAR2(15) NOT NULL,
    rut_personal      VARCHAR2(10) NOT NULL
);

ALTER TABLE rescate ADD CONSTRAINT rescate_pk PRIMARY KEY ( id_rescate );

CREATE TABLE seguimiento_adopcion (
    id_seg_adop VARCHAR2(25) NOT NULL,
    llamada     CHAR(1) NOT NULL,
    visita      CHAR(1) NOT NULL,
    anotacion   CLOB NOT NULL,
    evidencia   CLOB NOT NULL,
    fecha       DATE NOT NULL,
    id_adopcion VARCHAR2(15) NOT NULL,
    id_estado   VARCHAR2(15) NOT NULL
);

ALTER TABLE seguimiento_adopcion ADD CONSTRAINT seguimiento_adopcion_pk PRIMARY KEY ( id_seg_adop );

CREATE TABLE solicitud_adopcion (
    id_solicitud_ad VARCHAR2(25) NOT NULL,
    fecha_solicitud DATE NOT NULL,
    motivo          VARCHAR2(50) NOT NULL,
    observacion     VARCHAR2(50) NOT NULL,
    fecha_respuesta DATE NOT NULL,
    id_animal       VARCHAR2(15) NOT NULL,
    id_usuario      NUMBER NOT NULL,
    id_estado       VARCHAR2(15) NOT NULL
);

ALTER TABLE solicitud_adopcion ADD CONSTRAINT solicitud_adopcion_pk PRIMARY KEY ( id_solicitud_ad );

CREATE TABLE solicitud_hogar_temporal (
    id_solicitud_hog VARCHAR2(25) NOT NULL,
    fecha_solicitud  DATE NOT NULL,
    motivo           VARCHAR2(50) NOT NULL,
    observacion      VARCHAR2(50) NOT NULL,
    fecha_respuesta  DATE NOT NULL,
    id_casa          NUMBER NOT NULL,
    id_animal        VARCHAR2(15) NOT NULL,
    id_estado        VARCHAR2(15) NOT NULL
);

ALTER TABLE solicitud_hogar_temporal ADD CONSTRAINT solicitud_hogar_temporal_pk PRIMARY KEY ( id_solicitud_hog,
                                                                                              id_estado );

CREATE TABLE solicitud_voluntariado (
    id_solicitud_vol NUMBER(25) NOT NULL,
    fecha_solicitud  DATE NOT NULL,
    motivacion       VARCHAR2(100) NOT NULL,
    disponibilidad   VARCHAR2(100) NOT NULL,
    experiencia      VARCHAR2(100) NOT NULL,
    observacion      VARCHAR2(50) NOT NULL,
    fecha_respuesta  DATE NOT NULL,
    id_usuario       NUMBER NOT NULL,
    id_estado        VARCHAR2(15) NOT NULL
);

ALTER TABLE solicitud_voluntariado ADD CONSTRAINT solicitud_voluntariado_pk PRIMARY KEY ( id_solicitud_vol );

CREATE TABLE tratamiento (
    id_tratamiento   VARCHAR2(15) NOT NULL,
    fecha_inicio     DATE NOT NULL,
    fecha_termino    DATE NOT NULL,
    tipo_tratamiento VARCHAR2(50) NOT NULL,
    detalle          CLOB NOT NULL,
    observacion      CLOB NOT NULL,
    diagnostico      VARCHAR2(100) NOT NULL,
    costo            NUMBER(6) NOT NULL,
    id_estado        VARCHAR2(15) NOT NULL,
    rut_personal     VARCHAR2(10) NOT NULL
);

ALTER TABLE tratamiento ADD CONSTRAINT tratamiento_pk PRIMARY KEY ( id_tratamiento );

CREATE TABLE usuario (
    id_usuario       NUMBER NOT NULL,
    p_nombre         VARCHAR2(50) NOT NULL,
    s_nombre         VARCHAR2(50) NOT NULL,
    ap_paterno       VARCHAR2(50) NOT NULL,
    ap_materno       VARCHAR2(50) NOT NULL,
    contraseña       VARCHAR2(50) NOT NULL,
    correo           VARCHAR2(50),
    rut_personal     VARCHAR2(10) NOT NULL,
    genero           VARCHAR2(50) NOT NULL,
    fecha_nacimiento DATE NOT NULL
);

CREATE UNIQUE INDEX usuario__idx ON
    usuario (
        rut_personal
    ASC );

ALTER TABLE usuario ADD CONSTRAINT usuario_pk PRIMARY KEY ( id_usuario );

CREATE TABLE vacuna (
    id_vacuna   VARCHAR2(15) NOT NULL,
    nomb_vacuna VARCHAR2(50) NOT NULL,
    descripcion VARCHAR2(100) NOT NULL
);

ALTER TABLE vacuna ADD CONSTRAINT vacuna_pk PRIMARY KEY ( id_vacuna );

CREATE TABLE vacuna_animal (
    id_vacuna_animal VARCHAR2(25) NOT NULL,
    fecha_aplicacion DATE NOT NULL,
    fecha_prox_dosis DATE NOT NULL,
    aplicada         CHAR(1) NOT NULL,
    observacion      VARCHAR2(50) NOT NULL,
    id_animal        VARCHAR2(15) NOT NULL,
    id_vacuna        VARCHAR2(15) NOT NULL
);

ALTER TABLE vacuna_animal ADD CONSTRAINT vacuna_animal_pk PRIMARY KEY ( id_vacuna_animal );

CREATE TABLE veterinario (
    rut_personal VARCHAR2(10) NOT NULL,
    especialidad VARCHAR2(50) NOT NULL,
    experiencia  NUMBER(2) NOT NULL
);

ALTER TABLE veterinario ADD CONSTRAINT veterinario_pk PRIMARY KEY ( rut_personal );

ALTER TABLE adopcion
    ADD CONSTRAINT adopcion_animal_fk FOREIGN KEY ( id_animal )
        REFERENCES animal ( id_animal );

ALTER TABLE adopcion
    ADD CONSTRAINT adopcion_usuario_fk FOREIGN KEY ( id_usuario )
        REFERENCES usuario ( id_usuario );

ALTER TABLE animal
    ADD CONSTRAINT animal_raza_fk FOREIGN KEY ( id_raza )
        REFERENCES raza ( id_raza );

ALTER TABLE animal
    ADD CONSTRAINT animal_rescate_fk FOREIGN KEY ( id_rescate )
        REFERENCES rescate ( id_rescate );

ALTER TABLE casa_temporal
    ADD CONSTRAINT casa_temporal_estado_fk FOREIGN KEY ( id_estado )
        REFERENCES estado ( id_estado );

ALTER TABLE casa_temporal
    ADD CONSTRAINT casa_temporal_usuario_fk FOREIGN KEY ( id_usuario )
        REFERENCES usuario ( id_usuario );

ALTER TABLE comentario
    ADD CONSTRAINT comentario_estado_fk FOREIGN KEY ( id_estado )
        REFERENCES estado ( id_estado );

ALTER TABLE comentario
    ADD CONSTRAINT comentario_publicacion_fk FOREIGN KEY ( id_publicacion )
        REFERENCES publicacion ( id_publicacion );

ALTER TABLE comentario
    ADD CONSTRAINT comentario_usuario_fk FOREIGN KEY ( id_usuario )
        REFERENCES usuario ( id_usuario );

ALTER TABLE devolucion_adopcion
    ADD CONSTRAINT dev_adopcion_adopcion_fk FOREIGN KEY ( id_adopcion )
        REFERENCES adopcion ( id_adopcion );

ALTER TABLE devolucion_adopcion
    ADD CONSTRAINT devolucion_adopcion_estado_fk FOREIGN KEY ( id_estado )
        REFERENCES estado ( id_estado );

ALTER TABLE donacion
    ADD CONSTRAINT donacion_usuario_fk FOREIGN KEY ( id_usuario )
        REFERENCES usuario ( id_usuario );

ALTER TABLE evaluacion_animal
    ADD CONSTRAINT evaluacion_animal_animal_fk FOREIGN KEY ( id_animal )
        REFERENCES animal ( id_animal );

ALTER TABLE evaluacion_animal
    ADD CONSTRAINT ev_animal_veterinario_fk FOREIGN KEY ( rut_personal )
        REFERENCES veterinario ( rut_personal );

ALTER TABLE hogar_animal
    ADD CONSTRAINT hogar_animal_animal_fk FOREIGN KEY ( id_animal )
        REFERENCES animal ( id_animal );

ALTER TABLE hogar_animal
    ADD CONSTRAINT hogar_animal_casa_temporal_fk FOREIGN KEY ( id_casa )
        REFERENCES casa_temporal ( id_casa );

ALTER TABLE publicacion
    ADD CONSTRAINT publicacion_estado_fk FOREIGN KEY ( id_estado )
        REFERENCES estado ( id_estado );

ALTER TABLE rescate
    ADD CONSTRAINT rescate_estado_fk FOREIGN KEY ( id_estado )
        REFERENCES estado ( id_estado );

ALTER TABLE rescate
    ADD CONSTRAINT rescate_personal_fk FOREIGN KEY ( rut_personal )
        REFERENCES personal ( rut_personal );

ALTER TABLE seguimiento_adopcion
    ADD CONSTRAINT seg_adopcion_adopcion_fk FOREIGN KEY ( id_adopcion )
        REFERENCES adopcion ( id_adopcion );

ALTER TABLE seguimiento_adopcion
    ADD CONSTRAINT seguimiento_adopcion_estado_fk FOREIGN KEY ( id_estado )
        REFERENCES estado ( id_estado );

ALTER TABLE solicitud_adopcion
    ADD CONSTRAINT solicitud_adopcion_animal_fk FOREIGN KEY ( id_animal )
        REFERENCES animal ( id_animal );

ALTER TABLE solicitud_adopcion
    ADD CONSTRAINT solicitud_adopcion_estado_fk FOREIGN KEY ( id_estado )
        REFERENCES estado ( id_estado );

ALTER TABLE solicitud_adopcion
    ADD CONSTRAINT solicitud_adopcion_usuario_fk FOREIGN KEY ( id_usuario )
        REFERENCES usuario ( id_usuario );

ALTER TABLE solicitud_hogar_temporal
    ADD CONSTRAINT sol_hogar_temporal_animal_fk FOREIGN KEY ( id_animal )
        REFERENCES animal ( id_animal );
 
ALTER TABLE solicitud_hogar_temporal
    ADD CONSTRAINT soli_hogar_casa_temporal_fk FOREIGN KEY ( id_casa )
        REFERENCES casa_temporal ( id_casa );

ALTER TABLE solicitud_hogar_temporal
    ADD CONSTRAINT soli_hogar_estado_fk FOREIGN KEY ( id_estado )
        REFERENCES estado ( id_estado );

ALTER TABLE solicitud_voluntariado
    ADD CONSTRAINT soli_volun_estado_fk FOREIGN KEY ( id_estado )
        REFERENCES estado ( id_estado );

ALTER TABLE solicitud_voluntariado
    ADD CONSTRAINT soli_volun_usuario_fk FOREIGN KEY ( id_usuario )
        REFERENCES usuario ( id_usuario );

ALTER TABLE tratamiento
    ADD CONSTRAINT tratamiento_estado_fk FOREIGN KEY ( id_estado )
        REFERENCES estado ( id_estado );

ALTER TABLE tratamiento
    ADD CONSTRAINT tratamiento_veterinario_fk FOREIGN KEY ( rut_personal )
        REFERENCES veterinario ( rut_personal );

ALTER TABLE usuario
    ADD CONSTRAINT usuario_personal_fk FOREIGN KEY ( rut_personal )
        REFERENCES personal ( rut_personal );

ALTER TABLE vacuna_animal
    ADD CONSTRAINT vacuna_animal_animal_fk FOREIGN KEY ( id_animal )
        REFERENCES animal ( id_animal );

ALTER TABLE vacuna_animal
    ADD CONSTRAINT vacuna_animal_vacuna_fk FOREIGN KEY ( id_vacuna )
        REFERENCES vacuna ( id_vacuna );

ALTER TABLE veterinario
    ADD CONSTRAINT veterinario_personal_fk FOREIGN KEY ( rut_personal )
        REFERENCES personal ( rut_personal );