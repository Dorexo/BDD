/*1*/
/*a*/
select nom, fonction, ville 
from employe join service using(num_service) 
order by ville,fonction;
/*b*/
select nom, fonction 
from employe join service using(num_service) 
where ville='Brest';
/*c*/
/*select nom, fonction from employe 
where numemp_sup!=(select numemp from employe where fonction='pdg');*/
select e.nom, e.fonction 
from employe e join employe s 
on e.numemp_sup=s.numemp and s.fonction!='pdg';
/*d*/
select e.nom, 
    e.fonction, 
    s.nom as "nom sup", 
    s.fonction as "fonction sup", 
    ville 		
from employe e join service using(num_service) join employe s 
on e.numemp_sup=s.numemp 
order by e.fonction, e.nom;
/*2*/
/*a*/
select type_service, count(*) 
from employe join service using(num_service) 
group by type_service;
/*b*/
select 
    ville, 
    count(*) as "nb emp", 
    round(avg(salaire),2) as "salaire moy" 
from employe join service using(num_service) 
group by ville;
/*3*/
/*a*/
select s.num_service, s.type_service from service s 
where (select count(*) from employe e where e.num_service=s.num_service)=0;
/*4*/
/*a*/
select e.nom, e.fonction, s.nom as "nom sup", s.fonction as "fonction sup" 
from employe e left join employe s 
on e.numemp_sup=s.numemp 
order by e.fonction, e.nom;
/*b*/
/**/select num_service, type_service from service 
where num_service not in (select num_service from employe);
/**/select num_service, type_service from service s
where not exists (select * from employe where num_service=s.num_service);
/**/select s.num_service, s.type_service 
from service s left join employe e on e.num_service=s.num_service 
where e.num_service is null;