CREATE OR REPLACE FUNCTION retrieveCustomers(starting INT, ending INT)
RETURNS TABLE (
    customer_id INT,
    first_name VARCHAR(45),
    last_name VARCHAR(45),
    email VARCHAR(50),
    address_id smallint
) AS $$
BEGIN
    IF starting < 0 THEN
        RAISE EXCEPTION 'Invalid start parameter';
    END IF;
	IF ending > 600 THEN
        RAISE EXCEPTION 'Invalid end parameter';
    END IF;
	IF starting > ending THEN
        RAISE EXCEPTION 'Start parameter is bigger than end parameter';
    END IF;
    RETURN QUERY 
        SELECT customer.customer_id, customer.first_name, 
		customer.last_name, customer.email, customer.address_id
        FROM customer 
        ORDER BY customer.address_id 
        LIMIT ending - starting + 1
        OFFSET starting - 1;
END;
$$
LANGUAGE PLPGSQL;

SELECT * FROM retrieveCustomers(10, 40);