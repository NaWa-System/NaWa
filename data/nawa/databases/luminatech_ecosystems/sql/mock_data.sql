INSERT INTO business_segments (segment_id, segment_name, strategic_focus) VALUES 
(1, 'Lumina Services (Ads)', 'Search, Video, and Display Network Monetization'),
(2, 'LuminaCloud', 'Enterprise Compute, Storage, and AI Infrastructure'),
(3, 'Lumina Subscriptions & Devices', 'Consumer Hardware and Recurring Software Revenue');

INSERT INTO product_categories (category_id, segment_id, category_name, target_margin) VALUES 
(10, 1, 'Search & Other', 0.55),
(20, 1, 'StreamSphere Ads', 0.35),
(30, 2, 'Cloud Infrastructure', 0.15),
(40, 3, 'Consumer Subscriptions', 0.40);

INSERT INTO products (product_id, category_id, product_name, monetization_model) VALUES 
(101, 10, 'Lumina Search Engine', 'Pay-Per-Click (PPC) Advertising'),
(102, 20, 'StreamSphere Video', 'Pre-roll & Mid-roll Video Ads'),
(201, 30, 'LuminaCloud Compute Engine', 'Usage-Based B2B Billing'),
(301, 40, 'Lumina AI Agent Nova Pro', 'Monthly Consumer Subscription'),
(302, 40, 'Lumina Workspace Enterprise', 'Monthly B2B Per-Seat Subscription');

INSERT INTO regions (region_id, region_code, region_name) VALUES 
(1, 'US', 'United States'),
(2, 'EMEA', 'Europe, Middle East, and Africa'),
(3, 'APAC', 'Asia-Pacific');

INSERT INTO quarterly_financials_q1 (record_id, product_id, region_id, quarter, revenue_m, operating_income_m) VALUES 
(5001, 101, 1, 'Q1-2026', 22500.00, 14625.00),
(5002, 101, 2, 'Q1-2026', 13200.00, 7920.00),
(5003, 101, 3, 'Q1-2026', 8100.00, 4860.00),
(5004, 102, 1, 'Q1-2026', 4800.00, 1680.00),
(5005, 102, 2, 'Q1-2026', 3100.00, 1085.00),
(5006, 201, 1, 'Q1-2026', 5500.00, 825.00),
(5007, 201, 2, 'Q1-2026', 2800.00, 420.00),
(5008, 301, 1, 'Q1-2026', 950.00, 380.00),
(5009, 302, 1, 'Q1-2026', 1200.00, 480.00),
(5010, 302, 2, 'Q1-2026', 850.00, 340.00);

INSERT INTO digital_metrics (metric_id, product_id, quarter, monthly_active_users_m, average_revenue_per_user_usd) VALUES 
(8001, 101, 'Q1-2026', 3100.50, 14.12),
(8002, 102, 'Q1-2026', 2450.00, 3.22),
(8003, 301, 'Q1-2026', 47.50, 20.00);
