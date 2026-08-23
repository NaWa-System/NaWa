INSERT INTO regions (region_id, region_name) VALUES
  (1, 'Nordics'),
  (2, 'Western Europe'),
  (3, 'Baltic'),
  (4, 'North Atlantic');

INSERT INTO customers (customer_id, customer_name, customer_type, region_id, security_tier) VALUES
  (101, 'Swedmark Defence Materiel Agency', 'Government', 1, 'Restricted'),
  (102, 'Arkendal Air Force Logistics Command', 'Government', 2, 'Confidential'),
  (103, 'Vestra Coast Guard Directorate', 'Government', 4, 'Restricted'),
  (104, 'BaltSec Maritime Authority', 'Government', 3, 'Restricted'),
  (105, 'Orion Prime Systems AB', 'Prime Contractor', 1, 'Confidential'),
  (106, 'Helios Integrations GmbH', 'Prime Contractor', 2, 'Restricted');

INSERT INTO product_lines (product_line_id, product_line_name, domain) VALUES
  (11, 'Airborne Surveillance Sensors', 'Aerospace'),
  (12, 'Secure Tactical Communications', 'Security'),
  (13, 'Electronic Warfare Pods', 'Defence'),
  (14, 'Mission Software & Cryptography', 'Security');

INSERT INTO products (product_id, product_name, product_line_id, unit_of_measure, is_software, list_price, standard_unit_cost) VALUES
  (201, 'Skydome-90 AESA Radar Pod', 11, 'unit', FALSE, 1850000.00, 1325000.00),
  (202, 'Skydome-90 Line Replaceable Unit (LRU) Kit', 11, 'kit', FALSE, 240000.00, 165000.00),
  (203, 'VIGILINK-TAC Secure Radio (Vehicle/Air)', 12, 'unit', FALSE, 78000.00, 50500.00),
  (204, 'VIGILINK Crypto Module (KMI-Compatible)', 14, 'unit', FALSE, 26500.00, 14200.00),
  (205, 'SABLE-EW Compact EW Pod', 13, 'unit', FALSE, 1120000.00, 810000.00),
  (206, 'SABLE-EW Threat Library Update (Quarterly)', 14, 'license', TRUE, 180000.00, 52000.00),
  (207, 'Mission Computer Ruggedized (NV-MC4)', 11, 'unit', FALSE, 195000.00, 124000.00),
  (208, 'Secure Link Gateway (NV-GW2)', 12, 'unit', FALSE, 146000.00, 91000.00);

INSERT INTO contracts (contract_id, contract_code, customer_id, contract_type, start_date, end_date, contract_value, currency, status, region_id) VALUES
  (301, 'NV-24-011', 101, 'Sustainment', '2025-01-01', '2025-12-31', 9200000.00, 'EUR', 'Active', 1),
  (302, 'NV-24-019', 102, 'Spares', '2025-02-01', '2025-08-31', 3100000.00, 'EUR', 'Active', 2),
  (303, 'NV-24-026', 103, 'Capability Upgrade', '2025-01-15', '2025-10-31', 6800000.00, 'EUR', 'Active', 4),
  (304, 'NV-24-033', 104, 'Sustainment', '2025-03-01', '2025-12-31', 2700000.00, 'EUR', 'Active', 3),
  (305, 'NV-24-041', 105, 'Subcontract', '2025-01-01', '2025-06-30', 4200000.00, 'EUR', 'Active', 1),
  (306, 'NV-24-048', 106, 'Subcontract', '2025-02-15', '2025-07-31', 2500000.00, 'EUR', 'Active', 2);

INSERT INTO deliveries (delivery_id, contract_id, delivery_date, delivery_status, invoice_date, invoice_status, total_amount) VALUES
  (401, 301, '2025-01-20', 'Delivered', '2025-01-22', 'Paid', 690000.00),
  (402, 301, '2025-02-18', 'Delivered', '2025-02-20', 'Paid', 512000.00),
  (403, 301, '2025-03-19', 'Delivered', '2025-03-21', 'Paid', 748000.00),
  (404, 302, '2025-02-12', 'Delivered', '2025-02-14', 'Paid', 624000.00),
  (405, 302, '2025-03-14', 'Delivered', '2025-03-18', 'Paid', 468000.00),
  (406, 302, '2025-04-16', 'Delivered', '2025-04-18', 'Sent', 702000.00),
  (407, 303, '2025-01-28', 'Delivered', '2025-02-03', 'Paid', 1156000.00),
  (408, 303, '2025-03-27', 'Delivered', '2025-03-31', 'Paid', 984000.00),
  (409, 303, '2025-04-22', 'Shipped', NULL, NULL, 1215000.00),
  (410, 304, '2025-03-25', 'Delivered', '2025-03-27', 'Paid', 396000.00),
  (411, 304, '2025-04-24', 'Delivered', '2025-04-26', 'Sent', 522000.00),
  (412, 305, '2025-01-30', 'Delivered', '2025-02-05', 'Paid', 840000.00),
  (413, 305, '2025-02-26', 'Delivered', '2025-02-28', 'Paid', 660000.00),
  (414, 305, '2025-03-28', 'Delivered', '2025-04-01', 'Paid', 720000.00),
  (415, 306, '2025-02-25', 'Delivered', '2025-02-27', 'Paid', 455000.00),
  (416, 306, '2025-04-10', 'Delivered', '2025-04-12', 'Sent', 611000.00);

INSERT INTO delivery_items (delivery_item_id, delivery_id, product_id, quantity, unit_price, unit_cost) VALUES
  (501, 401, 202, 2, 230000.00, 165000.00),
  (502, 401, 204, 10, 24800.00, 14200.00),
  (503, 401, 203, 5, 76000.00, 50500.00),

  (504, 402, 206, 1, 175000.00, 52000.00),
  (505, 402, 204, 12, 25250.00, 14200.00),
  (506, 402, 208, 2, 145000.00, 91000.00),

  (507, 403, 202, 1, 235000.00, 165000.00),
  (508, 403, 207, 2, 190000.00, 124000.00),
  (509, 403, 203, 3, 77000.00, 50500.00),
  (510, 403, 206, 1, 176000.00, 52000.00),

  (511, 404, 203, 4, 77500.00, 50500.00),
  (512, 404, 208, 2, 148000.00, 91000.00),
  (513, 404, 204, 12, 26500.00, 14200.00),

  (514, 405, 202, 1, 240000.00, 165000.00),
  (515, 405, 204, 6, 26000.00, 14200.00),
  (516, 405, 208, 1, 150000.00, 91000.00),

  (517, 406, 203, 6, 78000.00, 50500.00),
  (518, 406, 204, 10, 26800.00, 14200.00),
  (519, 406, 208, 2, 151000.00, 91000.00),

  (520, 407, 205, 1, 1090000.00, 810000.00),
  (521, 407, 206, 1, 180000.00, 52000.00),

  (522, 408, 201, 1, 1795000.00, 1325000.00),
  (523, 408, 204, 8, 26000.00, 14200.00),

  (524, 409, 205, 1, 1110000.00, 810000.00),
  (525, 409, 206, 1, 185000.00, 52000.00),

  (526, 410, 203, 3, 78000.00, 50500.00),
  (527, 410, 204, 6, 25500.00, 14200.00),
  (528, 410, 208, 1, 150000.00, 91000.00),

  (529, 411, 206, 1, 180000.00, 52000.00),
  (530, 411, 204, 8, 26500.00, 14200.00),
  (531, 411, 203, 2, 79000.00, 50500.00),

  (532, 412, 202, 2, 230000.00, 165000.00),
  (533, 412, 203, 2, 77000.00, 50500.00),
  (534, 412, 204, 6, 26000.00, 14200.00),

  (535, 413, 208, 3, 146000.00, 91000.00),
  (536, 413, 204, 8, 26500.00, 14200.00),

  (537, 414, 207, 2, 195000.00, 124000.00),
  (538, 414, 203, 4, 78000.00, 50500.00),
  (539, 414, 204, 7, 26500.00, 14200.00),

  (540, 415, 203, 3, 78000.00, 50500.00),
  (541, 415, 208, 1, 146000.00, 91000.00),
  (542, 415, 204, 4, 26250.00, 14200.00),

  (543, 416, 202, 1, 242000.00, 165000.00),
  (544, 416, 203, 2, 79000.00, 50500.00),
  (545, 416, 204, 6, 26800.00, 14200.00),
  (546, 416, 208, 1, 151000.00, 91000.00);

INSERT INTO service_tickets (ticket_id, contract_id, opened_date, closed_date, priority, category, status, resolution_code, labor_hours) VALUES
  (601, 301, '2025-01-08', '2025-01-10', 'P2', 'Crypto Key Loading', 'Closed', 'Guided Procedure', 6.50),
  (602, 301, '2025-01-21', '2025-01-29', 'P3', 'Radio Intermittent Loss', 'Closed', 'Firmware Patch', 11.00),
  (603, 302, '2025-02-05', '2025-02-07', 'P2', 'Gateway Configuration', 'Closed', 'Remote Reconfiguration', 4.00),
  (604, 305, '2025-02-11', '2025-02-14', 'P1', 'LRU DOA', 'Closed', 'RMA Issued', 7.25),
  (605, 303, '2025-02-20', '2025-03-05', 'P1', 'EW Pod Calibration', 'Closed', 'Depot Recalibration', 28.00),
  (606, 303, '2025-03-12', NULL, 'P2', 'Threat Library Validation', 'Open', NULL, 9.50),
  (607, 304, '2025-03-18', '2025-03-20', 'P3', 'Crypto Module Audit Log', 'Closed', 'Config Update', 5.00),
  (608, 306, '2025-03-22', '2025-03-29', 'P2', 'Integration Test Failure', 'Closed', 'Interface Update', 16.00),
  (609, 301, '2025-04-03', NULL, 'P1', 'Secure Link Dropouts', 'Open', NULL, 13.00),
  (610, 302, '2025-04-08', NULL, 'P3', 'Spare Part Traceability', 'Open', NULL, 3.50),
  (611, 305, '2025-04-14', '2025-04-15', 'P2', 'Mission Computer Boot Error', 'Closed', 'Bootloader Fix', 8.00),
  (612, 304, '2025-04-21', '2025-04-28', 'P2', 'Radio Encryption Mode', 'Closed', 'Operator Training', 6.00);
