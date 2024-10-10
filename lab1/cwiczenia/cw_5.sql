--         Napisz polecenie, które wybiera title i title_no z tablicy title.
--
--     wynikiem powinna być pojedyncza kolumna o formacie jak w przykładzie poniżej:
--             The title is: Poems, title number 7
--     czyli zapytanie powinno zwracać pojedynczą kolumnę w oparciu o wyrażenie, które łączy 4 elementy:
--             stała znakowa ‘The title is:’
--         wartość kolumny  title
--         stała znakowa ‘title number’
--         wartość kolumny title_no

select 'The title is: ' + title + ' title number ' + trim(str(title_no))
from title
