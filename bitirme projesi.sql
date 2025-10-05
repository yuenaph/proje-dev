create database feymart

create table category(
category_id int identity(1,1)  primary key,
category_name nvarchar(50) not null
)

create table seller(
seller_id int identity(1,1)  primary key,
seller_name nvarchar(20) not null,
seller_address nvarchar(200) not null
)

create table customers(
customer_id int identity(1,1) primary key,
customer_name nvarchar(20) not null,
customer_surname nvarchar(20) not null,
customer_mail nvarchar(50) not null,
customer_city nvarchar(20) not null,
record_date date default getdate(),
)

create table products(
product_id int identity(1,1) primary key,
product_name nvarchar(20) not null,
product_price int not null,
product_stock int not null,
category_id int not null,
seller_id int not null,
foreign key (category_id) references category(category_id),
foreign key (seller_id) references seller(seller_id)
)

create table purchase(
purchase_id int identity(1,1)  primary key,
customer_id int not null,
purchase_date date default getdate(),
total int not null,
payment_method nvarchar(20) not null,
foreign key (customer_id) references customers(customer_id)
)

create table purchase_detail(
detail_id int identity(1,1)  primary key,
purchase_id int not null,
product_id int not null,
quantity int not null,
price int not null,
foreign key (product_id) references products(product_id),
foreign key (purchase_id) references purchase(purchase_id)
)

insert into category (category_name) 
values
('Kadın'),
('Erkek'),
('Ev & Mobilya'),
('Süpermarket'),
('Kozmetik'),
('Ayakkabı & Çanta'),
('Elektronik'),
('Kitap & Kırtasiye & Hobi');

insert into seller(seller_name, seller_address)
values
('Grimelange','Adıyaman'),
('Pull&Bear','İstanbul'),
('Karaca','Ankara'),
('Happy Center','İstanbul'),
('MAC','Düzce'),
('BIRKENSTOCK','İzmir'),
('dyson','Bursa'),
('Mr.DIY','Kars');

insert into customers(customer_name, customer_surname, customer_mail, customer_city)
values
('Zeynep Alya','Temiz','temizeynep@gmail.com','İstanbul'),
('Emine Sude','Yaman','esidemune@gmail.com','Sakarya'),
('Hüsna','Çaldaştan','çaldaştanhüsna@gmail.com','Kars'),
('Serre','Bayoğlu','bayoğluserre@gmail.com','İstanbul'),
('Mehmet','Yazıcı','yazıcımehmet@gmail.com','Mardin'),
('Özcan','Ayaz','ayazözcan@gmail.com','Bursa'),
('Abdullah','Yılmaz','yılmazabdullah@gmail.com','Düzce');

insert into products(product_name, product_price, product_stock, category_id, seller_id)
values
('T-Shirt','301','205','1','1'),
('Düğmeli Hırka','647','130','2','1'),
('Deri Bomber Ceket','2490','55','1','2'),
('Çizgili Kazak','1790','165','2','2'),
('Çelik Tencere','2799','345','3','3'),
('Elektrikli Süpürge','5999','400','3','3'),
('Çamaşır Suyu','67','100','4','4'),
('Makarna','35','105','4','4'),
('Fondöten','2277','300','5','5'),
('Göz Farı','1349','300','5','5'),
('Arizona Stil Terlik','3570','500','6','6'),
('London Shearling','5896','500','6','6'),
('Saç Düzleştiricisi','22999','600','7','7'),
('Kulaklık','9999','606','7','7'),
('A4 Defter','427','100','8','8'),
('Jel Kalem Seti','150','100','8','8');


begin tran;
--- serre'nin siparişi (purchase_id=1)
insert into purchase(customer_id,total,payment_method)
values
(4,0,'kredi kartı')

declare @purchase_id1 int = scope_identity();

insert into purchase_detail(purchase_id,product_id,quantity,price)
values
(@purchase_id1,11,2,3570),
(@purchase_id1,10,1,1349);

update p
set p.product_stock=p.product_stock-pd.qty
from products p
join(
	select product_id, sum(quantity) as qty
	from purchase_detail where purchase_id=@purchase_id1
	group by product_id
	)pd
	on
	p.product_id=pd.product_id;

update purchase
set total=(
	select sum(quantity*price)
	from purchase_detail
	where purchase_id=@purchase_id1
	)
where purchase_id =@purchase_id1;
commit;
go


begin tran;
---zeynep'in siparişi (purchase_id=2)
insert into purchase(customer_id,total,payment_method)
values
(1,0,'kapıda ödeme')

declare @purchase_id2 int = scope_identity();

insert into purchase_detail(purchase_id,product_id,quantity,price)
values
(@purchase_id2,15,1,427)

update p
set p.product_stock=p.product_stock-pd.qty
from products p
join(
	select product_id, sum(quantity) as qty
	from purchase_detail where purchase_id=@purchase_id2
	group by product_id
	)pd
	on
	p.product_id=pd.product_id;

update purchase
set total=(
	select sum(quantity*price)
	from purchase_detail
	where purchase_id=@purchase_id2
	)
where purchase_id=@purchase_id2;
commit;
go




begin tran;
---abdullah'ın siparişi (purchase_id=3)
insert into purchase(customer_id,total,payment_method)
values
(7,0,'kredi kartı')

declare @purchase_id3 int = scope_identity();

insert into purchase_detail(purchase_id,product_id,quantity,price)
values
(@purchase_id3,7,1,67)
insert into purchase_detail(purchase_id,product_id,quantity,price)
values
(@purchase_id3,13,1,22999)


update p
set p.product_stock=p.product_stock-pd.qty
from products p
join(
	select product_id, sum(quantity) as qty
	from purchase_detail
	where purchase_id = @purchase_id3
	group by product_id
	)pd
on
p.product_id= pd.product_id;


update purchase
set total=(
	select sum(quantity*price)
	from purchase_detail
	where purchase_id = @purchase_id3
	)
where purchase_id= @purchase_id3;

commit;
go




begin tran;
---özcan'ın siparişi (purchase_id=4)
insert into purchase(customer_id,total,payment_method)
values
(6,0,'kapıda ödeme')

declare @purchase_id4 int = scope_identity();

insert into purchase_detail(purchase_id,product_id,quantity,price)
values
(@purchase_id4,3,1,2490)
insert into purchase_detail(purchase_id,product_id,quantity,price)
values
(@purchase_id4,5,3,2799)

update p
set p.product_stock=p.product_stock-pd.qty
from products p
join(
	select product_id, sum(quantity) as qty
	from purchase_detail 
	where purchase_id=@purchase_id4
	group by product_id
	)pd
on 
p.product_id=pd.product_id

update purchase
set total= (
select sum(quantity * price)
from purchase_detail
where purchase_id=@purchase_id4
)

where purchase_id=@purchase_id4;
commit;
go


--- en çok sipariş veren müşteri sayısı
select top 5 c.customer_id,c.customer_name, c.customer_surname, count(p.purchase_id) as purchase_count
from customers c
join purchase p 
on 
c.customer_id=p.customer_id
group by c.customer_id,c.customer_name, c.customer_surname
order by purchase_count desc;

--- en çok satılan ürünler
select p.product_id, p.product_name, sum(pdet.quantity) as selled
from products p
join purchase_detail pdet 
on
p.product_id=pdet.product_id
group by p.product_id, p.product_name
order by selled desc;

--- en çok cirosu olan satıcılar
select s.seller_id, s.seller_name, seller_address, sum(pdet.price*pdet.quantity) as ciro
from seller s
join products p
on p.seller_id=s.seller_id
join purchase_detail pdet
on pdet.product_id=p.product_id
group by s.seller_id, s.seller_name, seller_address
order by ciro desc;

--- şehirlere göre müşteri sayısı
select customer_city, count(*) as city_count
from customers 
group by customer_city
order by city_count desc;

--- kategorilere göre toplam satış
select c.category_id,c.category_name,sum(pted.quantity*pted.price) as income
from category c
join products p
on 
p.category_id=c.category_id
join purchase_detail pted
on
p.product_id=pted.product_id
group by c.category_id,c.category_name
order by income desc;

--- aylara göre satışlar
select year(purchase_date), month(purchase_date), sum(pted.quantity*pted.price) as monthly_income
from purchase pu
join purchase_detail pted
on pu.purchase_id=pted.purchase_id
group by year(purchase_date), month(purchase_date)
order by monthly_income


--- JOINS
--- müşteri bilgisi + ürün bilgisi + satıcı bilgisi

select pu.purchase_id,
c.customer_name,
c.customer_surname,
p.product_name,
p.product_price,
pdet.quantity,
sum(pdet.quantity*pdet.price) as total_price,
s.seller_name,
pu.purchase_date,
pu.total
from purchase pu
join customers c
on c.customer_id=pu.customer_id
join purchase_detail pdet
on pdet.purchase_id = pu.purchase_id
join products p
on p.product_id=pdet.product_id
join seller s
on s.seller_id=p.seller_id
group by pu.purchase_id,c.customer_name,c.customer_surname,p.product_name,p.product_price,pdet.quantity,s.seller_name,pu.purchase_date,pu.total
order by pu.purchase_id;

--- hiç satılmamış ürünler

select p.product_id,product_name,product_price,product_stock
from products p
left join purchase_detail pdet
on p.product_id=pdet.product_id
where pdet.product_id is null;

--- hiç sipariş vermemiş müşteriler

select c.customer_id,c.customer_name,c.customer_surname,c.customer_mail,c.customer_city
from customers c
left join purchase pu
on c.customer_id=pu.customer_id
where pu.customer_id is null;
