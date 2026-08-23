INSERT INTO locations (location_id, location_name, region, open_date) VALUES 
(1, 'Metro Center', 'North', '2015-04-12'),
(2, 'Highway 99 Drive-Thru', 'South', '2018-09-22');

INSERT INTO products (product_id, product_name, category, unit_price) VALUES 
(101, 'Flame Classic Burger', 'Mains', 6.50),
(102, 'Double Flame Burger', 'Mains', 8.50),
(103, 'Crispy Fries', 'Sides', 3.00),
(104, 'Onion Rings', 'Sides', 3.50),
(105, 'Large Cola', 'Beverages', 2.50);

INSERT INTO orders (order_id, location_id, order_timestamp, total_amount) VALUES 
(1001, 1, '2024-01-15 12:30:00', 12.00),
(1002, 1, '2024-01-15 12:45:00', 18.00),
(1003, 2, '2024-02-10 18:00:00', 15.00),
(1004, 2, '2024-02-10 18:15:00', 9.50),
(1005, 1, '2024-03-05 13:00:00', 15.50),
(1006, 2, '2024-03-20 19:00:00', 20.50),
(1007, 1, '2024-03-25 12:00:00', 6.50),
(1008, 2, '2024-03-28 17:30:00', 11.50);

INSERT INTO order_items (item_id, order_id, product_id, quantity) VALUES 
(5001, 1001, 101, 1), (5002, 1001, 103, 1), (5003, 1001, 105, 1),
(5004, 1002, 102, 2), (5005, 1003, 101, 2), (5006, 1003, 104, 1),
(5007, 1004, 101, 1), (5008, 1004, 103, 1),
(5009, 1005, 102, 1), (5010, 1005, 103, 1), (5011, 1005, 105, 1),
(5012, 1006, 102, 2), (5013, 1006, 104, 1),
(5014, 1007, 101, 1),
(5015, 1008, 101, 1), (5016, 1008, 103, 1), (5017, 1008, 105, 1);

INSERT INTO employees (employee_id, location_id, role, hire_date) VALUES 
(1, 1, 'Store Manager', '2015-03-01'),
(2, 2, 'Shift Supervisor', '2018-08-15');
