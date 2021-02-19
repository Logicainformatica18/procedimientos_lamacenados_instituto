create database institute;
use institute;
create table student(
id_student int primary key identity,
firstname varchar(50),
lastname varchar(50),
names varchar(50),
create_at datetime,
update_at datetime
);

insert into student(firstname,lastname,names,create_at,update_at)
values
('cardenas','aquino','anthony',getdate(),getdate());
select * from student;
create table specialty(
id_specialty int primary key identity,
[description] varchar(70),
detail varchar(50),
create_at datetime,
update_at datetime
);
insert into specialty([description],detail,create_at,update_at)
values
('Computacion e informatica','',getdate(),getdate());
select * from specialty;
create table course(
id_course  int primary key identity,
[description] varchar(50),
detail varchar(50),
create_at datetime,
update_at datetime
);
insert into course([description],detail,create_at,update_at)
values
('MS SQL SERVER','',getdate(),getdate());
select * from course;
create table registry(
id_registry int primary key identity,
id_course int,
foreign key(id_course) references course(id_course),
id_specialty int,
foreign key(id_specialty) references specialty(id_specialty),
create_at datetime,
update_at datetime
);
insert into registry(id_course,id_specialty,create_at,update_at)
values
(1,1,getdate(),getdate());
select * from registry;

create table registry_detail(
id_registry_detail int primary key identity,
id_registry int,
foreign key(id_registry) references registry(id_registry),
id_student int,
foreign key(id_student) references student(id_student),
create_at datetime,
update_at datetime
);

select * from registry_detail;
create table qualification(
id_qualification int primary key identity,
id_registry_detail int,
foreign key(id_registry_detail) references
registry_detail(id_registry_detail),
n1 int default 0,
n2 int default 0,
n3 int default 0,
n4 int default 0,
n5 int default 0,
ex1 int default 0,
n7 int default 0,
n8 int default 0,
n9 int default 0,
n10 int default 0,
n11 int default 0,
ex2 int default 0,
create_at datetime,
update_at datetime
);
select * from qualification;
create table assistance(
id_assistance int primary key identity,
id_registry_detail int,
foreign key(id_registry_detail) references
registry_detail(id_registry_detail),
[date] date,
update_at datetime
);
select * from assistance;
go



-- sp

create procedure sp_registry_detail_insert(
@id_registry int,
@id_student int
)
as
begin
	insert into registry_detail(id_registry,id_student,create_at,update_at)
	values(@id_registry,@id_student,getdate(),getdate());
	-- @@identity captura el codigo generado en la anterior consulta (insert)
	--
	declare @id_registry_detail int =@@identity;
		insert into qualification(id_registry_detail) values (@id_registry_detail);
	-- 
	declare @date datetime = getdate();
	declare @date_end datetime = DATEADD(week,12,getdate());
	while (@date < @date_end)
	begin
	INSERT INTO assistance(id_registry_detail,[date],update_at)
	values (@id_registry_detail,@date,getdate());
	set @date =DATEADD(week,1,@date)
	end
end

execute sp_registry_detail_insert 1,1
exec sp_registry_detail_insert 1,1
select * from assistance

declare @hoy datetime = getdate()
declare @fecha_12 datetime = dateadd(week,1,getdate())

select @fecha_12;

select * from assistance