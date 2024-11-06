use library;


-- Napisz polecenie, które wyświetla listę dzieci będących członkami biblioteki (baza library). Interesuje nas imię,
-- nazwisko, data urodzenia dziecka i adres zamieszkania dziecka.
select firstname, lastname, birth_date, street, city, state, zip
from member m
         inner join dbo.juvenile j on m.member_no = j.member_no
         inner join dbo.adult a on j.adult_member_no = a.member_no


-- Napisz polecenie, które wyświetla listę dzieci będących członkami biblioteki (baza library). Interesuje nas imię,
-- nazwisko, data urodzenia dziecka, adres zamieszkania dziecka oraz imię i nazwisko rodzica.
-- ale te dane sa losowe xd
select m_child.firstname, m_child.lastname, j.birth_date, street, m_adult.lastname
from juvenile j
         inner join member m_child on j.member_no = m_child.member_no
         inner join adult a on j.adult_member_no = a.member_no
         inner join member m_adult on a.member_no = m_adult.member_no

