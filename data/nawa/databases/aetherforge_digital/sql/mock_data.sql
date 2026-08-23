INSERT INTO publishers (publisher_id, publisher_name, tier, platform_fee_pct) VALUES 
(1, 'TitanWorks Interactive', 'AAA', 0.20),
(2, 'Neon Indie Studios', 'Indie', 0.30),
(3, 'AetherForge First-Party', 'Internal', 0.00);

INSERT INTO games (game_id, publisher_id, title, genre, base_price_usd) VALUES 
(101, 1, 'Galactic Vanguard 4', 'Action RPG', 69.99),
(102, 2, 'Pixel Farm Valley', 'Simulation', 14.99),
(103, 3, 'Portal Paradox 3', 'Puzzle', 49.99),
(104, 1, 'Warfront 2026', 'FPS', 59.99);

INSERT INTO hardware_products (hw_id, model_name, hw_type, msrp_usd) VALUES 
(201, 'AetherDeck LCD 512GB', 'Handheld PC', 449.00),
(202, 'AetherDeck OLED 1TB', 'Handheld PC', 649.00);

INSERT INTO regional_markets (region_id, region_code, region_name) VALUES 
(1, 'NA', 'North America'),
(2, 'EU', 'Europe'),
(3, 'APAC', 'Asia-Pacific');

INSERT INTO digital_sales_q4 (sale_id, game_id, region_id, event_type, units_sold, gross_revenue_usd, aetherforge_cut_usd) VALUES 
(5001, 101, 1, 'Winter Sale', 450000, 25195500.00, 5039100.00),
(5002, 101, 2, 'Winter Sale', 320000, 17916800.00, 3583360.00),
(5003, 102, 3, 'Standard', 850000, 12741500.00, 3822450.00),
(5004, 103, 1, 'Standard', 150000, 7498500.00, 7498500.00),
(5005, 104, 2, 'Winter Sale', 210000, 10077900.00, 2015580.00),
(5006, 102, 1, 'Winter Sale', 410000, 6145900.00, 1843770.00);

INSERT INTO hardware_sales_q4 (hw_sale_id, hw_id, region_id, units_sold, gross_revenue_usd) VALUES 
(8001, 202, 1, 120000, 77880000.00),
(8002, 202, 2, 85000, 55165000.00),
(8003, 201, 3, 145000, 65105000.00),
(8004, 201, 1, 95000, 42655000.00);
