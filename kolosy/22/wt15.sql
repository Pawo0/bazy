-- zad 1)
-- Podaj liczbę̨ zamówień oraz wartość zamówień (bez opłaty za przesyłkę)
-- obsłużonych przez każdego pracownika w marcu 1997. Za datę obsłużenia
-- zamówienia należy uznać datę jego złożenia (orderdate). Jeśli pracownik nie
-- obsłużył w tym okresie żadnego zamówienia, to też powinien pojawić się na liście
-- (liczba obsłużonych zamówień oraz ich wartość jest w takim przypadku równa 0).
-- Zbiór wynikowy powinien zawierać: imię i nazwisko pracownika, liczbę obsłużonych
-- zamówień, wartość obsłużonych zamówień, oraz datę najpóźniejszego zamówienia
-- (w badanym okresie). (baza northwind)
use Northwind

select e.EmployeeID,
       FirstName,
       LastName,
       isnull(sum(totalPrice), 0) as totalCost,
       isnull(sum(cnt), 0)        as totalCnt,
       max(lastOrder)             as lastOrder
from Employees e
         left join
     (select o.OrderDate,
             EmployeeID,
             sum(UnitPrice * Quantity * (1 - Discount)) as totalPrice,
             count(*)                                   as cnt,
             max(OrderDate)                             as lastOrder
      from Orders o
               join [Order Details] od on o.OrderID = od.OrderID
      where year(OrderDate) = 1997
        and month(OrderDate) = 1
      group by o.OrderDate, EmployeeID) t
     on e.EmployeeID = t.EmployeeID
group by e.EmployeeID, e.FirstName, e.LastName


-- zad 2)
-- Podaj listę dzieci będących członkami biblioteki, które w dniu '2001-12-14' nie
-- zwróciły do biblioteki książki o tytule 'Walking'. Zbiór wynikowy powinien zawierać
-- imię i nazwisko oraz dane adresowe dziecka. (baza library)
use library
select firstname, lastname, street, city, state, zip
from juvenile j
         inner join adult a on j.adult_member_no = a.member_no
         inner join member m on j.member_no = m.member_no
where j.member_no not in (select distinct m.member_no
                          from juvenile j
                                   left join member m on j.member_no = m.member_no
                                   left join loanhist lh on lh.member_no = m.member_no
                                   join title t on lh.title_no = t.title_no
                          where title = 'Walking'
                            and year(in_date) = 2001
                            and month(in_date) = 12
                            and day(in_date) = 14)


-- zad 3)
-- Dla każdego klienta podaj imię i nazwisko pracownika, który w 1997r obsłużył
-- najwięcej jego zamówień, podaj także liczbę tych zamówień (jeśli jest kilku takich
-- pracownikow to wystarczy podać imię nazwisko jednego nich). Zbiór wynikowy
-- powinien zawierać nazwę klienta, imię i nazwisko pracownika oraz liczbę
-- obsłużonych zamówień. (baza northwind)
use Northwind
with cte as (select CustomerID, EmployeeID, cnt
             from (select o.CustomerID,
                          o.EmployeeID,
                          count(*)                                                             as cnt,
                          row_number() over (partition by o.CustomerID order by count(*) desc) as rnk
                   from Orders o
                            inner join Customers c on o.CustomerID = c.CustomerID
                   where year(OrderDate) = 1997
                   group by o.CustomerID, o.EmployeeID) t
             where rnk = 1)

select c.CompanyName,
       e.FirstName,
       e.LastName,
       (select cnt from cte where cte.CustomerID = o.CustomerID and o.EmployeeID = cte.EmployeeID) as cnt
from Orders o
         inner join Employees e on o.EmployeeID = e.EmployeeID
         inner join Customers c on o.CustomerID = c.CustomerID
where exists (
    select 1 from cte
             where cte.CustomerID = o.CustomerID and cte.EmployeeID = o.EmployeeID
)
group by o.CustomerID, o.EmployeeID, c.CompanyName, e.FirstName, e.LastName

