-- zad 1)
-- Dla każdego produktu z kategorii 'confections' podaj wartość przychodu za ten
-- produkt w marcu 1997 (wartość sprzedaży tego produktu bez opłaty za przesyłkę).
-- Jeśli dany produkt (należący do kategorii 'confections') nie był sprzedawany w tym
-- okresie to też powinien pojawić się na liście (wartość sprzedaży w takim przypadku
-- jest równa 0) (baza northwind)
use Northwind
with prod_conf as (select ProductID
                   from Products p
                            inner join Categories c on p.CategoryID = c.CategoryID
                   where CategoryName = 'confections')
select pc.ProductID, sum(UnitPrice*Quantity*(1-Discount))
from prod_conf pc
left join [Order Details] od on od.ProductID = pc.ProductID
left join Orders o on o.OrderID = od.OrderID and year(OrderDate) = 1997 and month(OrderDate) = 3
group by pc.ProductID


-- zad 2)
-- Podaj tytuły książek, które nie są aktualnie zarezerwowane przez dzieci mieszkające
-- w Arizonie (AZ). (baza library)


-- zad 3)
-- Dla każdego przewoźnika podaj nazwę produktu z kategorii 'Seafood', który ten
-- przewoźnik przewoził najczęściej w kwietniu 1997. Podaj też informację ile razy
-- dany przewoźnik przewoził ten produkt w tym okresie (jeśli takich produktów jest
-- więcej to wystarczy podać nazwę jednego z nich). Zbiór wynikowy powinien
-- zawierać nazwę przewoźnika, nazwę produktu oraz informację ile razy dany produkt
-- był przewożony (baza northwind)