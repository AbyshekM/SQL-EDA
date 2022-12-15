select * from sales
select * from product
select * from goldusers_signup
select * from users

-- 1) What is the total amount spent by each customer?

select a.userid, a.product_id, b.price 
FROM sales a INNER JOIN product b
ON a.product_id = b.product_id;


Select a.userid, SUM(b.price) Total_amount_spent
FROM sales a INNER JOIN product b
ON a.product_id = b.product_id
GROUP BY a.userid;

-- 2) How many days each customer visited?

select userid, COUNT(distinct created_date) Distinct_visits
FROM sales
GROUP BY userid;

-- 3) What was the first product purchased by each customer?

SELECT	*, RANK() over (partition by userid order by created_date) Ranking
From sales;

Select * 
FROM (SELECT	*, RANK() over (partition by userid order by created_date) Ranking
From sales) a WHERE ranking = 1;

-- 4) What is the most purchased item on the menu? How many times was it purchased by each customer?

SELECT product_id, count(product_id) Most_purchased
FROM sales
GROUP BY product_id
ORDER BY count(product_id) DESC
LIMIT 1;

select * FROM sales WHERE product_id = 
(SELECT product_id
FROM sales
GROUP BY product_id
ORDER BY count(product_id) DESC
LIMIT 1);

SELECT userid, count(product_id) Most_purchase_count
FROM sales WHERE product_id =
(SELECT product_id
FROM sales
GROUP BY product_id
ORDER BY count(product_id) DESC
LIMIT 1)
GROUP BY userid;

-- 5) Which product is the most purchased for each customer?

(Select userid, product_id, count(product_id) Purchase_count
FROM sales
GROUP BY userid, product_id);

SELECT * FROM
(SELECT *, rank() over(partition by userid order by Purchase_count DESC) Ranking FROM
(Select userid, product_id, count(product_id) Purchase_count
FROM sales
GROUP BY userid, product_id)a)b
WHERE Ranking=1;