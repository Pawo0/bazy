use Northwind

--     Wyświetl zamówienia dla których liczba pozycji zamówienia jest większa niż 5
select OrderID, count(*) cnt
from [Order Details]
group by OrderID
having count(*) > 5;

--     Wyświetl  klientów dla których w 1998 roku zrealizowano więcej niż 8 zamówień (wyniki posortuj malejąco wg
--     łącznej kwoty za dostarczenie zamówień dla każdego z klientów)
select CustomerID, count(*) as cnt
from Orders
where year(OrderDate) = 1998
group by CustomerID
having count(*) > 8
order by sum(Freight) desc


select *
from Orders;