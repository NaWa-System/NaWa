-- Categories
INSERT INTO categories (category_id, category_name) VALUES
(1, 'Tropical Plants'),
(2, 'Succulents & Cacti'),
(3, 'Ferns & Foliage'),
(4, 'Growing Kits'),
(5, 'Accessories & Care');

-- Products
INSERT INTO products (product_id, product_name, category_id, unit_cost, unit_price, is_active) VALUES
(1,  'Monstera Deliciosa (Medium)',      1, 12.00, 34.99, TRUE),
(2,  'Fiddle Leaf Fig (Small)',          1, 14.00, 42.99, TRUE),
(3,  'Bird of Paradise (Large)',         1, 28.00, 74.99, TRUE),
(4,  'Echeveria Trio Set',               2,  5.00, 18.99, TRUE),
(5,  'Barrel Cactus (Assorted)',         2,  4.00, 14.99, TRUE),
(6,  'Boston Fern (Hanging)',            3,  8.00, 26.99, TRUE),
(7,  'Pothos Marble Queen',             3,  6.00, 19.99, TRUE),
(8,  'Herb Grow Kit (Basil & Mint)',     4,  7.00, 22.99, TRUE),
(9,  'Terrarium Starter Kit',            4, 11.00, 36.99, TRUE),
(10, 'Moisture Meter Pro',               5,  4.50, 14.99, TRUE),
(11, 'Ceramic Pot Set (3-pack)',         5,  9.00, 29.99, TRUE),
(12, 'Premium Potting Mix (5L)',         5,  3.50, 11.99, TRUE),
(13, 'Calathea Orbifolia',              3, 10.00, 32.99, TRUE),
(14, 'String of Pearls',                2,  6.50, 22.99, TRUE);

-- Subscription Plans
INSERT INTO subscription_plans (plan_id, plan_name, monthly_price, box_size) VALUES
(1, 'Sprout',  24.99, 'Small'),
(2, 'Grow',    44.99, 'Medium'),
(3, 'Flourish',69.99, 'Large');

-- Customers
INSERT INTO customers (customer_id, first_name, last_name, email, city, state, channel, created_at) VALUES
(1,  'Ava',     'Lindqvist', 'ava.lindqvist@email.com',    'Austin',      'TX', 'Online',  '2024-01-05'),
(2,  'Marcus',  'Osei',      'marcus.osei@email.com',      'Austin',      'TX', 'In-Store','2024-01-12'),
(3,  'Priya',   'Nair',      'priya.nair@email.com',       'Houston',     'TX', 'Online',  '2024-01-18'),
(4,  'Ethan',   'Cho',       'ethan.cho@email.com',        'Dallas',      'TX', 'Online',  '2024-01-22'),
(5,  'Sofia',   'Reyes',     'sofia.reyes@email.com',      'Austin',      'TX', 'In-Store','2024-02-03'),
(6,  'James',   'Whitfield', 'james.whitfield@email.com',  'San Antonio', 'TX', 'Online',  '2024-02-09'),
(7,  'Naomi',   'Adeyemi',   'naomi.adeyemi@email.com',    'Austin',      'TX', 'Online',  '2024-02-14'),
(8,  'Leo',     'Tanaka',    'leo.tanaka@email.com',       'Denver',      'CO', 'Online',  '2024-02-20'),
(9,  'Rachel',  'Bloom',     'rachel.bloom@email.com',     'Austin',      'TX', 'In-Store','2024-03-01'),
(10, 'Darius',  'Okonkwo',   'darius.okonkwo@email.com',   'Houston',     'TX', 'Online',  '2024-03-07'),
(11, 'Claire',  'Fontaine',  'claire.fontaine@email.com',  'New Orleans', 'LA', 'Online',  '2024-03-11'),
(12, 'Jordan',  'McAllister','jordan.mcallister@email.com','Austin',      'TX', 'In-Store','2024-03-15'),
(13, 'Tamsin',  'Graves',    'tamsin.graves@email.com',    'Dallas',      'TX', 'Online',  '2024-03-19'),
(14, 'Ravi',    'Kapoor',    'ravi.kapoor@email.com',      'Austin',      'TX', 'Online',  '2024-01-28'),
(15, 'Zoe',     'Hartmann',  'zoe.hartmann@email.com',     'Portland',    'OR', 'Online',  '2024-02-25');

-- Subscriptions
INSERT INTO subscriptions (subscription_id, customer_id, plan_id, start_date, end_date, status) VALUES
(1,  1,  2, '2024-01-05', NULL,         'Active'),
(2,  3,  1, '2024-01-18', NULL,         'Active'),
(3,  4,  3, '2024-01-22', '2024-03-22', 'Cancelled'),
(4,  6,  2, '2024-02-09', NULL,         'Active'),
(5,  7,  1, '2024-02-14', NULL,         'Active'),
(6,  8,  3, '2024-02-20', NULL,         'Active'),
(7,  10, 2, '2024-03-07', NULL,         'Active'),
(8,  11, 1, '2024-03-11', NULL,         'Active'),
(9,  13, 3, '2024-03-19', NULL,         'Active'),
(10, 14, 2, '2024-01-28', '2024-02-28', 'Cancelled'),
(11, 15, 1, '2024-02-25', NULL,         'Active');

-- Orders
INSERT INTO orders (order_id, customer_id, order_date, channel, status, discount_amt, shipping_cost) VALUES
(1,  1,  '2024-01-08', 'Online',   'Completed', 0.00,  5.99),
(2,  2,  '2024-01-13', 'In-Store', 'Completed', 5.00,  0.00),
(3,  3,  '2024-01-20', 'Online',   'Completed', 0.00,  5.99),
(4,  4,  '2024-01-25', 'Online',   'Completed', 10.00, 5.99),
(5,  14, '2024-01-30', 'Online',   'Completed', 0.00,  5.99),
(6,  5,  '2024-02-05', 'In-Store', 'Completed', 0.00,  0.00),
(7,  6,  '2024-02-10', 'Online',   'Completed', 5.00,  5.99),
(8,  7,  '2024-02-15', 'Online',   'Completed', 0.00,  5.99),
(9,  8,  '2024-02-21', 'Online',   'Completed', 0.00,  5.99),
(10, 1,  '2024-02-27', 'Online',   'Completed', 0.00,  5.99),
(11, 15, '2024-02-28', 'Online',   'Completed', 0.00,  5.99),
(12, 9,  '2024-03-03', 'In-Store', 'Completed', 0.00,  0.00),
(13, 10, '2024-03-09', 'Online',   'Completed', 0.00,  5.99),
(14, 11, '2024-03-12', 'Online',   'Completed', 8.00,  5.99),
(15, 12, '2024-03-16', 'In-Store', 'Completed', 0.00,  0.00),
(16, 13, '2024-03-20', 'Online',   'Completed', 0.00,  5.99),
(17, 3,  '2024-03-22', 'Online',   'Completed', 0.00,  5.99),
(18, 2,  '2024-03-25', 'In-Store', 'Completed', 5.00,  0.00),
(19, 7,  '2024-03-28', 'Online',   'Completed', 0.00,  5.99),
(20, 4,  '2024-03-30', 'Online',   'Refunded',  0.00,  5.99);

-- Order Items
INSERT INTO order_items (item_id, order_id, product_id, quantity, unit_price) VALUES
(1,  1,  1,  1, 34.99),
(2,  1,  11, 1, 29.99),
(3,  2,  6,  1, 26.99),
(4,  2,  12, 2, 11.99),
(5,  3,  4,  2, 18.99),
(6,  3,  10, 1, 14.99),
(7,  4,  2,  1, 42.99),
(8,  4,  8,  1, 22.99),
(9,  5,  7,  2, 19.99),
(10, 5,  12, 1, 11.99),
(11, 6,  3,  1, 74.99),
(12, 6,  11, 1, 29.99),
(13, 7,  13, 1, 32.99),
(14, 7,  10, 1, 14.99),
(15, 8,  1,  1, 34.99),
(16, 8,  9,  1, 36.99),
(17, 9,  5,  3, 14.99),
(18, 9,  14, 1, 22.99),
(19, 10, 7,  1, 19.99),
(20, 10, 11, 1, 29.99),
(21, 11, 4,  1, 18.99),
(22, 11, 8,  1, 22.99),
(23, 12, 6,  1, 26.99),
(24, 12, 12, 1, 11.99),
(25, 13, 2,  1, 42.99),
(26, 13, 11, 1, 29.99),
(27, 14, 1,  1, 34.99),
(28, 14, 4,  2, 18.99),
(29, 15, 3,  1, 74.99),
(30, 15, 9,  1, 36.99),
(31, 16, 13, 2, 32.99),
(32, 16, 10, 1, 14.99),
(33, 17, 7,  2, 19.99),
(34, 17, 5,  1, 14.99),
(35, 18, 6,  1, 26.99),
(36, 18, 11, 2, 29.99),
(37, 19, 1,  1, 34.99),
(38, 19, 14, 2, 22.99),
(39, 20, 2,  1, 42.99),
(40, 20, 8,  1, 22.99);

-- Events
INSERT INTO events (event_id, event_name, event_date, capacity, tickets_sold, ticket_price) VALUES
(1, 'Terrarium Building Workshop',        '2024-01-20', 20, 18, 35.00),
(2, 'Beginner Plant Care Class',          '2024-02-10', 25, 22, 25.00),
(3, 'Succulent Arrangement Masterclass',  '2024-02-24', 15, 15, 45.00),
(4, 'Spring Potting Party',               '2024-03-09', 30, 27, 30.00),
(5, 'Propagation Workshop',               '2024-03-23', 20, 14, 35.00);
