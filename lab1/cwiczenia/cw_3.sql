--   Napisz polecenie, które:
--     wybiera numer członka biblioteki (member_no), isbn książki (isbn) i wartość naliczonej kary (fine_assessed) z 
--      tablicy loanhist  dla wszystkich wypożyczeń/zwrotów, dla których naliczono karę (wartość nie NULL w kolumnie fine_assessed)
--     stwórz kolumnę wyliczeniową zawierającą podwojoną wartość kolumny fine_assessed
--     stwórz alias double_fine dla tej kolumny (zmień nazwą kolumny na double_fine)
--     stwórz kolumnę o nazwie diff, zawierającą różnicę wartości w kolumnach double_fine i fine_assessed
--     wybierz wiersze dla których wartość w kolumnie diff jest większa niż 3

select *
from (select member_no, isbn, fine_assessed, fine_assessed * 2 as double_fine, fine_assessed * 2 - fine_assessed as diff
      from loanhist
      where fine_assessed is not null) t
where diff > 3

