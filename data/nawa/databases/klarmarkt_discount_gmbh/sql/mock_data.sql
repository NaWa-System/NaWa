INSERT INTO regions (region_id, region_name, hq_city) VALUES 
(1, 'DACH (Germany, Austria, CH)', 'Neckarsulm'),
(2, 'UK & Ireland', 'London'),
(3, 'North America', 'Arlington, VA');

INSERT INTO product_categories (category_id, category_name, is_non_food, target_gross_margin) VALUES 
(10, 'Fresh Produce & Bakery', FALSE, 0.12),
(20, 'Dairy & Chilled', FALSE, 0.08),
(30, 'Dry Groceries & FMCG', FALSE, 0.15),
(40, 'Non-Food Specials (Middle Aisle)', TRUE, 0.35);

INSERT INTO products (product_id, category_id, sku_name, brand_type, unit_price_eur) VALUES 
(101, 10, 'KlarBake Crusty Sourdough 500g', 'Private Label', 1.49),
(102, 10, 'Organic Bananas 1kg', 'Commodity', 1.19),
(201, 20, 'KlarBrand Fresh Milk 1L (Whole)', 'Private Label', 0.99),
(202, 20, 'Kerrygold Irish Butter 250g', 'National Brand', 2.89),
(301, 30, 'KlarBrand Penne Rigate 500g', 'Private Label', 0.79),
(401, 40, 'KlarTech 5L Digital Air Fryer', 'Private Label (Non-Food)', 49.99),
(402, 40, 'BuildMaster 20V Cordless Drill', 'Private Label (Non-Food)', 34.99);

INSERT INTO stores (store_id, region_id, store_name, square_meters) VALUES 
(1, 1, 'KlarMarkt Stuttgart-Mitte', 1400),
(2, 1, 'KlarMarkt Vienna-West', 1350),
(3, 2, 'KlarMarkt Manchester-South', 1200),
(4, 3, 'KlarMarkt Richmond-VA', 1800);

INSERT INTO weekly_sales_q2 (sales_id, store_id, product_id, week_num, units_sold, gross_revenue_eur, shrinkage_units) VALUES 
(5001, 1, 201, 14, 15000, 14850.00, 12),
(5002, 1, 401, 14, 850, 42491.50, 2),
(5003, 2, 101, 15, 12000, 17880.00, 45),
(5004, 3, 202, 15, 4500, 13005.00, 5),
(5005, 3, 402, 16, 1200, 41988.00, 8),
(5006, 4, 301, 16, 25000, 19750.00, 15),
(5007, 4, 401, 17, 1800, 89982.00, 3),
(5008, 1, 202, 17, 8000, 23120.00, 4),
(5009, 2, 402, 18, 950, 33240.50, 1),
(5010, 3, 201, 18, 18000, 17820.00, 14);
