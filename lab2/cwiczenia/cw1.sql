use Northwind;

-- Dla każdego zamówienia podaj jego wartość. Posortuj wynik wg wartości zamówień (w malejęcej kolejności)
select OrderID, sum(UnitPrice) as cost
from [Order Details]
group by OrderID
order by cost desc;

-- Zmodyfikuj zapytanie z poprzedniego punktu, tak aby zwracało tylko pierwszych 10 wierszy
select top 10 OrderID, sum(UnitPrice) as cost
from [Order Details]
group by OrderID
order by cost desc;

-- Podaj  nr zamówienia oraz wartość  zamówienia, dla zamówień, dla których łączna liczba zamawianych jednostek
-- produktów jest większa niż 250
select OrderID, sum(UnitPrice) as cost
from [Order Details]
group by OrderID
having sum(Quantity) > 250

-- Podaj liczbę zamówionych jednostek produktów dla  produktów, dla których productid jest mniejszy niż 3
select count(ProductID) as [cnt productid < 3]
from [Order Details]
where ProductID < 3;