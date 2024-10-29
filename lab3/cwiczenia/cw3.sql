use Northwind;

-- Dla każdej kategorii produktu (nazwa), podaj łączną liczbę zamówionych przez klientów jednostek towarów z tej kategorii.
select CategoryName, sum(Quantity) as TotalUnits
from Categories Cat
         inner join dbo.Products P on Cat.CategoryID = P.CategoryID
         inner join dbo.[Order Details] "[O D]" on P.ProductID = "[O D]".ProductID
group by Cat.CategoryID, CategoryName;

-- jesli "dla kazdego klienta"
select CategoryName, Cus.CompanyName, sum(Quantity) as TotalUnits
from Categories Cat
         inner join dbo.Products P on Cat.CategoryID = P.CategoryID
         inner join dbo.[Order Details] "[O D]" on P.ProductID = "[O D]".ProductID
         inner join dbo.Orders O on O.OrderID = "[O D]".OrderID
         inner join dbo.Customers Cus on Cus.CustomerID = O.CustomerID
group by Cat.CategoryID, CategoryName, Cus.CustomerID, Cus.CompanyName;

-- Dla każdej kategorii produktu (nazwa), podaj łączną liczbę zamówionych w 1997r jednostek towarów z tej kategorii.
select CategoryName, sum(Quantity) as TotalUnits
from Categories Cat
         inner join dbo.Products P on Cat.CategoryID = P.CategoryID
         inner join dbo.[Order Details] "[O D]" on P.ProductID = "[O D]".ProductID
         inner join dbo.Orders O on O.OrderID = "[O D]".OrderID
where year(OrderDate) = 1997
group by Cat.CategoryID, CategoryName;

-- Dla każdej kategorii produktu (nazwa), podaj łączną wartość zamówionych towarów z tej kategorii.
select CategoryName, sum(Quantity * "[O D]".UnitPrice) as TotalValue
from Categories Cat
         inner join dbo.Products P on Cat.CategoryID = P.CategoryID
         inner join dbo.[Order Details] "[O D]" on P.ProductID = "[O D]".ProductID
group by Cat.CategoryID, CategoryName;
