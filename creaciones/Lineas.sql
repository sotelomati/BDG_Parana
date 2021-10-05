SELECT id, geom, "Linea", ida, "Name", description, "timestamp", begin, "end", "altitudeMode", tessellate, extrude, visibility, "drawOrder", icon, linea, dir
	FROM public."AuxLineas";
	
create table Paradascolectivo
(
	Gid integer NOT NULL,
    geom geometry(PointZ,5347),
	linea character varying,
	nparada character varying,
	ida boolean,
    CONSTRAINT "Lineas_pkey" PRIMARY KEY (Gid)
)
--drop table Paradascolectivo
insert into Paradascolectivo 
SELECT id, geom, "Linea","Name", cast(ida as boolean) FROM public."AuxLineas"; 

select * from Paradascolectivo

select ST_Transform((ST_MakePoint(ST_X(geom),ST_Y(geom))),4326) from Paradascolectivo
select ST_MakePoint(ST_X(geom),ST_Y(geom)) from Paradascolectivo