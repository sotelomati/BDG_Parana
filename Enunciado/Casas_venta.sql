select * from public."AUXCasas_ventas"

CREATE TABLE IF NOT EXISTS Casas_ventas
(
    id_cv character varying NOT NULL,
    geom geometry(Point,5347),
    start_date date,
    end_date date,
    lat double precision,
    lon double precision,
    provincia character varying,
    departamento character varying,
    operacion character varying ,
    tipo character varying,
    habitaciones integer,
    dormitorio integer,
    bano integer,
    superficie_total integer,
    superficie_cubierta integer,
    precio integer,
    moneda character varying COLLATE pg_catalog."default",
    precio_periodo character varying COLLATE pg_catalog."default",
    titulo character varying COLLATE pg_catalog."default",
    descripcion character varying COLLATE pg_catalog."default",
    CONSTRAINT "Casas_ventas_pkey" PRIMARY KEY (id_cv)
)

INSERT INTO casas_ventas
SELECT id, geom, start_date, end_date, lat, lon,l2,l3,operation, type, rooms, bedrooms, bathrooms, surface_total, surface_covered, price, currency, price_period, title, description
	FROM public."AUXCasas_ventas" where l3 like 'Paraná'





