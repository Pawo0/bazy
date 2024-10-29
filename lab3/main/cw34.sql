use library;

-- Podaj listę członków biblioteki mieszkających w Arizonie (AZ) mają  więcej niż dwoje dzieci zapisanych do biblioteki
select m.member_no, m.firstname, m.lastname
from juvenile j
         inner join adult a on j.adult_member_no = a.member_no
         inner join member m on a.member_no = m.member_no
where state = 'AZ'
group by m.member_no, m.firstname, m.lastname
having count(*) > 2;

-- Podaj listę członków biblioteki mieszkających w Arizonie (AZ) którzy mają  więcej niż dwoje dzieci zapisanych do
-- biblioteki oraz takich którzy mieszkają w Kaliforni (CA) i mają więcej niż troje dzieci zapisanych do biblioteki
-- 1
select m.member_no, m.firstname, m.lastname
from juvenile j
         inner join adult a on j.adult_member_no = a.member_no
         inner join member m on a.member_no = m.member_no
group by m.member_no, m.firstname, m.lastname, state
having (count(*) > 2 and state = 'AZ')
    or (count(*) > 3 and state = 'CA')

-- 2
select m.member_no, m.firstname, m.lastname
from juvenile j
         inner join adult a on j.adult_member_no = a.member_no
         inner join member m on a.member_no = m.member_no
where state = 'AZ'
group by m.member_no, m.firstname, m.lastname
having count(*) > 2
union
select m.member_no, m.firstname, m.lastname
from juvenile j
         inner join adult a on j.adult_member_no = a.member_no
         inner join member m on a.member_no = m.member_no
where state = 'CA'
group by m.member_no, m.firstname, m.lastname
having count(*) > 3

