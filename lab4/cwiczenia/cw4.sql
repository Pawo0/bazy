use Northwind;

-- Czy są jacyś klienci którzy nie złożyli żadnego zamówienia w 1997 roku, jeśli tak to pokaż ich dane adresowe
select CompanyName, Address
from Customers c
where not exists(select 1
                 from Orders o
                 where year(OrderDate) = 1997
                   and c.CustomerID = o.CustomerID);

-- Wybierz nazwy i numery telefonów klientów , którym w 1997 roku przesyłki dostarczała firma United Package.
select c.CompanyName, c.Phone
from Customers c
where exists(select 1
             from Orders o
                      inner join Shippers s on o.ShipVia = s.ShipperID
             where year(OrderDate) = 1997
               and c.CustomerID = o.CustomerID
               and s.CompanyName = 'United Package')

-- Wybierz nazwy i numery telefonów klientów , którym w 1997 roku przesyłek nie dostarczała firma United Package.
select c.CompanyName, c.Phone
from Customers c
where not exists(select 1
                 from Orders o
                          inner join Shippers s on o.ShipVia = s.ShipperID
                 where year(OrderDate) = 1997
                   and c.CustomerID = o.CustomerID
                   and s.CompanyName = 'United Package')


-- Wybierz nazwy i numery telefonów klientów, którzy kupowali produkty z kategorii Confections.
-- 1
select c.CompanyName, c.Phone
from Customers c
where exists(select 1
             from Orders o
                      inner join [Order Details] od on o.OrderID = od.OrderID
                      inner join Products p on od.ProductID = p.ProductID
                      inner join Categories cat on p.CategoryID = cat.CategoryID
             where cat.CategoryName = 'Confections'
               and o.CustomerID = c.CustomerID);

-- 2
select distinct c.CompanyName, c.Phone
from Orders o
         inner join [Order Details] od on o.OrderID = od.OrderID
         inner join Products p on od.ProductID = p.ProductID
         inner join Categories cat on p.CategoryID = cat.CategoryID
         inner join Customers c on o.CustomerID = c.CustomerID
where CategoryName = 'Confections'

-- Wybierz nazwy i numery telefonów klientów, którzy nie kupowali produktów z kategorii Confections.
select c.CompanyName, c.Phone
from Customers c
where not exists(select 1
                 from Orders o
                          inner join [Order Details] od on o.OrderID = od.OrderID
                          inner join Products p on od.ProductID = p.ProductID
                          inner join Categories cat on p.CategoryID = cat.CategoryID
                 where cat.CategoryName = 'Confections'
                   and o.CustomerID = c.CustomerID);

-- Wybierz nazwy i numery telefonów klientów, którzy w 1997r nie kupowali produktów z kategorii Confections.
select c.CompanyName, c.Phone
from Customers c
where not exists(select 1
                 from Orders o
                          inner join [Order Details] od on o.OrderID = od.OrderID
                          inner join Products p on od.ProductID = p.ProductID
                          inner join Categories cat on p.CategoryID = cat.CategoryID
                 where cat.CategoryName = 'Confections'
                   and o.CustomerID = c.CustomerID
                   and year(OrderDate) = 1997);
