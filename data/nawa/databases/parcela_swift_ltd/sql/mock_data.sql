INSERT INTO regions (region_id, region_name, country) VALUES
(1, 'Greater London', 'UK'),
(2, 'Midlands', 'UK'),
(3, 'North West England', 'UK'),
(4, 'Scotland', 'UK'),
(5, 'Republic of Ireland', 'Ireland');

INSERT INTO depots (depot_id, depot_name, region_id, address) VALUES
(1, 'London Gateway Depot', 1, 'Unit 4, Beckton Industrial Park, London, E6 5NX'),
(2, 'Birmingham Central Depot', 2, '15 Aston Cross Business Park, Birmingham, B6 5RQ'),
(3, 'Manchester North Depot', 3, 'Trafford Park Distribution Centre, Manchester, M17 1PL'),
(4, 'Glasgow Hub', 4, '22 Shieldhall Road, Glasgow, G51 4JW'),
(5, 'Dublin Express Depot', 5, 'Liffey Valley Logistics Park, Dublin 22, D22 XY45');

INSERT INTO customers (customer_id, customer_name, customer_type, account_manager, region_id, contract_start_date) VALUES
(1, 'Halsworth Retail Group', 'B2B', 'Sarah Connell', 1, '2022-03-01'),
(2, 'CrestMed Pharmaceuticals', 'B2B', 'James Okafor', 2, '2021-07-15'),
(3, 'TinderBox Gifts Ltd.', 'B2B', 'Sarah Connell', 3, '2023-01-10'),
(4, 'Doyle & Partners Trading', 'B2B', 'Niamh Brennan', 5, '2022-11-01'),
(5, 'Consumer Direct Pool', 'B2C', NULL, 1, NULL),
(6, 'Voltline Tech Solutions', 'B2B', 'James Okafor', 2, '2023-06-01'),
(7, 'Ferngrove Organics', 'B2B', 'Sarah Connell', 3, '2022-09-20'),
(8, 'Cairn Fine Foods', 'B2B', 'Laura McTavish', 4, '2023-02-14');

INSERT INTO service_types (service_id, service_name, standard_days, base_rate_gbp) VALUES
(1, 'Next Day Express', 1, 12.50),
(2, 'Two Day Standard', 2, 7.80),
(3, 'Economy Parcel', 5, 4.20),
(4, 'Freight Pallet', 3, 85.00),
(5, 'Returns Management', 2, 5.50);

INSERT INTO shipments (shipment_id, customer_id, depot_id, service_id, shipment_date, promised_delivery_date, actual_delivery_date, status, weight_kg, declared_value_gbp, revenue_gbp) VALUES
(1001, 1, 1, 1, '2024-01-08', '2024-01-09', '2024-01-09', 'Delivered', 2.50, 320.00, 15.00),
(1002, 1, 1, 1, '2024-01-10', '2024-01-11', '2024-01-11', 'Delivered', 1.80, 210.00, 14.50),
(1003, 2, 2, 4, '2024-01-12', '2024-01-15', '2024-01-15', 'Delivered', 45.00, 2400.00, 95.00),
(1004, 3, 3, 2, '2024-01-15', '2024-01-17', '2024-01-18', 'Delivered Late', 3.20, 150.00, 9.50),
(1005, 5, 1, 3, '2024-01-16', '2024-01-21', '2024-01-21', 'Delivered', 0.80, 45.00, 5.20),
(1006, 4, 5, 1, '2024-01-18', '2024-01-19', '2024-01-20', 'Delivered Late', 2.10, 180.00, 13.80),
(1007, 6, 2, 2, '2024-01-22', '2024-01-24', '2024-01-24', 'Delivered', 5.50, 890.00, 18.00),
(1008, 7, 3, 3, '2024-01-25', '2024-01-30', '2024-01-30', 'Delivered', 1.20, 75.00, 5.50),
(1009, 8, 4, 1, '2024-01-28', '2024-01-29', NULL, 'Failed', 3.00, 420.00, 14.00),
(1010, 1, 1, 5, '2024-02-01', '2024-02-03', '2024-02-03', 'Delivered', 1.50, 200.00, 6.50),
(1011, 2, 2, 4, '2024-02-05', '2024-02-08', '2024-02-08', 'Delivered', 62.00, 3100.00, 110.00),
(1012, 3, 3, 1, '2024-02-07', '2024-02-08', '2024-02-09', 'Delivered Late', 2.80, 230.00, 14.80),
(1013, 6, 2, 1, '2024-02-09', '2024-02-10', '2024-02-10', 'Delivered', 4.20, 760.00, 16.50),
(1014, 4, 5, 2, '2024-02-12', '2024-02-14', '2024-02-14', 'Delivered', 6.00, 340.00, 12.00),
(1015, 7, 3, 2, '2024-02-14', '2024-02-16', '2024-02-16', 'Delivered', 2.50, 120.00, 9.80),
(1016, 5, 1, 3, '2024-02-15', '2024-02-20', '2024-02-20', 'Delivered', 0.95, 55.00, 5.20),
(1017, 8, 4, 1, '2024-02-18', '2024-02-19', '2024-02-19', 'Delivered', 2.70, 390.00, 14.00),
(1018, 1, 1, 4, '2024-02-20', '2024-02-23', '2024-02-23', 'Delivered', 88.00, 5200.00, 98.00),
(1019, 3, 3, 3, '2024-02-22', '2024-02-27', NULL, 'In Transit', 1.10, 60.00, 5.00),
(1020, 2, 2, 1, '2024-02-26', '2024-02-27', '2024-02-27', 'Delivered', 3.40, 510.00, 15.50),
(1021, 6, 2, 2, '2024-03-01', '2024-03-03', '2024-03-03', 'Delivered', 7.00, 1100.00, 20.00),
(1022, 4, 5, 1, '2024-03-04', '2024-03-05', '2024-03-05', 'Delivered', 1.90, 210.00, 13.50),
(1023, 1, 1, 1, '2024-03-05', '2024-03-06', '2024-03-06', 'Delivered', 3.10, 450.00, 16.00),
(1024, 8, 4, 2, '2024-03-07', '2024-03-09', '2024-03-10', 'Delivered Late', 4.50, 300.00, 11.50),
(1025, 7, 3, 4, '2024-03-10', '2024-03-13', '2024-03-13', 'Delivered', 110.00, 8000.00, 120.00),
(1026, 5, 1, 3, '2024-03-11', '2024-03-16', '2024-03-16', 'Delivered', 1.30, 70.00, 5.20),
(1027, 2, 2, 4, '2024-03-13', '2024-03-16', NULL, 'Failed', 75.00, 4500.00, 105.00),
(1028, 3, 3, 2, '2024-03-15', '2024-03-17', '2024-03-17', 'Delivered', 2.90, 190.00, 10.00),
(1029, 6, 2, 1, '2024-03-18', '2024-03-19', '2024-03-19', 'Delivered', 5.10, 920.00, 17.50),
(1030, 8, 4, 5, '2024-03-20', '2024-03-22', '2024-03-22', 'Delivered', 2.00, 150.00, 6.00),
(1031, 1, 1, 2, '2024-03-22', '2024-03-24', '2024-03-24', 'Delivered', 4.00, 380.00, 12.00),
(1032, 4, 5, 3, '2024-03-25', '2024-03-30', '2024-03-30', 'Delivered', 0.70, 40.00, 4.50),
(1033, 7, 3, 1, '2024-03-26', '2024-03-27', '2024-03-27', 'Delivered', 3.60, 280.00, 15.00),
(1034, 5, 1, 1, '2024-03-28', '2024-03-29', NULL, 'In Transit', 1.00, 90.00, 13.50);

INSERT INTO delivery_exceptions (exception_id, shipment_id, exception_type, exception_date, resolved, resolution_notes) VALUES
(1, 1004, 'Missed Collection', '2024-01-15', TRUE, 'Re-collected following day, delivered within 24 hours of original promise.'),
(2, 1006, 'Address Not Found', '2024-01-19', TRUE, 'Correct address obtained from customer, redelivered successfully.'),
(3, 1009, 'Recipient Unavailable', '2024-01-29', FALSE, 'Three delivery attempts failed. Parcel held at depot.'),
(4, 1012, 'Damaged in Transit', '2024-02-08', TRUE, 'Claim raised. Replacement shipment dispatched at no charge.'),
(5, 1019, 'Customs Delay', '2024-02-25', FALSE, 'Awaiting customs clearance documentation from sender.'),
(6, 1024, 'Driver Route Deviation', '2024-03-09', TRUE, 'Delivered following day. Apology issued to customer.'),
(7, 1027, 'Vehicle Breakdown', '2024-03-14', FALSE, 'Shipment rescheduled. Customer notified. ETA pending.'),
(8, 1034, 'Sorting Error', '2024-03-29', FALSE, 'Parcel mislabelled at depot. Investigation underway.');

INSERT INTO vehicles (vehicle_id, depot_id, registration, vehicle_type, capacity_kg, owned_or_contracted) VALUES
(1, 1, 'LN23 AWX', 'Transit Van', 800.00, 'Owned'),
(2, 1, 'LN23 BYZ', 'Transit Van', 800.00, 'Owned'),
(3, 1, 'LN22 CPR', 'Heavy Goods Vehicle', 5000.00, 'Owned'),
(4, 2, 'BM73 DKL', 'Transit Van', 800.00, 'Contracted'),
(5, 2, 'BM73 EMQ', 'Heavy Goods Vehicle', 5000.00, 'Owned'),
(6, 3, 'MN24 FRS', 'Transit Van', 800.00, 'Owned'),
(7, 3, 'MN23 GTV', 'Heavy Goods Vehicle', 5000.00, 'Contracted'),
(8, 4, 'GW22 HXN', 'Transit Van', 800.00, 'Owned'),
(9, 5, 'D-IE 24001', 'Transit Van', 800.00, 'Contracted'),
(10, 5, 'D-IE 22445', 'Heavy Goods Vehicle', 4500.00, 'Contracted');

INSERT INTO depot_performance (performance_id, depot_id, report_month, total_shipments, on_time_deliveries, failed_deliveries, total_revenue_gbp, operating_cost_gbp) VALUES
(1, 1, '2024-01-01', 98, 88, 3, 12450.00, 8900.00),
(2, 2, '2024-01-01', 74, 69, 2, 9870.00, 7200.00),
(3, 3, '2024-01-01', 65, 58, 4, 7640.00, 6100.00),
(4, 4, '2024-01-01', 42, 36, 5, 5320.00, 4800.00),
(5, 5, '2024-01-01', 31, 28, 2, 4110.00, 3500.00),
(6, 1, '2024-02-01', 105, 96, 2, 13890.00, 9400.00),
(7, 2, '2024-02-01', 80, 76, 1, 11200.00, 7650.00),
(8, 3, '2024-02-01', 70, 62, 3, 8450.00, 6300.00),
(9, 4, '2024-02-01', 48, 44, 2, 6020.00, 4950.00),
(10, 5, '2024-02-01', 35, 33, 1, 4780.00, 3600.00),
(11, 1, '2024-03-01', 118, 108, 4, 15640.00, 10200.00),
(12, 2, '2024-03-01', 88, 80, 3, 12350.00, 8100.00),
(13, 3, '2024-03-01', 79, 72, 4, 9870.00, 7000.00),
(14, 4, '2024-03-01', 55, 49, 3, 7210.00, 5400.00),
(15, 5, '2024-03-01', 40, 37, 2, 5540.00, 4100.00);
