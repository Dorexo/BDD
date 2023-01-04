/*1*/
/*h*/
create role sakiladmin login inherit password 'sakilamdp';
/*f*/
\c sakila
grant all privileges on all tables in schema public to sakiladmin;
/*g*/
\q
psql sakila sakiladmin

/*2.1*/
/*a*/
select title, name, release_year from film join film_category fc using(film_id) join category c on c.category_id=fc.category_id;
/*b*/
update actor set first_name='BRAD' where last_name='PITT';
/*c*/
/*select first_name, last_name, title from actor join film_actor using(actor_id) join film using(film_id) where title='AMADEUS HOLY';*/
select first_name, last_name from actor join film_actor fa using(actor_id) where fa.film_id=(select film_id from film where title='AMADEUS HOLY');
/*d*/
select title, (select count(*) from actor join film_actor fa using(actor_id) where fa.film_id=f.film_id) as "Nombre_acteurs" from film f order by "Nombre_acteurs" desc;
/*select f.title, count(*) as nombre_acteurs from film f left join film_actor fa on f.film_id=fa.film_id group by f.title order by nombre_acteurs desc;*/
/*e*/
select a.first_name, a.last_name, (select count(*) from film_actor fa where fa.actor_id=a.actor_id) as "Nombre_films" from actor a order by "Nombre_films" desc limit 10;
/*select ac.first_name, ac.last_name, count(*) as num_film from actor ac left join film_actor fa on ac.actor_id=fa.actor_id group by ac.actor_id order by num_film desc limit 10;*/
/*2.2*/
/*a*/
select first_name, last_name, (select sum(amount) from payment join rental r using(rental_id) where r.customer_id=c.customer_id) as "Montants" from customer c order by "Montants" desc limit 10;
/*b*/
select name, city, (select sum(amount) from payment p where s.id=p.staff_id) as "Montants" from staff_list s;
/*c*/
select name, (select sum(amount) from payment p where s.id=p.staff_id and p.payment_date>='2005-06-15' and p.payment_date<='2005-07-14') as "Montants" from staff_list s;
/*select s.first_name,s.last_name,sum(p.amount) as "toto" from staff s join payment p on s.staff_id = p.staff_id where p.payment_date between '2005-06-15' and '2005-07-14' group by s.first_name, s.last_name;*/
/*d*/
select date(p.payment_date), s.name, s.city, sum(p.amount) as "Montant" from staff_list s left join payment p on s.id=p.staff_id and date(p.payment_date)>='2005-06-15' and date(p.payment_date)<='2005-07-14' group by date(p.payment_date), s.name, s.city order by date(p.payment_date);
/*e*/
select f.title, count(*) as "Nb loué" from film f join inventory using(film_id) join rental using(inventory_id) join payment using(rental_id) group by f.title order by "Nb loué" desc limit 10;

select f.title, count(*) as "Nb loué" from film f join inventory i using(film_id) join store using(store_id) join address a using(address_id) join city c using(city_id) join rental r on r.inventory_id=i.inventory_id join payment using(rental_id) where a.address='47 MySakila Drive' and c.city='Lethbridge' group by f.title order by "Nb loué" desc limit 10;
/*f*/
select f.title, avg(age(r.return_date,r.rental_date)) as "Durée" from film f join inventory using(film_id) join rental r using(inventory_id) group by f.title order by "Durée" desc limit 10;