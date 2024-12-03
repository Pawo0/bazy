-- zad 1)
-- Podaj tytuły książek zarezerwowanych przez dorosłych członków biblioteki
-- mieszkających w Arizonie (AZ). Zbiór wynikowy powinien zawierać imię i nazwisko
-- członka biblioteki, jego adres oraz tytuł zarezerwowanej książki. Jeśli jakaś osoba
-- dorosła mieszkająca w Arizonie nie ma zarezerwowanej żadnej książki to też
-- powinna znaleźć się na liście, a w polu przeznaczonym na tytuł książki powinien
-- pojawić się napis BRAK. (baza library)
use library
select firstname, lastname, isnull(title, 'BRAK')
from member m
         left join reservation r on m.member_no = r.member_no
         inner join adult a on m.member_no = a.member_no
         left join item i on r.isbn = i.isbn
         left join title t on i.title_no = t.title_no
where state = 'AZ'
order by firstname, lastname

-- zad 2)
-- Pokaż nazwy produktów, kategorii 'Beverages' które nie były kupowane w okresie
-- od '1997.02.20' do '1997.02.25' Dla każdego takiego produktu podaj jego nazwę,
-- nazwę dostawcy (supplier), oraz nazwę kategorii. Zbiór wynikowy powinien
-- zawierać nazwę produktu, nazwę dostawcy oraz nazwę kategorii. (baza northwind)
use Northwind
with cte as
         (select p.ProductID
          from Products p
                   inner join [Order Details] od on p.ProductID = od.ProductID
                   inner join Orders o on od.OrderID = o.OrderID
                   inner join Categories c on p.CategoryID = c.CategoryID
          where CategoryName = 'Beverages'
            and OrderDate between '1997-02-20' and '1997-02-25')

select p.ProductName, s.CompanyName, c.CategoryName
from Products p
         inner join Categories c on p.CategoryID = c.CategoryID
         inner join Suppliers s on p.SupplierID = s.SupplierID
where ProductID not in (select * from cte)
  and CategoryName = 'Beverages';



-- zad 3)
-- Podaj liczbę̨ zamówień oraz wartość zamówień (uwzględnij opłatę za przesyłkę)
-- złożonych przez każdego klienta w lutym 1997. Jeśli klient nie złożył w tym okresie
-- żadnego zamówienia, to też powinien pojawić się na liście (liczba złożonych
-- zamówień oraz ich wartość jest w takim przypadku równa 0). Zbiór wynikowy
-- powinien zawierać: nazwę klienta, liczbę obsłużonych zamówień, oraz wartość
-- złożonych zamówień. (baza northwind)
select c.CompanyName,
       count(distinct o.OrderID) as                         OrderCnt,
       sum(UnitPrice * Quantity * (1 - Discount)) + Freight totalCost
from Customers c
         left join Orders o on c.CustomerID = o.CustomerID
         inner join [Order Details] od on o.OrderID = od.OrderID
where year(OrderDate) = 1997
  and month(OrderDate) = 2
group by c.CustomerID, c.CompanyName, o.Freight