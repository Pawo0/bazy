use Northwind;


-- Dla każdego pracownika (imię i nazwisko) podaj łączną wartość zamówień obsłużonych przez tego pracownika
-- Ogranicz wynik tylko do pracowników
-- a) którzy mają podwładnych
select E.EmployeeID, E.FirstName, E.LastName, sum(Quantity * UnitPrice * (1 - Discount))
from Employees E
         inner join Orders O on E.EmployeeID = O.EmployeeID
         inner join [Order Details] OD on O.OrderID = OD.OrderID
where exists(select 1
             from Employees E2
             where E2.ReportsTo = E.EmployeeID)
group by E.EmployeeID, E.FirstName, E.LastName;

-- b) którzy nie mają podwładnych
select E.EmployeeID, E.FirstName, E.LastName, sum(Quantity * UnitPrice * (1 - Discount))
from Employees E
         inner join Orders O on E.EmployeeID = O.EmployeeID
         inner join [Order Details] OD on O.OrderID = OD.OrderID
where not exists(select 1
                 from Employees E2
                 where E2.ReportsTo = E.EmployeeID)
group by E.EmployeeID, E.FirstName, E.LastName;

-- Napisz polecenie, które wyświetla klientów z Francji którzy w 1998r złożyli więcej niż dwa zamówienia oraz klientów 
-- z Niemiec którzy w 1997r złożyli więcej niż trzy zamówienia
select C.CompanyName
from Customers C
         inner join Orders O on C.CustomerID = O.CustomerID
group by C.CustomerID, C.CompanyName, Country
having (Country = 'France' and count(*) > 2)
    or (Country = 'Germany' and count(*) > 3);

