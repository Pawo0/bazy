use Northwind;

-- Który ze spedytorów był najaktywniejszy w 1997 roku, podaj nazwę tego spedytora
select top 1 with ties CompanyName
from Orders O
         inner join dbo.Shippers S on S.ShipperID = O.ShipVia
where year(OrderDate) = 1997
group by ShipperID, CompanyName
order by count(*) desc;

-- Dla każdego zamówienia podaj wartość zamówionych produktów. Zbiór wynikowy powinien zawierać nr zamówienia,
-- datę zamówienia, nazwę klienta oraz wartość zamówionych produktów
select O.OrderID, O.OrderDate, C.CompanyName, sum(UnitPrice * Quantity) as TotalValue
from Orders O
         inner join dbo.[Order Details] "[O D]" on O.OrderID = "[O D]".OrderID
         inner join dbo.Customers C on C.CustomerID = O.CustomerID
group by O.OrderID, O.OrderDate, C.CompanyName;

-- Dla każdego zamówienia podaj jego pełną wartość (wliczając opłatę za przesyłkę). Zbiór wynikowy powinien zawierać
-- nr zamówienia, datę zamówienia, nazwę klienta oraz pełną wartość zamówienia
select O.OrderId, O.OrderDate, C.CompanyName, sum(UnitPrice * Quantity * (1 - Discount)) + O.Freight as TotalPrice
from Orders O
         inner join dbo.[Order Details] "[O D]" on O.OrderID = "[O D]".OrderID
         inner join dbo.Customers C on C.CustomerID = O.CustomerID
group by O.OrderId, O.OrderDate, C.CompanyName, O.Freight;