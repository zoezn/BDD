/* Grupo 2
Zoe Jimenez
Deisy Garzón León
Juan Ignacio
Victor Manuel Rayo Valencia
Lina Alejandra Mantilla Perafán
Gina Carolina Montoya Cruz
*/

/* 1 Crear una vista con los siguientes datos de los clientes: ID, contacto, y el
Fax. En caso de que no tenga Fax, colocar el teléfono, pero aclarándolo. Por
ejemplo: “TEL: (01) 123-4567” */

CREATE VIEW v_clientes AS
SELECT c.ClienteID, c.Contacto, COALESCE(c.fax, c.telefono)
FROM clientes c;

SELECT * FROM v_clientes;

/* 2. Se necesita listar los números de teléfono de los clientes que no tengan
fax. Hacerlo de dos formas distintas:
a. Consultando la tabla de clientes.
b. Consultando la vista de clientes. */

SELECT Contacto, Telefono, Fax
FROM clientes c
WHERE Fax = '';

/* Proveedores

1. Crear una vista con los siguientes datos de los proveedores: ID,
contacto, compañía y dirección. Para la dirección tomar la dirección,
ciudad, código postal y país */

CREATE VIEW c_proveedores AS
SELECT ProveedorID, Contacto, Compania, 
concat( direccion, ', ', ciudad,', ',pais,', ',codigoPostal) Direccion
FROM proveedores;

SELECT * FROM c_proveedores;


/* 2.  Listar los proveedores que vivan en la calle Americanas en Brasil. Hacerlo
de dos formas distintas:
a. Consultando la tabla de proveedores.
b. Consultando la vista de proveedores. */

-- a --
SELECT p.Contacto, p.Direccion, p.pais
FROM proveedores p
WHERE  p.direccion LIKE "%Americanas%"
WHERE p.pais;


-- b --







