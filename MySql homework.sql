USE sakila;

SELECT first_name, last_name FROM actor;

SELECT concat(UPPER(first_name), ' ', UPPER(last_name)) as 'Actor Name'
FROM actor;

SELECT actor_id, first_name, last_name 
FROM actor
WHERE first_name = 'Joe';

SELECT actor_id, first_name, last_name 
FROM actor
WHERE last_name like '%GEN%';

SELECT actor_id, first_name, last_name 
FROM actor
WHERE last_name like '%LI%'
ORDER BY last_name, first_name;

SELECT country_id, country
FROM country
WHERE country in ('Afghanistan', 'Bangladesh', 'China');

ALTER TABLE `sakila`.`actor` 
ADD COLUMN `middle_name` VARCHAR(50) NULL AFTER `first_name`;

ALTER TABLE `sakila`.`actor` 
CHANGE COLUMN `middle_name` `middle_name` BLOB NULL DEFAULT NULL ;

ALTER TABLE `sakila`.`actor` 
DROP COLUMN `middle_name`;

SELECT last_name, count(actor_id)
FROM actor	
GROUP BY last_name
ORDER BY last_name;

SELECT last_name, count(actor_id)
FROM actor	
GROUP BY last_name
HAVING COUNT(actor_id) > 1
ORDER BY last_name;

UPDATE actor
SET first_name = 'HARPO' 
WHERE first_name = 'Groucho' 
and last_name = 'Williams'; 

UPDATE actor
SET first_name = IF(first_name = 'HARPO' , 'GROUCHO','MUCHO GORUCHO')
WHERE actor_id = 172;
	   
SHOW CREATE TABLE  sakila.address;

SELECT s.first_name
, s.last_name
, a.address
, a.address2
FROM staff as s
INNER JOIN address as a
ON s.address_id = a.address_id;
 
SELECT s.staff_id
, s.first_name
, s.last_name
, SUM(p.amount) as TotAmt
FROM staff as s
INNER JOIN payment as p
ON s.staff_id = p.staff_id
WHERE payment_date BETWEEN '2005-08-01' and '2005-08-31'
GROUP BY s.staff_id, s.first_name, s.last_name
ORDER BY s.last_name;

SELECT f.film_id
, f.title
, COUNT(fa.actor_id) as NumActors
FROM film as f
INNER JOIN film_actor as fa
ON f.film_id = fa.film_id
GROUP BY f.film_id, f.title
ORDER by f.title;

SELECT f.film_id
, f.title
, COUNT(i.inventory_id) as CntInventory
FROM film as f
INNER JOIN inventory as i
ON f.film_id = i.film_id
and f.title = 'Hunchback Impossible'
GROUP BY f.film_id, f.title
ORDER BY f.title;

SELECT c.customer_id
, c.last_name
, c.first_name
, SUM(p.amount) as TotalPayments
FROM customer as c 
INNER JOIN payment as p
ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY c.last_name;

SELECT f.film_id
, f.title
FROM film as f
INNER JOIN `language` as l
ON f.language_id = l.language_id
and l.name = 'English'
and (f.title like 'k%' or f.title like 'q%');

SELECT a.first_name
, a.last_name
FROM actor as a
INNER JOIN film_actor as fa
on a.actor_id = fa.actor_id
WHERE fa.film_id IN
	(SELECT f.film_id
		FROM film as f
        WHERE f.title = 'Alone Trip'
	);

SELECT cs.last_name
, cs.first_name
, cs.email
FROM customer as cs
INNER JOIN address as a
ON cs.address_id = a.address_id
INNER JOIN city as ci
ON a.city_id = ci.city_id
INNER JOIN country as co
ON ci.country_id = co.country_id
and co.country = 'Canada';


SELECT f.film_id
, f.title
, c.name as Category
FROM film as f
INNER JOIN film_category as fc
ON f.film_id = fc.film_id
INNER JOIN category as c
ON fc.category_id = c.category_id
and c.name = 'Family';

SELECT f.film_id
, f.title
, COUNT(r.inventory_id) as NumRents
FROM rental as r
INNER JOIN inventory as i
ON r.inventory_id = i.inventory_id
INNER JOIN film as f
ON i.film_id = f.film_id
GROUP BY f.film_id, f.title
ORDER BY COUNT(r.inventory_id) DESC;

SELECT s.store_id
, a.address 
, SUM(p.amount)
FROM store as s
INNER JOIN customer as c
ON s.store_id = c.store_id
INNER JOIN payment as p
ON c.customer_id = p.customer_id
INNER JOIN address as a 
ON s.address_id = a.address_id
GROUP BY s.store_id, a.address
ORDER BY s.store_id;

SELECT s.store_id
, ci.city
, co.country
FROM store as s
INNER JOIN address as a 
ON s.address_id = a.address_id
INNER JOIN city as ci
ON a.city_id = ci.city_id
INNER JOIN country as co
ON ci.country_id = co.country_id;

SELECT c.name
, SUM(p.amount) as GrossRevenue
FROM payment as p
INNER JOIN rental as r
ON p.rental_id = r.rental_id
INNER JOIN inventory as i
ON r.inventory_id = i.inventory_id
INNER JOIN film_category as fc
ON i.film_id = fc.film_id
INNER JOIN category as c
ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY SUM(p.amount) DESC
LIMIT 5;

CREATE VIEW TopCategoryRevenue_vw as 
SELECT c.name
, SUM(p.amount) as GrossRevenue
FROM payment as p
INNER JOIN rental as r
ON p.rental_id = r.rental_id
INNER JOIN inventory as i
ON r.inventory_id = i.inventory_id
INNER JOIN film_category as fc
ON i.film_id = fc.film_id
INNER JOIN category as c
ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY SUM(p.amount) DESC
LIMIT 5;

SELECT * 
FROM TopCategoryRevenue_vw;

DROP VIEW TopCategoryRevenue_vw;

