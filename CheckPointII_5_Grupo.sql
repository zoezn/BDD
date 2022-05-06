/* Camada 1 : 1021TDIIBD1C1LAED1021FT
Grupo 5
Cecilia Abate
Tania Paola Lenis Gómez 
Zoe Jimenez
Juan Ignacio Morales
*/

/* 1. Listar todos los clientes cuyo nombre comience con la letra "A". Se debe mostrar
id como "Número de cliente", apellido y nombre.*/
SELECT nombre, id "Número de cliente", apellido 
FROM cliente 
WHERE nombre LIKE "A%";
-- 5 rows 

/* 2. Mostrar el número de la sucursal con domicilio "Ramón Freire Serrano 7410". */
SELECT numero 
FROM  sucursal 
WHERE domicilio LIKE "Ramón Freire Serrano 7410";
-- 1 row 

/*3. Se requiere saber cuál es el mayor importe prestado*/
SELECT MAX(importe)
FROM prestamo;
-- 1 row 

/*4. Listar los pagos realizados con números 10, 14, 27, 45.*/
SELECT id FROM pago WHERE id in (10 ,14, 27, 45);
-- 4 rows 


/* 5. Calcular el total de los pagos realizados para el préstamo número cuarenta. El
reporte debe tener dos columnas denominadas "Número de préstamo" y el
"Total pagado".*/
SELECT prestamo_id "Número de préstamo", sum(importe) "Total pagado"  
FROM pago 
WHERE prestamo_id = "40";
-- 1 row

/*6. Listar los empleados que no pertenezcan a la sucursal dos y que la fecha de alta del contrato sea mayor que 5/09/21 o igual a 25/06/21. Ordenar por alta de
contrato.-*/
SELECT alta_contrato_laboral, sucursal_numero
FROM empleado
WHERE sucursal_numero <>2 AND alta_contrato_laboral >'2021-09-05' AND '2021-06-25';
-- 1 row


/*7. Listar los pagos realizados con importe entre $1030,25 a $1666,66 (ordenarlos
por el importe pagado de mayor a menor).*/
SELECT importe
FROM pago
WHERE importe between 1030.25 AND 1666.66 
ORDER BY importe DESC;
-- 14 rows


/*8. Mostrar el quinto pago realizado con menor importe.*/
SELECT importe, id
FROM pago
ORDER BY importe
LIMIT 1 OFFSET 4;
-- 1 row

/*9. Mostrar el préstamo con mayor importe. Este reporte debe contener el número
del préstamo, la fecha de otorgamiento y el importe. */
SELECT max(importe), id, fecha_otorgado
FROM prestamo;
-- 1 row


/* 10. Mostrar las diez cuentas bancarias con menor saldo. Este reporte debe contener
el número de cuenta, saldo y el código del tipo de cuenta.*/
SELECT numero, saldo, cuenta_tipo_id  
FROM cuenta 
ORDER BY saldo ASC 
LIMIT 10;
-- 10 rows


-- 11. Listar los préstamos otorgados entre 10/07/21 al 10/08/21 (ordenarlos por fecha
-- de otorgamiento)
select * from prestamo
where fecha_otorgado between '2021-07-10' and '2021-08-10'
order by fecha_otorgado desc;
-- 10 rows


-- 12. Listar en forma ordenada las cuentas bancarias que tengan un descubierto
-- otorgado superior o igual a $8999,80.
select * from cuenta
where descubierto_otorgado > '8999,80'
order by numero;
-- 10 rows


-- 13. Listar todos los empleados cuyo apellido termine con los caracteres "do". Se
-- debe mostrar el legajo, apellido, nombre y email.
select legajo, apellido, nombre, email
from empleado
where apellido like "%do";
-- 4 rows


-- 14. Se desea conocer cuál es el promedio de los saldos de las cajas de ahorro
select avg(saldo) 
from cuenta;
-- 1 row


-- 15. Mostrar el tercer préstamo con mayor importe.
select * from  prestamo
order by importe
limit 1
offset 2;
-- 1 row


-- 16. Calcular la cantidad de cuentas que tiene la sucursal número cinco. El reporte
-- debe tener dos columnas denominadas "Sucursal" y el "Cantidad de Cuentas".
select count(numero) as cantidad_de_cuentas, sucursal_numero as sucursal
from cuenta
where sucursal_numero = 5;
-- 1 row


-- 17. Mostrar todas las ciudades que contengan una palabra de cinco caracteres, pero
-- el tercer carácter debe ser igual a "n".
select * from ciudad
where nombre like "%_n__%";
-- 43 rows

-- 18. Modificar el tipo de cuenta bancaria "Cuenta Corriente" a "Cuenta Especial"
select  replace (tipo, "CUENTA CORRIENTE", "Cuenta Especial")
from cuenta_tipo;
-- 2 rows


-- 19. En la fecha de hoy, agregar en la sucursal número nueve al empleado Quinteros Arias Raúl Alejandro con domicilio en Av. 25 de mayo 7410 - Pilar - Buenos Aires, mail: quiteros2021bs@gmail.com, teléfono móvil: '+5491154000745'.
insert into empleado values (default, 9, 'Arias', 'Raúl Alejandro', 'Av. 25 de mayo 7410 - Pilar', 44 , 'quiteros2021bs@gmail.com', '+5491154000745', '2021-11-15' );
-- 1 row

-- 20. Eliminar el registro del préstamo número cuarenta y cinco
delete from prestamo
where id=45;
-- no se puede borrar registro por la clave foránea
 
