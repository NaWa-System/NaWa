INSERT INTO regions (region_id, region_name) VALUES
  (1, 'Northeast'),
  (2, 'Southeast'),
  (3, 'Midwest'),
  (4, 'West');

INSERT INTO channels (channel_id, channel_name) VALUES
  (1, 'Direct Online'),
  (2, 'Big-Box Retail'),
  (3, 'Installer/Trade');

INSERT INTO products (product_id, sku, product_name, category, unit_cost, list_price, is_active) VALUES
  (1, 'KC-FR240', 'Aeria 240 Frost-Free Refrigerator', 'Refrigeration', 620.00, 1099.00, TRUE),
  (2, 'KC-DW14S', 'RinseCraft 14-Place Dishwasher', 'Dishwashing', 290.00, 599.00, TRUE),
  (3, 'KC-WM9Q',  'SpinHarbor 9kg Quiet Washer', 'Laundry', 340.00, 699.00, TRUE),
  (4, 'KC-DR7V',  'Ventura 7kg Vented Dryer', 'Laundry', 280.00, 579.00, TRUE),
  (5, 'KC-OV60I', 'SableHeat 60cm Induction Range', 'Cooking', 410.00, 899.00, TRUE),
  (6, 'KC-MW30C', 'Crestwave 30L Countertop Microwave', 'Small Appliances', 55.00, 129.00, TRUE),
  (7, 'KC-HOOD90', 'SilenceLine 90cm Range Hood', 'Cooking', 120.00, 249.00, TRUE);

INSERT INTO customers (customer_id, customer_name, customer_type, region_id, created_date) VALUES
  (1, 'Maya Chen', 'Consumer', 4, '2026-01-08'),
  (2, 'Olive Street Properties', 'Installer', 3, '2026-01-14'),
  (3, 'NorthMart Appliances', 'Retailer', 1, '2025-11-20'),
  (4, 'Blue Ridge Home Supply', 'Retailer', 2, '2025-12-05'),
  (5, 'J. Alvarez', 'Consumer', 2, '2026-02-02'),
  (6, 'MetroKitchen Install Co.', 'Installer', 1, '2026-01-28'),
  (7, 'Lakeside Value Retail', 'Retailer', 3, '2025-10-11'),
  (8, 'R. Patel', 'Consumer', 1, '2026-03-03'),
  (9, 'Sunset Remodel Partners', 'Installer', 4, '2026-02-10'),
  (10, 'K. Thompson', 'Consumer', 3, '2026-01-22');

INSERT INTO orders (order_id, order_date, customer_id, channel_id, order_status, ship_date, delivery_date, region_id) VALUES
  (1001, '2026-01-05', 3, 2, 'Delivered', '2026-01-07', '2026-01-12', 1),
  (1002, '2026-01-09', 4, 2, 'Delivered', '2026-01-10', '2026-01-15', 2),
  (1003, '2026-01-18', 1, 1, 'Delivered', '2026-01-19', '2026-01-24', 4),
  (1004, '2026-01-26', 7, 2, 'Delivered', '2026-01-28', '2026-02-03', 3),
  (1005, '2026-02-03', 2, 3, 'Delivered', '2026-02-05', '2026-02-12', 3),
  (1006, '2026-02-08', 5, 1, 'Delivered', '2026-02-09', '2026-02-13', 2),
  (1007, '2026-02-14', 6, 3, 'Delivered', '2026-02-16', '2026-02-23', 1),
  (1008, '2026-02-20', 9, 3, 'Delivered', '2026-02-22', '2026-03-01', 4),
  (1009, '2026-03-02', 8, 1, 'Delivered', '2026-03-03', '2026-03-07', 1),
  (1010, '2026-03-06', 10, 1, 'Delivered', '2026-03-07', '2026-03-12', 3),
  (1011, '2026-03-11', 4, 2, 'Delivered', '2026-03-12', '2026-03-18', 2),
  (1012, '2026-03-16', 7, 2, 'Cancelled', NULL, NULL, 3),
  (1013, '2026-03-19', 3, 2, 'Delivered', '2026-03-21', '2026-03-26', 1),
  (1014, '2026-03-24', 9, 3, 'Delivered', '2026-03-25', '2026-04-02', 4),
  (1015, '2026-03-28', 5, 1, 'Shipped', '2026-03-30', NULL, 2),
  (1016, '2026-04-03', 6, 3, 'Booked', NULL, NULL, 1);

INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, discount_pct) VALUES
  (2001, 1001, 2, 18, 525.00, 5.00),
  (2002, 1001, 6, 30, 119.00, 0.00),

  (2003, 1002, 3, 12, 655.00, 0.00),
  (2004, 1002, 4, 10, 545.00, 0.00),

  (2005, 1003, 1, 1, 1049.00, 0.00),
  (2006, 1003, 7, 1, 229.00, 0.00),

  (2007, 1004, 2, 14, 515.00, 7.50),
  (2008, 1004, 5, 6, 835.00, 5.00),

  (2009, 1005, 3, 20, 625.00, 6.00),
  (2010, 1005, 4, 18, 519.00, 6.00),
  (2011, 1005, 6, 20, 109.00, 0.00),

  (2012, 1006, 2, 1, 579.00, 0.00),
  (2013, 1006, 6, 1, 129.00, 0.00),

  (2014, 1007, 1, 8, 999.00, 9.00),
  (2015, 1007, 5, 8, 829.00, 7.00),
  (2016, 1007, 7, 8, 219.00, 0.00),

  (2017, 1008, 5, 10, 849.00, 5.00),
  (2018, 1008, 7, 10, 239.00, 0.00),

  (2019, 1009, 3, 1, 699.00, 0.00),
  (2020, 1009, 4, 1, 559.00, 0.00),

  (2021, 1010, 6, 1, 129.00, 0.00),
  (2022, 1010, 2, 1, 599.00, 0.00),

  (2023, 1011, 2, 16, 529.00, 4.00),
  (2024, 1011, 6, 20, 115.00, 0.00),

  (2025, 1012, 1, 6, 1025.00, 8.00),
  (2026, 1012, 5, 6, 845.00, 6.00),

  (2027, 1013, 1, 10, 995.00, 10.00),
  (2028, 1013, 2, 20, 519.00, 6.00),

  (2029, 1014, 5, 4, 879.00, 3.00),
  (2030, 1014, 7, 4, 239.00, 0.00),

  (2031, 1015, 3, 1, 679.00, 0.00),

  (2032, 1016, 1, 2, 1049.00, 0.00),
  (2033, 1016, 7, 2, 249.00, 0.00);

INSERT INTO service_tickets (ticket_id, ticket_date, order_id, product_id, region_id, issue_category, severity, status, resolution_days, warranty_covered, parts_cost, labor_cost) VALUES
  (3001, '2026-01-29', 1003, 1, 4, 'Cooling', 'Med', 'Resolved', 6, TRUE, 48.00, 120.00),
  (3002, '2026-02-04', 1002, 3, 2, 'Noise', 'Low', 'Closed', 3, TRUE, 0.00, 65.00),
  (3003, '2026-02-18', 1006, 2, 2, 'Leak', 'High', 'Resolved', 9, TRUE, 26.00, 180.00),
  (3004, '2026-02-25', 1007, 5, 1, 'Electronics', 'Med', 'Resolved', 7, TRUE, 35.00, 140.00),
  (3005, '2026-03-03', 1009, 4, 1, 'Heat', 'Med', 'Closed', 5, TRUE, 18.00, 95.00),
  (3006, '2026-03-08', 1001, 2, 1, 'Install', 'Low', 'Closed', 2, FALSE, 0.00, 90.00),
  (3007, '2026-03-17', 1011, 2, 2, 'Leak', 'Med', 'Resolved', 8, TRUE, 22.00, 160.00),
  (3008, '2026-03-22', 1013, 1, 1, 'Cooling', 'High', 'Open', NULL, TRUE, 0.00, 0.00),
  (3009, '2026-03-29', 1014, 7, 4, 'Noise', 'Low', 'Closed', 4, TRUE, 0.00, 75.00),
  (3010, '2026-04-06', 1015, 3, 2, 'Electronics', 'Med', 'Open', NULL, TRUE, 0.00, 0.00);

