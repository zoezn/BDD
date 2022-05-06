/* Grupo 6
Daiana Lujan Servin Olivera
Tomas Caceres
Paulina Sánchez Bermúdez
Tania Paola Lenis Gómez
Dina Luz Perez Montes
Zoe Jimenez */


-- 1. Listar las canciones cuya duración sea mayor a 2 minutos.
SELECT *
FROM canciones
WHERE milisegundos > '120000';

-- 2. Listar las canciones cuyo nombre comience con una vocal.
SELECT nombre
from canciones
where nombre like 'a%' or nombre like 'e%'or nombre like 'i%' or nombre like 'o%' or nombre like 'u%';

-- 3. Listar las canciones ordenadas por compositor en forma descendente.
SELECT * FROM canciones 
ORDER BY compositor DESC;

-- Luego, por nombre en forma ascendente. Incluir únicamente aquellas canciones que tengan compositor.
SELECT * FROM canciones 
WHERE compositor != ''
ORDER BY nombre;

-- 4. a) Listar la cantidad de canciones de cada compositor.
select count(*) as "Cant Canciones", Compositor from canciones WHERE compositor != '' group by compositor ;

-- b) Modificar la consulta para incluir únicamente los compositores que tengan más de 10 canciones.
select count(*) as CantCanciones, Compositor 
from canciones 
WHERE compositor != '' 
group by compositor 
HAVING CantCanciones > 10;

-- 5. a) Listar el total facturado agrupado por ciudad. 
select sum(total), ciudad_de_facturacion 
from musimundos.facturas
group by ciudad_de_facturacion;

-- b) Modificar el listado del punto (a) mostrando únicamente las ciudades de Canadá.
select sum(total), ciudad_de_facturacion, pais_de_facturacion 
from musimundos.facturas
where pais_de_facturacion like "Canada"
group by ciudad_de_facturacion;

-- c) Modificar el listado del punto (a) mostrando únicamente las ciudades con una facturación mayor a 38.
SELECT 
    SUM(total), ciudad_de_facturacion
FROM
    facturas
GROUP BY ciudad_de_facturacion
HAVING SUM(total) > 38;

-- d) Modificar el listado del punto (a) agrupando la facturación por país, y luego por ciudad.
SELECT 
    SUM(total), pais_de_facturacion
FROM
    facturas
GROUP BY pais_de_facturacion;

SELECT 
    SUM(total), ciudad_de_facturacion
FROM
    facturas
GROUP BY ciudad_de_facturacion;

-- 6. a) Listar la duración mínima, máxima y promedio de las canciones. 
Select max(milisegundos) "Duración máxima", min(milisegundos) "Duración mínima", avg(milisegundos) "Duración promedio" from canciones;

-- b) Modificar el punto (a) mostrando la información agrupada por género. 
SELECT 
    generos.nombre as géneros,
    MIN(milisegundos) AS 'minimo duracion',
    MAX(milisegundos) AS 'maximo duracion',
    AVG(milisegundos) AS 'promedio duracion'
FROM
    canciones
        JOIN
    generos ON canciones.id_genero = generos.id
GROUP BY géneros;
