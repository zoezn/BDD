-- Caso de estudio: AdventureWorks - Consultas de repaso (Resolución)
-- Base de datos: AdventureWorks

-- WHERE
-- 1. Mostrar los nombre de los productos que tengan cualquier combinación de ‘mountain bike’
-- Tablas:  Product
-- Campos: Name
SELECT Name FROM product
WHERE Name LIKE '%mountain%' OR Name LIKE '%bike%';

-- 2. Mostrar las personas cuyo nombre empiece con la letra “y”
-- Tablas: Contact
-- Campos: FirstName
SELECT FirstName FROM contact
WHERE FirstName LIKE 'Y%';

-- ORDER BY
-- 1. Mostrar cinco productos más caros y su nombre ordenado en forma alfabética
-- Tablas: Product
-- Campos: Name, ListPrice
SELECT Name, ListPrice FROM product
ORDER BY ListPrice DESC, Name ASC LIMIT 5;

-- OPERADORES & JOINS
-- 1. Mostrar el nombre concatenado con el apellido de las personas cuyo apellido sea johnson
-- Tablas: Contact
-- Campos: FirstName, LastName
SELECT CONCAT(FirstName, ' ', LastName) FROM contact
WHERE LastName = 'johnson';

-- 2. Mostrar todos los productos cuyo precio sea inferior a 150$ de color rojo o cuyo precio sea mayor a 500$ de color negro
-- Tablas: Product
-- Campos: ListPrice, Color
SELECT ListPrice, Color FROM product
WHERE (ListPrice < 150 AND Color = 'Red') OR  (ListPrice > 500 AND Color = 'Black');

-- FUNCIONES DE AGREGACIÓN
-- 1. Mostrar la fecha más reciente de venta
-- Tablas:  SalesOrderHeader
-- Campos: OrderDate
SELECT MAX(OrderDate) AS OrderDate FROM salesorderheader;

-- 2. Mostrar el precio más barato de todas las bicicletas
-- Tablas:  Product
-- Campos: ListPrice
SELECT min(ListPrice) FROM product
WHERE Name LIKE '%bike%';


-- GROUP BY
-- 1. Mostrar los productos y la cantidad total vendida de cada uno de ellos
-- Tablas:  SalesOrderDetail
-- Campos: ProductID, OrderQty
SELECT ProductID, SUM(OrderQty) AS Cantidad FROM salesorderdetail
GROUP BY ProductID;


-- HAVING
-- 1. Mostrar la cantidad de facturas que vendieron más de 20 unidades.
-- Tablas: Sales.SalesOrderDetail
-- Campos: SalesOrderID, OrderQty
SELECT SalesOrderID, SUM(OrderQty) AS Cantidad FROM salesorderdetail
GROUP BY SalesOrderID HAVING Cantidad > 20;

-- JOINS
-- 1. Mostrar el código de logueo, número de territorio y sueldo básico de los vendedores
-- Tablas:  Employee,  SalesPerson
-- Campos: LoginID, TerritoryID, Bonus, SalesYTD
SELECT LoginID, TerritoryID, Bonus, SalesYTD FROM Employee e
INNER JOIN SalesPerson sp ON sp.SalesPersonID = e.employeeid;

-- 2. Mostrar los productos que sean ruedas
-- Tablas:  Product,  ProductSubcategory
-- Campos: Name, ProductSubcategoryID
SELECT p.Name, p.ProductSubcategoryID, ps.Name AS Subcategory FROM product p
INNER JOIN productsubcategory ps USING(ProductSubcategoryID)
WHERE ps.Name = 'Wheels';

-- 3.Mostrar los nombres de los productos que no son bicicletas
-- Tablas: Product,  ProductSubcategory
-- Campos: Name, ProductSubcategoryID
SELECT p.Name, p.ProductSubcategoryID, ps.Name AS Subcategory FROM product p
INNER JOIN productsubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID 
WHERE ps.Name NOT LIKE '%Bike%';