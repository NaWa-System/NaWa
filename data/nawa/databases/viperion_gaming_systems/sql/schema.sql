CREATE TABLE product_lines (
  line_id INT PRIMARY KEY,
  line_name VARCHAR(50),
  category VARCHAR(50),
  target_margin DECIMAL(4,2)
);

CREATE TABLE products (
  product_id INT PRIMARY KEY,
  line_id INT,
  sku_name VARCHAR(100),
  release_year INT,
  msrp DECIMAL(8,2),
  FOREIGN KEY (line_id) REFERENCES product_lines(line_id)
);

CREATE TABLE regions (
  region_id INT PRIMARY KEY,
  region_code VARCHAR(10),
  region_name VARCHAR(50)
);

CREATE TABLE quarterly_sales (
  sales_id INT PRIMARY KEY,
  product_id INT,
  region_id INT,
  quarter VARCHAR(10),
  units_sold INT,
  gross_revenue DECIMAL(12,2),
  FOREIGN KEY (product_id) REFERENCES products(product_id),
  FOREIGN KEY (region_id) REFERENCES regions(region_id)
);

CREATE TABLE software_metrics (
  metric_id INT PRIMARY KEY,
  region_id INT,
  quarter VARCHAR(10),
  synkronize_mau_k INT,
  vipercoin_revenue DECIMAL(10,2),
  FOREIGN KEY (region_id) REFERENCES regions(region_id)
);
