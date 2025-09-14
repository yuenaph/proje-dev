create database veritabani_books
use veritabani_books

create table books
(
book_id int identity(1,1) primary key,
title nvarchar(70) not null,
author nvarchar(30) not null,
genre nvarchar(20),
price decimal(18,2),
stock int,
published_year int,
added_at date 
)

insert into books(title,author,genre,price,stock,published_year,added_at)
values
(N'Kayıp Zamanın İzinde',	'M. Proust',	'roman', 129.90,	25,	1913,	'2025-08-20'),
(N'Simyacı',	'P. Coelho',	'roman'	,89.50,	40,	1988,	'2025-08-21'),
(N'Sapiens','Y. N. Harari','tarih',159.00	,18	,2011,	'2025-08-25'),
(N'İnce Memed',	'Y. Kemal',	'roman',	99.90,	12,	1955,	'2025-08-22'),
(N'Körlük','J.Saramag', 'roman',99.90,12,1995,'2025-08-22'),
(N'Dune','F. Herbert','bilim',149.00,30,1965,'2025-09-01'),
(N'Hayvan Çiftliği','G. Orwell','roman',79.90,55,195,'2025-08-23'),
(N'1984', 'G. Orwell',	'roman',	99.00,	35,	1949,	'2025-08-24'),
(N'Nutuk', 'M. K. Atatürk', 'tarih',139.00,20,1927,'2025-08-27'),
(N'Küçük Prens', N'A. de Saint-Exupéry', N'çocuk', 69.90, 80, 1943, '2025-08-26'),
(N'Başlangıç', N'D. Brown', N'roman', 109.00, 22, 2017, '2025-09-02'),
(N'Atomik Alışkanlıklar', N'J. Clear', N'kişisel gelişim', 129.00, 28, 2018, '2025-09-03'),
(N'Zamanın Kısa Tarihi', N'S. Hawking', N'bilim', 119.50, 16, 1988, '2025-08-29'),
(N'Şeker Portakalı', N'J. M. de Vasconcelos', N'roman', 84.90, 45, 1968, '2025-08-30'),
(N'Bir İdam Mahkûmunun Son Günü', N'V. Hugo', N'roman', 74.90, 26, 1829, '2025-08-31');

select *from books
-- question 1 --
select title, author, price
from books 
order by price asc
-- question 2 --
select title , genre
from books 
where[genre]='roman'
order by title asc
-- question 3 --
select title ,price
from books 
where[price] between 80 and 120
-- question 4 --
select title , stock
from books
where[stock]<20
-- question 5 --
select title 
from books
where lower(title) like N'%zaman%'
-- question 6 --
select title,author
from books
where[genre] in (N'roman',N'bilim')
-- question 7 --
select title, published_year
from books
where [published_year]>=2000
order by published_year desc
-- question 8 --
select title, added_at
from books
where added_at >= dateadd(day, -10, getdate());
-- question 9 --
select top 5 title, price
from books
order by price desc;
-- question 10 --
select title, price, stock
from books
where [stock] between 30 and 60
order by price asc
