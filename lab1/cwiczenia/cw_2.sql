-- 1. Napisz polecenie, które wybiera numer tytułu i tytuł dla wszystkich  książek, których tytuły zawierających słowo 'adventure'
select title_no, title
from title
where title like '%adventure%';

-- 2. Napisz polecenie, które wybiera numer czytelnika, oraz zapłaconą karę dla wszystkich książek, tore zostały zwrócone w listopadzie 2001
select member_no, fine_paid
from loanhist
where year(due_date) = 2001 and month(due_date) = 11
-- and fine_paid is not null;

-- 3. Napisz polecenie, które wybiera wszystkie unikalne pary miast i stanów z tablicy adult.
select distinct city, state
from adult;

-- 4. Napisz polecenie, które wybiera wszystkie tytuły z tablicy title i wyświetla je w porządku alfabetycznym.
select title
from title
order by title;