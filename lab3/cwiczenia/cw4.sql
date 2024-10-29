use Northwind;


-- Dla każdego przewoźnika (nazwa) podaj liczbę zamówień które przewieźli w 1997r
select CompanyName, count(*) as ShippedIn1997
from Shippers S
         inner join dbo.Orders O on S.ShipperID = O.ShipVia
where year(OrderDate) = 1997
group by S.ShipperID, S.CompanyName

-- Który z przewoźników był najaktywniejszy (przewiózł największą liczbę zamówień) w 1997r, podaj nazwę tego przewoźnika
select top 1 with ties CompanyName
from Shippers S
         inner join dbo.Orders O on S.ShipperID = O.ShipVia
where year(OrderDate) = 1997
group by S.ShipperID, S.CompanyName
order by count(*) desc

-- Dla każdego przewoźnika podaj łączną wartość "opłat za przesyłkę" przewożonych przez niego zamówień od '1998-05-03'
-- do '1998-05-29'
select S.CompanyName, sum(Freight)
from Shippers S
         inner join Orders O on S.ShipperID = O.ShipVia
where OrderDate between '1998-05-03' and '1998-05-29'
group by S.ShipperID, S.CompanyName;

-- Dla każdego pracownika (imię i nazwisko) podaj łączną wartość zamówień obsłużonych przez tego pracownika w maju 1996
select E.FirstName, E.LastName, sum(Quantity * UnitPrice * (1 - Discount))
from Employees E
         inner join Orders O on E.EmployeeID = O.EmployeeID
         inner join dbo.[Order Details] "[O D]" on O.OrderID = "[O D]".OrderID
where year(OrderDate) = 1996
  and month(OrderDate) = 6
group by E.EmployeeID, E.FirstName, E.LastName;

-- Który z pracowników obsłużył największą liczbę zamówień w 1996r, podaj imię i nazwisko takiego pracownika
select top 1 with ties E.FirstName, E.LastName
from Orders O
         inner join dbo.Employees E on E.EmployeeID = O.EmployeeID
where year(OrderDate) = 1996
group by E.EmployeeID, E.FirstName, E.LastName
order by count(*) desc;

-- Który z pracowników był najaktywniejszy (obsłużył zamówienia o największej wartości) w 1996r, podaj imię i nazwisko
-- takiego pracownika
select top 1 with ties E.FirstName, E.LastName
from Orders O
         inner join dbo.Employees E on E.EmployeeID = O.EmployeeID
         inner join dbo.[Order Details] "[O D]" on O.OrderID = "[O D]".OrderID
where year(OrderDate) = 1996
group by E.EmployeeID, E.FirstName, E.LastName
order by sum(Quantity * UnitPrice * (1 - Discount)) desc;
