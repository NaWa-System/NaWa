INSERT INTO product_lines (line_id, line_name, category, target_margin) VALUES 
(10, 'Venom Laptops', 'Systems', 0.18),
(20, 'Fang Peripherals', 'Input Devices', 0.45),
(30, 'Coil Audio', 'Acoustics', 0.38);

INSERT INTO products (product_id, line_id, sku_name, release_year, msrp) VALUES 
(101, 10, 'Venom Blade 16 (RTX 5080)', 2026, 2999.00),
(102, 10, 'Venom Blade 14 (RTX 5060)', 2025, 1899.00),
(201, 20, 'Fang DeathStrike Pro V2 Wireless', 2025, 149.99),
(202, 20, 'Fang Huntsman Elite Optical', 2026, 199.99),
(301, 30, 'Coil Kraken V3 Hypersense', 2024, 129.99);

INSERT INTO regions (region_id, region_code, region_name) VALUES 
(1, 'NA', 'North America'),
(2, 'EMEA', 'Europe, Middle East, Africa'),
(3, 'APAC', 'Asia-Pacific');

INSERT INTO quarterly_sales (sales_id, product_id, region_id, quarter, units_sold, gross_revenue) VALUES 
(5001, 101, 1, 'Q2-2026', 8500, 25491500.00),
(5002, 101, 2, 'Q2-2026', 5200, 15594800.00),
(5003, 101, 3, 'Q2-2026', 4100, 12295900.00),
(5004, 102, 1, 'Q2-2026', 12000, 22788000.00),
(5005, 201, 1, 'Q2-2026', 145000, 21748550.00),
(5006, 201, 2, 'Q2-2026', 110000, 16498900.00),
(5007, 201, 3, 'Q2-2026', 280000, 41997200.00),
(5008, 202, 1, 'Q2-2026', 95000, 18999050.00),
(5009, 301, 3, 'Q2-2026', 160000, 20798400.00),
(5010, 301, 2, 'Q2-2026', 85000, 11049150.00);

INSERT INTO software_metrics (metric_id, region_id, quarter, synkronize_mau_k, vipercoin_revenue) VALUES 
(8001, 1, 'Q2-2026', 12500, 4500500.00),
(8002, 2, 'Q2-2026', 8800, 2100000.00),
(8003, 3, 'Q2-2026', 26500, 8950000.00);
