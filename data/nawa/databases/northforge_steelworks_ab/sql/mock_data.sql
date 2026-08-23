INSERT INTO plants (plant_id, plant_name, country, region, process_route) VALUES
  (1, 'Lulea Melt & Plate Works', 'Sweden', 'Nordics', 'EAF->Caster->Plate Mill'),
  (2, 'Oxelosund Strip Mill', 'Sweden', 'Nordics', 'EAF->Caster->Hot Strip Mill'),
  (3, 'Raahe Coating & Finishing', 'Finland', 'Nordics', 'Cold Rolling->Coating');

INSERT INTO products (product_id, product_name, product_category, grade, thickness_mm, width_mm) VALUES
  (1, 'HF 450 Hot-Rolled Coil 6.0mm', 'HRC', 'S450MC', 6.00, 1500),
  (2, 'HF 700 Hot-Rolled Coil 4.0mm', 'HRC', 'S700MC', 4.00, 1600),
  (3, 'NF Plate 355 20mm', 'Plate', 'S355', 20.00, 2000),
  (4, 'NF Plate 690 16mm', 'Plate', 'S690QL', 16.00, 2500),
  (5, 'CF Galv Coil 1.2mm', 'Coated', 'DX51D+Z', 1.20, 1250),
  (6, 'CF Prepaint Coil 0.7mm', 'Coated', 'DX52D+Z', 0.70, 1000);

INSERT INTO customers (customer_id, customer_name, customer_segment, country, region) VALUES
  (1, 'Baltic Lifting Systems UAB', 'OEM - Material Handling', 'Lithuania', 'Baltics'),
  (2, 'NordHaul Trailers AS', 'OEM - Transport', 'Norway', 'Nordics'),
  (3, 'SkandWind Towers AB', 'Fabricator - Renewables', 'Sweden', 'Nordics'),
  (4, 'RheinWerk Maschinen GmbH', 'OEM - Heavy Equipment', 'Germany', 'DACH'),
  (5, 'Fenland Steel Service Ltd', 'Service Center', 'United Kingdom', 'UKI'),
  (6, 'Polaris BuildTech Sp. z o.o.', 'Distributor', 'Poland', 'CEE');

INSERT INTO production_batches (batch_id, plant_id, product_id, batch_date, batch_status, tons_produced, tons_scrapped, energy_mwh) VALUES
  (1001, 2, 1,  '2026-01-05', 'Released', 820.00, 18.00, 980.00),
  (1002, 2, 2,  '2026-01-14', 'Released', 760.00, 22.00, 1015.00),
  (1003, 1, 3,  '2026-01-20', 'Released', 540.00, 12.00, 710.00),
  (1004, 1, 4,  '2026-01-28', 'Released', 510.00, 16.00, 745.00),
  (1005, 3, 5,  '2026-02-03', 'Released', 680.00, 20.00, 560.00),
  (1006, 3, 6,  '2026-02-11', 'Released', 460.00, 14.00, 430.00),
  (1007, 2, 1,  '2026-02-17', 'Released', 840.00, 19.00, 995.00),
  (1008, 2, 2,  '2026-02-24', 'Released', 780.00, 24.00, 1040.00),
  (1009, 1, 3,  '2026-03-02', 'Released', 560.00, 11.00, 725.00),
  (1010, 1, 4,  '2026-03-08', 'Released', 520.00, 15.00, 760.00),
  (1011, 3, 5,  '2026-03-15', 'Released', 700.00, 21.00, 575.00),
  (1012, 3, 6,  '2026-03-21', 'Released', 480.00, 12.00, 440.00),
  (1013, 2, 1,  '2026-03-25', 'Released', 860.00, 17.00, 1005.00),
  (1014, 2, 2,  '2026-03-29', 'Released', 790.00, 23.00, 1050.00),
  (1015, 1, 4,  '2026-03-31', 'Released', 505.00, 14.00, 740.00),
  (1016, 3, 5,  '2026-03-31', 'QualityHold', 690.00, 0.00, 570.00);

INSERT INTO sales_orders (order_id, customer_id, order_date, order_status, incoterm, currency) VALUES
  (5001, 1,  '2026-01-07', 'Confirmed', 'DAP', 'EUR'),
  (5002, 2,  '2026-01-12', 'Confirmed', 'FCA', 'EUR'),
  (5003, 3,  '2026-01-18', 'Confirmed', 'DAP', 'SEK'),
  (5004, 4,  '2026-01-27', 'Confirmed', 'DAP', 'EUR'),
  (5005, 5,  '2026-02-02', 'Confirmed', 'CIF', 'GBP'),
  (5006, 6,  '2026-02-09', 'Confirmed', 'FCA', 'EUR'),
  (5007, 4,  '2026-02-16', 'Confirmed', 'DAP', 'EUR'),
  (5008, 2,  '2026-02-22', 'Confirmed', 'FCA', 'EUR'),
  (5009, 3,  '2026-03-04', 'Confirmed', 'DAP', 'SEK'),
  (5010, 1,  '2026-03-10', 'Confirmed', 'DAP', 'EUR'),
  (5011, 5,  '2026-03-18', 'Confirmed', 'CIF', 'GBP'),
  (5012, 6,  '2026-03-26', 'Confirmed', 'FCA', 'EUR');

INSERT INTO sales_order_lines (order_line_id, order_id, product_id, ordered_tons, unit_price_per_ton, promised_ship_date) VALUES
  (7001, 5001, 1, 120.00, 980.00,  '2026-02-05'),
  (7002, 5001, 2, 80.00, 1250.00,  '2026-02-12'),
  (7003, 5002, 1, 150.00, 970.00,  '2026-02-08'),
  (7004, 5002, 5, 60.00, 1120.00,  '2026-02-20'),
  (7005, 5003, 4, 200.00, 14500.00,  '2026-02-25'),
  (7006, 5004, 2, 140.00, 1280.00,  '2026-03-05'),
  (7007, 5004, 3, 110.00, 910.00,  '2026-03-02'),
  (7008, 5005, 5, 180.00, 980.00,  '2026-03-10'),
  (7009, 5006, 6, 90.00, 1320.00,  '2026-03-14'),
  (7010, 5007, 4, 160.00, 1490.00,  '2026-03-22'),
  (7011, 5007, 2, 100.00, 1270.00,  '2026-03-18'),
  (7012, 5008, 1, 130.00, 965.00,  '2026-03-20'),
  (7013, 5009, 4, 220.00, 14600.00,  '2026-04-05'),
  (7014, 5010, 2, 95.00, 1260.00,  '2026-04-02'),
  (7015, 5011, 5, 210.00, 990.00,  '2026-04-08'),
  (7016, 5012, 6, 120.00, 1310.00,  '2026-04-12');

INSERT INTO shipments (shipment_id, order_line_id, plant_id, ship_date, delivered_date, shipped_tons, freight_cost, delivery_status) VALUES
  (9001, 7001, 2,  '2026-02-04',  '2026-02-07', 118.00, 4200.00, 'Delivered'),
  (9002, 7002, 2,  '2026-02-13',  '2026-02-16', 80.00, 3100.00, 'Delivered'),
  (9003, 7003, 2,  '2026-02-09',  '2026-02-12', 150.00, 5200.00, 'Delivered'),
  (9004, 7004, 3,  '2026-02-21',  '2026-02-25', 58.00, 2600.00, 'Delivered'),
  (9005, 7005, 1,  '2026-02-27',  '2026-03-03', 200.00, 9800.00, 'Delivered'),
  (9006, 7007, 1,  '2026-03-03',  '2026-03-08', 110.00, 4700.00, 'Delivered'),
  (9007, 7006, 2,  '2026-03-06',  '2026-03-10', 138.00, 6200.00, 'Delivered'),
  (9008, 7008, 3,  '2026-03-12',  '2026-03-16', 175.00, 7400.00, 'Delivered'),
  (9009, 7009, 3,  '2026-03-15',  '2026-03-20', 90.00, 3900.00, 'Delivered'),
  (9010, 7011, 2,  '2026-03-19',  '2026-03-24', 100.00, 5100.00, 'Delivered'),
  (9011, 7010, 1,  '2026-03-23',  '2026-03-29', 155.00, 8600.00, 'Delivered'),
  (9012, 7012, 2,  '2026-03-21',  '2026-03-25', 130.00, 4800.00, 'Delivered'),
  (9013, 7014, 2,  '2026-04-03', NULL, 50.00, 2100.00, 'InTransit'),
  (9014, 7013, 1,  '2026-04-06', NULL, 120.00, 6100.00, 'InTransit'),
  (9015, 7015, 3,  '2026-04-09', NULL, 60.00, 2400.00, 'InTransit'),
  (9016, 7016, 3,  '2026-04-09', NULL, 40.00, 1600.00, 'InTransit');
