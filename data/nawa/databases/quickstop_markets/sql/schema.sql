CREATE TABLE stores (
  store_id INTEGER PRIMARY KEY,
  store_name VARCHAR(100) NOT NULL,
  city VARCHAR(60) NOT NULL,
  state VARCHAR(30) NOT NULL,
  region VARCHAR(30) NOT NULL,
  opened_date DATE NOT NULL,
  has_fuel INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE product_categories (
  category_id INTEGER PRIMARY KEY,
  category_name VARCHAR(60) NOT NULL,
  department VARCHAR(40) NOT NULL
);

CREATE TABLE products (
  product_id INTEGER PRIMARY KEY,
  product_name VARCHAR(120) NOT NULL,
  category_id INTEGER NOT NULL,
  unit_cost NUMERIC(8,2) NOT NULL,
  unit_price NUMERIC(8,2) NOT NULL,
  is_active INTEGER NOT NULL DEFAULT 1,
  FOREIGN KEY (category_id) REFERENCES product_categories(category_id)
);

CREATE TABLE customers (
  customer_id INTEGER PRIMARY KEY,
  first_name VARCHAR(60) NOT NULL,
  last_name VARCHAR(60) NOT NULL,
  email VARCHAR(120),
  loyalty_enrolled INTEGER NOT NULL DEFAULT 0,
  loyalty_points INTEGER NOT NULL DEFAULT 0,
  joined_date DATE NOT NULL
);

CREATE TABLE transactions (
  transaction_id INTEGER PRIMARY KEY,
  store_id INTEGER NOT NULL,
  customer_id INTEGER,
  transaction_date DATE NOT NULL,
  transaction_time TIME NOT NULL,
  payment_method VARCHAR(30) NOT NULL,
  total_amount NUMERIC(10,2) NOT NULL,
  FOREIGN KEY (store_id) REFERENCES stores(store_id),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE transaction_items (
  item_id INTEGER PRIMARY KEY,
  transaction_id INTEGER NOT NULL,
  product_id INTEGER NOT NULL,
  quantity INTEGER NOT NULL,
  unit_price NUMERIC(8,2) NOT NULL,
  unit_cost NUMERIC(8,2) NOT NULL,
  line_total NUMERIC(10,2) NOT NULL,
  FOREIGN KEY (transaction_id) REFERENCES transactions(transaction_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE inventory (
  inventory_id INTEGER PRIMARY KEY,
  store_id INTEGER NOT NULL,
  product_id INTEGER NOT NULL,
  quantity_on_hand INTEGER NOT NULL,
  reorder_level INTEGER NOT NULL,
  last_restocked_date DATE NOT NULL,
  FOREIGN KEY (store_id) REFERENCES stores(store_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE fuel_sales (
  fuel_sale_id INTEGER PRIMARY KEY,
  store_id INTEGER NOT NULL,
  sale_date DATE NOT NULL,
  fuel_type VARCHAR(20) NOT NULL,
  gallons_sold NUMERIC(10,3) NOT NULL,
  price_per_gallon NUMERIC(6,3) NOT NULL,
  cost_per_gallon NUMERIC(6,3) NOT NULL,
  total_revenue NUMERIC(10,2) NOT NULL,
  FOREIGN KEY (store_id) REFERENCES stores(store_id)
);
