-- 1. Napisz polecenie select  za pomocą którego uzyskasz identyfikator/numer tytułu oraz tytuł książki
select title_no, title
from title;

-- 2. Napisz polecenie, które wybiera tytuł o numerze/identyfikatorze 10
select title
from title
where title_no = 10;

-- 3. Napisz polecenie select, za pomocą którego uzyskasz numer książki (nr tyułu)  i autora dla wszystkich książek, których autorem jest Charles Dickens lub Jane Austen
select *
from title
where author = 'Charles Dickens'
   or author = 'Jane Austen';