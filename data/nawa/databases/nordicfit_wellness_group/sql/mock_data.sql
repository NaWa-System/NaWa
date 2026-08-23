INSERT INTO clubs (club_id, club_name, city, country, tier, square_meters) VALUES 
(1, 'NordicFit Stureplan', 'Stockholm', 'Sweden', 'Flagship', 3500),
(2, 'NordicFit Södermalm', 'Stockholm', 'Sweden', 'Standard', 2100),
(3, 'NordicFit Majorstuen', 'Oslo', 'Norway', 'Flagship', 3200),
(4, 'NordicFit Amager', 'Copenhagen', 'Denmark', 'Premium', 2800);

INSERT INTO membership_plans (plan_id, plan_name, monthly_fee_sek, access_level) VALUES 
(10, 'Nordic Basic', 449.00, 'Single Club'),
(20, 'Nordic Premium', 649.00, 'City-Wide'),
(30, 'Nordic All-Access', 899.00, 'Nordic Region'),
(40, 'Nordic Corporate', 499.00, 'City-Wide');

INSERT INTO club_monthly_performance (record_id, club_id, report_month, active_members, new_joins, churned_members) VALUES 
(1001, 1, '2026-03', 8500, 450, 120),
(1002, 2, '2026-03', 6200, 310, 180),
(1003, 3, '2026-03', 7800, 420, 150),
(1004, 4, '2026-03', 6900, 380, 140);

INSERT INTO revenue_streams (revenue_id, club_id, report_month, stream_category, gross_revenue_sek) VALUES 
(5001, 1, '2026-03', 'Membership Dues', 6350000.00),
(5002, 1, '2026-03', 'Personal Training', 2850000.00),
(5003, 1, '2026-03', 'Retail & F&B', 420000.00),
(5004, 2, '2026-03', 'Membership Dues', 3850000.00),
(5005, 2, '2026-03', 'Personal Training', 950000.00),
(5006, 3, '2026-03', 'Membership Dues', 5980000.00),
(5007, 3, '2026-03', 'Personal Training', 2450000.00),
(5008, 4, '2026-03', 'Membership Dues', 4950000.00),
(5009, 4, '2026-03', 'Personal Training', 1650000.00);

INSERT INTO group_fitness_stats (stat_id, club_id, class_category, report_month, classes_held, total_attendees, average_capacity_pct) VALUES 
(8001, 1, 'High Intensity (HIIT)', '2026-03', 120, 3400, 0.94),
(8002, 1, 'Mind & Body (Yoga/Pilates)', '2026-03', 90, 2100, 0.85),
(8003, 2, 'Strength & Conditioning', '2026-03', 85, 1950, 0.78),
(8004, 3, 'High Intensity (HIIT)', '2026-03', 110, 3100, 0.92),
(8005, 4, 'Indoor Cycling', '2026-03', 75, 1800, 0.80);
