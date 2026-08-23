INSERT INTO regions (region_id, region_name) VALUES
  (1, 'West'),
  (2, 'Midwest'),
  (3, 'South'),
  (4, 'Northeast');

INSERT INTO channels (channel_id, channel_name) VALUES
  (1, 'Direct Online'),
  (2, 'National Retail'),
  (3, 'Regional Dealer');

INSERT INTO customers (customer_id, customer_name, customer_type, region_id, channel_id, created_date) VALUES
  (101, 'Avery Chen', 'Consumer', 1, 1, '2025-10-11'),
  (102, 'Jordan Patel', 'Consumer', 4, 1, '2025-11-03'),
  (103, 'Mia Robinson', 'Consumer', 3, 2, '2025-09-18'),
  (104, 'Ethan Brooks', 'Consumer', 2, 2, '2025-12-05'),
  (105, 'Sofia Martinez', 'Consumer', 1, 1, '2026-01-07'),
  (106, 'Noah Williams', 'Consumer', 4, 2, '2026-01-22'),
  (107, 'Priya Singh', 'Consumer', 3, 3, '2026-02-02'),
  (108, 'Caleb Johnson', 'Consumer', 2, 1, '2026-02-18'),
  (201, 'BrightBuy Electronics - Denver', 'Business', 1, 3, '2025-08-01'),
  (202, 'HomeView AV - Atlanta', 'Business', 3, 3, '2025-08-14'),
  (203, 'Northline Retail - Boston', 'Business', 4, 2, '2025-07-20'),
  (204, 'PrairieTech Superstore - Chicago', 'Business', 2, 2, '2025-07-29');

INSERT INTO products (product_id, sku, model_name, screen_size_in, panel_type, series, launch_date, msrp) VALUES
  (1, 'LF-NOVA55-OLED', 'Nova 55 OLED', 55, 'OLED', 'Nova', '2025-09-15', 1299.00),
  (2, 'LF-NOVA65-OLED', 'Nova 65 OLED', 65, 'OLED', 'Nova', '2025-09-15', 1799.00),
  (3, 'LF-APEX75-QLED', 'Apex 75 QLED', 75, 'QLED', 'Apex', '2025-10-20', 1499.00),
  (4, 'LF-CORE50-LED', 'Core 50 LED', 50, 'LED', 'Core', '2025-08-10', 599.00),
  (5, 'LF-CORE65-LED', 'Core 65 LED', 65, 'LED', 'Core', '2025-08-10', 799.00);

INSERT INTO orders (order_id, order_date, customer_id, channel_id, region_id, order_status, shipped_date, delivered_date) VALUES
  (1001, '2026-01-05', 101, 1, 1, 'Delivered', '2026-01-06', '2026-01-09'),
  (1002, '2026-01-12', 103, 2, 3, 'Delivered', '2026-01-13', '2026-01-17'),
  (1003, '2026-01-20', 203, 2, 4, 'Delivered', '2026-01-22', '2026-01-28'),
  (1004, '2026-01-28', 201, 3, 1, 'Delivered', '2026-01-29', '2026-02-03'),
  (1005, '2026-02-03', 102, 1, 4, 'Delivered', '2026-02-04', '2026-02-07'),
  (1006, '2026-02-10', 202, 3, 3, 'Delivered', '2026-02-11', '2026-02-16'),
  (1007, '2026-02-14', 104, 2, 2, 'Delivered', '2026-02-15', '2026-02-19'),
  (1008, '2026-02-22', 105, 1, 1, 'Returned',  '2026-02-23', '2026-02-26'),
  (1009, '2026-03-01', 204, 2, 2, 'Delivered', '2026-03-03', '2026-03-07'),
  (1010, '2026-03-06', 106, 2, 4, 'Delivered', '2026-03-07', '2026-03-11'),
  (1011, '2026-03-10', 107, 3, 3, 'Delivered', '2026-03-11', '2026-03-16'),
  (1012, '2026-03-14', 108, 1, 2, 'Delivered', '2026-03-15', '2026-03-19'),
  (1013, '2026-03-20', 201, 3, 1, 'Delivered', '2026-03-21', '2026-03-26'),
  (1014, '2026-03-25', 202, 3, 3, 'Delivered', '2026-03-26', '2026-03-31'),
  (1015, '2026-03-29', 105, 1, 1, 'Delivered', '2026-03-30', '2026-04-02'),
  (1016, '2026-04-03', 102, 1, 4, 'Shipped',   '2026-04-04', NULL);

INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price, unit_cost, warranty_years, warranty_price) VALUES
  (5001, 1001, 1, 1, 1249.00, 820.00, 2, 129.00),
  (5002, 1002, 4, 1, 579.00, 360.00, 2, 79.00),
  (5003, 1003, 3, 12, 1310.00, 930.00, 0, 0.00),
  (5004, 1003, 5, 8, 710.00, 520.00, 0, 0.00),
  (5005, 1004, 4, 20, 545.00, 360.00, 0, 0.00),
  (5006, 1004, 5, 10, 735.00, 520.00, 0, 0.00),
  (5007, 1005, 2, 1, 1699.00, 1120.00, 3, 199.00),
  (5008, 1006, 3, 6, 1345.00, 930.00, 0, 0.00),
  (5009, 1006, 5, 10, 720.00, 520.00, 0, 0.00),
  (5010, 1007, 5, 1, 769.00, 520.00, 2, 99.00),
  (5011, 1008, 1, 1, 1269.00, 820.00, 2, 129.00),
  (5012, 1009, 4, 18, 555.00, 360.00, 0, 0.00),
  (5013, 1009, 5, 14, 725.00, 520.00, 0, 0.00),
  (5014, 1010, 3, 1, 1449.00, 930.00, 0, 0.00),
  (5015, 1011, 4, 3, 569.00, 360.00, 2, 79.00),
  (5016, 1011, 5, 1, 789.00, 520.00, 2, 99.00),
  (5017, 1012, 2, 1, 1749.00, 1120.00, 3, 199.00),
  (5018, 1013, 5, 16, 715.00, 520.00, 0, 0.00),
  (5019, 1014, 3, 4, 1335.00, 930.00, 0, 0.00),
  (5020, 1014, 4, 10, 548.00, 360.00, 0, 0.00),
  (5021, 1015, 1, 1, 1229.00, 820.00, 2, 129.00),
  (5022, 1016, 5, 1, 789.00, 520.00, 2, 99.00);

INSERT INTO returns (return_id, order_id, product_id, return_date, return_reason, return_status, refund_amount) VALUES
  (9001, 1008, 1, '2026-03-05', 'BuyerRemorse', 'Refunded', 1398.00);

