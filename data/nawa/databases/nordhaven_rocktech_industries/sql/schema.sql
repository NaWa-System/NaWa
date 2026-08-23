CREATE TABLE regions (
  region_id INTEGER PRIMARY KEY,
  region_name VARCHAR(50) NOT NULL
);

CREATE TABLE customers (
  customer_id INTEGER PRIMARY KEY,
  customer_name VARCHAR(120) NOT NULL,
  region_id INTEGER NOT NULL,
  customer_type VARCHAR(30) NOT NULL,
  account_status VARCHAR(20) NOT NULL,
  created_date DATE NOT NULL,
  FOREIGN KEY (region_id) REFERENCES regions(region_id)
);

CREATE TABLE products (
  product_id INTEGER PRIMARY KEY,
  sku VARCHAR(30) NOT NULL UNIQUE,
  product_name VARCHAR(120) NOT NULL,
  category VARCHAR(40) NOT NULL,
  material_grade VARCHAR(40) NOT NULL,
  standard_cost DECIMAL(12,2) NOT NULL,
  list_price DECIMAL(12,2) NOT NULL,
  active_flag CHAR(1) NOT NULL
);

CREATE TABLE manufacturing_batches (
  batch_id INTEGER PRIMARY KEY,
  product_id INTEGER NOT NULL,
  plant VARCHAR(60) NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE,
  units_produced INTEGER NOT NULL,
  units_scrapped INTEGER NOT NULL,
  qc_status VARCHAR(20) NOT NULL,
  unit_manufacturing_cost DECIMAL(12,2) NOT NULL,
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE sales_orders (
  order_id INTEGER PRIMARY KEY,
  order_number VARCHAR(30) NOT NULL UNIQUE,
  customer_id INTEGER NOT NULL,
  order_date DATE NOT NULL,
  requested_ship_date DATE,
  ship_date DATE,
  order_status VARCHAR(20) NOT NULL,
  channel VARCHAR(20) NOT NULL,
  currency VARCHAR(10) NOT NULL,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE sales_order_items (
  order_item_id INTEGER PRIMARY KEY,
  order_id INTEGER NOT NULL,
  product_id INTEGER NOT NULL,
  quantity INTEGER NOT NULL,
  unit_price DECIMAL(12,2) NOT NULL,
  discount_pct DECIMAL(5,2) NOT NULL,
  FOREIGN KEY (order_id) REFERENCES sales_orders(order_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE warranty_claims (
  claim_id INTEGER PRIMARY KEY,
  order_id INTEGER NOT NULL,
  product_id INTEGER NOT NULL,
  claim_date DATE NOT NULL,
  claim_status VARCHAR(20) NOT NULL,
  reason_code VARCHAR(40) NOT NULL,
  units_claimed INTEGER NOT NULL,
  credit_amount DECIMAL(12,2) NOT NULL,
  FOREIGN KEY (order_id) REFERENCES sales_orders(order_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

