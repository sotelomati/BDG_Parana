/*
Eliminamos el punto Z del geojson ya que no lo vamos a utilizar y complejiza las Query
*/

CREATE TABLE Paradas_colectivos (
	Gid integer NOT NULL PRIMARY KEY,
	Geom geometry NOT NULL,
	Numero_linea varchar(5),
	Numero_parada integer,
	Ida_vuelta boolean
)

Insert INTO Paradas_colectivos
SELECT id, geom, linea, CAST("Name" AS INTEGER), CAST(ida AS BOOLEAN) FROM public."Lineas_prueba";

select * from Paradas_colectivos where Numero_linea like '1' and ida_vuelta = True order by numero_parada