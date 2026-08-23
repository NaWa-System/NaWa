CREATE TABLE studios (
  studio_id INT PRIMARY KEY,
  studio_name VARCHAR(100),
  city VARCHAR(50),
  country VARCHAR(50),
  focus_area VARCHAR(100),
  headcount INT
);

CREATE TABLE franchises (
  franchise_id INT PRIMARY KEY,
  franchise_name VARCHAR(100),
  genre VARCHAR(50),
  creation_year INT,
  lifetime_revenue_m DECIMAL(8,2)
);

CREATE TABLE games (
  game_id INT PRIMARY KEY,
  franchise_id INT,
  title VARCHAR(150),
  release_date DATE,
  engine_used VARCHAR(50),
  development_budget_m DECIMAL(6,2),
  FOREIGN KEY (franchise_id) REFERENCES franchises(franchise_id)
);

CREATE TABLE sales_metrics (
  metric_id INT PRIMARY KEY,
  game_id INT,
  platform VARCHAR(50),
  region VARCHAR(50),
  report_quarter VARCHAR(10),
  units_sold_k INT,
  gross_revenue_m DECIMAL(8,2),
  FOREIGN KEY (game_id) REFERENCES games(game_id)
);

CREATE TABLE live_service_engagement (
  engagement_id INT PRIMARY KEY,
  game_id INT,
  report_quarter VARCHAR(10),
  monthly_active_users_m DECIMAL(5,2),
  mtx_revenue_m DECIMAL(8,2),
  average_session_length_hrs DECIMAL(4,2),
  FOREIGN KEY (game_id) REFERENCES games(game_id)
);
