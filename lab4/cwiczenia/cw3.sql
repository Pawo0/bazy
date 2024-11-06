use library;

-- Dla każdego dorosłego członka biblioteki podaj jego imię, nazwisko oraz liczbę jego dzieci.
select firstname,
       lastname,
       (select count(*)
        from juvenile j
        where j.adult_member_no = a.member_no) as child_counter
from adult a
         inner join member m on a.member_no = m.member_no;

-- Dla każdego dorosłego członka biblioteki podaj jego imię, nazwisko, liczbę jego dzieci, liczbę zarezerwowanych
-- książek oraz liczbę wypożyczonych książek.
select firstname,
       lastname,
       (select count(*)
        from juvenile j
        where j.adult_member_no = a.member_no) as childs,

       (select count(*)
        from reservation r
        where r.member_no = a.member_no)       as reservations,

       (select count(*)
        from loanhist lh
        where lh.member_no = a.member_no)
           +
       (select count(*)
        from loan l
        where l.member_no = a.member_no)       as loans
from adult a
         inner join member m on a.member_no = m.member_no;



-- Dla każdego dorosłego członka biblioteki podaj jego imię, nazwisko, liczbę jego dzieci, oraz liczbę książek
-- zarezerwowanych i wypożyczonych przez niego i jego dzieci.
select m.firstname,
       m.lastname,
       t1.member_no,
       t1.childs,
       t1.reservations + coalesce(sum(t2.reservations), 0) as reservations,
       t1.loans + coalesce(sum(t2.loans), 0)               as loans
from (select a.member_no,

             (select count(*)
              from juvenile j
              where j.adult_member_no = a.member_no) as childs,

             (select count(*)
              from reservation r
              where r.member_no = a.member_no)       as reservations,

             (select count(*)
              from loanhist lh
              where lh.member_no = a.member_no)
                 +
             (select count(*)
              from loan l
              where l.member_no = a.member_no)       as loans
      from adult a
               inner join member m on a.member_no = m.member_no) t1
         left join
     (select j.adult_member_no,

             (select count(*)
              from reservation r
              where r.member_no = j.adult_member_no) as reservations,

             (select count(*)
              from loanhist lh
              where lh.member_no = j.adult_member_no)
                 +
             (select count(*)
              from loan l
              where l.member_no = j.adult_member_no) as loans

      from juvenile j) t2 on t1.member_no = t2.adult_member_no
         inner join
     member m on t1.member_no = m.member_no
group by m.firstname,
         m.lastname,
         t1.member_no,
         t1.childs,
         t1.reservations,
         t1.loans


-- Dla każdego tytułu książki podaj ile razy ten tytuł był wypożyczany w 2001r
-- 1
select t.title, count(*)
from loanhist lh
         inner join title t on lh.title_no = t.title_no
where year(out_date) = 2001
group by lh.title_no, t.title;

-- 2
select title,
       (select count(*)
        from loanhist lh
        where t.title_no = lh.title_no
          and year(out_date) = 2001)
from title t


-- Dla każdego tytułu książki podaj ile razy ten tytuł był wypożyczany w 2002r
select title,
       (select count(*)
        from loanhist lh
        where t.title_no = lh.title_no
          and year(out_date) = 2002)
from title t
