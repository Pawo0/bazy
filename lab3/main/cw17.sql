use Northwind;

-- Wybierz nazwy i ceny produktów (baza northwind) o cenie jednostkowej pomiędzy 20.00 a 30.00, dla każdego produktu
-- podaj dane adresowe dostawcy
select ProductName, UnitPrice, s.CompanyName
from Products p
inner join Suppliers s
on p.SupplierID = s.SupplierID
where UnitPrice between 20 and 30;

-- Wybierz nazwy produktów oraz inf. o stanie magazynu dla produktów dostarczanych przez firmę ‘Tokyo Traders’
select ProductName, UnitsInStock
from Products p
inner join Suppliers s
on p.SupplierID = s.SupplierID
where s.CompanyName = 'Tokyo Traders'

-- Czy są jacyś klienci którzy nie złożyli żadnego zamówienia w 1997 roku, jeśli tak to pokaż ich dane adresowe
select c.*
from Customers c
left join (select *
            from Orders
            where year(OrderDate) = 1997) t
on c.CustomerID = t.CustomerID
where OrderID is null;

-- Wybierz nazwy i numery telefonów dostawców, dostarczających produkty, których aktualnie nie  ma w magazynie.
select s.CompanyName, Phone, p.ProductName
from Products p
inner join Suppliers s
on p.SupplierID = s.SupplierID
where p.UnitsInStock = 0;

-- Wybierz zamówienia złożone w marcu 1997. Dla każdego takiego zamówienia wyświetl jego numer, datę złożenia zamówienia
-- oraz nazwę i numer telefonu klienta
select o.OrderID, o.OrderDate, c.CompanyName, c.Phone
from Orders o
inner join Customers c
on o.CustomerID = c.CustomerID
where year(OrderDate) = 1997 and month(OrderDate) = 3;