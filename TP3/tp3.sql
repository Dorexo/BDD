/*1*/
/*a*/
insert into employe (numemp,nom,fonction,numemp_sup,date_embauche,salaire,num_service)
values (666,'AAAAA','directeur',839,'2022-11-18',6666,40);
/*b*/
insert into employe (numemp,nom,fonction,numemp_sup,date_embauche,salaire,num_service)
values (777,'BBBBB','ingenieur',666,'2022-11-18',777,40);
/*g*/
/* ERROR:  insert or update on table "employe" violates foreign key constraint "employe_num_service_fkey"
DETAIL:  Key (num_service)=(50) is not present in table "service". */
/*2*/
/*a*/
update employe set salaire=salaire+salaire*0.1;
/*c*/
/* ERROR:  insert or update on table "employe" violates foreign key constraint "employe_numemp_sup_fkey"
DETAIL:  Key (numemp_sup)=(999) is not present in table "employe". */
/*3*/
/*a*/
delete from employe where num_service=40;
/*b*/
/* ERROR:  update or delete on table "employe" violates foreign key constraint "employe_numemp_sup_fkey" on table "employe"
DETAIL:  Key (numemp)=(839) is still referenced from table "employe". */
alter table employe disable trigger all;
delete from employe where fonction='pdg';
alter table employe enable trigger all;
/*4*/
/*a*/
alter table employe drop constraint employe_numpemp_sup_fkey;
alter table employe add constraint employe_numpemp_sup_fkey 
	foreign key (numemp_sup) references employe (numemp) on delete cascade;



/**/
create view as select * from employe natural join service;
\d