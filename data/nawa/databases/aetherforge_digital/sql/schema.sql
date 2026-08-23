CREATE TABLE publishers (
  publisher_id INT PRIMARY KEY,
  publisher_name VARCHAR(100),
  tier VARCHAR(50),
  platform_fee_pct DECIMAL(4,2)
);

CREATE TABLE games (
  game_id INT PRIMARY KEY,
  publisher_id INT,
  title VARCHAR(150),
  genre VARCHAR(50),
  base_price_usd DECIMAL(6,2),
  FOREIGN KEY (publisher_id) REFERENCES publishers(publisher_id)
);

CREATE TABLE hardware_products (
  hw_id INT PRIMARY KEY,
  model_name VARCHAR(100),
  hw_type VARCHAR(50),
  msrp_usd DECIMAL(8,2)
);

CREATE TABLE regional_markets (
  region_id INT PRIMARY KEY,
  region_code VARCHAR(10),
  region_name VARCHAR(50)
);

CREATE TABLE digital_sales_q4 (
  sale_id INT PRIMARY KEY,
  game_id INT,
  region_id INT,
  event_type VARCHAR(50),
  units_sold INT,
  gross_revenue_usd DECIMAL(12,2),
  aetherforge_cut_usd DECIMAL(12,2),
  FOREIGN KEY (game_id) REFERENCES games(game_id),
  FOREIGN KEY (region_id) REFERENCES regional_markets(region_id)
);

CREATE TABLE hardware_sales_q4 (
  hw_sale_id INT PRIMARY KEY,
  hw_id INT,
  region_id INT,
  units_sold INT,
  gross_revenue_usd DECIMAL(12,2),
  FOREIGN KEY (hw_id) REFERENCES hardware_products(hw_id),
  FOREIGN KEY (region_id) REFERENCES regional_markets(region_id)
);
