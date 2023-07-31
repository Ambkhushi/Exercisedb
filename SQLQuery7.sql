create database TriggerDb
use TriggerDb
create table Customers(
Cid int primary key,
Fname nvarchar(50) not null,
Lname nvarchar(50) not null,
OdLimit float not null,
MEdate date not null)

create table CustomersLog(
LogId int primary key identity,
Cid int,
Fname nvarchar(50),
Lname nvarchar(50),
OdLimit float,
MEdate date,
ActionTaken nvarchar(100),
ActionTime datetime)

--create trigger[schema_name.] trigger_name---
create trigger insertTrigger
on Customers
after insert
as
declare @id int
declare @fn nvarchar(50)
declare @ln nvarchar(50)
declare @odlimit float
declare @mdate date

select @id=Cid from inserted 
select @fn=Fname from inserted
select @ln=Lname from inserted
select @odlimit=Odlimit from inserted
select @mdate=MEdate from inserted
insert into CustomersLog (Cid,Fname,Lname,OdLimit,MEdate,ActionTaken,ActionTime)
values
(@id,@fn,@ln,@odlimit,@mdate,'Record Inserted',getdate())
print 'Trigger Fired action Captured!!!'

insert into Customers(Cid,Fname,Lname,OdLimit,MEdate) values (2,'Raj','Kumar',67000.90,'12/12/2021')
select * from Customers
select * from CustomersLog
------------------------------------------------------
create trigger afterDelTrigger
on Customers
after delete
as
declare @id int
declare @fn nvarchar(50)
declare @ln nvarchar(50)
declare @odlimit float
declare @mdate date

select @id=Cid from deleted
select @fn=Fname from deleted
select @ln=Lname from deleted
select @odlimit=Odlimit from deleted
select @mdate=MEdate from deleted
insert into CustomersLog (Cid,Fname,Lname,OdLimit,MEdate,ActionTaken,ActionTime)
values
(@id,@fn,@ln,@odlimit,@mdate,'Record deleted',getdate())
print 'Trigger Fired your delete action Captured!!!'

delete from Customers where Cid=1

select * from Customers
select * from CustomersLog
-------------------------------------------------------------
create trigger afterUpdateTrigger
on Customers
after update
as
declare @id int
declare @fn nvarchar(50)
declare @ln nvarchar(50)
declare @odlimit float
declare @mdate date

select @id=Cid from inserted
select @fn=Fname from inserted
select @ln=Lname from inserted
select @odlimit=Odlimit from inserted
select @mdate=MEdate from inserted
insert into CustomersLog (Cid,Fname,Lname,OdLimit,MEdate,ActionTaken,ActionTime)
values
(@id,@fn,@ln,@odlimit,@mdate,'Record updated',getdate())
print 'Trigger Fired your update action Captured!!!'

update Customers set Fname='Aaroohi' where Cid=2

select * from Customers
select * from CustomersLog

insert into Customers (Cid,Fname,Lname,OdLimit,MEdate) values (5,'Deep','Das',67000.90,'12/12/2021')
insert into Customers (Cid,Fname,Lname,OdLimit,MEdate) values (9,'Reenu','Vats',67000.90,'12/12/2021')
------------------------------------------
create trigger insteofadDelTrigger
on Customers
instead of delete
as
declare @id int
declare @fn nvarchar(50)
declare @ln nvarchar(50)
declare @odlimit float
declare @mdate date
select @id=Cid from deleted
select @fn=Fname from deleted
select @ln=Lname from deleted
select @odlimit=Odlimit from deleted
select @mdate=MEdate from deleted
if(@odlimit>=800000)
begin
raiserror('you can not delete this Customer its VIP',16,1)
rollback
end
else
begin
delete from Customers where Cid=@id
Commit;
insert into CustomersLog(cid,Fname,Lname,OdLimit,MEdate,ActionTaken,ActionTime)
values
(@id,@fn,@ln,@odlimit,@mdate,'InsteadofTrigger:Record Delete',GETDATE())
print 'instead of Trigger says Trigger Fired your delete action Captured!!!'
end
delete from Customers where Cid=5
select *from Customers
select * from CustomersLog
delete from Customers where Cid=9
--------------------------
CREATE TRIGGER Secure
ON DATABASE
FOR Create_table
AS
begin
PRINT 'you must disable Trigger "Secure" create tables!'
ROLLBACK
end

create table OurTable(ID int primary key,
Name nvarchar(50) not null)
