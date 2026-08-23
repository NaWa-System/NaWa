INSERT INTO regions (region_id, region_name) VALUES
  (1, 'Northeast'),
  (2, 'Southeast'),
  (3, 'Midwest'),
  (4, 'West');

INSERT INTO clients (client_id, client_name, industry, region_id, start_date, status) VALUES
  (101, 'HarborPoint Properties', 'Commercial Real Estate', 1, '2025-10-01', 'Active'),
  (102, 'TriCounty Logistics', 'Logistics & Warehousing', 3, '2025-11-15', 'Active'),
  (103, 'GreenCrest Retail Group', 'Retail', 2, '2025-09-01', 'Active'),
  (104, 'Lakeside Medical Clinics', 'Healthcare', 3, '2026-01-10', 'Active'),
  (105, 'SierraForge Manufacturing', 'Manufacturing', 4, '2025-12-01', 'Active');

INSERT INTO sites (site_id, client_id, site_name, city, state, risk_level, status) VALUES
  (201, 101, 'HarborPoint - Riverside Tower', 'Boston', 'MA', 'Medium', 'Active'),
  (202, 101, 'HarborPoint - Elm Street Garage', 'Cambridge', 'MA', 'High', 'Active'),
  (203, 102, 'TriCounty - DC1 Warehouse', 'Columbus', 'OH', 'High', 'Active'),
  (204, 103, 'GreenCrest - Mall Outlet 14', 'Orlando', 'FL', 'Medium', 'Active'),
  (205, 103, 'GreenCrest - Standalone 22', 'Tampa', 'FL', 'Low', 'Active'),
  (206, 104, 'Lakeside - Clinic North', 'Cleveland', 'OH', 'Medium', 'Active'),
  (207, 105, 'SierraForge - Plant 3', 'San Jose', 'CA', 'High', 'Active');

INSERT INTO officers (officer_id, full_name, hire_date, region_id, employment_status, hourly_cost) VALUES
  (301, 'Darius Coleman', '2023-04-17', 1, 'Active', 22.50),
  (302, 'Mei Santos', '2024-02-05', 1, 'Active', 23.25),
  (303, 'Renee Whitaker', '2022-08-22', 2, 'Active', 21.75),
  (304, 'Caleb Nguyen', '2025-01-13', 3, 'Active', 22.00),
  (305, 'Imani Brooks', '2023-11-06', 3, 'Active', 24.00),
  (306, 'Evan Hart', '2021-06-30', 4, 'Active', 25.50),
  (307, 'Sofia Patel', '2024-09-09', 2, 'Active', 21.50);

INSERT INTO contracts (contract_id, client_id, contract_type, start_date, end_date, billing_rate_hourly, minimum_hours_per_month, status) VALUES
  (401, 101, 'On-site Guarding', '2025-10-01', NULL, 38.00, 240, 'Active'),
  (402, 102, 'On-site Guarding', '2025-11-15', NULL, 40.00, 320, 'Active'),
  (403, 103, 'Mobile Patrol', '2025-09-01', NULL, 34.00, 120, 'Active'),
  (404, 104, 'On-site Guarding', '2026-01-10', NULL, 39.00, 160, 'Active'),
  (405, 105, 'On-site Guarding', '2025-12-01', NULL, 42.00, 200, 'Active');

INSERT INTO shifts (shift_id, site_id, officer_id, contract_id, shift_date, hours_worked, shift_type, hourly_bill_rate, status) VALUES
  (5001, 201, 301, 401, '2026-01-05', 8.0, 'Day', 38.00, 'Completed'),
  (5002, 202, 302, 401, '2026-01-06', 10.0, 'Night', 40.00, 'Completed'),
  (5003, 203, 304, 402, '2026-01-08', 12.0, 'Night', 41.00, 'Completed'),
  (5004, 204, 303, 403, '2026-01-12', 6.0, 'Patrol', 34.00, 'Completed'),
  (5005, 205, 307, 403, '2026-01-14', 6.0, 'Patrol', 34.00, 'Completed'),
  (5006, 206, 305, 404, '2026-01-20', 8.0, 'Day', 39.00, 'Completed'),
  (5007, 207, 306, 405, '2026-01-22', 8.0, 'Day', 42.00, 'Completed'),

  (5008, 201, 301, 401, '2026-02-03', 8.0, 'Day', 38.00, 'Completed'),
  (5009, 202, 302, 401, '2026-02-05', 10.0, 'Night', 40.00, 'Completed'),
  (5010, 203, 304, 402, '2026-02-06', 12.0, 'Night', 41.00, 'Completed'),
  (5011, 204, 303, 403, '2026-02-09', 6.0, 'Patrol', 34.00, 'Completed'),
  (5012, 205, 307, 403, '2026-02-11', 6.0, 'Patrol', 34.00, 'Completed'),
  (5013, 206, 305, 404, '2026-02-18', 10.0, 'Day', 39.00, 'Completed'),
  (5014, 207, 306, 405, '2026-02-23', 8.0, 'Day', 42.00, 'Completed'),

  (5015, 201, 302, 401, '2026-03-04', 8.0, 'Day', 38.00, 'Completed'),
  (5016, 202, 301, 401, '2026-03-06', 10.0, 'Night', 40.00, 'Completed'),
  (5017, 203, 305, 402, '2026-03-07', 12.0, 'Night', 41.00, 'Completed'),
  (5018, 204, 307, 403, '2026-03-10', 6.0, 'Patrol', 34.00, 'Completed'),
  (5019, 205, 303, 403, '2026-03-12', 6.0, 'Patrol', 34.00, 'Completed'),
  (5020, 206, 304, 404, '2026-03-16', 8.0, 'Day', 39.00, 'Completed'),
  (5021, 207, 306, 405, '2026-03-21', 10.0, 'Night', 44.00, 'Completed'),

  (5022, 201, 301, 401, '2026-03-28', 8.0, 'Day', 38.00, 'Completed'),
  (5023, 203, 304, 402, '2026-03-29', 12.0, 'Night', 41.00, 'Completed'),

  (5024, 202, 302, 401, '2026-04-02', 10.0, 'Night', 40.00, 'Completed'),
  (5025, 206, 305, 404, '2026-04-05', 8.0, 'Day', 39.00, 'Completed'),
  (5026, 204, 303, 403, '2026-04-06', 6.0, 'Patrol', 34.00, 'Completed');

INSERT INTO incidents (incident_id, site_id, incident_datetime, incident_type, severity, reported_by_officer_id, resolved_flag, resolution_notes) VALUES
  (7001, 202, '2026-01-06 22:14:00', 'Trespass', 'Medium', 302, 'Y', 'Subject removed from stairwell; client notified.'),
  (7002, 203, '2026-01-08 02:41:00', 'Theft', 'High', 304, 'Y', 'Trailer seal tampered; police report filed; camera footage preserved.'),
  (7003, 204, '2026-01-12 19:05:00', 'Disorderly', 'Low', 303, 'Y', 'De-escalation completed; no further action required.'),
  (7004, 201, '2026-02-03 14:22:00', 'SafetyHazard', 'Medium', 301, 'Y', 'Wet floor and signage issue; facilities engaged within 30 minutes.'),
  (7005, 205, '2026-02-11 21:48:00', 'Vandalism', 'Medium', 307, 'Y', 'Graffiti documented; local PD notified; area secured.'),
  (7006, 203, '2026-02-06 03:12:00', 'Alarm', 'Low', 304, 'Y', 'False alarm due to door sensor; maintenance ticket recommended.'),
  (7007, 206, '2026-02-18 09:33:00', 'MedicalAssist', 'Medium', 305, 'Y', 'Assisted staff with lobby incident; EMS called; incident documented.'),
  (7008, 207, '2026-03-21 23:07:00', 'AccessBreach', 'High', 306, 'Y', 'Unauthorized badge attempt; badge disabled; HR/security informed.'),
  (7009, 202, '2026-03-06 01:26:00', 'Trespass', 'Medium', 301, 'Y', 'Repeat trespasser observed; photo added to site briefing.'),
  (7010, 201, '2026-03-28 16:10:00', 'Disorderly', 'Low', 301, 'Y', 'Visitor refused to leave; escorted out without incident.'),
  (7011, 203, '2026-03-29 04:55:00', 'Theft', 'High', 304, 'N', 'Open investigation; awaiting client inventory reconciliation.'),
  (7012, 204, '2026-04-06 20:12:00', 'SafetyHazard', 'Low', 303, 'Y', 'Trip hazard near loading area; cones placed; store manager notified.');
