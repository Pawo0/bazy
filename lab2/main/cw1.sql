--         Podaj liczbę produktów o cenach mniejszych niż 10 lub większych niż 20
select count(*) as cnt
from Products
where UnitPrice < 10
   or UnitPrice > 20;

--     Podaj maksymalną cenę produktu dla produktów o cenach poniżej 20
select max(UnitPrice)
from Products
where UnitPrice < 20

--     Podaj maksymalną i minimalną i średnią cenę produktu dla produktów o produktach sprzedawanych w butelkach (‘bottle’)
select min(UnitPrice) as min, max(UnitPrice) as max
from Products
where QuantityPerUnit like '%bottle%';
--     Wypisz informację o wszystkich produktach o cenie powyżej średniej
select *
from Products
where UnitPrice > (select avg(UnitPrice)
                   from Products)

--     Podaj sumę/wartość zamówienia o numerze 10250
select cast(sum(UnitPrice * Quantity * (1 - Discount)) as decimal(10, 2))
from [Order Details]
where OrderID = 10250;
