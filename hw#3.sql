

-- Karma Gurung 
-- HW#3 
--1.      List all cities that have both Employees and Customers.
Select c.City
From Customers c
Union 
Select City 
From Employees e
Order By City

--2  List all cities that have Customers but no Employee.
--a.  Use sub-query
select distinct city 
from Customers c
where city NOT IN(Select e.city
from Employees e
where e.city=C.City)


--b. do not use sub-query

select c.City
from customers c
except
select e.city
from Employees e


--3. List all products and their total order quantities throughout all orders.

select p.ProductName, sum(od.quantity) as TotalOrderQuantity,	Dense_RANK() over (order by od.quantity) [rank]
from orders o left join [Order Details] as od
on o.OrderID=od.OrderID
JOIN products p on p.ProductID=od.ProductID
group by p.ProductName, od.Quantity

--Select ProductName, UnitPrice, Dense_Rank() Over(Order By UnitPrice) [Rank]
--From Products

--4. List all Customer Cities and total products ordered by that city.
select c.city, sum(od.quantity) as TotalProducts , rank() over (order by city) [rank]
from customers c left join
orders o on c.customerID= o.CustomerID
join [Order Details] od on od.orderID=o.OrderID
group by c.city


--5. List all Customer Cities that have at least two customers.

--a. Use union
select c.city
from customers c

Intersect

select o.Shipcity
from Orders o
where o.ShipCity>2


--b.  Use sub-query and no union

select c.city
from Customers c
where c.city >2 (select ShipCity
from orders o)



--6.List all Customer Cities that have ordered at least two different kinds of products.


select c.city, count(p.category)
from products p left join orderdetails od
on p.productID=od.productID
JOIN ORDERS O ON od.orderID=O.orderid
join customers c on c.customerID=O.customerID
group by c.city, p.category 






--7. List all Customers who have ordered products, but have the ‘ship city’ on the order different from their own customer cities.

 select p.productName, AVG(od.quantity), c.City, Rank() over(partition by p.productName order by o.shipcity) as [rank]
 from Customers c right join orders o on o.customerID = C.customerID
JOIN [Order Details] od on o.OrderID=od.OrderID
JOIN products p on p.ProductID=od.ProductID
group by p.ProductName, od.Quantity, s.city 


--8.      List 5 most popular products, their average price, and the customer city that ordered most quantity of it.

 select top 5 p.productName, AVG(od.quantity), c.City, Rank() over(partition by p.productName order by od.quantity) as [rank]
 from Customers c right join orders o on o.customerID = C.customerID
JOIN [Order Details] od on o.OrderID=od.OrderID
JOIN products p on p.ProductID=od.ProductID
group by p.ProductName, od.Quantity, c.city 



 --Select p.SupplierID, p.ProductName, Rank() Over(Partition By p.SupplierId Order By p.UnitPrice) as [Rank]
--From Products p
--9.      List all cities that have never ordered something but we have employees there.

--a.      Use sub-query

select distinct c.city 
from Customers c
where city IN (Select e.city 
from employees e left join
orders o on o.EmployeeID=e.EmployeeID
join [Order Details] od on o.OrderID=od.OrderID
where od.Quantity=0)


--b.      Do not use sub-query
select c.city 
from Customers c right join orders o
on o.CustomerID= c.CustomerID
join Employees e on e.EmployeeID =o.EmployeeID
where e.city is not null

union

Select e.city 
from employees e left join
orders o on o.EmployeeID=e.EmployeeID
join [Order Details] od on o.OrderID=od.OrderID
where od.Quantity=0





--10.  List one city, if exists, that is the city from where the employee sold most orders (not the product quantity) is, and also the city of most total quantity of products ordered from. (tip: join  sub-query)

select  c.city 
from Customers c
where city IN (Select e.city, MAX(od.quantity)
from employees e left join
orders o on o.EmployeeID=e.EmployeeID
join [Order Details] od on o.OrderID=od.OrderID
group by e.city)


--11. How do you remove the duplicates record of a table?
--use union or distinct for unique columns