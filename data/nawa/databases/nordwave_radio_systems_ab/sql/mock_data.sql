INSERT INTO regions (region_id, region_name, country) VALUES
  (1, 'Nordics', 'Sweden'),
  (2, 'DACH', 'Germany'),
  (3, 'UK & Ireland', 'United Kingdom'),
  (4, 'Iberia', 'Spain'),
  (5, 'North America', 'United States');

INSERT INTO customers (customer_id, customer_name, customer_type, hq_region_id, account_tier, contract_start_date) VALUES
  (101, 'Skylink Mobile Group', 'MNO', 1, 'Strategic', '2025-10-01'),
  (102, 'RheinTel Communications', 'MNO', 2, 'Strategic', '2025-09-15'),
  (103, 'Albion Wireless PLC', 'MNO', 3, 'Key', '2025-11-01'),
  (104, 'IberWave Telecom', 'MNO', 4, 'Key', '2025-08-01'),
  (105, 'Pioneer Neutral Host', 'NeutralHost', 5, 'Growth', '2026-01-15');

INSERT INTO product_catalog (product_id, product_name, product_category, unit_of_measure, list_price_usd) VALUES
  (201, 'NR Radio Unit 64T64R (3.5GHz)', 'Radio Unit', 'unit', 185000.00),
  (202, 'NR Radio Unit 32T32R (2.6GHz)', 'Radio Unit', 'unit', 132000.00),
  (203, 'Baseband Compute Shelf (vRAN Ready)', 'Baseband', 'unit', 98000.00),
  (204, 'Massive MIMO Antenna Panel', 'Antenna', 'unit', 42000.00),
  (205, 'Edge Site Power & Cooling Kit', 'Site Infrastructure', 'kit', 26000.00),
  (206, 'Network Optimization Service (Monthly)', 'Service', 'month', 24000.00),
  (207, 'Integration & Acceptance Testing (Per Site)', 'Service', 'site', 18000.00);

INSERT INTO projects (project_id, customer_id, region_id, project_name, start_date, planned_end_date, actual_end_date, project_status, contract_value_usd) VALUES
  (301, 101, 1, 'Skylink 5G Mid-Band Expansion Q1', '2026-01-05', '2026-03-31', '2026-03-28', 'Completed', 2150000.00),
  (302, 102, 2, 'RheinTel Urban Capacity Upgrade (Phase 2)', '2026-01-12', '2026-04-15', NULL, 'In Progress', 2980000.00),
  (303, 103, 3, 'Albion vRAN Trial & Integration', '2026-02-01', '2026-04-30', NULL, 'In Progress', 1120000.00),
  (304, 104, 4, 'IberWave Site Modernization Program', '2025-12-15', '2026-03-20', '2026-03-18', 'Completed', 1760000.00),
  (305, 105, 5, 'Pioneer Neutral-Host Small Cell Backbone', '2026-02-10', '2026-05-31', NULL, 'In Progress', 940000.00),
  (306, 101, 1, 'Skylink Network Optimization Retainer', '2026-01-01', '2026-03-31', NULL, 'In Progress', 216000.00);

INSERT INTO work_orders (work_order_id, project_id, work_order_date, work_order_type, status) VALUES
  (401, 301, '2026-01-08', 'Site Survey', 'Closed'),
  (402, 301, '2026-01-20', 'Integration & Acceptance', 'Closed'),
  (403, 302, '2026-01-18', 'Hardware Staging', 'Closed'),
  (404, 302, '2026-02-05', 'Integration & Acceptance', 'In Progress'),
  (405, 303, '2026-02-12', 'vRAN Lab Build', 'Closed'),
  (406, 303, '2026-03-10', 'Field Trial Integration', 'In Progress'),
  (407, 304, '2026-01-06', 'Site Modernization', 'Closed'),
  (408, 304, '2026-02-14', 'Integration & Acceptance', 'Closed'),
  (409, 305, '2026-02-18', 'Backhaul Design', 'Closed'),
  (410, 305, '2026-03-22', 'Edge Site Bring-Up', 'In Progress'),
  (411, 306, '2026-01-31', 'Optimization Sprint', 'Closed'),
  (412, 306, '2026-02-28', 'Optimization Sprint', 'Closed'),
  (413, 306, '2026-03-31', 'Optimization Sprint', 'Closed');

INSERT INTO project_deliveries (delivery_id, project_id, delivery_date, product_id, quantity, unit_price_usd, delivery_status) VALUES
  (501, 301, '2026-01-15', 201, 4, 171500.00, 'Delivered'),
  (502, 301, '2026-01-15', 203, 3, 91000.00, 'Delivered'),
  (503, 301, '2026-02-02', 204, 8, 39000.00, 'Delivered'),
  (504, 301, '2026-02-20', 207, 12, 17500.00, 'Delivered'),
  (505, 302, '2026-01-28', 201, 6, 173000.00, 'Delivered'),
  (506, 302, '2026-02-18', 202, 5, 124500.00, 'Delivered'),
  (507, 302, '2026-03-05', 203, 6, 93500.00, 'Delivered'),
  (508, 302, '2026-03-25', 204, 10, 40200.00, 'Shipped'),
  (509, 303, '2026-02-20', 203, 4, 90000.00, 'Delivered'),
  (510, 303, '2026-03-15', 201, 2, 176000.00, 'Delivered'),
  (511, 303, '2026-03-15', 207, 6, 18000.00, 'Delivered'),
  (512, 304, '2026-01-10', 202, 6, 122000.00, 'Delivered'),
  (513, 304, '2026-01-10', 205, 6, 25200.00, 'Delivered'),
  (514, 304, '2026-02-08', 204, 12, 38800.00, 'Delivered'),
  (515, 304, '2026-02-26', 207, 14, 17000.00, 'Delivered'),
  (516, 305, '2026-03-01', 205, 8, 24800.00, 'Delivered'),
  (517, 305, '2026-03-28', 203, 2, 96000.00, 'Shipped'),
  (518, 306, '2026-01-31', 206, 1, 24000.00, 'Delivered'),
  (519, 306, '2026-02-28', 206, 1, 24000.00, 'Delivered'),
  (520, 306, '2026-03-31', 206, 1, 24000.00, 'Delivered');

INSERT INTO project_milestones (milestone_id, project_id, milestone_name, due_date, completion_date, milestone_status, invoice_amount_usd, invoice_status) VALUES
  (601, 301, 'Design Sign-off', '2026-01-12', '2026-01-11', 'Completed', 350000.00, 'Paid'),
  (602, 301, 'First Cluster On-Air', '2026-02-10', '2026-02-09', 'Completed', 520000.00, 'Paid'),
  (603, 301, 'Final Acceptance', '2026-03-31', '2026-03-28', 'Completed', 680000.00, 'Sent'),
  (604, 302, 'Capacity Plan Approved', '2026-01-31', '2026-02-02', 'Completed', 420000.00, 'Paid'),
  (605, 302, 'Hardware Delivered (Batch 1)', '2026-02-28', '2026-02-18', 'Completed', 610000.00, 'Sent'),
  (606, 302, 'On-Air Wave 1', '2026-03-31', NULL, 'At Risk', 740000.00, 'Not Sent'),
  (607, 303, 'Lab Validation Complete', '2026-02-28', '2026-02-26', 'Completed', 180000.00, 'Paid'),
  (608, 303, 'Field Trial On-Air', '2026-03-31', NULL, 'In Progress', 260000.00, 'Sent'),
  (609, 304, 'Modernization 50% Complete', '2026-02-15', '2026-02-14', 'Completed', 480000.00, 'Paid'),
  (610, 304, 'Final Acceptance', '2026-03-20', '2026-03-18', 'Completed', 620000.00, 'Sent'),
  (611, 305, 'Backhaul Design Approved', '2026-03-10', '2026-03-12', 'Completed', 120000.00, 'Paid'),
  (612, 305, 'Edge Sites Ready', '2026-04-30', NULL, 'In Progress', 210000.00, 'Not Sent'),
  (613, 306, 'Optimization Month 1', '2026-01-31', '2026-01-31', 'Completed', 72000.00, 'Paid'),
  (614, 306, 'Optimization Month 2', '2026-02-28', '2026-02-28', 'Completed', 72000.00, 'Paid'),
  (615, 306, 'Optimization Month 3', '2026-03-31', '2026-03-31', 'Completed', 72000.00, 'Sent');
