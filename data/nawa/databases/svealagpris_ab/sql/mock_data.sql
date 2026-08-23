INSERT INTO stores (store_id, store_name, city, sqm_size) VALUES 
(1, 'SveaLågpris Barkarby', 'Stockholm', 2500),
(2, 'SveaLågpris Sisjön', 'Gothenburg', 3000),
(3, 'SveaLågpris Svågertorp', 'Malmö', 2800);

INSERT INTO products (product_id, product_name, brand_type, category, base_price) VALUES 
(101, 'Svea Vardag Mjölk 1L', 'Private Label', 'Dairy', 12.50),
(102, 'Arla Herrgård Ost 1kg', 'National Brand', 'Dairy', 89.90),
(103, 'Svea Vardag Pasta Penne 1kg', 'Private Label', 'Pantry', 14.90),
(104, 'Gevalia Bryggkaffe 450g', 'National Brand', 'Beverages', 45.00),
(105, 'Svea Vardag Toalettpapper 8-pack', 'Private Label', 'Household', 39.90);

INSERT INTO transactions (transaction_id, store_id, transaction_date, total_amount) VALUES 
(1001, 1, '2024-01-15', 182.30),
(1002, 2, '2024-01-16', 45.00),
(1003, 3, '2024-02-10', 217.30),
(1004, 1, '2024-02-28', 129.80),
(1005, 2, '2024-03-12', 39.90);

INSERT INTO transaction_lines (line_id, transaction_id, product_id, quantity, line_total) VALUES 
(5001, 1001, 101, 2, 25.00),
(5002, 1001, 102, 1, 89.90),
(5003, 1001, 104, 1, 45.00),
(5004, 1001, 103, 1, 14.90),
(5005, 1002, 104, 1, 45.00),
(5006, 1003, 102, 2, 179.80),
(5007, 1003, 101, 3, 37.50),
(5008, 1004, 105, 2, 79.80),
(5009, 1004, 101, 4, 50.00),
(5010, 1005, 105, 1, 39.90);
