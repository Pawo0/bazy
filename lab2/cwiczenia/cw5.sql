use Northwind;

-- Dla każdego pracownika podaj liczbę obsługiwanych przez niego zamówień z podziałem na lata
select EmployeeID, year(OrderDate) as year, count(*) as [Orders handled]
from Orders
group by EmployeeID, year(OrderDate);
    
-- Dla każdego pracownika podaj liczbę obsługiwanych przez niego zamówień z podziałem na lata i miesiące.
select EmployeeID, year(OrderDate) as year, month(OrderDate) as month, count(*) as [Orders handled]
from Orders
group by EmployeeID, year(OrderDate), month(OrderDate);