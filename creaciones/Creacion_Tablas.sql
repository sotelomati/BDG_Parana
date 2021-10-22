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

CREATE TABLE localidades(
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL
);

INSERT INTO localidades(nombre)
SELECT DISTINCT localidad FROM public."AUX_escuelas_parana";


CREATE TABLE escuelas(
	gid VARCHAR(25) PRIMARY KEY,
	geom geometry NOT NULL,
	nombre VARCHAR(200),
	sector VARCHAR(1),
	domicilio VARCHAR(200),
	email VARCHAR(200),
	localidad_id INTEGER,
	FOREIGN KEY(localidad_id) REFERENCES localidad(id)
);


Escuelas:
 Tipo educación
