INSERT INTO regions (region_id, region_name) VALUES
  (1, 'North America'),
  (2, 'LATAM'),
  (3, 'Nordics/Europe');

INSERT INTO customers (customer_id, customer_name, region_id, customer_type, account_status, created_date) VALUES
  (101, 'Canyon Ridge Mining Co.', 1, 'Mine Operator', 'Active', '2024-11-15'),
  (102, 'Ironvale Underground Services', 1, 'Contractor', 'Active', '2025-01-08'),
  (103, 'Sierra Basin Minerals', 2, 'Mine Operator', 'Active', '2025-02-02'),
  (104, 'Aurora Drill & Blast AB', 3, 'Contractor', 'Active', '2025-03-18'),
  (105, 'Kestrel Quarry Group', 1, 'Mine Operator', 'Active', '2025-04-22'),
  (106, 'Altiplano Copper Ltd.', 2, 'Mine Operator', 'Active', '2025-05-05'),
  (107, 'Borealis Mining Supply Oy', 3, 'Distributor', 'Active', '2025-05-20');

INSERT INTO products (product_id, sku, product_name, category, material_grade, standard_cost, list_price, active_flag) VALUES
  (201, 'NRT-DB-45', 'Tungsten-Carbide Drill Bit 45mm', 'Drill Bits', 'WC-Co 12%', 145.00, 260.00, 'Y'),
  (202, 'NRT-DB-51', 'Tungsten-Carbide Drill Bit 51mm', 'Drill Bits', 'WC-Co 12%', 165.00, 295.00, 'Y'),
  (203, 'NRT-RM-76', 'Reamer 76mm Heavy Duty', 'Reamers', 'Alloy Steel H13', 210.00, 390.00, 'Y'),
  (204, 'NRT-WS-01', 'Wear Shoe Set (Dozer/Loader)', 'Wear Parts', 'AR450', 520.00, 890.00, 'Y'),
  (205, 'NRT-ROD-14', 'Drill Rod 14ft (Threaded)', 'Drill Steel', '4140 HT', 95.00, 175.00, 'Y'),
  (206, 'NRT-ADP-02', 'Shank Adapter (Universal)', 'Adapters', '42CrMo4', 120.00, 225.00, 'Y');

INSERT INTO manufacturing_batches (batch_id, product_id, plant, start_date, end_date, units_produced, units_scrapped, qc_status, unit_manufacturing_cost) VALUES
  (301, 201, 'Gothenburg Toolworks', '2026-01-05', '2026-01-12', 900, 18, 'Released', 146.50),
  (302, 202, 'Gothenburg Toolworks', '2026-01-15', '2026-01-24', 700, 21, 'Released', 168.20),
  (303, 205, 'Lulea Steel Cell', '2026-01-20', '2026-02-02', 1200, 12, 'Released', 94.10),
  (304, 203, 'Gothenburg Toolworks', '2026-02-03', '2026-02-11', 420, 10, 'Released', 214.40),
  (305, 206, 'Lulea Steel Cell', '2026-02-10', '2026-02-20', 650, 16, 'Released', 121.80),
  (306, 204, 'Tampere Wear Parts', '2026-02-18', '2026-03-02', 180, 6, 'Released', 535.00),
  (307, 201, 'Gothenburg Toolworks', '2026-03-04', '2026-03-12', 950, 25, 'Released', 147.20),
  (308, 202, 'Gothenburg Toolworks', '2026-03-10', '2026-03-19', 780, 19, 'Released', 169.10),
  (309, 203, 'Gothenburg Toolworks', '2026-03-18', '2026-03-28', 460, 9, 'Released', 213.70),
  (310, 204, 'Tampere Wear Parts', '2026-03-20', '2026-04-03', 200, 8, 'Released', 538.00);

INSERT INTO sales_orders (order_id, order_number, customer_id, order_date, requested_ship_date, ship_date, order_status, channel, currency) VALUES
  (401, 'SO-2026-0103', 101, '2026-01-03', '2026-01-10', '2026-01-09', 'Shipped', 'Direct', 'USD'),
  (402, 'SO-2026-0111', 102, '2026-01-11', '2026-01-18', '2026-01-20', 'Shipped', 'Direct', 'USD'),
  (403, 'SO-2026-0119', 103, '2026-01-19', '2026-01-28', '2026-01-27', 'Shipped', 'Distributor', 'USD'),
  (404, 'SO-2026-0204', 104, '2026-02-04', '2026-02-14', '2026-02-13', 'Shipped', 'Direct', 'EUR'),
  (405, 'SO-2026-0210', 105, '2026-02-10', '2026-02-18', '2026-02-19', 'Shipped', 'Direct', 'USD'),
  (406, 'SO-2026-0218', 106, '2026-02-18', '2026-02-28', '2026-02-27', 'Shipped', 'Distributor', 'USD'),
  (407, 'SO-2026-0303', 107, '2026-03-03', '2026-03-12', '2026-03-11', 'Shipped', 'Distributor', 'EUR'),
  (408, 'SO-2026-0310', 101, '2026-03-10', '2026-03-18', '2026-03-17', 'Shipped', 'Direct', 'USD'),
  (409, 'SO-2026-0318', 102, '2026-03-18', '2026-03-28', '2026-03-30', 'Shipped', 'Direct', 'USD'),
  (410, 'SO-2026-0324', 103, '2026-03-24', '2026-04-02', NULL, 'Open', 'Distributor', 'USD'),
  (411, 'SO-2026-0402', 104, '2026-04-02', '2026-04-10', NULL, 'Open', 'Direct', 'EUR'),
  (412, 'SO-2026-0407', 105, '2026-04-07', '2026-04-15', NULL, 'Open', 'Direct', 'USD');

INSERT INTO sales_order_items (order_item_id, order_id, product_id, quantity, unit_price, discount_pct) VALUES
  (501, 401, 201, 120, 255.00, 2.00),
  (502, 401, 205, 200, 170.00, 0.00),
  (503, 402, 202, 90, 290.00, 1.50),
  (504, 402, 206, 60, 220.00, 0.00),
  (505, 403, 201, 160, 248.00, 3.00),
  (506, 403, 203, 40, 372.00, 4.00),
  (507, 404, 202, 110, 305.00, 0.00),
  (508, 404, 205, 180, 178.00, 0.00),
  (509, 405, 204, 22, 860.00, 2.00),
  (510, 405, 206, 55, 228.00, 0.00),
  (511, 406, 201, 140, 250.00, 2.50),
  (512, 406, 205, 260, 168.00, 1.00),
  (513, 407, 203, 55, 400.00, 0.00),
  (514, 407, 206, 80, 230.00, 0.00),
  (515, 408, 201, 150, 258.00, 1.00),
  (516, 408, 202, 70, 292.00, 1.00),
  (517, 409, 205, 240, 172.00, 0.00),
  (518, 409, 203, 45, 385.00, 2.00),
  (519, 410, 202, 95, 288.00, 3.00),
  (520, 410, 206, 75, 218.00, 2.00),
  (521, 411, 204, 18, 895.00, 0.00),
  (522, 411, 203, 30, 405.00, 0.00),
  (523, 412, 201, 130, 256.00, 1.50),
  (524, 412, 205, 150, 171.00, 0.00);

INSERT INTO warranty_claims (claim_id, order_id, product_id, claim_date, claim_status, reason_code, units_claimed, credit_amount) VALUES
  (601, 402, 202, '2026-02-06', 'Approved', 'Premature Wear', 6, 1700.00),
  (602, 404, 205, '2026-02-25', 'Closed', 'Thread Damage', 4, 680.00),
  (603, 405, 204, '2026-03-12', 'Denied', 'Misuse/Installation', 2, 0.00),
  (604, 406, 201, '2026-03-20', 'Approved', 'Brazing Defect', 5, 1250.00),
  (605, 408, 201, '2026-04-05', 'Open', 'Chipping/Cracking', 3, 750.00);

