create table stgCustomer(id int, phonenumber varchar(100))
create table DimCustomer(id int, phonenumber varchar(100),IsActive bit, StartDate date, EndDate date)

--insert into dbo.stgCustomer values (1,'98989')
--select * from stgCustomer

insert into DimCustomer 
select id,
	phonenumber,
	1 as IsActive,
	getdate() as StartDate,
	NULL as EndDate
from stgCustomer s
where not exists(select 1 from DimCustomer t where t.id = s.id)

--select * from DimCustomer

--update DimCustomer
--set phonenumber = '3w43444'

update T
set T.phonenumber = s.phonenumber,
	T.isActive =0,
	T.EndDate = getdate()
from DimCustomer T
join stgCustomer s on t.id = s.id and T.isActive =1 


insert into DimCustomer 
select id,
	phonenumber,
	1 as IsActive,
	getdate() as StartDate,
	NULL as EndDate
from stgCustomer s
where exists(select 1 from DimCustomer t where t.id = s.id and t.IsActive=0) 

--select * from DimCustomer