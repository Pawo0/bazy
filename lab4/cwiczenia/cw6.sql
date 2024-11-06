use Northwind;


-- Podaj produkty kupowane przez więcej niż jednego klienta
select p.ProductID, p.ProductName
from Products p
         inner join [Order Details] od on p.ProductID = od.ProductID
         inner join Orders o on od.OrderID = o.OrderID
group by p.ProductID, p.ProductName
having count(distinct CustomerID) >= 2

-- Podaj produkty kupowane w 1997r przez więcej niż jednego klienta
select p.ProductID, p.ProductName
from Products p
         inner join [Order Details] od on p.ProductID = od.ProductID
         inner join Orders o on od.OrderID = o.OrderID
where year(OrderDate) = 1997
group by p.ProductID, p.ProductName
having count(distinct CustomerID) >= 2


-- Podaj nazwy klientów którzy w 1997r kupili co najmniej dwa różne produkty z kategorii 'Confections'
select *
from Customers cu
where exists(select 1
             from Orders o
                      inner join [Order Details] od on o.OrderID = od.OrderID
                      inner join Products p on od.ProductID = p.ProductID
                      inner join Categories cat on p.CategoryID = cat.CategoryID
             where CategoryName = 'Confections'
               and year(OrderDate) = 1997
               and cu.CustomerID = CustomerID
             group by CustomerID, cat.CategoryName, cat.CategoryID
             having count(*) >= 2);

