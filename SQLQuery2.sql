--1.Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, with no filter.
Select ProductID, Name, Color, ListPrice
From Production.Product

--2. Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, excludes the rows that ListPrice is 0.
Select ProductID, Name, Color, ListPrice
From Production.Product
where ListPrice >0

--3. Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, the rows that are NULL for the Color column.
Select ProductID, Name, Color, ListPrice
From Production.Product
where color is NULL

-- 4. Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, the rows that are not NULL for the Color column.
Select ProductID, Name, Color, ListPrice
From Production.Product
WHERE COLOR IS NOT NULL

--5.Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, the rows that are not NULL for the column Color, and the column ListPrice has a value greater than zero.
Select ProductID, Name, Color, ListPrice
From Production.Product
Where color is not Null
AND ListPrice > 0 

--6 Write a query that concatenates the columns Name and Color from the Production.Product table by excluding the rows that are null for color.
SELECT CONCAT(Name, Color) as NameColor
fROM Production.Product
Where color is not NULL 

--7. Write a query that generates the following result set  from Production.Product:

/*NAME: LL Crankarm  --  COLOR: Black
NAME: ML Crankarm  --  COLOR: Black
NAME: HL Crankarm  --  COLOR: Black
NAME: Chainring Bolts  --  COLOR: Silver
NAME: Chainring Nut  --  COLOR: Silver
NAME: Chainring  --  COLOR: Black */

Select Name, color
from production.product 
where name like '%Crankarm'
or name like 'Chainring%'
order by name DESC

-- 8. Write a query to retrieve the to the columns ProductID and Name from the Production.Product table filtered by ProductID from 400 to 500
select ProductID, Name
from production.Product
where ProductID BETWEEN 400 AND 500

-- 9. Write a query to retrieve the to the columns  ProductID, Name and color from the Production.Product table restricted to the colors black and blue
SELECT ProductID, Name, Color
from Production.Product
where color in ('Black','Blue')

-- 10. Write a query to get a result set on products that begins with the letter S. 
select name
from production.product
where name like 'S%'

--11.Write a query that retrieves the columns Name and ListPrice from the Production.Product table. Your result set should look something like the following. Order the result set by the Name column. 
Select Name, ListPrice
from Production.Product
where name like 's%'
order by Name asc

--12. Write a query that retrieves the columns Name and ListPrice from the Production.Product table. Your result set should look something like the following. Order the result set by the Name column. The products name should start with either 'A' or 'S'

Select Name, ListPrice
from Production.Product
where name like 'A%' 
or name like 'S%'
order by name asc

--13. Write a query so you retrieve rows that have a Name that begins with the letters SPO, but is then not followed by the letter K. After this zero or more letters can exists. Order the result set by the Name column.
select name
from production.Product
where name like 'SPO[^_k]%'
order by name 

-- 14.-Write a query that retrieves unique colors from the table Production.Product. Order the results  in descending  manner
select distinct color
from production.product
order by color desc


--- 15.Write a query that retrieves the unique combination of columns ProductSubcategoryID and Color from the Production.Product table. Format and sort so the result set accordingly to the following. We do not want any rows that are NULL.in any of the two columns in the result.
select DISTINCT ProductSubcategoryID, color
FROM Production.product
where ProductSubcategoryID IS NOT NULL
AND color IS NOT NULL



