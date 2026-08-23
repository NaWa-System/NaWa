CREATE TABLE regions (
  region_id INT PRIMARY KEY,
  region_name VARCHAR(50),
  hq_city VARCHAR(50)
);

CREATE TABLE product_categories (
  category_id INT PRIMARY KEY,
  category_name VARCHAR(50),
  is_non_food BOOLEAN,
  target_gross_margin DECIMAL(4,2)
);

CREATE TABLE products (
  product_id INT PRIMARY KEY,
  category_id INT,
  sku_name VARCHAR(100),
  brand_type VARCHAR(50),
  unit_price_eur DECIMAL(6,2),
  FOREIGN KEY (category_id) REFERENCES product_categories(category_id)
);

CREATE TABLE stores (
  store_id INT PRIMARY KEY,
  region_id INT,
  store_name VARCHAR(100),
  square_meters INT,
  FOREIGN KEY (region_id) REFERENCES regions(region_id)
);

CREATE TABLE weekly_sales_q2 (
  sales_id INT PRIMARY KEY,
  store_id INT,
  product_id INT,
  week_num INT,
  units_sold INT,
  gross_revenue_eur DECIMAL(12,2),
  shrinkage_units INT,
  FOREIGN KEY (store_id) REFERENCES stores(store_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);
