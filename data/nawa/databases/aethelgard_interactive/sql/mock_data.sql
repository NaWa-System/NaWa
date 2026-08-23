INSERT INTO studios (studio_id, studio_name, city, country, focus_area, headcount) VALUES 
(1, 'Aethelgard Paris', 'Paris', 'France', 'Core Franchise Leadership & Engine Tech', 850),
(2, 'Aethelgard Montreal', 'Montreal', 'Canada', 'Open World Design & Live Service', 1200),
(3, 'Aethelgard Bucharest', 'Bucharest', 'Romania', 'QA, Porting, and Multiplayer Architecture', 600),
(4, 'Aethelgard Kyoto', 'Kyoto', 'Japan', 'Concept Art & Niche Platformers', 150);

INSERT INTO franchises (franchise_id, franchise_name, genre, creation_year, lifetime_revenue_m) VALUES 
(10, 'Chronicles of Mythos', 'Action RPG', 2008, 4500.00),
(20, 'Tactical Breach', 'Tactical Shooter', 2014, 3200.00),
(30, 'Neon Jumpers', 'Platformer', 2010, 850.00);

INSERT INTO games (game_id, franchise_id, title, release_date, engine_used, development_budget_m) VALUES 
(101, 10, 'Chronicles of Mythos: Valhalla', '2023-10-15', 'MythosEngine 4.0', 145.00),
(102, 10, 'Chronicles of Mythos: Odyssey', '2020-09-12', 'MythosEngine 3.5', 110.00),
(201, 20, 'Tactical Breach: Global Offensive', '2019-11-05', 'AethelStrike 2.0', 85.00),
(301, 30, 'Neon Jumpers: Overdrive', '2023-08-20', 'Unity', 25.00);

INSERT INTO sales_metrics (metric_id, game_id, platform, region, report_quarter, units_sold_k, gross_revenue_m) VALUES 
(5001, 101, 'PlayStation 5', 'North America', 'Q4-2023', 1800, 125.80),
(5002, 101, 'PlayStation 5', 'Europe', 'Q4-2023', 2100, 146.50),
(5003, 101, 'PC', 'Global', 'Q4-2023', 1500, 89.90),
(5004, 101, 'Xbox Series X', 'North America', 'Q4-2023', 950, 66.40),
(5005, 201, 'PC', 'Global', 'Q4-2023', 500, 14.50),
(5006, 201, 'PlayStation 5', 'Global', 'Q4-2023', 300, 8.90),
(5007, 301, 'Nintendo Switch', 'Global', 'Q4-2023', 1200, 47.80);

INSERT INTO live_service_engagement (engagement_id, game_id, report_quarter, monthly_active_users_m, mtx_revenue_m, average_session_length_hrs) VALUES 
(8001, 101, 'Q4-2023', 8.50, 42.30, 3.20),
(8002, 201, 'Q4-2023', 22.40, 155.60, 2.80),
(8003, 102, 'Q4-2023', 1.20, 5.40, 1.50),
(8004, 301, 'Q4-2023', 3.50, 12.10, 1.10);
