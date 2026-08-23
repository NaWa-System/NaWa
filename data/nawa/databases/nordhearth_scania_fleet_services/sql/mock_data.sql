INSERT INTO regions (region_id, region_name) VALUES
  (1, 'Twin Cities Metro'),
  (2, 'Central Minnesota'),
  (3, 'Northern Wisconsin');

INSERT INTO customers (customer_id, customer_name, industry, region_id, credit_terms) VALUES
  (101, 'IronVale Aggregates', 'Construction Materials', 2, 'Net 30'),
  (102, 'Lakefront Retail Distribution', 'Retail Logistics', 1, 'Net 45'),
  (103, 'NorthStar Manufacturing Co.', 'Industrial Manufacturing', 1, 'Net 30'),
  (104, 'PineRiver Timber Products', 'Forestry Products', 3, 'Net 30'),
  (105, 'MidPrairie Food Processing', 'Food & Beverage', 2, 'Net 45');

INSERT INTO vehicles (vehicle_id, vin, make, model, model_year, region_id, purchase_date, status) VALUES
  (201, 'YS2R4X2000M123401', 'Scania', 'R 450 6x2', 2021, 1, '2023-05-12', 'Active'),
  (202, 'YS2R4X2000M123402', 'Scania', 'S 500 6x2', 2020, 1, '2022-11-03', 'Active'),
  (203, 'YS2R4X2000M123403', 'Scania', 'G 410 4x2', 2019, 2, '2021-08-21', 'Active'),
  (204, 'YS2R4X2000M123404', 'Scania', 'R 500 6x4', 2018, 2, '2020-06-18', 'Active'),
  (205, 'YS2R4X2000M123405', 'Scania', 'P 410 4x2', 2022, 3, '2024-02-09', 'Active'),
  (206, 'YS2R4X2000M123406', 'Scania', 'R 450 6x2', 2017, 3, '2019-09-15', 'In Maintenance');

INSERT INTO drivers (driver_id, driver_name, license_class, region_id, hire_date, employment_status) VALUES
  (301, 'Maya Lindholm', 'CDL-A', 1, '2022-03-14', 'Active'),
  (302, 'Ethan Vang', 'CDL-A', 1, '2021-10-04', 'Active'),
  (303, 'Jorge Alvarez', 'CDL-A', 2, '2020-07-27', 'Active'),
  (304, 'Hannah Kline', 'CDL-A', 2, '2023-01-09', 'Active'),
  (305, 'Devon Patel', 'CDL-A', 3, '2022-09-19', 'Active');

INSERT INTO parts (part_id, part_name, part_category, unit_cost, unit_price) VALUES
  (401, 'Oil Filter - Heavy Duty', 'Consumables', 18.50, 34.00),
  (402, 'Engine Oil 15W-40 (L)', 'Fluids', 2.10, 4.25),
  (403, 'Air Filter Element', 'Consumables', 42.00, 78.00),
  (404, 'Brake Pad Set (Front)', 'Brakes', 155.00, 265.00),
  (405, 'Brake Disc (Front)', 'Brakes', 210.00, 345.00),
  (406, 'Coolant концентрат (L)', 'Fluids', 1.85, 3.95),
  (407, 'Battery 24V Heavy Duty', 'Electrical', 145.00, 245.00),
  (408, 'Drive Belt', 'Engine', 36.00, 72.00),
  (409, 'Tire 315/70R22.5', 'Tires', 295.00, 485.00),
  (410, 'DEF Fluid (L)', 'Fluids', 0.85, 1.70);

INSERT INTO shipments (shipment_id, customer_id, vehicle_id, driver_id, origin_city, destination_city, shipment_date, scheduled_delivery_date, actual_delivery_date, status, distance_miles, weight_tons, rate_type, revenue, fuel_cost) VALUES
  (5001, 103, 201, 301, 'Minneapolis, MN', 'Eau Claire, WI', '2026-01-07', '2026-01-08', '2026-01-08', 'Delivered',  90, 12.50, 'Per Trip', 1450.00, 310.00),
  (5002, 102, 202, 302, 'St. Paul, MN', 'Duluth, MN', '2026-01-12', '2026-01-13', '2026-01-13', 'Delivered', 155, 9.20, 'Per Trip', 1625.00, 365.00),
  (5003, 101, 203, 303, 'St. Cloud, MN', 'Brainerd, MN', '2026-01-18', '2026-01-18', '2026-01-19', 'Delivered Late', 92, 18.00, 'Per Mile', 920.00, 255.00),
  (5004, 105, 204, 304, 'Willmar, MN', 'Rochester, MN', '2026-01-25', '2026-01-26', '2026-01-26', 'Delivered', 178, 14.10, 'Per Mile', 1246.00, 415.00),
  (5005, 104, 205, 305, 'Wausau, WI', 'Green Bay, WI', '2026-02-02', '2026-02-03', '2026-02-03', 'Delivered', 106, 16.30, 'Per Trip', 1380.00, 295.00),
  (5006, 103, 201, 301, 'Minneapolis, MN', 'La Crosse, WI', '2026-02-06', '2026-02-07', '2026-02-07', 'Delivered', 142, 11.80, 'Per Mile', 994.00, 340.00),
  (5007, 102, 202, 302, 'St. Paul, MN', 'Fargo, ND', '2026-02-10', '2026-02-11', '2026-02-11', 'Delivered', 236, 8.60, 'Per Mile', 1416.00, 520.00),
  (5008, 101, 203, 303, 'St. Cloud, MN', 'Moorhead, MN', '2026-02-14', '2026-02-15', '2026-02-15', 'Delivered', 192, 19.50, 'Per Mile', 1344.00, 510.00),
  (5009, 105, 204, 304, 'Willmar, MN', 'Sioux Falls, SD', '2026-02-20', '2026-02-21', '2026-02-22', 'Delivered Late', 269, 13.70, 'Per Mile', 1883.00, 650.00),
  (5010, 104, 205, 305, 'Wausau, WI', 'Madison, WI', '2026-02-26', '2026-02-27', '2026-02-27', 'Delivered', 172, 15.60, 'Per Trip', 1560.00, 420.00),
  (5011, 103, 201, 301, 'Minneapolis, MN', 'Duluth, MN', '2026-03-03', '2026-03-04', '2026-03-04', 'Delivered', 154, 10.90, 'Per Mile', 1078.00, 395.00),
  (5012, 102, 202, 302, 'St. Paul, MN', 'Eau Claire, WI', '2026-03-07', '2026-03-08', '2026-03-08', 'Delivered', 92, 9.10, 'Per Trip', 1200.00, 240.00),
  (5013, 101, 203, 303, 'St. Cloud, MN', 'Duluth, MN', '2026-03-11', '2026-03-12', '2026-03-12', 'Delivered', 174, 17.40, 'Per Mile', 1218.00, 485.00),
  (5014, 105, 204, 304, 'Willmar, MN', 'Des Moines, IA', '2026-03-16', '2026-03-17', '2026-03-17', 'Delivered', 376, 12.90, 'Per Mile', 2632.00, 920.00),
  (5015, 104, 206, 305, 'Wausau, WI', 'Minneapolis, MN', '2026-03-20', '2026-03-21', NULL, 'Cancelled', 231, 14.40, 'Per Mile', 0.00, 0.00),
  (5016, 103, 201, 301, 'Minneapolis, MN', 'Green Bay, WI', '2026-03-24', '2026-03-25', '2026-03-25', 'Delivered', 279, 11.20, 'Per Mile', 1953.00, 710.00),
  (5017, 102, 202, 302, 'St. Paul, MN', 'Rochester, MN', '2026-03-28', '2026-03-28', '2026-03-28', 'Delivered', 91, 8.80, 'Per Trip', 1150.00, 215.00),
  (5018, 105, 204, 304, 'Willmar, MN', 'Omaha, NE', '2026-04-02', '2026-04-03', '2026-04-03', 'Delivered', 517, 13.10, 'Per Mile', 3619.00, 1225.00),
  (5019, 101, 203, 303, 'St. Cloud, MN', 'Fargo, ND', '2026-04-05', '2026-04-06', '2026-04-06', 'Delivered', 248, 18.60, 'Per Mile', 1736.00, 640.00),
  (5020, 104, 205, 305, 'Wausau, WI', 'Milwaukee, WI', '2026-04-07', '2026-04-08', NULL, 'In Transit', 188, 16.10, 'Per Trip', 1585.00, 410.00);

INSERT INTO maintenance_work_orders (work_order_id, vehicle_id, work_order_date, work_type, odometer_miles, labor_hours, labor_rate, parts_cost, total_cost, downtime_days, status) VALUES
  (7001, 201, '2026-01-09', 'Preventive', 182340, 3.50, 120.00, 185.00, 605.00, 0.50, 'Closed'),
  (7002, 202, '2026-01-20', 'Repair', 211880, 6.00, 120.00, 610.00, 1330.00, 1.00, 'Closed'),
  (7003, 203, '2026-02-05', 'Preventive', 256140, 4.00, 120.00, 210.00, 690.00, 0.60, 'Closed'),
  (7004, 204, '2026-02-18', 'Repair', 298020, 7.25, 120.00, 1210.00, 2080.00, 1.40, 'Closed'),
  (7005, 205, '2026-02-28', 'Inspection', 64200, 2.25, 120.00, 78.00, 348.00, 0.25, 'Closed'),
  (7006, 201, '2026-03-10', 'Repair', 189900, 5.50, 120.00, 485.00, 1145.00, 0.90, 'Closed'),
  (7007, 206, '2026-03-18', 'Repair', 341550, 9.00, 120.00, 1460.00, 2540.00, 2.30, 'Closed'),
  (7008, 202, '2026-03-29', 'Preventive', 219430, 3.75, 120.00, 205.00, 655.00, 0.50, 'Closed'),
  (7009, 204, '2026-04-06', 'Repair', 304880, 4.50, 120.00, 970.00, 1510.00, 1.10, 'Open');

INSERT INTO maintenance_work_order_parts (work_order_id, part_id, quantity, unit_price, extended_price) VALUES
  (7001, 401, 1, 34.00, 34.00),
  (7001, 402, 35, 4.25, 148.75),
  (7002, 404, 1, 265.00, 265.00),
  (7002, 405, 2, 345.00, 690.00),
  (7003, 401, 1, 34.00, 34.00),
  (7003, 402, 32, 4.25, 136.00),
  (7003, 403, 1, 78.00, 78.00),
  (7004, 409, 2, 485.00, 970.00),
  (7004, 408, 1, 72.00, 72.00),
  (7005, 403, 1, 78.00, 78.00),
  (7006, 407, 1, 245.00, 245.00),
  (7006, 410, 140, 1.70, 238.00),
  (7007, 404, 1, 265.00, 265.00),
  (7007, 405, 1, 345.00, 345.00),
  (7007, 409, 1, 485.00, 485.00),
  (7008, 401, 1, 34.00, 34.00),
  (7008, 402, 34, 4.25, 144.50),
  (7009, 409, 2, 485.00, 970.00);

