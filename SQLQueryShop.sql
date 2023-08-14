-- 1
SELECT p.name, MIN(s.price) min_price FROM Product p
JOIN Sale s ON s.id_product = p.id
GROUP BY p.name

-- 2
SELECT p.name FROM Product p
JOIN Sale s ON s.id_product = p.id
GROUP BY p.name HAVING AVG(s.price) > 50

-- 3
SELECT c.name category, COUNT(p.name) count_product FROM Product p
JOIN Category c ON p.id_category = c.id
JOIN Delivery d ON d.id_product = p.id
GROUP BY c.name HAVING AVG(d.price) > 100

-- 4
SELECT c.name category, p.name product, SUM(s.price * s.quantity) sum_price FROM Product p
JOIN Category c ON p.id_category = c.id
JOIN Sale s ON s.id_product = p.id
WHERE c.name IN ('Tobacco', 'Alcohol') GROUP BY c.name, p.name;

-- 5
SELECT s.name supplier, MIN(d.price) min_price FROM Product p
JOIN Delivery d ON d.id_product = p.id
JOIN Supplier s ON d.id_supplier = s.id
WHERE d.date_of_delivery BETWEEN DATEADD(MONTH, -1, GETDATE()) AND GETDATE()
GROUP BY s.name ORDER BY min_price ASC;

--6
SELECT pr.name producer, CONCAT(st.street, ' ', ct.name, ' ', c.name) producer_address, COUNT(p.name) count_product FROM Product p
JOIN Producer pr ON p.id_producer = pr.id
JOIN Address st ON st.id = pr.id_address
JOIN City ct ON ct.id = st.id_city
JOIN Region r ON ct.id_region = r.id
JOIN Country c ON r.id_country = c.id
JOIN Sale s ON p.id = s.id_product
GROUP BY pr.name, CONCAT(st.street, ' ', ct.name, ' ', c.name) HAVING SUM(s.price) BETWEEN 100 AND 200

-- 7
SELECT c.name category, COUNT(p.quantity) count_product FROM Product p
JOIN Category c ON p.id_category = c.id
GROUP BY c.name ORDER BY COUNT(p.quantity) ASC

-- 8
SELECT c.name category, COUNT(p.id) count_product FROM Product p
JOIN Category c ON p.id_category = c.id
JOIN Delivery d ON d.id_product = p.id
JOIN Supplier s ON s.id = d.id_supplier
WHERE s.name IN ('Alcohol', 'Tobacco', 'Dairy')
GROUP BY c.name HAVING SUM(d.price) > 400;