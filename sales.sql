
CREATE TABLE customers (
    cust_id SERIAL PRIMARY KEY,
    cust_name VARCHAR(100) NOT NULL
);

INSERT INTO customers (cust_name)
VALUES
    ('Raju'), ('Sham'), ('Paul'), ('Alex');

CREATE TABLE orders (
    ord_id SERIAL PRIMARY KEY,
    ord_date DATE NOT NULL,
    cust_id INTEGER NOT NULL,
    FOREIGN KEY (cust_id) REFERENCES customers(cust_id)
);

INSERT INTO orders (ord_date, cust_id)
VALUES
    ('2024-01-01', 1),
    ('2024-02-01', 2),
    ('2024-03-01', 3),
    ('2024-04-04', 2);

CREATE TABLE products (
    p_id SERIAL PRIMARY KEY,
    p_name VARCHAR(100) NOT NULL,
    price NUMERIC NOT NULL
);

INSERT INTO products (p_name, price)
VALUES
    ('Laptop', 55000.00),
    ('Mouse', 500),
    ('Keyboard', 800.00),
    ('Cable', 250.00)
;



CREATE TABLE order_items (
    item_id SERIAL PRIMARY KEY,
    ord_id INTEGER NOT NULL,
    p_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    FOREIGN KEY (ord_id) REFERENCES orders(ord_id),
    FOREIGN KEY (p_id) REFERENCES products(p_id)
);

INSERT INTO order_items (ord_id, p_id, quantity)
VALUES
    (1, 1, 1),
    (1, 4, 2),
    (2, 1, 1),
    (3, 2, 1),
    (3, 4, 5),
    (4, 3, 1);


SELECT p.p_name, oi.quantity FROM order_items oi
JOIN  products p ON oi.p_id = p.p_id;



SELECT c.cust_name, p.p_name, oi.quantity, o.ord_date, p.price FROM order_items oi
JOIN  
products p ON oi.p_id = p.p_id
JOIN
orders o ON oi.ord_id = o.ord_id
JOIN 
customers c ON  c.cust_id = o.cust_id;


CREATE VIEW selling_data AS 
SELECT c.cust_name, p.p_name, oi.quantity, o.ord_date, p.price,
(oi.quantity*p.price) AS total_price
FROM order_items oi
JOIN  
products p ON oi.p_id = p.p_id
JOIN
orders o ON oi.ord_id = o.ord_id
JOIN 
customers c ON  c.cust_id = o.cust_id;

SELECT * FROM selling_data;

SELECT p_name, SUM(total_price) 
FROM selling_data
GROUP BY p_name 
HAVING SUM(total_price) > 1500;

SELECT p_name, SUM(total_price) 
FROM selling_data
GROUP BY ROLLUP (p_name)
ORDER BY SUM(total_price);

SELECT coalesce(p_name, 'Total'), SUM(total_price) 
FROM selling_data
GROUP BY ROLLUP (p_name)
ORDER BY SUM(total_price);







