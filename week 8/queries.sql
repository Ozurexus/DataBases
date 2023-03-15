--query 1
select DISTINCT film.film_id, film.title from film 
left JOIN inventory ON film.film_id = inventory.film_id
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
left JOIN rental ON inventory.inventory_id = rental.inventory_id
WHERE (category.name = 'Horror' OR category.name = 'Sci-Fi') and (film.rating='PG-13' or film.rating='R') and rental.rental_id IS NULL
order by film.title

--query 2
with expr AS (
	SELECT store_profit.store_id,  city_id , profit FROM 
   (SELECT store_id, city_id FROM store
     JOIN address ON store.address_id = address.address_id) AS city_store
    JOIN
  (SELECT SUM(amount) AS profit,  store_id FROM
     (SELECT rental.rental_id,amount, inventory_id FROM payment
     JOIN rental ON rental.rental_id = payment.rental_id
     WHERE payment_date BETWEEN '2007-05-01' AND '2007-05-31') AS monthly
   JOIN inventory ON inventory.inventory_id = monthly.inventory_id 
   GROUP BY store_id) AS store_profit
ON city_store.store_id = store_profit.store_id)

SELECT DISTINCT store_id,  city_id, MAX(profit) as monthly_profit
FROM  expr 
GROUP BY store_id, city_id;
