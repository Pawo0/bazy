use Northwind;


-- Podaj wszystkie produkty których cena jest mniejsza niż średnia cena produktu
select *
from Products
where UnitPrice < (select avg(UnitPrice)
                   from Products);

-- Podaj wszystkie produkty których cena jest mniejsza niż średnia cena produktu danej kategorii
select *
from Products p1
where UnitPrice < (select avg(UnitPrice)
                   from Products p2
                   where p2.CategoryID = p1.CategoryID);

-- Dla każdego produktu podaj jego nazwę, cenę, średnią cenę wszystkich produktów oraz różnicę między ceną produktu
-- a średnią ceną wszystkich produktów

select ProductName,
       UnitPrice,
       (select avg(UnitPrice) from Products)             as avgPrice,
       UnitPrice - (select avg(UnitPrice) from Products) as diff
from Products p;

-- Dla każdego produktu podaj jego nazwę kategorii, nazwę produktu, cenę, średnią cenę wszystkich produktów danej
-- kategorii oraz różnicę między ceną produktu a średnią ceną wszystkich produktów danej kategorii
select c.CategoryName,
       p.ProductName,
       UnitPrice,
       (select avg(UnitPrice)
        from Products p2
        where p2.CategoryID = p.CategoryID)             as avgCategoryPrice,
       UnitPrice - (select avg(UnitPrice)
                    from Products p2
                    where p2.CategoryID = p.CategoryID) as diffToAvgCategory
from Products p
         inner join Categories c on p.CategoryID = c.CategoryID;