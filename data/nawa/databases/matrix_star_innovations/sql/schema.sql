CREATE TABLE regions (
  region_id INT PRIMARY KEY,
  region_name VARCHAR(50),
  hq_location VARCHAR(50)
);

CREATE TABLE product_categories (
  category_id INT PRIMARY KEY,
  category_name VARCHAR(50),
  gross_margin_target DECIMAL(4,2)
);

CREATE TABLE products (
  product_id INT PRIMARY KEY,
  category_id INT,
  model_name VARCHAR(100),
  tier VARCHAR(50),
  msrp DECIMAL(8,2),
  FOREIGN KEY (category_id) REFERENCES product_categories(category_id)
);

CREATE TABLE sales_channels (
  channel_id INT PRIMARY KEY,
  channel_name VARCHAR(50),
  channel_type VARCHAR(50)
);

CREATE TABLE regional_sales_q3 (
  record_id INT PRIMARY KEY,
  product_id INT,
  region_id INT,
  channel_id INT,
  units_sold INT,
  gross_revenue DECIMAL(12,2),
  FOREIGN KEY (product_id) REFERENCES products(product_id),
  FOREIGN KEY (region_id) REFERENCES regions(region_id),
  FOREIGN KEY (channel_id) REFERENCES sales_channels(channel_id)
);
