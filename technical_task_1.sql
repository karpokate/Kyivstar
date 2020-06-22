-- task 1 
-- вывести самую объемную книгу 
select id_book, name_book 
from book 
where pages = (select max (pages) from book) 

-- task 2 
-- вывести всех студентов, которые брали книгу name_1
select *
from students 
where (id_book) in (select id_book 
from book where name_book = 'name_1') 

-- task 3
-- какое количество студентов брали книгу name_2
select count (id_student)  
from students 
where (id_book) in (select id_book 
from book where name_book = 'name_2') 

-- task 4
-- вывести в алфавитном порядке названия самых дорогих книг в каждом жанре
-- цены уникальны 
select * from book 
where (genre,price) in (select genre, max(price) from book group by genre)
order by NLSSORT(name_book, 'NLS_SORT = BINARY')

-- task 5
-- вывести все возможные данные книги, в названии которых присутствует символ %
-- vers 1 
select * 
from book 
where  regexp_like (name_book,'%') 
-- vers 2 
select * 
from book 
where name_book like '%\%%' ESCAPE '\'

-- task 6
-- вывести имена последних по дате трех студентов и книги которые они брали
-- vers 1 
select name_student, name_book  from (select name_student, id_book, 
rank () over (order by date_ desc) as filter 
from students
where rownum<4) a, book b
where a.id_book=b.id_book
-- vers 2 
select name_student, name_book  from (select name_student, id_book 
from students
where rownum<4
order by date_ desc) a, book b
where a.id_book=b.id_book
-- task 7
-- вывести книги, которые студенты брали в течении последнего месяца
select *
from book 
where (id_book) not in (
select id_book
from students
where date_ < add_months(sysdate,-1))
