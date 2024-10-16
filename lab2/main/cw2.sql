use Northwind

--     Podaj maksymalną cenę zamawianego produktu dla każdego zamówienia
select OrderID, max(UnitPrice) as "max price"
from [Order Details]
group by OrderID ;

--     Posortuj zamówienia wg maksymalnej ceny produktu
select OrderID, max(UnitPrice) as "max price"
from [Order Details]
group by OrderID
order by "max price" desc;

--     Podaj maksymalną i minimalną cenę zamawianego produktu dla każdego zamówienia
select OrderID, min(UnitPrice) min, max(UnitPrice) max
from [Order Details]
group by OrderID;

--     Podaj liczbę zamówień dostarczanych przez poszczególnych spedytorów (przewoźników)
select ShipVia, count(*) cnt
from Orders
group by ShipVia;
--     Który ze spedytorów był najaktywniejszy w 1997 roku
select top 1 with ties ShipVia, count(*) cnt
from Orders
where year(OrderDate) = 1997
group by ShipVia
order by cnt desc;
