------------------------------------------------------------
--                      CALLES                            --
------------------------------------------------------------


CREATE TABLE calles_tipo(
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(20)
);

INSERT INTO calles_tipo(nombre)
SELECT DISTINCT highway FROM public."AUX_calles_parana";

CREATE TABLE calles(
	gid VARCHAR(15) PRIMARY KEY,
	geom geometry NOT NULL,
	nombre VARCHAR(100),
	tipo_id INTEGER,
	FOREIGN KEY(tipo_id) REFERENCES calles_tipo(id)
)

INSERT INTO calles(gid,geom,nombre,tipo_id)
SELECT id, geom, name, (SELECT id FROM calles_tipo WHERE nombre LIKE highway) FROM public."AUX_calles_parana";


------------------------------------------------------------
--                      PROPIEDADES                       --
------------------------------------------------------------


CREATE TABLE propiedades_tipo(
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(20)
);

INSERT INTO propiedades_tipo(nombre)
SELECT DISTINCT tipo FROM public.casas_ventas;

CREATE TABLE propiedades(
	gid VARCHAR(25) PRIMARY KEY,
	geom geometry NOT NULL,
	titulo VARCHAR(200),
	descripcion VARCHAR(3000),
	operacion VARCHAR(1),
	tipo_id INTEGER,
	habitaciones INTEGER,
	dormitorios INTEGER,
	banios INTEGER,
	sup_total INTEGER,
	sup_cubierta INTEGER,
	precio INTEGER,
	moneda  VARCHAR(3),
	periodo VARCHAR(20),
	FOREIGN KEY(tipo_id) REFERENCES propiedades_tipo(id)
);

INSERT INTO propiedades(gid,geom,titulo,descripcion,operacion,tipo_id,habitaciones,dormitorios,banios,sup_total,sup_cubierta,precio,moneda,periodo)
SELECT id_cv, geom, titulo, descripcion, LEFT(operacion,1), (SELECT id FROM propiedades_tipo WHERE nombre LIKE tipo), habitaciones, dormitorio, bano, superficie_total, superficie_cubierta, precio, moneda, precio_periodo 
FROM public.casas_ventas;


------------------------------------------------------------
--                      COMISARIAS                        --
------------------------------------------------------------


CREATE TABLE comisarias(
	gid VARCHAR(25) PRIMARY KEY,
	geom geometry NOT NULL,
	nombre VARCHAR(200)
);

INSERT INTO comisarias(gid,geom,nombre)
SELECT id, geom, "Name"	FROM public."AUX_comisarias";


------------------------------------------------------------
--                  CENTROS DE SALUD                      --
------------------------------------------------------------

CREATE TABLE centros_salud(
	gid VARCHAR(25) PRIMARY KEY,
	geom geometry NOT NULL,
	nombre VARCHAR(200)
);

INSERT INTO centros_salud(gid,geom,nombre)
SELECT id, geom, "Name" FROM public."AUX_hospitales";


------------------------------------------------------------
--                     ESCUELAS                           --
------------------------------------------------------------

CREATE TABLE escuelas(
	gid VARCHAR(25) PRIMARY KEY,
	geom geometry NOT NULL,
	nombre VARCHAR(200),
	sector VARCHAR(50),
	domicilio VARCHAR(200),
	email VARCHAR(200),
	localidad VARCHAR(50) DEFAULT 'PARANA',
	edu_comun BOOLEAN DEFAULT FALSE,
	edu_especial BOOLEAN DEFAULT FALSE,
	edu_jov_adultos BOOLEAN DEFAULT FALSE,
	edu_arte BOOLEAN DEFAULT FALSE,
	edu_servicios BOOLEAN DEFAULT FALSE
);

INSERT INTO escuelas(gid,geom,nombre,sector,domicilio,email,edu_comun,edu_especial,edu_jov_adultos,edu_arte,edu_servicios)
SELECT gid,geom,nombre,sector,domicilio,email,(CASE ed_comun WHEN 'X' THEN TRUE ELSE FALSE END),(CASE ed_especia WHEN 'X' THEN TRUE ELSE FALSE END),(CASE ed_jov_adu WHEN 'X' THEN TRUE ELSE FALSE END),(CASE ed_arte WHEN 'X' THEN TRUE ELSE FALSE END),(CASE servicios_ WHEN 'X' THEN TRUE ELSE FALSE END)
FROM public."AUX_escuelas_parana"
WHERE localidad = 'PARANA';


------------------------------------------------------------
--                   Radios censales                      --
------------------------------------------------------------

CREATE TABLE radios_censales(
	gid VARCHAR(25) PRIMARY KEY,
	geom geometry NOT NULL,
	varon INTEGER,
	mujer INTEGER,
	hogares INTEGER,
	jardin_preescolar INTEGER,
	primario INTEGER,
	egb INTEGER,
	secundario INTEGER,
	polimodal INTEGER,
	superior INTEGER,
	universitario INTEGER,
	post_universitario INTEGER,
	especial INTEGER
);

INSERT INTO radios_censales(gid,geom,varon,mujer,hogares,jardin_preescolar,primario,egb,secundario,polimodal,superior,universitario,post_universitario,especial)
SELECT id, geom, varon, mujer, hogares, "PERSONA-P09.csv_1 Inicial (jard�n, preescolar)", "PERSONA-P09.csv_2 Primario", "PERSONA-P09.csv_3 EGB", "PERSONA-P09.csv_4 Secundario", "PERSONA-P09.csv_5 Polimodal", "PERSONA-P09.csv_6 Superior no universitario", "PERSONA-P09.csv_7 Universitario", "PERSONA-P09.csv_8 Post universitario", "PERSONA-P09.csv_9 Educaci�n especial"
FROM public."AUX_radios_censales_parana";
