CREATE TABLE store_locations (
  location_id INTEGER PRIMARY KEY,
  store_name VARCHAR(100) NOT NULL,
  city VARCHAR(50) NOT NULL,
  region VARCHAR(50) NOT NULL,
  store_size_sqm INTEGER,
  opened_date DATE
);

CREATE TABLE product_departments (
  department_id INTEGER PRIMARY KEY,
  department_name VARCHAR(80) NOT NULL,
  is_fresh BOOLEAN DEFAULT FALSE
);

CREATE TABLE products (
  product_id INTEGER PRIMARY KEY,
  product_name VARCHAR(120) NOT NULL,
  department_id INTEGER NOT NULL,
  is_hemkop_brand BOOLEAN DEFAULT FALSE,
  cost_price DECIMAL(8,2) NOT NULL,
  sell_price DECIMAL(8,2) NOT NULL,
  FOREIGN KEY (department_id) REFERENCES product_departments(department_id)
);

CREATE TABLE customers (
  customer_id INTEGER PRIMARY KEY,
  home_store_id INTEGER NOT NULL,
  segment VARCHAR(30) NOT NULL,
  registered_date DATE NOT NULL,
  FOREIGN KEY (home_store_id) REFERENCES store_locations(location_id)
);

CREATE TABLE sales_transactions (
  transaction_id INTEGER PRIMARY KEY,
  store_id INTEGER NOT NULL,
  customer_id INTEGER,
  transaction_date DATE NOT NULL,
  total_amount DECIMAL(10,2) NOT NULL,
  payment_method VARCHAR(20) NOT NULL,
  FOREIGN KEY (store_id) REFERENCES store_locations(location_id),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE transaction_items (
  item_id INTEGER PRIMARY KEY,
  transaction_id INTEGER NOT NULL,
  product_id INTEGER NOT NULL,
  quantity INTEGER NOT NULL,
  unit_sell_price DECIMAL(8,2) NOT NULL,
  FOREIGN KEY (transaction_id) REFERENCES sales_transactions(transaction_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE promotions (
  promo_id INTEGER PRIMARY KEY,
  promo_name VARCHAR(120) NOT NULL,
  department_id INTEGER NOT NULL,
  discount_pct DECIMAL(5,2) NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  FOREIGN KEY (department_id) REFERENCES product_departments(department_id)
);

CREATE TABLE stock_levels (
  stock_id INTEGER PRIMARY KEY,
  store_id INTEGER NOT NULL,
  product_id INTEGER NOT NULL,
  units_on_hand INTEGER NOT NULL,
  reorder_threshold INTEGER NOT NULL,
  last_updated DATE NOT NULL,
  FOREIGN KEY (store_id) REFERENCES store_locations(location_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);
