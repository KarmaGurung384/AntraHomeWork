-- 1. How many products can you find in the Production.Product table?
select distinct COUNT(Name) as TotalnumberOfProducts
from production.Product

-- 2.Write a query that retrieves the number of products in the Production.Product table that are included in a subcategory. The rows that have NULL in column ProductSubcategoryID are considered to not be a part of any subcategory
select distinct COUNT(Name) as NumberOfProducts
from production.product
where ProductSubcategoryID IS NOT null


--3. How many Products reside in each SubCategory? Write a query to display the results with the following titles.
--ProductSubcategoryID CountedProducts
select ProductSubcategoryID, COUNT(Name) as CountedProducts
from production.product
group by ProductSubcategoryID 

---------4.  How many products that do not have a product subcategory.
select COunt(ProductSubcategoryID) as CountSubcatergory 
From Production.Product
where ProductSubcategoryID is NULL

--5 Write a query to list the sum of products quantity in the Production.ProductInventory table.
select sum( quantity) as SumofProducts
from Production.ProductInventory

-- 6.Write a query to list the sum of products in the Production.ProductInventory table and LocationID set to 40 and limit the result to include just summarized quantities less than 100.
  --  ProductID    TheSum

      select i.ProductID, SUM(i.quantity) AS TheSum
	  from Production.ProductInventory i left join
	  production.Location l on l.LocationID=i.LocationID
	  where l.LocationID = 40
	  and i.Quantity<100
	  GROUP BY i.ProductID

--7. Write a query to list the sum of products with the shelf information in the Production.ProductInventory table and LocationID set to 40 and limit the result to include just summarized quantities less than 100
--   Shelf      ProductID    TheSum

      select i.Shelf,i.ProductID, SUM(i.quantity) AS TheSum
	  from Production.ProductInventory i left join
	  production.Location l on l.LocationID=i.LocationID
	  where l.LocationID = 40
	  and i.Quantity<100
	  Group by i.Shelf, i.ProductID

--8. Write the query to list the average quantity for products where column LocationID has the value of 10 from the table Production.ProductInventory table
    select AVG(Quantity) as AverageQuantity
	from Production.ProductInventory
	Where LocationID = 10

--9. Write query  to see the average quantity  of  products by shelf  from the table Production.ProductInventory
-- ProductID   Shelf      TheAvg
     select productID, Shelf, AVG(Quantity) AS TheAvg
	 from Production.ProductInventory
	 group by Shelf, ProductID

--10. Write query  to see the average quantity  of  products by shelf excluding rows that has the value of N/A in the column Shelf from the table Production.ProductInventory
-- ProductID   Shelf      TheAvg
  select ProductID, Shelf, AVG(quantity) as TheAvg
  from Production.ProductInventory
  where Shelf NOT LIKE '%N/A%'
  group by Shelf, ProductID
  
  --11.List the members (rows) and average list price in the Production.Product table. This should be grouped independently over the Color and the Class column. Exclude the rows where Color or Class are null.
--  Color                       Class              TheCount          AvgPrice
select color,class, AVG(ListPrice) as AvgPrice
from Production.product p
where color is NOT NULL
AND Class is NOT NULL
group by color, class

--- 12.  Write a query that lists the country and province names from person. CountryRegion and person. StateProvince tables. Join them and produce a result set similar to the following.
--    Country                        Province
Select distinct r.Name as Country, p.StateProvinceCode as Province
from person.CountryRegion r LEFT JOIN
Person.StateProvince p on r.CountryRegionCode = p.CountryRegionCode


--- 13. Write a query that lists the country and province names from person. CountryRegion and person. StateProvince tables and list the countries filter them by Germany and Canada. Join them and produce a result set similar to the following.
  --Country                        Province 
 Select distinct r.Name as Country, p.StateProvinceCode as Province
   from person.CountryRegion r LEFT JOIN
Person.StateProvince p on r.CountryRegionCode = p.CountryRegionCode
where r.Name IN('Germany','Canada')


---------#-14.  List all Products that has been sold at least once in last 25 years.
    Select P.productNmae
	from [order details] od left join
	Products p on
	p.productid=od.productid
	join Order o on
	o.orderID=od.orderID
	where od.quantity >= 1
	AND o.orderdate between '1997-01-01' and '2012-12-31'


--------15. List top 5 locations (Zip Code) where the products sold most.
select TOP 5 o.shipPostalCode, MAX(Productname)
from [order details] od left join
	Products p on
	p.productid=od.productid
	join Order o on
	o.orderID=od.orderID


--- 16. -List top 5 locations (Zip Code) where the products sold most in last 25 years.
 Select TOP 5 O.shippostalcode
	from [order details] od left join
	Products p on
	p.productid=od.productid
	join Order o on
	o.orderID=od.orderID
	where od.quantity >= 1
	AND o.orderdate between '1997-01-01' and '2012-12-31'

--- 17.List all city names and number of customers in that city.   
    select  City, COUNT( DISTINCT CustomerID) AS NumberOfCustomer
	from Customers
	group by city, CustomerID 


---18 List city names which have more than 2 customers, and number of customers in that city
    select distinct c.City, count(c.CustomerID) AS NumberOfCustomer
	From Customers c left join
	orders o on o.customerID=c.customerID
	WHERE O.customerID>2
	Group by c.city

 

	--19List the names of customers who placed orders after 1/1/98 with order date
	select c.ContactName, o.orderdate
	from customerS c left join
	[orders] o on o.customerID=c.customerID
	Where o.orderdate < '1998-01-01'

	-- 20.List the names of all customers with most recent order dates

	select c.ContactName, MAX(o.orderdate)
	from customerS c left join
	[orders] o on o.customerID=c.customerID


	--21.. Display the names of all customers  along with the  count of products they bought
	select c.contactname, count(od.quantity)
	from customers c left join
	[orders] o on o.customerID=c.customerID
	JOIN [Order Details] od on o.orderID=od.orderID
	JOIN Products p on p.productID = od.orderID
	group by c.contactName


--22.Display the customer ids who bought more than 100 Products with count of products.
select c.customerID, count(p.ProductID) AS TotalCount
	from customers c left join
	[orders] o on o.customerID=c.customerID
	JOIN [Order Details] od on o.orderID=od.orderID
	JOIN Products p on p.productID = od.productID
	where od.quantity> 100
	Group by c.customerID


--23.   List all of the possible ways that suppliers can ship their products. Display the results as below
--Supplier Company Name                Shipping Company Name

Select si.CompanyName
From Shippers si
 Union
 Select su.CompanyName 
 From Suppliers su

 
 --24. Display the products order each day. Show Order date and Product Name.
 select o.orderdate, p.productName
 from orders o left join
[order details] od on o.orderID=od.orderID
JOIN Products p on p.productID=od.productID
GROUP BY o.orderdate, p.productname

--25. .  Displays pairs of employees who have the same job title
select e.firstname, e.lastname 
from employees e
group by e.firstname, e.lastname 
having count(title)>1

---26. Display all the Managers who have more than 2 employees reporting to them.
Select e.EmployeeID, e.FirstName + ' ' + e.LastName, e.ReportsTo, m.EmployeeID, m.FirstName + ' ' + m.LastName as [Manager Name]
From Employees e Join Employees m
On e.ReportsTo = m.EmployeeID

--27.Display the customers and suppliers by city. The results should have the following columns
-- city name contact name type (Customer or Supplier)

Select c.city as Cityname, c.contactname as contactname
from customers c
union
select s.city as Cityname ,s.contactname as contactname 
from suppliers s

