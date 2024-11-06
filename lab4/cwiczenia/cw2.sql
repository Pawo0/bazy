use Northwind;


-- Dla każdego klienta podaj łączną wartość jego zamówień (bez opłaty za przesyłkę) z 1996r
select C.CustomerID, CompanyName, sum(Quantity * UnitPrice * (1 - Discount))
from Customers C
         inner join Orders O on C.CustomerID = O.CustomerID
         inner join dbo.[Order Details] "[O D]" on O.OrderID = "[O D]".OrderID
where year(OrderDate) = 1996
group by C.CustomerID, CompanyName;

-- Dla każdego klienta podaj łączną wartość jego zamówień (uwzględnij opłatę za przesyłkę) z 1996r
-- 1
select t1.CustomerID, TotalPriceWithoutFreight + TotalFreight as TotalPrice
from (select O.CustomerID, sum(Quantity * UnitPrice * (1 - Discount)) as TotalPriceWithoutFreight
      from Orders O
               inner join dbo.[Order Details] "[O D]" on O.OrderID = "[O D]".OrderID
      where year(OrderDate) = 1996
      group by O.CustomerID) t1
         inner join
     (select CustomerID, sum(Freight) as TotalFreight
      from Orders O
      where year(OrderDate) = 1996
      group by CustomerID) t2 on t1.CustomerID = t2.CustomerID

-- 2
select t.CustomerID, sum(TotalOrderPrice) as TotalPrice
from (select o.CustomerID,
             Freight + (select sum(Quantity * UnitPrice * (1 - Discount))
                        from [Order Details] od
                        where od.OrderID = o.OrderID
                        group by od.OrderID) as TotalOrderPrice
      from Orders o
      where year(OrderDate) = 1996
      group by o.OrderID, o.CustomerID, Freight) t
         inner join Customers C on C.CustomerID = t.CustomerID
group by t.CustomerID


-- Dla każdego klienta podaj maksymalną wartość zamówienia złożonego przez tego klienta w 1997r
select CustomerID, max(suma) MaxPrice
from Orders o
         inner join
     (select od.OrderID,
             sum(Quantity * UnitPrice * (1 - Discount)) as suma
      from [Order Details] od
               inner join Orders Oinner on od.OrderID = Oinner.OrderID
      where year(OrderDate) = 1997
      group by od.OrderID) t on t.OrderID = o.OrderID
group by CustomerID


