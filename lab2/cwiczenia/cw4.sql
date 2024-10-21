use Northwind;

-- Dla każdego pracownika podaj liczbę obsługiwanych przez niego zamówień w 1997r
select count(*)
from Orders
where year(OrderDate) = 1997 or year(ShippedDate) = 1997;

-- Dla każdego pracownika podaj ilu klientów (różnych klientów) obsługiwał ten pracownik w 1997r
select count(distinct CustomerID)
from Orders
where year(OrderDate) = 1997 or year(ShippedDate) = 1997;

-- Dla każdego spedytora/przewoźnika podaj łączną wartość "opłat za przesyłkę" dla przewożonych przez niego zamówień
select ShipVia, sum(Freight) as [total freight]
from Orders
group by ShipVia;

-- Dla każdego spedytora/przewoźnika podaj łączną wartość "opłat za przesyłkę" przewożonych przez niego zamówień w
-- latach od 1996 do 1997
select ShipVia, sum(Freight) as [total freight in 1996-1997]
from Orders
where year(ShippedDate) between 1996 and 1997
group by ShipVia;