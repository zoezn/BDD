-- CLASE 14 --
-- Diana Milena Ramos Villa --
-- Zoe Jimenez --
-- Mario Esteban Medina --
-- Monica Bernal --
-- Laura Daniela Peralta Gutiérrez --
-- Dina Luz Perez Montes --

-- 1) ¿Cuántos clientes existen?

SELECT count(ClienteID) 
FROM clientes;

-- 2) ¿Cuántos clientes hay por ciudad?

SELECT Ciudad, count(ClienteID) 
FROM clientes 
GROUP BY Ciudad;

-- FACTURAS --
-- 1) ¿Cuál es el total de transporte?

SELECT SUM(Transporte) Total 
FROM facturas;

-- 2) ¿Cuál es el total de transporte por EnvioVia (empresa de envío)?

SELECT EnvioVia 'Empresa de envio', SUM(Transporte) 'Total transporte' 
FROM facturas GROUP BY EnvioVia;

-- 3) Calcular la cantidad de facturas por cliente. Ordenar descendentemente por cantidad de facturas.

SELECT ClienteID AS Cliente, COUNT(FacturaID) AS cantidadFacturas 
FROM facturas 
GROUP BY ClienteID 
ORDER BY cantidadFacturas desc;

-- 4) Obtener el Top 5 de clientes de acuerdo a su cantidad de facturas.

SELECT ClienteID AS Cliente, COUNT(FacturaID) AS cantidadFacturas 
FROM facturas 
GROUP BY ClienteID 
ORDER BY cantidadFacturas desc 
LIMIT 5;

-- 5) ¿Cuál es el país de envío menos frecuente de acuerdo a la cantidad de facturas?

SELECT PaisEnvio, count(FacturaID) cantidadFacturas 
FROM facturas 
GROUP BY PaisEnvio 
ORDER BY cantidadFacturas 
LIMIT 1;

-- 6) Se quiere otorgar un bono al empleado con más ventas. ¿Qué ID de empleado realizó más operaciones de ventas?

SELECT count(EmpleadoID) Ventas, EmpleadoID 
FROM facturas 
GROUP BY EmpleadoID 
ORDER BY Ventas 
DESC LIMIT 1;

-- SELECT count(EmpleadoID) SumaEmpleado, EmpleadoID FROM facturas GROUP BY EmpleadoID ORDER BY SumaEmpleado DESC LIMIT 1

-- FACTURA DETALLE --
-- 1) ¿Cuál es el producto que aparece en más líneas de la tabla Factura Detalle?

SELECT count(productoID) Veces, ProductoID	
FROM facturadetalle 
GROUP BY ProductoID 
ORDER BY Veces 
DESC LIMIT 1; 

-- 2) ¿Cuál es el total facturado? Considerar que el total facturado es la suma de cantidad por precio unitario.

SELECT SUM(PrecioUnitario*Cantidad) 'Total facturado' 
FROM facturadetalle;

-- 3) ¿Cuál es el total facturado para los productos ID entre 30 y 50?

SELECT ProductoID, SUM(Cantidad*PrecioUnitario) Total	
FROM facturadetalle  
GROUP BY ProductoID 
HAVING ProductoID BETWEEN 30 AND 50; 

-- 4) ¿Cuál es el precio unitario promedio de cada producto?

SELECT ProductoID, AVG(Preciounitario) 'Promedio'
FROM facturadetalle 
GROUP BY ProductoID;

-- 5) ¿Cuál es el precio unitario máximo?

SELECT productoID, MAX(precioUnitario) 'Max. precio unitario' 
FROM facturadetalle;


