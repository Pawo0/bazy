use Northwind;

-- Wybierz nazwy i numery telefonów klientów, którzy kupowali produkty  z kategorii ‘Confections’
-- 1
select distinct Cu.CompanyName, Cu.Phone
from Customers Cu
         inner join dbo.Orders O on Cu.CustomerID = O.CustomerID
         inner join dbo.[Order Details] "[O D]" on O.OrderID = "[O D]".OrderID
         inner join dbo.Products P on P.ProductID = "[O D]".ProductID
         inner join dbo.Categories Ca on Ca.CategoryID = P.CategoryID
where CategoryName = 'Confections';

-- 2
select distinct Cu.CompanyName, Cu.Phone, CategoryName
from Customers Cu
         inner join dbo.Orders O on Cu.CustomerID = O.CustomerID
         inner join dbo.[Order Details] "[O D]" on O.OrderID = "[O D]".OrderID
         inner join dbo.Products P on P.ProductID = "[O D]".ProductID
         left join dbo.Categories Ca on Ca.CategoryID = P.CategoryID and CategoryName = 'Confections'
where CategoryName is not null;

-- Wybierz nazwy i numery telefonów klientów, którzy nie kupowali produktów z kategorii ‘Confections’
select Cu.CompanyName, Cu.Phone
from Customers Cu
where not exists(select 1
                 from Orders O
                          inner join dbo.[Order Details] "[O D]" on O.OrderID = "[O D]".OrderID
                          inner join dbo.Products P on P.ProductID = "[O D]".ProductID
                          inner join dbo.Categories Ca on Ca.CategoryID = P.CategoryID
                 where Cu.CustomerID = O.CustomerID
                   and Ca.CategoryName = 'Confections')

select Cu.CompanyName, Cu.Phone
from Customers Cu
where Cu.CustomerID not in(select O.CustomerID
                 from Orders O
                          inner join dbo.[Order Details] "[O D]" on O.OrderID = "[O D]".OrderID
                          inner join dbo.Products P on P.ProductID = "[O D]".ProductID
                          inner join dbo.Categories Ca on Ca.CategoryID = P.CategoryID
                 where Cu.CustomerID = O.CustomerID
                   and Ca.CategoryName = 'Confections')


-- Wybierz nazwy i numery telefonów klientów, którzy w 1997r nie kupowali produktów z kategorii ‘Confections’
select Cu.CompanyName, Cu.Phone
from Customers Cu
where not exists(select 1
                 from Orders O
                          inner join dbo.[Order Details] "[O D]" on O.OrderID = "[O D]".OrderID
                          inner join dbo.Products P on P.ProductID = "[O D]".ProductID
                          inner join dbo.Categories Ca on Ca.CategoryID = P.CategoryID
                 where Cu.CustomerID = O.CustomerID
                   and Ca.CategoryName = 'Confections'
                   and year(O.OrderDate) = 1997)