use staffDb
select * from dept
select * from Salary
select * from staff
--abs
select Salary, abs(Salary) as AbsoluteValue from staff
select abs(-10.67)
--rand
select rand(10)
--
select Salary, round(Salary,1) as RoundedAmount from staff
select round(17.56719,3)
--
select upper(Fname) as FirstName from staff
select upper('dotnet')
---
select lower(Lname) as LastName from staff
select lower('DOTNET')
---
select ltrim(Fname) from staff
select ltrim(' dotnet')
--
select convert (int,Salary) from staff
select convert (int, 15.56)
select Fname +'->'+Lname+'->'+Designation+'->'+convert(nvarchar(50),Id)as 'first Name->Last Name->Designation->Id'
from staff

--date function
select getdate() as Today

select DATEPART(DAY,getdate())'Date'
select DATEPART(MONTH,getdate())'month'
select DATEPART(YEAR,getdate())'year'

select DATEDIFF(year,'12/12/2019','12/10/2022')
select DATEDIFF(MONTH,'12/12/2019','12/10/2022')
select DATEDIFF(Day,'12/12/2019','12/10/2022')

-------
create table Customer(
cid int primary key,
cname nvarchar(50) not null,
cemail nvarchar(50) not null unique,
contact nvarchar(10) not null unique,
cpwd as RIGHT(Cname,2)+CAST(cid as nvarchar(10))+''+Left(contact,2) persisted,
menddate DATE not null)
--drop table Customer
insert into Customer
(cid,cname,cemail,contact,menddate)
values
(1000,'John D','Johnd@gmail.com','1234567890','2023-12-31'),
(1001,'Jane Smith','smithjane@gmail.com','9876543210','2022-10-15'),
(1003,'Sam Johnson','samJohnson@gmail.com','9765432180','2023-03-22')
----
create function fnGetFullName(
@fn nvarchar(50),
@ln nvarchar(50)
)
returns nvarchar(101)
as
begin
return(Select @fn+''+@ln);
end

---calling the above creatred function
select dbo.fnGetFullName('Sam',' Dicosta') as 'Full Name'
select id,dbo.fnGetFullName(fname, lname) as 'Full Name', Salary from staff

create schema ourSchema;

create table ourSchema.Staff
( id int primary key,
Salary decimal(6,2))

alter table ourSchema.Staff alter column Salary decimal (8,2)

insert into ourSchema.Staff values (1,98000.50)
insert into ourSchema.Staff values (2,75000.25)
insert into ourSchema.Staff values (3,80000.90)
insert into ourSchema.Staff values (4,65000.75)

create function ourSchema.fnGetBonus(
@sal decimal(8,2)
)
returns decimal(8,2)
as
begin
return (select @sal*0.15);
end

select Salary,ourSchema.fnGetBonus(Salary) as 'Bonus' from ourSchema.Staff

create database JoinExDb
use JoinExDb
create function fnGetEmployee()
returns table
as
return(select * from Emps)

drop database TriggerDb