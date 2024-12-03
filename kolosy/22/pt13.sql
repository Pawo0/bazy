-- zad 1)
-- Podaj nazwy produktów które w marcu 1997 nie były kupowane przez klientów z
-- Francji. Dla każdego takiego produktu podaj jego nazwę, nazwę kategorii do której
-- należy ten produkt oraz jego cenę.
with cte as (select ProductID
             from Customers c
                      inner join Orders o on c.CustomerID = o.CustomerID
                      inner join [Order Details] od on o.OrderID = od.OrderID
             where Country = 'France'
               and year(OrderDate) = 1997
               and month(OrderDate) = 3)
select ProductName, UnitPrice, CategoryName
from Products p
         inner join Categories c on p.CategoryID = c.CategoryID
where p.ProductID not in (select * from cte);


-- zad 2)
-- Napisz polecenie które wyświetla imiona i nazwiska dorosłych członków biblioteki,
-- mieszkających w Arizonie (AZ) lub Kalifornii (CA), których wszystkie dzieci są
-- urodzone przed '2000-10-14'
use library
with with_young_child as (select adult_member_no
                          from juvenile j
                          group by adult_member_no
                          having max(birth_date) < '2000-10-14')
select firstname, lastname
from member m
         inner join adult a on m.member_no = a.member_no
where m.member_no in (select * from with_young_child)
  and (state = 'AZ' or state = 'CA')

-- zad 3)
-- Dla każdego klienta podaj imię i nazwisko pracownika, który w 1997r obsłużył
-- najwięcej jego zamówień, podaj także liczbę tych zamówień (jeśli jest kilku takich
-- pracownikow to wystarczy podać imię nazwisko jednego nich). Zbiór wynikowy
-- powinien zawierać nazwę klienta, imię i nazwisko pracownika oraz liczbę
-- obsłużonych zamówień. (baza northwind)
use Northwind
with cte as (select CustomerID, EmployeeID, cnt
             from (select CustomerID,
                          EmployeeID,
                          count(*)                                                           as cnt,
                          row_number() over (partition by CustomerID order by count(*) desc) as rnk
                   from Orders o
                   where year(OrderDate) = 1997
                   group by CustomerID, EmployeeID) t
             where rnk = 1)
select c.CompanyName, FirstName, LastName, cnt
from cte
         inner join Customers c on cte.CustomerID = c.CustomerID
         inner join Employees e on cte.EmployeeID = e.EmployeeID
