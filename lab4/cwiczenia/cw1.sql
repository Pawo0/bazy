use Northwind;

-- Podaj łączną wartość zamówienia o numerze 10250 (uwzględnij cenę za przesyłkę)
select O.OrderID, sum(UnitPrice * Quantity * (1 - Discount)) + Freight
from Orders O
         inner join dbo.[Order Details] "[O D]" on O.OrderID = "[O D]".OrderID
where O.OrderID = 10250
group by O.OrderID, Freight;

-- Podaj łączną wartość każdego zamówienia (uwzględnij cenę za przesyłkę)
select O.OrderID, sum(UnitPrice * Quantity * (1 - Discount)) + Freight
from Orders O
         inner join dbo.[Order Details] "[O D]" on O.OrderID = "[O D]".OrderID
group by O.OrderID, Freight;

-- Dla każdego produktu podaj maksymalną wartość zakupu tego produktu
select P.ProductName, max(Quantity * "[O D]".UnitPrice)
from Products P
         inner join dbo.[Order Details] "[O D]" on P.ProductID = "[O D]".ProductID
group by P.ProductID, P.ProductName;

-- Dla każdego produktu podaj maksymalną wartość zakupu tego produktu w 1997r
select P.ProductName, max(Quantity * "[O D]".UnitPrice)
from Products P
         inner join dbo.[Order Details] "[O D]" on P.ProductID = "[O D]".ProductID
         inner join dbo.Orders O on "[O D]".OrderID = O.OrderID
where year(OrderDate) = 1997
group by P.ProductID, P.ProductName;