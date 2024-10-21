use library;
-- Dla każdego czytelnika podaj liczbę zarezerwowanych przez niego książek
select member_no, count(*) as [reservations]
from reservation
group by member_no;

-- Dla każdego czytelnika podaj liczbę wypożyczonych przez niego książek
select member_no, count(*) as [loans]
from loanhist
group by member_no;

-- Dla każdego czytelnika podaj liczbę książek zwróconych przez niego w 2001r.
select member_no, count(*)
from loanhist
where year(in_date) = 2001
group by member_no ;

-- Dla każdego czytelnika podaj sumę kar jakie zapłacił w 2001r
select member_no, sum(fine_paid) as [fine paind in 2001]
from loanhist
where year(in_date) = 2001
group by member_no
-- having sum(fine_paid) is not null;

-- Ile książek wypożyczono w maju 2001
select count(*) as [borrowed in May 2001]
from loanhist
where year(out_date) = 2002 and month(out_date) = 5;
    
-- Na jak długo średnio były wypożyczane książki w maju 2001
select avg(datediff(hh, out_date, in_date)) as [avg borrow time in h]
from loanhist
where year(out_date) = 2002 and month(out_date) = 5;


select *
from loanhist
where loanhist.fine_paid is not null;