use Northwind;

-- Wybierz nazwy i ceny produktów (baza northwind) o cenie jednostkowej pomiędzy 20.00 a 30.00, dla każdego produktu
-- podaj dane adresowe dostawcy, interesują nas tylko produkty z kategorii ‘Meat/Poultry’
select ProductName, UnitPrice, Address
from Products P
         inner join dbo.Suppliers S on S.SupplierID = P.SupplierID
         inner join dbo.Categories C on C.CategoryID = P.CategoryID
where c.CategoryName = 'Meat/poultry'
  and UnitPrice between 20 and 30;


-- Wybierz nazwy i ceny produktów z kategorii ‘Confections’ dla każdego produktu podaj nazwę dostawcy.
select ProductName, CompanyName
from Products P
         inner join dbo.Suppliers S on S.SupplierID = P.SupplierID
         inner join dbo.Categories C on C.CategoryID = P.CategoryID
where CategoryName = 'Confections'

-- Dla każdego klienta podaj liczbę złożonych przez niego zamówień. Zbiór wynikowy powinien zawierać nazwę klienta,
-- oraz liczbę zamówień
select CompanyName, count(*)
from Customers C
         inner join Orders O on C.CustomerID = O.CustomerID
group by CompanyName;

-- Dla każdego klienta podaj liczbę złożonych przez niego zamówień w marcu 1997r
select CompanyName, count(*)
from Customers C
         inner join dbo.Orders O on C.CustomerID = O.CustomerID
where year(OrderDate) = 1997
  and month(OrderDate) = 3
group by CompanyName;