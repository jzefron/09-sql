use sakila;
-- 1a
select first_name, last_name from actor;
-- 1b
select concat(ucase(first_name), " ", ucase(last_name)) as ACTOR_NAME from actor ;
-- 2a
select actor_id, first_name, last_name from actor where (first_name = 'JOE');
-- 2b
select * from actor where last_name regexp 'gen';
-- 2c 
select last_name, first_name from actor where last_name regexp 'li';
select country_id, country from country
 where country in ('china', 'Afghanistan', 'Bangladesh');
 alter table actor 
	add description blob;
alter table actor
	drop column description;
-- select  distinct  last_name, count from actor-- unique(last_name) from actor
 select last_name, count(*) from actor group by last_name;
  select last_name,  count(*) n from actor  group by last_name having n>1  ;
  update actor 
  set first_name = 'HARPO' where first_name = 'GROUCHO' and last_name = 'WILLIAMS';
   update actor 
set first_name = 'GROUCHO' where first_name = 'HARPO' and last_name = 'WILLIAMS';
-- 5a
show create table address;
-- 6a
select first_name, last_name, address,  district, postal_code from staff left join address on staff.address_id = address.address_id;
-- 6b
select first_name, last_name, sum(amount) from staff left join payment on staff.staff_id = payment.staff_id group by staff.staff_id;
--  6c
select title, count(actor_id) from film_actor inner join film  on film_actor.film_id = film.film_id group by title;
-- 6d
select count(*) from film right join inventory on film.film_id = inventory.film_id where film.title = 'Hunchback Impossible';
-- 6e
select first_name, last_name, sum(amount) `Total Amount Paid` from customer right join payment on customer.customer_id = payment.customer_id group by customer.customer_id order by last_name;
-- 7a 
select * from film where title like 'k%' or title like 'q%';
-- 7b
select * from actor where actor_id in (select actor_id from film_actor where film_id in (select film_id from film where title = 'ALONE TRIP'));
-- 7c
select first_name, last_name, email from customer where address_id in (select address_id from address where city_id in (select city_id from city where country_id in (select country_id from country where country = 'CANADA')));
-- 7d 
select * from film where film_id in ( select film_id from film_category where category_id in ( select category_id from category where name = 'Family'));
-- 7e
select count(0), title from rental r join (select inventory_id , title from inventory i join  film f on i.film_id = f.film_id) j on r.inventory_id = j.inventory_id group by title order by count(0) desc;
-- 7f
select sum(amount), store_id from payment join staff where payment.staff_id = staff.staff_id group by store_id
; -- 7g
select store_id,city,country from store join (select address_id, city,country from  address a  join (select city, country, city_id from city c join country n on n.country_id = c.country_id) j  on j.city_id = a.city_id) j2 on j2.address_id = store.address_id;
-- 7h
select name, sum(amount) from category c join (select category_id, amount from film_category join (select film_id, amount from inventory join( select inventory_id, amount from rental r join payment p on r.rental_id = p.rental_id ) j on j.inventory_id  = inventory.inventory_id) j2 on j2.film_id = film_category.film_id) j3 on j3.category_id = c.category_id group by name order by sum(amount) desc limit 5;
-- 8a
create view Top_5_genre as
select name, sum(amount) from category c join (select category_id, amount from film_category join (select film_id, amount from inventory join( select inventory_id, amount from rental r join payment p on r.rental_id = p.rental_id ) j on j.inventory_id  = inventory.inventory_id) j2 on j2.film_id = film_category.film_id) j3 on j3.category_id = c.category_id group by name order by sum(amount) desc limit 5;
-- 8b
select * from Top_5_genre;
-- 8c 
drop view Top_5_genre; 