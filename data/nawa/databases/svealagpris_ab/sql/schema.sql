CREATE TABLE stores (
  store_id INT PRIMARY KEY,
  store_name VARCHAR(100),
  city VARCHAR(50),
  sqm_size INT
);

CREATE TABLE products (
  product_id INT PRIMARY KEY,
  product_name VARCHAR(100),
  brand_type VARCHAR(50),
  category VARCHAR(50),
  base_price DECIMAL(6,2)
);

CREATE TABLE transactions (
  transaction_id INT PRIMARY KEY,
  store_id INT,
  transaction_date DATE,
  total_amount DECIMAL(8,2),
  FOREIGN KEY (store_id) REFERENCES stores(store_id)
);

CREATE TABLE transaction_lines (
  line_id INT PRIMARY KEY,
  transaction_id INT,
  product_id INT,
  quantity INT,
  line_total DECIMAL(8,2),
  FOREIGN KEY (transaction_id) REFERENCES transactions(transaction_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);
