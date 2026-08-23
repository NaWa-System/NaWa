CREATE TABLE stores (
  store_id INTEGER PRIMARY KEY,
  store_name VARCHAR(100) NOT NULL,
  city VARCHAR(100) NOT NULL,
  region VARCHAR(50) NOT NULL,
  store_type VARCHAR(50) NOT NULL,
  opened_date DATE NOT NULL
);

CREATE TABLE categories (
  category_id INTEGER PRIMARY KEY,
  category_name VARCHAR(100) NOT NULL,
  department VARCHAR(50) NOT NULL
);

CREATE TABLE products (
  product_id INTEGER PRIMARY KEY,
  product_name VARCHAR(150) NOT NULL,
  category_id INTEGER NOT NULL,
  unit_cost DECIMAL(10,2) NOT NULL,
  unit_price DECIMAL(10,2) NOT NULL,
  is_private_label BOOLEAN NOT NULL DEFAULT FALSE,
  FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

CREATE TABLE customers (
  customer_id INTEGER PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  email VARCHAR(150) NOT NULL,
  loyalty_tier VARCHAR(20) NOT NULL,
  registration_date DATE NOT NULL,
  home_store_id INTEGER,
  FOREIGN KEY (home_store_id) REFERENCES stores(store_id)
);

CREATE TABLE transactions (
  transaction_id INTEGER PRIMARY KEY,
  store_id INTEGER NOT NULL,
  customer_id INTEGER,
  transaction_date DATE NOT NULL,
  channel VARCHAR(20) NOT NULL,
  total_amount DECIMAL(10,2) NOT NULL,
  discount_applied DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  FOREIGN KEY (store_id) REFERENCES stores(store_id),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE transaction_items (
  item_id INTEGER PRIMARY KEY,
  transaction_id INTEGER NOT NULL,
  product_id INTEGER NOT NULL,
  quantity INTEGER NOT NULL,
  unit_price DECIMAL(10,2) NOT NULL,
  unit_cost DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (transaction_id) REFERENCES transactions(transaction_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE inventory (
  inventory_id INTEGER PRIMARY KEY,
  store_id INTEGER NOT NULL,
  product_id INTEGER NOT NULL,
  stock_quantity INTEGER NOT NULL,
  reorder_level INTEGER NOT NULL,
  last_restocked_date DATE NOT NULL,
  FOREIGN KEY (store_id) REFERENCES stores(store_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE promotions (
  promotion_id INTEGER PRIMARY KEY,
  promotion_name VARCHAR(150) NOT NULL,
  category_id INTEGER,
  discount_percent DECIMAL(5,2) NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  FOREIGN KEY (category_id) REFERENCES categories(category_id)
);
