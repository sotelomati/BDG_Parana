/*
Eliminamos el punto Z del geojson ya que no lo vamos a utilizar y complejiza las Query
*/

CREATE TABLE Paradas_colectivos (
	gid integer NOT NULL PRIMARY KEY,
	geom geometry NOT NULL,
	numero_linea varchar(5),
	numero_parada integer,
	ida_vuelta boolean
)

Insert INTO Paradas_colectivos
SELECT id, geom, linea, CAST("Name" AS INTEGER), CAST(ida AS BOOLEAN) FROM public."Lineas_prueba";

select * from Paradas_colectivos where Numero_linea like '1' and ida_vuelta = True order by numero_parada


010000

(Primeros dos digito numero de linea) (tercer digito ida 1 - vuelta 0) (ultimos 3 gid)