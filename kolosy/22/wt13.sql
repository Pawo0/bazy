-- zad 1)
-- Dla każdego klienta podaj imię i nazwisko pracownika, który w 1997r obsłużył
-- najwięcej jego zamówień, podaj także liczbę tych zamówień (jeśli jest kilku takich
-- pracownikow to wystarczy podać imię nazwisko jednego nich). Za datę obsłużenia
-- zamówienia należy przyjąć orderdate. Zbiór wynikowy powinien zawierać nazwę
-- klienta, imię i nazwisko pracownika oraz liczbę obsłużonych zamówień. (baza
-- northwind)
use Northwind
--          ŹLE
-- select CustomerID, FirstName, LastName, cnt
-- from (select c.CustomerID,
--              e.FirstName,
--              e.LastName,
--              count(*)                                                              as cnt,
--              row_number() over (partition by c.CustomerID order by count(*) desc ) as rnk
--       from Orders o
--                inner join Customers c
--                           on o.CustomerID = c.CustomerID
--                inner join Employees e
--                           on o.EmployeeID = e.EmployeeID
--       where year(OrderDate) = 1997
--       group by c.CustomerID, e.EmployeeID, e.FirstName, e.LastName
--       having count(*) = (select max(orderCnt)
--                          from (select count(*) as orderCnt
--                                from Orders o2
--                                         inner join Employees e2 on o2.EmployeeID = e2.EmployeeID
--                                where o2.CustomerID = c.CustomerID
--                                group by e2.EmployeeID, o2.CustomerID) t)) xd
-- where rnk = 1

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

select o.CustomerID,
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


-- zad 2)
-- Podaj liczbę̨ zamówień oraz wartość zamówień (uwzględnij opłatę za przesyłkę)
-- obsłużonych przez każdego pracownika w lutym 1997. Za datę obsłużenia
-- zamówienia należy uznać datę jego złożenia (orderdate). Jeśli pracownik nie
-- obsłużył w tym okresie żadnego zamówienia, to też powinien pojawić się na liście
-- (liczba obsłużonych zamówień oraz ich wartość jest w takim przypadku równa 0).
-- Zbiór wynikowy powinien zawierać: imię i nazwisko pracownika, liczbę obsłużonych
-- zamówień, wartość obsłużonych zamówień. (baza northwind)
use Northwind
select FirstName,
       LastName,
       OrderQuantity,
       totalPriceWithoutFreight + (select sum(o1.Freight)
                                   from Orders o1
                                   where year(OrderDate) = 1997
                                     and month(OrderDate) = 2
                                     and o1.EmployeeID = t.EmployeeID
                                   group by o1.EmployeeID) as totalPrice
from (select e.EmployeeID,
             FirstName,
             LastName,
             count(*)                                   as OrderQuantity,
             sum(UnitPrice * Quantity * (1 - Discount)) as totalPriceWithoutFreight
      from Orders o
               left join [Order Details] od on o.OrderID = od.OrderID
               right join Employees e on o.EmployeeID = e.EmployeeID
      where year(OrderDate) = 1997
        and month(OrderDate) = 2
      group by FirstName, LastName, e.EmployeeID) t
union
select firstname, lastname, 0, 0
from Employees
where EmployeeID not in (select employeeid from orders where MONTH(OrderDate)=2 and YEAR(OrderDate)=1997)


select *
from Orders
where EmployeeID = 7 and year(OrderDate) = 1997 and month(OrderDate) = 2;

-- zad 3)
-- Podaj listę dzieci będących członkami biblioteki, które w dniu '2001-12-14'
-- zwróciły do biblioteki książkę o tytule 'Walking'. Zbiór wynikowy powinien zawierać
-- imię i nazwisko oraz dane adresowe dziecka. (baza library)
use library;
select m.member_no,firstname, lastname, street, city, state, zip
from juvenile j
inner join adult a  on j.adult_member_no = a.member_no
inner join member m on j.member_no = m.member_no
inner join loanhist lh on lh.member_no = m.member_no
inner join title t on t.title_no = lh.title_no
where year(in_date) = 2001 and month(in_date) = 12 and day(in_date) = 14
    and t.title = 'Walking'


select *
from loanhist
where title_no = 12 and year(in_date) = 2001 and month(in_date) = 12 and day(in_date) = 14


