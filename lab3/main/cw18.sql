use library;

-- Napisz polecenie, które wyświetla listę dzieci będących członkami biblioteki (baza library). Interesuje nas imię,
-- nazwisko i data urodzenia dziecka.
select firstname, lastname, birth_date
from juvenile j
inner join dbo.member m
    on m.member_no = j.member_no;

-- Napisz polecenie, które podaje tytuły aktualnie wypożyczonych książek
select distinct title
from loan l
inner join title t
    on l.title_no = t.title_no;

-- Podaj informacje o karach zapłaconych za przetrzymywanie książki o tytule ‘Tao Teh King’.  Interesuje nas data
-- oddania książki, ile dni była przetrzymywana i jaką zapłacono karę
select datediff(d, due_date, in_date) as diff, fine_paid, due_date, in_date
from loanhist lh
inner join title t
    on lh.title_no = t.title_no
where title = 'Tao Teh King'
and in_date > due_date
and fine_paid is not null

-- Napisz polecenie które podaje listę książek (mumery ISBN) zarezerwowanych przez osobę o nazwisku: Stephen A. Graff
select isbn, firstname, middleinitial, lastname
from reservation r
inner join member m
    on r.member_no = m.member_no
where firstname = 'Stephen' and middleinitial = 'A' and lastname = 'Graff';