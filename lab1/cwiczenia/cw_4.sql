-- Napisz polecenie, które
--     generuje pojedynczą kolumnę, która zawiera kolumny: firstname (imię członka biblioteki), middleinitial (inicjał
--     drugiego imienia) i lastname (nazwisko) z tablicy member dla wszystkich członków biblioteki, którzy nazywają się Anderson
--      nazwij tak powstałą kolumnę email_name (użyj aliasu email_name dla kolumny)
--     zmodyfikuj polecenie, tak by zwróciło 'listę proponowanych loginów e-mail'  utworzonych przez połączenie imienia
--      członka biblioteki, z inicjałem drugiego imienia i pierwszymi dwoma literami nazwiska (wszystko małymi małymi literami).
--     wykorzystaj funkcję SUBSTRING do uzyskania części kolumny znakowej oraz LOWER do zwrócenia wyniku małymi literami.
--     wykorzystaj operator (+) do połączenia napisów.

select replace(lower(firstname + middleinitial + substring(lastname, 0, 3)),' ','') as email_name
from member
where lastname = 'Anderson'
order by email_name;