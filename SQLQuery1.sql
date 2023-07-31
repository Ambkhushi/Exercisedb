drop database exercisedb
create database exercisedb
use exercisedb
create table student(
Sid int primary key,
Sname nvarchar(50),
Semail nvarchar(50),
Scontact nvarchar(10))

insert into student(Sid,Sname,Semail,Scontact) values
(1,'Sam','sam123@gmail.com','9876543210'),
(2,'Devis','Dev123@gmail.com','8765432190'),
(3,'Neel','neel1@gmail.com','7654321980')
---
create table fee( 
Sid int,
Sfee float,
Smonth int,
Syear int,
Primary Key (Sid,Smonth,Syear),
Foreign Key(Sid) References student(Sid))
------
create table PayConfirmation(
Sid int,
name nvarchar(50),
Email nvarchar(50),
fee float,
payondate date)
------
create trigger trgfeepayconfirmation
on fee
after insert
as
declare @id int
declare @name nvarchar(50)
declare @email nvarchar(50)
declare @fee float

select @id=Sid from inserted
select @fee=Sfee from inserted
begin
select @name=Sname, @email=Semail from student where sid=@id
insert into PayConfirmation values(@id,@name,@email,@fee,GETDATE())
print 'Pay Confirmation Table Updated'
end

insert into fee (Sid,Sfee,Smonth,Syear)values (4,1800,1,2023)
insert into fee values (1,2500,5,2023)
insert into fee values (2,1500,6,2023)
insert into fee values (2,1700,7,2023)

select * from PayConfirmation