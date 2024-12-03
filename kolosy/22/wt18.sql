-- zad 1)
-- Dla każdego pracownika podaj nazwę klienta, dla którego dany pracownik w 1997r
-- obsłużył najwięcej zamówień, podaj także liczbę tych zamówień (jeśli jest kilku
-- takich klientów to wystarczy podać nazwę jednego nich). Za datę obsłużenia
-- zamówienia należy przyjąć orderdate. Zbiór wynikowy powinien zawierać imię i
-- nazwisko pracownika, nazwę klienta, oraz liczbę obsłużonych zamówień. (baza
-- northwind)
use Northwind
with cte as
         (select EmployeeID, CustomerID, cnt
          from (select EmployeeID,
                       CustomerID,
                       count(*)                                                           as cnt,
                       row_number() over (partition by EmployeeID order by count(*) desc) as rnk
                from Orders o
                where year(OrderDate) = 1997
                group by EmployeeID, CustomerID) t
          where rnk = 1)
select e.FirstName, e.LastName, c.CompanyName, cnt
from cte
         inner join Employees e on cte.EmployeeID = e.EmployeeID
         inner join Customers c on cte.CustomerID = c.CustomerID;

-- zad 2)
-- Wyświetl numery zamówień złożonych w od marca do maja 1997, które były
-- przewożone przez firmę 'United Package' i nie zawierały produktów z kategorii
-- "confections". (baza northwind)
use Northwind
with cte as (select o.OrderID
             from Orders o
                      inner join [Order Details] od on o.OrderID = od.OrderID
                      inner join Products p on od.ProductID = p.ProductID
                      inner join Categories c on p.CategoryID = c.CategoryID
             where CategoryName = 'confections'
               and year(OrderDate) = 1997
               and month(OrderDate) between 3 and 5)
select OrderID
from Orders o
         inner join Shippers s on o.ShipVia = s.ShipperID
where year(OrderDate) = 1997
  and month(OrderDate) between 3 and 5
  and s.CompanyName = 'United Package'
  and o.OrderID not in (select * from cte)

-- zad 3)
-- Podaj tytuły książek wypożyczonych (aktualnie) przez dzieci mieszkające w Arizonie
-- (AZ). Zbiór wynikowy powinien zawierać imię i nazwisko członka biblioteki
-- (dziecka), jego adres oraz tytuł wypożyczonej książki. Jeśli jakieś dziecko
-- mieszkająca w Arizonie nie ma wypożyczonej żadnej książki to też powinno znaleźć
-- się na liście, a w polu przeznaczonym na tytuł książki powinien pojawić się napis
-- BRAK. (baza library)
use library
with child_from_arizona as (select j.member_no, j.adult_member_no
                            from juvenile j
                                     inner join member m on j.member_no = m.member_no
                                     inner join adult a on j.adult_member_no = a.member_no
                            where state = 'AZ')
select firstname, lastname, street, city, isnull(title, 'BRAK')
from child_from_arizona cha
         inner join member m on m.member_no = cha.member_no
         inner join adult a on a.member_no = cha.adult_member_no
         left join loan l on cha.member_no = l.member_no
         left join title t on l.title_no = t.title_no



-- JEST DUZO TAKICH WILLIAMOW xd
select firstname, lastname, street
from juvenile j
inner join adult a on j.adult_member_no = a.member_no
inner join member m on j.member_no = m.member_no
where firstname = 'William' and street = 'Cannery Row'
