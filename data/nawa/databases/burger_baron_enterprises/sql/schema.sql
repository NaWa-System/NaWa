CREATE TABLE regions (
  region_id INT PRIMARY KEY,
  region_code VARCHAR(10),
  region_name VARCHAR(50)
);

CREATE TABLE restaurants (
  restaurant_id INT PRIMARY KEY,
  region_id INT,
  ownership_type VARCHAR(50),
  format_type VARCHAR(50),
  has_drive_thru BOOLEAN,
  FOREIGN KEY (region_id) REFERENCES regions(region_id)
);

CREATE TABLE menu_categories (
  category_id INT PRIMARY KEY,
  category_name VARCHAR(50),
  target_food_cost_pct DECIMAL(4,2)
);

CREATE TABLE menu_items (
  item_id INT PRIMARY KEY,
  category_id INT,
  item_name VARCHAR(100),
  base_price_usd DECIMAL(6,2),
  FOREIGN KEY (category_id) REFERENCES menu_categories(category_id)
);

CREATE TABLE quarterly_financials_q1 (
  record_id INT PRIMARY KEY,
  restaurant_id INT,
  quarter VARCHAR(10),
  systemwide_sales_usd DECIMAL(12,2),
  digital_sales_usd DECIMAL(12,2),
  guest_counts INT,
  FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id)
);

CREATE TABLE loyalty_metrics (
  metric_id INT PRIMARY KEY,
  region_id INT,
  quarter VARCHAR(10),
  active_loyalty_members_m DECIMAL(6,2),
  loyalty_driven_sales_m DECIMAL(10,2),
  FOREIGN KEY (region_id) REFERENCES regions(region_id)
);
