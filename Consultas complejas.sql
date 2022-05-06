-- Where
-- 1. Mostrar los nombre de los productos que tengan cualquier combinación de
-- ‘mountain bike’
-- Tablas: Product
-- Campos: Name

SELECT p.Name
FROM product p
WHERE p.Name like '%mountain bike%';

-- resuelto
SELECT Name FROM product
WHERE Name LIKE '%mountain%' OR Name LIKE '%bike%';


-- 2. Mostrar las personas cuyo nombre empiece con la letra “y”
-- Tablas: Contact
-- Campos: FirstName

SELECT FirstName
FROM contact
WHERE FirstName like "y%" ;

-- Order by
-- 1. Mostrar cinco productos más caros y su nombre ordenado en forma alfabética
-- Tablas: Product
-- Campos: Name, ListPrice

SELECT name, listprice
FROM product
ORDER BY listprice desc, name asc limit 5;

-- OPERADORES & JOINS
-- 1. Mostrar el nombre concatenado con el apellido de las personas cuyo apellido sea johnson
-- Tablas: Contact
-- Campos: FirstName, LastName

SELECT CONCAT(FirstName, ' ', LastName)
FROM contact
WHERE LastName = "johnson";


-- 2. Mostrar todos los productos cuyo precio sea inferior a 150$ de color rojo o cuyo precio sea mayor a 500$ de color negro
-- Tablas: Product
-- Campos: ListPrice, Color

SELECT ListPrice, Color
FROM Product
WHERE (ListPrice < 150 AND Color = "red") OR (ListPrice > 500 AND Color = "black");


-- FUNCIONES DE AGREGACIÓN
-- 1. Mostrar la fecha más reciente de venta
-- Tablas:  SalesOrderHeader
-- Campos: OrderDate

SELECT OrderDate
FROM SalesOrderHeader
ORDER BY orderdate DESC LIMIT 1 ;
-- resuelto
SELECT MAX(OrderDate) AS OrderDate FROM salesorderheader;

-- 2. Mostrar el precio más barato de todas las bicicletas
-- Tablas:  Product
-- Campos: ListPrice