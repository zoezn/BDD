/* Grupo 2
Tania Paola Lenis Gómez
Cristián David
Marcela Ramírez
Isabela Acosta
Diana Milena Ramos Villa
Zoe Jimenez
*/

-- PARTE UNO --
SELECT f.FacturaID, f.FechaFactura, c.Compania, cl.Contacto, ct.CategoriaNombre, 
p.ProductoNombre, fd.PrecioUnitario, fd.Cantidad
FROM facturas f
INNER JOIN correos c
ON c.CorreoID = f.EnvioVia
INNER JOIN clientes cl
ON cl.ClienteID = f.ClienteID
INNER JOIN facturadetalle fd
ON fd.FacturaID = f.FacturaID
INNER JOIN productos p
ON fd.ProductoID = p.ProductoID
INNER JOIN categorias ct
ON ct.CategoriaID = p.CategoriaID ;

-- PARTE 2 --
/* 1. Listar todas las categorías junto con información de sus productos. Incluir todas
 las categorías aunque no tengan productos. */

SELECT c.CategoriaNombre, p.ProductoNombre
FROM productos p
RIGHT JOIN categorias c
ON p.CategoriaID = c.CategoriaID;

/* 2. Listar la información de contacto de los clientes que no hayan comprado nunca
en emarket. */

SELECT cl.contacto, cl.Telefono, cl.Fax
FROM clientes cl
LEFT JOIN facturas f
ON cl.ClienteID = f.ClienteID
WHERE f.FacturaID IS NULL;

/* 3. Realizar un listado de productos. Para cada uno indicar su nombre, categoría, y
la información de contacto de su proveedor. Tener en cuenta que puede haber
productos para los cuales no se indicó quién es el proveedor. */

SELECT p.ProductoNombre, pr.Contacto, c.CategoriaNombre
FROM categorias c
RIGHT JOIN productos p
ON p.CategoriaID = c.CategoriaID
LEFT JOIN proveedores pr
ON pr.ProveedorID = p.ProveedorID ;

/* 4. Para cada categoría listar el promedio del precio unitario de sus productos. */

SELECT c.CategoriaNombre, AVG(p.PrecioUnitario) promedio
FROM categorias c
JOIN productos p
ON p.CategoriaID = c.CategoriaID
GROUP BY c.CategoriaNombre ;

/* 5. Para cada cliente, indicar la última factura de compra. Incluir a los clientes que
nunca hayan comprado en e-market. */

SELECT cl.contacto, MAX(f.FechaFactura) "Ultima factura", f.FacturaID
FROM clientes cl
LEFT JOIN facturas f
ON cl.ClienteID = f.ClienteID
GROUP BY cl.Contacto;

/* 6. Todas las facturas tienen una empresa de correo asociada (enviovia). Generar un
listado con todas las empresas de correo, y la cantidad de facturas
correspondientes. Realizar la consulta utilizando RIGHT JOIN. */

SELECT c.Compania, COUNT(f.FacturaID) 'Cant. facturas'
FROM facturas f
RIGHT JOIN correos c
ON c.CorreoID = f.EnvioVia
GROUP BY c.Compania; 














