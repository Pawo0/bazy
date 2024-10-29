use Northwind;

-- Dla każdego zamówienia podaj łączną liczbę zamówionych jednostek towaru oraz nazwę klienta.
select O.OrderId, CompanyName, sum(Quantity) as totalUnitsCnt
from Orders O
         inner join Customers C on O.CustomerID = C.CustomerID
         inner join dbo.[Order Details] "[O D]" on O.OrderID = "[O D]".OrderID
group by CompanyName, O.OrderId


-- Dla każdego zamówienia podaj łączną wartość zamówionych produktów (wartość zamówienia bez opłaty za przesyłkę)
-- oraz nazwę klienta.
select O.OrderID, C.CompanyName, sum(UnitPrice * Quantity * (1 - Discount)) as OrderTotal
from Orders O
         inner join dbo.[Order Details] "[O D]" on O.OrderID = "[O D]".OrderID
         inner join dbo.Customers C on O.CustomerID = C.CustomerID
group by O.OrderID, C.CompanyName


-- Dla każdego zamówienia podaj łączną wartość tego zamówienia (wartość zamówienia wraz z opłatą za przesyłkę) oraz
-- nazwę klienta.
select O.OrderID, C.CompanyName, sum(UnitPrice * Quantity * (1 - Discount)) + Freight as OrderTotal
from Orders O
         inner join dbo.[Order Details] "[O D]" on O.OrderID = "[O D]".OrderID
         inner join dbo.Customers C on O.CustomerID = C.CustomerID
group by O.OrderID, C.CompanyName, Freight

-- Zmodyfikuj poprzednie przykłady tak żeby dodać jeszcze imię i nazwisko pracownika obsługującego zamówień
select O.OrderID,
       C.CompanyName,
       sum(UnitPrice * Quantity * (1 - Discount)) + Freight as OrderTotal,
       E.FirstName,
       E.LastName
from Orders O
         inner join dbo.[Order Details] "[O D]" on O.OrderID = "[O D]".OrderID
         inner join dbo.Customers C on O.CustomerID = C.CustomerID
         inner join dbo.Employees E on E.EmployeeID = O.EmployeeID
group by O.OrderID, C.CompanyName, Freight, E.FirstName, E.LastName
