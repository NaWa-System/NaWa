INSERT INTO regions (region_id, region_name, hq_location) VALUES 
(1, 'North America', 'City of Industry, CA'),
(2, 'EMEA', 'Frankfurt, Germany'),
(3, 'APAC', 'Taipei, Taiwan');

INSERT INTO product_categories (category_id, category_name, gross_margin_target) VALUES 
(10, 'Motherboards', 0.25),
(20, 'Graphics Cards (GPUs)', 0.15),
(30, 'Gaming Laptops', 0.22),
(40, 'Monitors & Peripherals', 0.30);

INSERT INTO products (product_id, category_id, model_name, tier, msrp) VALUES 
(101, 10, 'MEG Z990 Godlike', 'Enthusiast', 999.00),
(102, 10, 'MAG B850 Tomahawk', 'Mainstream', 219.00),
(201, 20, 'GeForce RTX 5090 Suprim X', 'Enthusiast', 1999.00),
(202, 20, 'GeForce RTX 5070 Gaming X Trio', 'Performance', 699.00),
(301, 30, 'Titan GT77 HX', 'Enthusiast', 3599.00),
(302, 30, 'Stealth 16 Studio', 'Creator', 1899.00),
(401, 40, 'Optix MEG381CQR Plus', 'Performance', 899.00);

INSERT INTO sales_channels (channel_id, channel_name, channel_type) VALUES 
(1, 'Matrix-Star Direct Web', 'D2C'),
(2, 'Global E-Tailers (Amazon/Newegg)', 'B2C Retail'),
(3, 'Enterprise Fleet Sales', 'B2B');

INSERT INTO regional_sales_q3 (record_id, product_id, region_id, channel_id, units_sold, gross_revenue) VALUES 
(5001, 101, 1, 2, 4500, 4495500.00),
(5002, 102, 2, 2, 25000, 5475000.00),
(5003, 201, 1, 1, 3200, 6396800.00),
(5004, 202, 3, 2, 42000, 29358000.00),
(5005, 301, 1, 1, 1800, 6478200.00),
(5006, 302, 2, 3, 5500, 10444500.00),
(5007, 401, 3, 2, 12000, 10788000.00),
(5008, 201, 2, 2, 2800, 5597200.00),
(5009, 102, 1, 2, 31000, 6789000.00),
(5010, 302, 1, 3, 8500, 16141500.00);
