INSERT INTO regions (region_id, region_code, region_name) VALUES 
(1, 'US', 'United States'),
(2, 'IOM', 'International Operated Markets'),
(3, 'IDL', 'International Developmental Licensed');

INSERT INTO restaurants (restaurant_id, region_id, ownership_type, format_type, has_drive_thru) VALUES 
(101, 1, 'Franchised', 'Freestanding', TRUE),
(102, 1, 'Company-Owned', 'Urban Inline', FALSE),
(103, 2, 'Franchised', 'Freestanding', TRUE),
(104, 2, 'Franchised', 'Transit Hub', FALSE),
(105, 3, 'Franchised', 'Freestanding', TRUE);

INSERT INTO menu_categories (category_id, category_name, target_food_cost_pct) VALUES 
(10, 'Core Beef Burgers', 0.28),
(20, 'Chicken & Fish', 0.25),
(30, 'Breakfast', 0.18),
(40, 'Beverages & McCafe', 0.10);

INSERT INTO menu_items (item_id, category_id, item_name, base_price_usd) VALUES 
(1, 10, 'The Grand Baron', 5.99),
(2, 10, 'Double Baron Cheeseburger', 2.99),
(3, 20, 'Crispy Baron Chicken Sandwich', 4.99),
(4, 30, 'Baron Egg Muffin', 3.49),
(5, 40, 'Premium Roast Coffee (Large)', 1.99);

INSERT INTO quarterly_financials_q1 (record_id, restaurant_id, quarter, systemwide_sales_usd, digital_sales_usd, guest_counts) VALUES 
(5001, 101, 'Q1-2026', 1250000.00, 562500.00, 145000),
(5002, 102, 'Q1-2026', 980000.00, 686000.00, 112000),
(5003, 103, 'Q1-2026', 1420000.00, 639000.00, 168000),
(5004, 104, 'Q1-2026', 850000.00, 425000.00, 135000),
(5005, 105, 'Q1-2026', 1100000.00, 330000.00, 195000);

INSERT INTO loyalty_metrics (metric_id, region_id, quarter, active_loyalty_members_m, loyalty_driven_sales_m) VALUES 
(8001, 1, 'Q1-2026', 38.50, 4200.00),
(8002, 2, 'Q1-2026', 52.20, 6100.00),
(8003, 3, 'Q1-2026', 85.00, 5800.00);
