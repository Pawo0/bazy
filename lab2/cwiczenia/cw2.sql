use library;

-- Ilu jest dorosłych czytekników
select distinct count(*) as [adult members]
from adult;

-- Ile jest dzieci zapisanych do biblioteki
select distinct count(*) as [child members]
from juvenile;

-- Ilu z dorosłych czytelników mieszka w Kaliforni (CA)
select count(*) as [California members]
from adult
where state = 'CA';

-- Dla każdego dorosłego czytelnika podaj liczbę jego dzieci.
select adult_member_no, count(*) as child
from juvenile
group by adult_member_no;

-- Dla każdego dorosłego czytelnika podaj liczbę jego dzieci urodzonych przed 1998r
select adult_member_no, count(*) as child
from juvenile
where year(birth_date) < 1998
group by adult_member_no ;