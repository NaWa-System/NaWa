CREATE TABLE business_segments (
  segment_id INT PRIMARY KEY,
  segment_name VARCHAR(50),
  strategic_focus VARCHAR(100)
);

CREATE TABLE product_categories (
  category_id INT PRIMARY KEY,
  segment_id INT,
  category_name VARCHAR(50),
  target_margin DECIMAL(4,2),
  FOREIGN KEY (segment_id) REFERENCES business_segments(segment_id)
);

CREATE TABLE products (
  product_id INT PRIMARY KEY,
  category_id INT,
  product_name VARCHAR(100),
  monetization_model VARCHAR(50),
  FOREIGN KEY (category_id) REFERENCES product_categories(category_id)
);

CREATE TABLE regions (
  region_id INT PRIMARY KEY,
  region_code VARCHAR(10),
  region_name VARCHAR(50)
);

CREATE TABLE quarterly_financials_q1 (
  record_id INT PRIMARY KEY,
  product_id INT,
  region_id INT,
  quarter VARCHAR(10),
  revenue_m DECIMAL(12,2),
  operating_income_m DECIMAL(12,2),
  FOREIGN KEY (product_id) REFERENCES products(product_id),
  FOREIGN KEY (region_id) REFERENCES regions(region_id)
);

CREATE TABLE digital_metrics (
  metric_id INT PRIMARY KEY,
  product_id INT,
  quarter VARCHAR(10),
  monthly_active_users_m DECIMAL(8,2),
  average_revenue_per_user_usd DECIMAL(8,2),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);
