use Northwind;

-- Podaj nazwy przewoźników, którzy w marcu 1998 przewozili produkty z kategorii 'Meat/Poultry'
select distinct S.CompanyName
from Orders O
         inner join dbo.Shippers S on S.ShipperID = O.ShipVia
         inner join dbo.[Order Details] "[O D]" on O.OrderID = "[O D]".OrderID
         inner join dbo.Products P on "[O D]".ProductID = P.ProductID
         inner join dbo.Categories C on P.CategoryID = C.CategoryID
where CategoryName = 'Meat/Poultry'
  and year(O.OrderDate) = 1998
  and month(O.OrderDate) = 3;

-- Podaj nazwy przewoźników, którzy w marcu 1997r nie przewozili produktów z kategorii 'Meat/Poultry'
select CompanyName
from Shippers S
except
(select distinct S.CompanyName
 from Orders O
          inner join dbo.Shippers S on S.ShipperID = O.ShipVia
          inner join dbo.[Order Details] "[O D]" on O.OrderID = "[O D]".OrderID
          inner join dbo.Products P on "[O D]".ProductID = P.ProductID
          inner join dbo.Categories C on P.CategoryID = C.CategoryID
 where CategoryName = 'Meat/Poultry'
   and year(O.OrderDate) = 1997
   and month(O.OrderDate) = 3)

-- Dla każdego przewoźnika podaj wartość produktów z kategorii 'Meat/Poultry' które ten przewoźnik przewiózł w marcu 1997
select S.CompanyName, sum("[O D]".UnitPrice * Quantity) as TotalPrice
from Orders O
         inner join dbo.Shippers S on S.ShipperID = O.ShipVia
         inner join dbo.[Order Details] "[O D]" on O.OrderID = "[O D]".OrderID
         inner join dbo.Products P on "[O D]".ProductID = P.ProductID
         inner join dbo.Categories C on P.CategoryID = C.CategoryID
where CategoryName = 'Meat/Poultry'
  and year(O.OrderDate) = 1998
  and month(O.OrderDate) = 3
group by S.CompanyName