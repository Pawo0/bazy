use Northwind;


-- Napisz polecenie, które wyświetla pracowników oraz ich podwładnych (baza northwind)
select *
from Employees E1
         inner join Employees E2 on E1.EmployeeID = E2.ReportsTo;

-- Napisz polecenie, które wyświetla pracowników, którzy nie mają podwładnych (baza northwind)
select *
from Employees E1
         left join Employees E2 on E1.EmployeeID = E2.ReportsTo
where E2.EmployeeID is null;

-- Napisz polecenie, które wyświetla pracowników, którzy mają podwładnych (baza northwind)
-- 1
select E1.EmployeeID, E1.FirstName, E1.LastName
from Employees E1
         inner join Employees E2 on E1.EmployeeID = E2.ReportsTo
group by E1.EmployeeID, E1.FirstName, E1.LastName

-- 2
select *
from Employees e
where e.EmployeeID in (select distinct ReportsTo
                       from Employees)

-- 3
select *
from Employees e
where exists(select 1
             from Employees e2
             where e2.ReportsTo = e.EmployeeID)


