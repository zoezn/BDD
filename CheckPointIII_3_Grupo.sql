-- ================= BASE DE DATOS I - PROYECTO - EL DESCUBIERTO ================= --
-- =============================== CHECKPOINT III ================================ --
-- Base de datos: el_descubierto
-- Camada N°: 1021TDIIBD1C1LAED1021FT
-- Equipo N°: 3
-- Integrantes: 
-- Alejandra Marin
-- Brenda Bueno
-- Elena Fischietto
-- Zoe Jimenez


-- 1. Listar todos los clientes que tengan tres o más cuentas bancarias. Mostrar el
-- número de cliente, apellido y nombre separado por un espacio dentro de una
-- misma columna denominada "Cliente" y, la cantidad de cuentas que posee.

select id, concat(apellido," ", nombre) as cliente, count(cliente_x_cuenta.cliente_id) as cuentas from cliente
inner join cliente_x_cuenta
on cliente_x_cuenta.cliente_id=cliente.id
group by id
having cuentas >=3;
-- 6 rows --

 
 -- 2. Listar todos los clientes que no tengan una cuenta bancaria. Mostrar el número
-- de cliente, apellido y nombre en mayúsculas dentro de una misma columna
-- denominada "Cliente sin cuenta bancaria".
 
select id, upper(concat(apellido," ", nombre)) as "cliente sin cuenta bancaria" , count(cliente_x_cuenta.cliente_id) as cuentas from cliente
left join  cliente_x_cuenta
on cliente_x_cuenta.cliente_id=cliente.id
group by id
having cuentas=0;
-- 8 rows --



-- 3. Listar todos los clientes que tengan al menos un préstamo que corresponda a la
-- sucursal de la ciudad de "Pilar - Buenos Aires". Se debe mostrar el número de
-- cliente, apellido, nombre, número de préstamo, número de sucursal, nombre de
-- la ciudad y país de dicha sucursal.

select cliente.id, concat(cliente.apellido," ", cliente.nombre) as "cliente", prestamo.id as prestamo, sucursal.numero as sucursal, ciudad.nombre as ciudad, pais.nombre as pais from cliente
inner join cliente_x_prestamo
on cliente_x_prestamo.cliente_id=cliente.id
inner join prestamo 
on cliente_x_prestamo.prestamo_id=prestamo.id
inner join sucursal
on sucursal.numero=prestamo.sucursal_numero
inner join ciudad
on sucursal.Ciudad_id=ciudad.id
inner join pais
on ciudad.pais_id=pais.id
where ciudad.nombre="Pilar - Buenos Aires"
group by cliente.id;
-- 2 rows --


-- 4. Listar los clientes que tengan una o más cajas de ahorro y que en la segunda letra de su apellido contenga una "e".
SELECT CONCAT(c.apellido, ' ', c.nombre) cliente, ct.tipo, cu.numero FROM cliente c
INNER JOIN cliente_x_cuenta cc ON cc.cliente_id = c.id
INNER JOIN cuenta cu ON cu.numero = cc.cuenta_numero
INNER JOIN cuenta_tipo ct ON ct.id = cu.cuenta_tipo_id
WHERE ct.id = 1 AND c.apellido LIKE '_e%';
-- Cantidad de registros devueltos (rows): 5


-- 5. Listar absolutamente todos los países y la cantidad de clientes que tengan.
SELECT p.nombre pais, COUNT(c.id) cantidad_clientes FROM cliente c
INNER JOIN ciudad ci ON ci.id = c.ciudad_id
RIGHT JOIN pais p ON p.id = ci.pais_id
GROUP BY pais;
-- Cantidad de registros devueltos (rows): 20


-- 6. Calcular el importe total y la cantidad de préstamos otorgados en el mes de
-- agosto por cada cliente. Mostrar el número de cliente, importe total y cantidad
-- de préstamos.

SELECT c.id 'Cliente ID', SUM(p.importe) 'Importe total', COUNT(p.id) 'Cantidad de préstamos'
FROM cliente_x_prestamo cp
INNER JOIN cliente c
ON c.id = cp.cliente_id
INNER JOIN prestamo p
ON p.id = cp.prestamo_id
WHERE MONTH(p.fecha_otorgado) = '08'
GROUP BY c.id;
-- 9 rows --


-- 7. Calcular el importe total y la cantidad de cuotas pagadas para el préstamo
-- número cuarenta.

SELECT p.id Prestamo, SUM(pg.importe) 'Importe total', COUNT(pg.id) 'Cantidad de pagos'
FROM prestamo p
INNER JOIN pago pg
ON pg.prestamo_id = p.id
WHERE p.id = 40;
-- 1 row --


-- 8. Determinar el importe restante que falta por pagar para el préstamo número 45. 

SELECT p.id 'Préstamo ID' , p.importe - SUM(pg.importe) 'Restante por pagar'
FROM pago pg
INNER JOIN prestamo p
ON pg.prestamo_id = p.id
WHERE p.id = 45;
-- 1 row --


-- 9. Listar los préstamos de la sucursal número cuatro. Mostrar el número de cliente, apellido, nombre y el número de préstamo. 
SELECT c.id 'Número de cliente', c.apellido, c.nombre, p.id 'Numero de préstamo'
FROM prestamo p
INNER JOIN cliente_x_prestamo cp
ON cp.prestamo_id = p.id
INNER JOIN cliente c
ON c.id = cp.cliente_id
INNER JOIN sucursal s
ON s.numero = sucursal_numero
WHERE sucursal_numero = 4;
-- 6 rows --


-- 10. Reportar el número del préstamo y la cantidad de cuotas pagadas por cada uno
-- préstamo. Se debe formatear el dato de la cantidad de cuotas pagadas, por
-- ejemplo, si se ha pagado una cuota, sería "1 cuota paga"; si se han pagado dos o
-- más cuotas, sería en plural "2 cuotas pagas" y "Ninguna cuota paga" para los 
-- préstamos que aún no han recibido un pago.


SELECT p.id,
CASE
WHEN count(pg.id)  = 1 THEN "1 cuota paga"
WHEN count(pg.id)  >= 2 THEN CONCAT(count(pg.id)," cuotas pagas")
WHEN count(pg.id) = 0 THEN "Ninguna cuota paga"
ELSE '' END
AS 'Cant. cuotas pagadas'
FROM pago pg
RIGHT JOIN prestamo p
ON p.id = pg.prestamo_id
GROUP BY p.id;
-- 47 rows --


-- 11. Listar absolutamente todos los empleados y las cuentas bancarias que tengan asociada. Mostrar en una sola columna el apellido y la letra inicial del nombre del empleado (Ej. Tello Aguilera C.), en otra columna, el número de cuenta y el tipo (Ej. 10560 - CAJA DE AHORRO). Los campos nulos deben figurar con la leyenda "-Sin asignación-".
SELECT COALESCE(CONCAT(e.apellido, ' ', LEFT(e.nombre,1)),'-Sin asignación-') empleado, CONCAT(c.numero, ' - ', ct.tipo) cuenta FROM cuenta c
LEFT JOIN empleado e ON e.legajo = c.ejecutivo_cuenta
LEFT JOIN cuenta_tipo ct ON ct.id = c.cuenta_tipo_id;
-- Cantidad de registros devueltos (rows): 61

-- 12. Reportar todos los datos de los clientes y los números de cuenta que tienen.
SELECT c.id, CONCAT(c. apellido, ' ', c.nombre) cliente, CONCAT(c.domicilio, ' | ', ci.nombre) domicilio, c.email, c.telefono_movil, cc.cuenta_numero FROM cliente c
INNER JOIN cliente_x_cuenta cc ON cc.cliente_id = c.id
INNER JOIN ciudad ci ON ci.id = c.ciudad_id;
-- Cantidad de registros devueltos (rows): 64 

-- 13. Listar los clientes con residencia en las ciudades de "Las Heras - Mendoza", "Viña del Mar - Valparaíso", "Córdoba - Córdoba" y "Monroe - Buenos Aires". Se debe mostrar el apellido, nombre del cliente y todos los datos referidos a la ciudad 
SELECT CONCAT(c.apellido, ' ',c.nombre) cliente, ci.id ciudad_id, ci.nombre ciudad, ci.codigo_postal, p.nombre pais FROM cliente c
INNER JOIN ciudad ci ON ci.id = c.ciudad_id
INNER JOIN pais p ON p.id = ci.pais_id
WHERE ci.nombre = 'Las Heras - Mendoza' OR ci.nombre = 'Viña del Mar - Valparaíso' OR ci.nombre = 'Córdoba - Córdoba' OR ci.nombre = 'Monroe - Buenos Aires';
-- Cantidad de registros devueltos (rows): 6

-- 14. Listar los clientes que tienen préstamos otorgados entre 15/08/21 al 5/09/21 (ordenarlos por fecha de otorgamiento). Mostrar sólo el email del cliente, teléfono móvil y todos los datos referidos al préstamo.
SELECT c.email, c.telefono_movil, p.id prestamo_id, p.sucursal_numero, p.fecha_otorgado, p.importe, p.cantidad_cuota FROM cliente c
INNER JOIN cliente_x_prestamo cp ON cp.cliente_id = c.id
INNER JOIN prestamo p ON p.id = cp.prestamo_id
WHERE p.fecha_otorgado BETWEEN '2021-08-15' AND '2021-09-05'
ORDER BY p.fecha_otorgado;
-- Cantidad de registros devueltos (rows): 4

-- 15. Listar de manera ordenada, los empleados que no pertenezcan a la sucursal de la ciudad "Monroe - Buenos Aires" y que la fecha de alta del contrato se halle dentro del rango 2016 al 2018. Mostrar el email del empleado, número de sucursal y el nombre de la ciudad
SELECT e. legajo, e.email, e.sucursal_numero, ci.nombre ciudad FROM empleado e
INNER JOIN sucursal s ON s.numero = e.sucursal_numero
INNER JOIN ciudad ci ON ci.id = e.ciudad_id
WHERE ci.id != 3 AND (YEAR(e.alta_contrato_laboral) BETWEEN '2016' AND '2018')
ORDER BY e.legajo;
-- Cantidad de registros devueltos (rows): 21


-- 16. Listar las cuentas bancarias que tienen dos titulares. Mostrar sólo el número de cuenta y la cantidad de titulares
-- Cantidad de registros devueltos (rows): 3
SELECT c.numero AS Num_Cuenta, COUNT(clcta.cliente_id) AS Cant_Titulares 
FROM cuenta c INNER JOIN cliente_x_cuenta clcta ON c.numero = clcta.cuenta_numero
INNER JOIN cliente cl ON clcta.cliente_id = cl.id 
GROUP BY Num_Cuenta HAVING Cant_Titulares = 2;


-- 17. Se desea conocer el segundo pago con mayor importe efectuado en las sucursales de Chile. 
-- Mostrar el número y hora de pago, importe pagado y el nombre del país.
-- Cantidad de registros devueltos (rows): 1
SELECT pa.id Numero_Pago, pa.fecha Fecha_y_Hora, pa.importe, pai.nombre FROM pago pa INNER JOIN prestamo pr ON pa.prestamo_id = pr.id
INNER JOIN sucursal s ON pr.sucursal_numero = s.numero 
INNER JOIN ciudad c ON s.Ciudad_id = c.id
INNER JOIN pais pai ON c.pais_id = pai.id WHERE pai.nombre = 'Chile' ORDER BY pa.importe DESC limit 1 offset 1;


-- 18. Listar los clientes que no tienen préstamos. Mostrar el apellido, nombre y email del cliente.
-- Cantidad de registros devueltos (rows): 20 
select c.apellido, c.nombre, c.email from cliente c left join cliente_x_prestamo cxp on c.id = cxp.cliente_id
left join prestamo p on cxp.prestamo_id = p.id where p.id is null;


-- 19. Se desea conocer el mes y año en que se terminaría de pagar el préstamo número treinta a partir de la fecha de otorgamiento. 
-- Se debe mostrar el email del cliente, número de préstamo, fecha de otorgamiento, importe prestado, mes y año que correspondería a la última cuota 
-- (Ej. "agosto de 2021").
-- Cantidad de registros devueltos (rows): 1
SELECT c.email, p.id, p.fecha_otorgado, p.importe, date_add(p.fecha_otorgado, INTERVAL p.cantidad_cuota Month) Fecha_Fin_Pago 
FROM cliente c INNER JOIN cliente_x_prestamo cxp ON c.id = cxp.cliente_id
LEFT JOIN prestamo p ON cxp.prestamo_id = p.id WHERE p.id = 30;


-- 20. Listar las ciudades (sin repetir) que tengan entre dos a cuatro cuentas bancarias. Se debe mostrar el país, ciudad y la cantidad de cuentas.
-- Además, se debe ordenar por país y ciudad.
-- Cantidad de registros devueltos (rows): 15
SELECT DISTINCT(CONCAT(p.nombre, ' / ', ci.nombre)) Pais_Ciudad, COUNT(cta.numero) Cant_cuentas FROM pais p INNER JOIN ciudad ci ON p.id = ci.pais_id INNER JOIN sucursal s ON ci.id = s.Ciudad_id 
INNER JOIN cuenta cta ON s.numero = cta.sucursal_numero GROUP BY Pais_Ciudad having Cant_cuentas BETWEEN 2 AND 4 ORDER BY Pais_Ciudad;

