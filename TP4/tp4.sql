/*1*/
/*a*/
create role testrole login superuser createrole;
create database testbdd owner testrole;
/*b*/
create table table1(num INT, name VARCHAR(10), adresse VARCHAR(20),
	primary key(num));
create table table2(adresse VARCHAR(20), house VARCHAR(10), primary key(adresse));
/*c*/
create role test2role login;
grant insert, select, update, delete on table1 to test2role;

/*2*/
/*a*/
create view employe_service as 
select e.nom,
	e.fonction, 
	(e.salaire+coalesce(e.comm,0)) as "Revenu mensuel", 
	es.nom as "nom sup", 
	type_service, 
	ville 
from employe e join service using(num_service) 
	join employe es on e.numemp_sup=es.numemp;
/*b*/
select * from employe_service where type_service='siege';
/*c*/
create role viewrole login;
grant all privileges on employ_service to viewrole;

/*3*/
/*a*/
alter table employe add salaireetcom numeric(1000,4);
update employe set salaireetcom=salaire+coalesce(comm,0);
/*b*/
create function salairecom() returns trigger as $salairecom$
	begin
	if new.salaireetcom < new.salaire then
	raise exception '% ne peut pas avoir un salaire+comm < salaire!',new.nom;
	end if;
	end;
	$salairecom$ language plpgsql;
 create trigger salairecom before insert or update 
	on employe for each row execute procedure salairecom();