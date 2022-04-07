use sakila;
-- 1. How many films are there for each of the categories in the category table. Use appropriate join to write this query.

SELECT COUNT(f.film_id) AS 'Number of films', c.name AS Category
FROM sakila.film f
JOIN sakila.film_category fc
ON f.film_id=fc.film_id
JOIN sakila.category c
ON  c.category_id=fc.category_id
GROUP BY Category
ORDER BY 'Number of films';

-- 2. Display the total amount rung up by each staff member in August of 2005.
SELECT SUM(p.amount) AS 'Total amount', s.first_name AS 'First Name', s.last_name AS 'Last Name'
FROM sakila.payment p
JOIN sakila.staff s
USING (staff_id)
WHERE CONVERT(p.payment_date,DATE) BETWEEN '2005-08-01' AND '2005-08-31'
GROUP BY s.staff_id
ORDER BY 'Total amount';



-- 3. Which actor has appeared in the most films?
SELECT * 
FROM sakila.actor;

SELECT * 
FROM sakila.film_actor;

SELECT a.first_name, a.last_name, COUNT(f.film_id) AS 'Number of films'
FROM sakila.actor a
JOIN sakila.film_actor f
USING (actor_id)
GROUP BY a.actor_id
ORDER BY COUNT(f.film_id) DESC;




-- 4. Most active customer (the customer that has rented the most number of films)
SELECT * 
FROM sakila.rental;

SELECT * 
FROM sakila.customer;


SELECT CONCAT(a.first_name, ' ', a.last_name) AS 'Customer' , COUNT(r.inventory_id) AS Number_of_rentals
FROM sakila.customer a
JOIN sakila.rental r
USING (customer_id)
GROUP BY a.customer_id
ORDER BY Number_of_rentals DESC;




-- 5. Display the first and last names, as well as the address, of each staff member.

SELECT	s.first_name, s.last_name, a.address
FROM sakila.staff s
JOIN sakila.address a
USING (address_id);


-- 6. List each film and the number of actors who are listed for that film.

SELECT	f.title AS Film
		, COUNT(fa.actor_id) 'Number Of Actors'
FROM sakila.film f
	JOIN sakila.film_actor fa
		USING (film_id)
GROUP BY Film
ORDER BY Film;

-- 7. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name.
SELECT *
FROM payment;
SELECT *
FROM customer;

SELECT CONCAT(c.last_name, ' ', c.first_name) AS Customer, SUM(pay.amount) AS 'Total_paid'
FROM sakila.customer c
JOIN sakila.payment pay
USING (customer_id)
GROUP BY c.customer_id
ORDER BY c.last_name;

-- 8. List number of films per category. Done in number 1!!



-- LAB- SQL 8


-- 1. Write a query to display for each store its store ID, city, and country.

SELECT	s.store_id, ci.city, c.country
FROM store s
JOIN address a
USING (address_id)
JOIN city ci
USING (city_id)
JOIN country c
USING (country_id);



-- 2. Write a query to display how much business, in dollars, each store brought in.

SELECT	s.store_id, SUM(pay.amount) AS 'Total Revenue'
FROM store s
JOIN staff sta
USING (store_id)
JOIN payment pay
USING (staff_id)
GROUP BY s.store_id;


-- 3. Which film categories are longest?

SELECT	c.name AS Category, ROUND(AVG(f.length)) 'Mean Duration'
FROM sakila.category c
JOIN sakila.film_category fc
USING (category_id)
JOIN sakila.film f
USING (film_id)
GROUP BY Category
ORDER BY `Mean Duration` DESC;


-- 4. Display the most frequently rented movies in descending order.
SELECT * 
FROM rental;

SELECT * 
FROM film;

SELECT * 
FROM inventory;

SELECT COUNT(r.rental_id) as Number_rented, f.title
FROM rental r
JOIN inventory i
USING (inventory_id)
JOIN film f
USING (film_id)
GROUP BY f.title
ORDER BY Number_rented DESC;







-- 5. List the top five genres in gross revenue in descending order.

SELECT	c.name AS 'Genre', SUM(pay.amount) AS 'Gross Revenue'
FROM sakila.film f
JOIN sakila.inventory i
USING (film_id)
JOIN sakila.rental p
USING (inventory_id)
JOIN sakila.payment pay
USING (customer_id)
JOIN sakila.film_category fc
ON  (f.film_id = fc.film_id)
JOIN sakila.category c
USING (category_id)
GROUP BY `Genre`
ORDER BY `Gross Revenue` DESC
LIMIT 5;




-- 6. Is "Academy Dinosaur" available for rent from Store 1?

SELECT s.store_id, f.title, COUNT(s.store_id) as Available
FROM film f
JOIN inventory i
USING (film_id)
JOIN store s
USING (store_id)
WHERE f.title = 'ACADEMY DINOSAUR';




-- 7. Get all pairs of actors that worked together.

SELECT	CONCAT(act1.first_name,' ',act1.last_name) AS 'ACTOR 1', CONCAT(act2.first_name,' ',act2.last_name) AS 'ACTOR 2', f.title AS 'FILM'
FROM sakila.film_actor a -- SELF JOIN
JOIN sakila.film_actor b
ON  (a.actor_id <> b.actor_id) AND (a.film_id = b.film_id) 
JOIN sakila.actor act1
ON act1.actor_id = a.actor_id
JOIN sakila.actor act2
ON act2.actor_id = b.actor_id
JOIN sakila.film f
ON a.film_id = f.film_id    
GROUP BY `Film`;


-- 8. Get all pairs of customers that have rented the same film more than 3 times.
-- 9. For each film, list actor that has acted in more films.