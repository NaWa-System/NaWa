INSERT INTO regions (region_id, region_name, country_code) VALUES
  (1, 'Germany', 'DE'),
  (2, 'Austria', 'AT'),
  (3, 'Switzerland', 'CH'),
  (4, 'Netherlands', 'NL'),
  (5, 'Belgium', 'BE');

INSERT INTO customers (customer_id, email, first_name, last_name, region_id, created_at, marketing_opt_in) VALUES
  (101, 'lena.mueller@example.com', 'Lena', 'Mueller', 1,  '2025-12-05', TRUE),
  (102, 'tom.vande@example.com', 'Tom', 'Vande', 5,  '2026-01-12', FALSE),
  (103, 'sophie.keller@example.com', 'Sophie', 'Keller', 1,  '2026-01-20', TRUE),
  (104, 'milan.devries@example.com', 'Milan', 'deVries', 4,  '2026-02-02', TRUE),
  (105, 'anna.gruber@example.com', 'Anna', 'Gruber', 2,  '2026-02-10', FALSE),
  (106, 'noah.meier@example.com', 'Noah', 'Meier', 3,  '2026-02-18', TRUE),
  (107, 'julie.peeters@example.com', 'Julie', 'Peeters', 5,  '2026-03-01', TRUE),
  (108, 'felix.schmidt@example.com', 'Felix', 'Schmidt', 1,  '2026-03-05', FALSE),
  (109, 'emma.janssen@example.com', 'Emma', 'Janssen', 4,  '2026-03-15', TRUE),
  (110, 'lukas.huber@example.com', 'Lukas', 'Huber', 2,  '2026-03-22', TRUE);

INSERT INTO products (product_id, sku, product_name, category, brand, list_price, unit_cost, is_sustainable) VALUES
  (201, 'TH-TSH-001', 'Everyday Cotton Tee', 'Apparel', 'Northline Basics', 19.90, 7.40, FALSE),
  (202, 'TH-JNS-014', 'Slim Fit Denim Jeans', 'Apparel', 'Rivertown Denim', 59.90, 24.00, FALSE),
  (203, 'TH-DRS-112', 'Midi Wrap Dress', 'Apparel', 'Atelier Lune', 89.00, 38.50, TRUE),
  (204, 'TH-SNK-210', 'Retro Runner Sneakers', 'Footwear', 'Kinetiq', 79.90, 33.00, FALSE),
  (205, 'TH-BTS-330', 'Leather Chelsea Boots', 'Footwear', 'Berg & Co.', 139.00, 62.00, FALSE),
  (206, 'TH-JKT-055', 'Lightweight Puffer Jacket', 'Outerwear', 'Skyward', 119.00, 55.00, FALSE),
  (207, 'TH-ACC-501', 'Recycled Nylon Tote', 'Accessories', 'GreenThread', 34.90, 12.20, TRUE),
  (208, 'TH-KNT-078', 'Merino Knit Sweater', 'Apparel', 'Alpine Loom', 99.00, 44.00, TRUE),
  (209, 'TH-ACC-640', 'Minimalist Belt', 'Accessories', 'Berg & Co.', 29.90, 10.50, FALSE),
  (210, 'TH-SNK-305', 'Canvas Low-Top Sneaker', 'Footwear', 'Northline Basics', 49.90, 19.50, TRUE);

INSERT INTO orders (order_id, customer_id, order_date, channel, status, shipping_fee, discount_amount, currency) VALUES
  (3001, 101,  '2026-01-08', 'Web', 'Delivered', 4.95, 0.00, 'EUR'),
  (3002, 102,  '2026-01-18', 'Mobile', 'Delivered', 0.00, 10.00, 'EUR'),
  (3003, 103,  '2026-01-29', 'Web', 'Delivered', 4.95, 5.00, 'EUR'),
  (3004, 104,  '2026-02-06', 'Mobile', 'Delivered', 0.00, 0.00, 'EUR'),
  (3005, 105,  '2026-02-14', 'Web', 'Delivered', 4.95, 0.00, 'EUR'),
  (3006, 106,  '2026-02-23', 'Web', 'Delivered', 0.00, 15.00, 'CHF'),
  (3007, 101,  '2026-03-03', 'Mobile', 'Delivered', 0.00, 0.00, 'EUR'),
  (3008, 107,  '2026-03-07', 'Web', 'Delivered', 4.95, 0.00, 'EUR'),
  (3009, 108,  '2026-03-12', 'Mobile', 'Delivered', 0.00, 8.00, 'EUR'),
  (3010, 109,  '2026-03-18', 'Web', 'Delivered', 4.95, 0.00, 'EUR'),
  (3011, 110,  '2026-03-24', 'Mobile', 'Delivered', 0.00, 12.00, 'EUR'),
  (3012, 103,  '2026-03-28', 'Web', 'Delivered', 4.95, 0.00, 'EUR'),
  (3013, 104,  '2026-04-02', 'Mobile', 'Shipped', 0.00, 0.00, 'EUR'),
  (3014, 107,  '2026-04-06', 'Web', 'Processing', 4.95, 0.00, 'EUR');

INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price) VALUES
  (4001, 3001, 201, 2, 19.90),
  (4002, 3001, 209, 1, 29.90),
  (4003, 3002, 202, 1, 54.90),
  (4004, 3002, 204, 1, 79.90),
  (4005, 3003, 203, 1, 89.00),
  (4006, 3003, 207, 1, 34.90),
  (4007, 3004, 210, 2, 49.90),
  (4008, 3004, 201, 1, 19.90),
  (4009, 3005, 206, 1, 119.00),
  (4010, 3005, 204, 1, 79.90),
  (4011, 3006, 208, 1, 99.00),
  (4012, 3006, 207, 1, 34.90),
  (4013, 3007, 205, 1, 139.00),
  (4014, 3007, 209, 1, 29.90),
  (4015, 3008, 202, 2, 59.90),
  (4016, 3008, 210, 1, 49.90),
  (4017, 3009, 201, 3, 18.90),
  (4018, 3009, 207, 1, 34.90),
  (4019, 3010, 203, 1, 89.00),
  (4020, 3010, 204, 1, 79.90),
  (4021, 3011, 206, 1, 109.00),
  (4022, 3011, 210, 1, 49.90),
  (4023, 3012, 208, 1, 99.00),
  (4024, 3012, 201, 1, 19.90),
  (4025, 3013, 202, 1, 59.90),
  (4026, 3013, 209, 2, 29.90),
  (4027, 3014, 207, 2, 34.90),
  (4028, 3014, 210, 1, 49.90);

INSERT INTO shipments (shipment_id, order_id, warehouse_region_id, carrier, shipped_date, delivered_date, shipping_status) VALUES
  (5001, 3001, 1, 'DHL',  '2026-01-09',  '2026-01-11', 'Delivered'),
  (5002, 3002, 5, 'bpost',  '2026-01-19',  '2026-01-22', 'Delivered'),
  (5003, 3003, 1, 'DHL',  '2026-01-30',  '2026-02-02', 'Delivered'),
  (5004, 3004, 4, 'PostNL',  '2026-02-07',  '2026-02-10', 'Delivered'),
  (5005, 3005, 2, 'Austrian Post',  '2026-02-15',  '2026-02-18', 'Delivered'),
  (5006, 3006, 3, 'Swiss Post',  '2026-02-24',  '2026-02-27', 'Delivered'),
  (5007, 3007, 1, 'DHL',  '2026-03-04',  '2026-03-06', 'Delivered'),
  (5008, 3008, 5, 'bpost',  '2026-03-08',  '2026-03-11', 'Delivered'),
  (5009, 3009, 1, 'DHL',  '2026-03-13',  '2026-03-15', 'Delivered'),
  (5010, 3010, 4, 'PostNL',  '2026-03-19',  '2026-03-22', 'Delivered'),
  (5011, 3011, 2, 'Austrian Post',  '2026-03-25',  '2026-03-28', 'Delivered'),
  (5012, 3012, 1, 'DHL',  '2026-03-29',  '2026-04-01', 'Delivered'),
  (5013, 3013, 4, 'PostNL',  '2026-04-03', NULL, 'In Transit'),
  (5014, 3014, 5, 'bpost', NULL, NULL, 'Pending');

INSERT INTO returns (return_id, order_id, product_id, return_date, quantity, reason, refund_amount, status) VALUES
  (6001, 3002, 202,  '2026-01-27', 1, 'Size', 54.90, 'Refunded'),
  (6002, 3003, 207,  '2026-02-10', 1, 'Not as described', 34.90, 'Refunded'),
  (6003, 3004, 210,  '2026-02-20', 1, 'Size', 49.90, 'Refunded'),
  (6004, 3005, 204,  '2026-02-26', 1, 'Defect', 79.90, 'Refunded'),
  (6005, 3007, 205,  '2026-03-15', 1, 'Size', 139.00, 'Refunded'),
  (6006, 3009, 201,  '2026-03-21', 1, 'Changed mind', 18.90, 'Refunded'),
  (6007, 3010, 203,  '2026-03-29', 1, 'Size', 89.00, 'Refunded');

