CREATE TABLE clubs (
  club_id INT PRIMARY KEY,
  club_name VARCHAR(100),
  city VARCHAR(50),
  country VARCHAR(50),
  tier VARCHAR(50),
  square_meters INT
);

CREATE TABLE membership_plans (
  plan_id INT PRIMARY KEY,
  plan_name VARCHAR(50),
  monthly_fee_sek DECIMAL(8,2),
  access_level VARCHAR(50)
);

CREATE TABLE club_monthly_performance (
  record_id INT PRIMARY KEY,
  club_id INT,
  report_month VARCHAR(10),
  active_members INT,
  new_joins INT,
  churned_members INT,
  FOREIGN KEY (club_id) REFERENCES clubs(club_id)
);

CREATE TABLE revenue_streams (
  revenue_id INT PRIMARY KEY,
  club_id INT,
  report_month VARCHAR(10),
  stream_category VARCHAR(50),
  gross_revenue_sek DECIMAL(12,2),
  FOREIGN KEY (club_id) REFERENCES clubs(club_id)
);

CREATE TABLE group_fitness_stats (
  stat_id INT PRIMARY KEY,
  club_id INT,
  class_category VARCHAR(50),
  report_month VARCHAR(10),
  classes_held INT,
  total_attendees INT,
  average_capacity_pct DECIMAL(5,2),
  FOREIGN KEY (club_id) REFERENCES clubs(club_id)
);
