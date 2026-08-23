CREATE TABLE regions (
  region_id INTEGER PRIMARY KEY,
  region_name VARCHAR(50) NOT NULL,
  country_code CHAR(2) NOT NULL
);

CREATE TABLE customers (
  customer_id INTEGER PRIMARY KEY,
  email VARCHAR(120) NOT NULL UNIQUE,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  region_id INTEGER NOT NULL,
  created_at DATE NOT NULL,
  marketing_opt_in BOOLEAN NOT NULL,
  FOREIGN KEY (region_id) REFERENCES regions(region_id)
);

CREATE TABLE products (
  product_id INTEGER PRIMARY KEY,
  sku VARCHAR(30) NOT NULL UNIQUE,
  product_name VARCHAR(120) NOT NULL,
  category VARCHAR(60) NOT NULL,
  brand VARCHAR(60) NOT NULL,
  list_price DECIMAL(10,2) NOT NULL,
  unit_cost DECIMAL(10,2) NOT NULL,
  is_sustainable BOOLEAN NOT NULL
);

CREATE TABLE orders (
  order_id INTEGER PRIMARY KEY,
  customer_id INTEGER NOT NULL,
  order_date DATE NOT NULL,
  channel VARCHAR(20) NOT NULL,
  status VARCHAR(20) NOT NULL,
  shipping_fee DECIMAL(10,2) NOT NULL,
  discount_amount DECIMAL(10,2) NOT NULL,
  currency CHAR(3) NOT NULL,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
  order_item_id INTEGER PRIMARY KEY,
  order_id INTEGER NOT NULL,
  product_id INTEGER NOT NULL,
  quantity INTEGER NOT NULL,
  unit_price DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (order_id) REFERENCES orders(order_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE shipments (
  shipment_id INTEGER PRIMARY KEY,
  order_id INTEGER NOT NULL,
  warehouse_region_id INTEGER NOT NULL,
  carrier VARCHAR(40) NOT NULL,
  shipped_date DATE,
  delivered_date DATE,
  shipping_status VARCHAR(20) NOT NULL,
  FOREIGN KEY (order_id) REFERENCES orders(order_id),
  FOREIGN KEY (warehouse_region_id) REFERENCES regions(region_id)
);

CREATE TABLE returns (
  return_id INTEGER PRIMARY KEY,
  order_id INTEGER NOT NULL,
  product_id INTEGER NOT NULL,
  return_date DATE NOT NULL,
  quantity INTEGER NOT NULL,
  reason VARCHAR(40) NOT NULL,
  refund_amount DECIMAL(10,2) NOT NULL,
  status VARCHAR(20) NOT NULL,
  FOREIGN KEY (order_id) REFERENCES orders(order_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

