INSERT INTO categories (category_id, category_name, parent_category_id) VALUES
(1, 'Laptops', NULL),
(2, 'Desktops', NULL),
(3, 'Peripherals', NULL),
(4, 'Gaming Laptops', 1),
(5, 'Business Laptops', 1),
(6, 'Custom Builds', 2),
(7, 'Monitors', 3),
(8, 'Keyboards & Mice', 3);

INSERT INTO products (product_id, sku, product_name, category_id, unit_cost, unit_price, stock_quantity, is_active) VALUES
(1, 'NX-ROG-G16-2024', 'ASUS ROG Strix G16 Gaming Laptop', 4, 1100.00, 1599.00, 42, TRUE),
(2, 'NX-ZEN-PRO-14', 'ASUS Zenbook Pro 14 OLED', 5, 890.00, 1299.00, 30, TRUE),
(3, 'NX-VIVO-15', 'ASUS VivoBook 15 Student Laptop', 5, 420.00, 649.00, 75, TRUE),
(4, 'NX-CBL-I9-RTX', 'NexCore Custom Build - i9 RTX 4080', 6, 1800.00, 2599.00, 10, TRUE),
(5, 'NX-CBL-I7-MID', 'NexCore Custom Build - i7 Mid-Range', 6, 950.00, 1399.00, 18, TRUE),
(6, 'NX-MON-27-4K', 'ASUS ProArt 27" 4K Monitor', 7, 480.00, 749.00, 25, TRUE),
(7, 'NX-MON-24-FHD', 'ASUS TUF 24" FHD Gaming Monitor', 7, 180.00, 299.00, 60, TRUE),
(8, 'NX-KB-ROG-MECH', 'ASUS ROG Mechanical Keyboard', 8, 75.00, 139.00, 90, TRUE),
(9, 'NX-MS-ROG-OPTICAL', 'ASUS ROG Optical Gaming Mouse', 8, 35.00, 69.00, 110, TRUE),
(10, 'NX-ZEN-FLIP-13', 'ASUS ZenBook Flip 13 OLED 2-in-1', 5, 780.00, 1149.00, 20, TRUE);

INSERT INTO customers (customer_id, customer_name, customer_type, email, region, registered_date) VALUES
(1, 'Erik Lindqvist', 'individual', 'erik.l@gmail.com', 'Sweden', '2023-03-15'),
(2, 'Sigma Solutions AB', 'business', 'procurement@sigmasolutions.se', 'Sweden', '2022-11-01'),
(3, 'Aino Mäkinen', 'individual', 'aino.m@hotmail.com', 'Finland', '2023-07-22'),
(4, 'Baltic Tech OÜ', 'business', 'orders@baltictech.ee', 'Estonia', '2023-01-10'),
(5, 'Jonas Berg', 'individual', 'jonas.berg@outlook.com', 'Norway', '2024-01-05'),
(6, 'Kristine Dahl', 'individual', 'k.dahl@proton.me', 'Denmark', '2023-09-18'),
(7, 'NordMedia Group', 'business', 'tech@nordmedia.dk', 'Denmark', '2022-06-30'),
(8, 'Petras Kavaliauskas', 'individual', 'petras.k@gmail.com', 'Lithuania', '2024-02-14'),
(9, 'Lena Svensson', 'individual', 'lena.s@gmail.com', 'Sweden', '2023-05-09'),
(10, 'Apex Consulting AS', 'business', 'it@apexconsulting.no', 'Norway', '2023-08-20');

INSERT INTO orders (order_id, customer_id, order_date, channel, status, shipping_cost) VALUES
(1, 1, '2024-01-08', 'online', 'completed', 9.90),
(2, 2, '2024-01-12', 'in-store', 'completed', 0.00),
(3, 3, '2024-01-20', 'online', 'completed', 9.90),
(4, 4, '2024-01-25', 'online', 'completed', 0.00),
(5, 5, '2024-02-03', 'online', 'completed', 9.90),
(6, 6, '2024-02-10', 'in-store', 'completed', 0.00),
(7, 7, '2024-02-14', 'online', 'completed', 0.00),
(8, 1, '2024-02-19', 'online', 'returned', 9.90),
(9, 9, '2024-02-28', 'in-store', 'completed', 0.00),
(10, 10, '2024-03-05', 'online', 'completed', 0.00),
(11, 3, '2024-03-11', 'online', 'completed', 9.90),
(12, 8, '2024-03-15', 'online', 'completed', 9.90),
(13, 2, '2024-03-18', 'in-store', 'completed', 0.00),
(14, 5, '2024-03-22', 'online', 'pending', 9.90),
(15, 6, '2024-03-25', 'online', 'completed', 9.90),
(16, 7, '2024-03-28', 'online', 'completed', 0.00),
(17, 4, '2024-03-29', 'online', 'completed', 0.00),
(18, 9, '2024-03-30', 'in-store', 'cancelled', 0.00);

INSERT INTO order_items (item_id, order_id, product_id, quantity, unit_price, discount_pct) VALUES
(1, 1, 1, 1, 1599.00, 0.00),
(2, 1, 8, 1, 139.00, 5.00),
(3, 2, 4, 2, 2599.00, 5.00),
(4, 3, 3, 1, 649.00, 0.00),
(5, 4, 5, 3, 1399.00, 8.00),
(6, 5, 1, 1, 1599.00, 0.00),
(7, 5, 9, 1, 69.00, 0.00),
(8, 6, 6, 1, 749.00, 0.00),
(9, 7, 10, 5, 1149.00, 10.00),
(10, 8, 2, 1, 1299.00, 0.00),
(11, 9, 7, 2, 299.00, 0.00),
(12, 10, 5, 4, 1399.00, 8.00),
(13, 11, 9, 2, 69.00, 0.00),
(14, 11, 8, 1, 139.00, 0.00),
(15, 12, 3, 1, 649.00, 5.00),
(16, 13, 4, 1, 2599.00, 5.00),
(17, 14, 6, 1, 749.00, 0.00),
(18, 15, 7, 1, 299.00, 0.00),
(19, 16, 2, 3, 1299.00, 7.00),
(20, 17, 5, 2, 1399.00, 8.00),
(21, 18, 1, 1, 1599.00, 0.00);

INSERT INTO warranty_plans (plan_id, plan_name, duration_months, annual_fee) VALUES
(1, 'Basic Cover', 12, 79.00),
(2, 'Standard Shield', 24, 129.00),
(3, 'Premium Guard', 36, 189.00),
(4, 'Business Pro', 24, 219.00);

INSERT INTO warranty_subscriptions (subscription_id, customer_id, plan_id, product_id, start_date, end_date, status) VALUES
(1, 1, 2, 1, '2024-01-08', '2026-01-08', 'active'),
(2, 2, 4, 4, '2024-01-12', '2026-01-12', 'active'),
(3, 3, 1, 3, '2024-01-20', '2025-01-20', 'active'),
(4, 4, 4, 5, '2024-01-25', '2026-01-25', 'active'),
(5, 5, 3, 1, '2024-02-03', '2027-02-03', 'active'),
(6, 6, 1, 6, '2024-02-10', '2025-02-10', 'active'),
(7, 7, 4, 10, '2024-02-14', '2026-02-14', 'active'),
(8, 9, 2, 7, '2024-02-28', '2026-02-28', 'active'),
(9, 10, 4, 5, '2024-03-05', '2026-03-05', 'active'),
(10, 8, 1, 3, '2024-03-15', '2025-03-15', 'active');
