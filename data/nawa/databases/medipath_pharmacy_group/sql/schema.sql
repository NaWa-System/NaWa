CREATE TABLE stores (
  store_id INTEGER PRIMARY KEY,
  store_name VARCHAR(100) NOT NULL,
  city VARCHAR(100) NOT NULL,
  state VARCHAR(50) NOT NULL,
  region VARCHAR(50) NOT NULL,
  opened_date DATE NOT NULL
);

CREATE TABLE product_categories (
  category_id INTEGER PRIMARY KEY,
  category_name VARCHAR(100) NOT NULL,
  category_type VARCHAR(50) NOT NULL
);

CREATE TABLE products (
  product_id INTEGER PRIMARY KEY,
  product_name VARCHAR(150) NOT NULL,
  category_id INTEGER NOT NULL,
  unit_cost DECIMAL(10,2) NOT NULL,
  unit_price DECIMAL(10,2) NOT NULL,
  requires_prescription BOOLEAN NOT NULL,
  FOREIGN KEY (category_id) REFERENCES product_categories(category_id)
);

CREATE TABLE customers (
  customer_id INTEGER PRIMARY KEY,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  date_of_birth DATE NOT NULL,
  loyalty_member BOOLEAN NOT NULL,
  primary_store_id INTEGER NOT NULL,
  registration_date DATE NOT NULL,
  FOREIGN KEY (primary_store_id) REFERENCES stores(store_id)
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

CREATE TABLE transactions (
  transaction_id INTEGER PRIMARY KEY,
  store_id INTEGER NOT NULL,
  customer_id INTEGER,
  transaction_date DATE NOT NULL,
  transaction_type VARCHAR(50) NOT NULL,
  total_amount DECIMAL(10,2) NOT NULL,
  payment_method VARCHAR(50) NOT NULL,
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
  discount_amount DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  FOREIGN KEY (transaction_id) REFERENCES transactions(transaction_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE clinical_services (
  service_id INTEGER PRIMARY KEY,
  store_id INTEGER NOT NULL,
  customer_id INTEGER NOT NULL,
  service_type VARCHAR(100) NOT NULL,
  service_date DATE NOT NULL,
  service_fee DECIMAL(10,2) NOT NULL,
  administered_by VARCHAR(100) NOT NULL,
  outcome_status VARCHAR(50) NOT NULL,
  FOREIGN KEY (store_id) REFERENCES stores(store_id),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
