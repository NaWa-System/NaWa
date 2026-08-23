CREATE TABLE plants (
  plant_id INTEGER PRIMARY KEY,
  plant_name VARCHAR(100) NOT NULL,
  country VARCHAR(50) NOT NULL,
  region VARCHAR(50) NOT NULL,
  process_route VARCHAR(50) NOT NULL
);

CREATE TABLE products (
  product_id INTEGER PRIMARY KEY,
  product_name VARCHAR(120) NOT NULL,
  product_category VARCHAR(40) NOT NULL,
  grade VARCHAR(40) NOT NULL,
  thickness_mm DECIMAL(6,2) NOT NULL,
  width_mm INTEGER NOT NULL
);

CREATE TABLE customers (
  customer_id INTEGER PRIMARY KEY,
  customer_name VARCHAR(140) NOT NULL,
  customer_segment VARCHAR(60) NOT NULL,
  country VARCHAR(50) NOT NULL,
  region VARCHAR(50) NOT NULL
);

CREATE TABLE production_batches (
  batch_id INTEGER PRIMARY KEY,
  plant_id INTEGER NOT NULL,
  product_id INTEGER NOT NULL,
  batch_date DATE NOT NULL,
  batch_status VARCHAR(20) NOT NULL,
  tons_produced DECIMAL(10,2) NOT NULL,
  tons_scrapped DECIMAL(10,2) NOT NULL,
  energy_mwh DECIMAL(12,2) NOT NULL,
  CONSTRAINT fk_batches_plant FOREIGN KEY (plant_id) REFERENCES plants(plant_id),
  CONSTRAINT fk_batches_product FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE sales_orders (
  order_id INTEGER PRIMARY KEY,
  customer_id INTEGER NOT NULL,
  order_date DATE NOT NULL,
  order_status VARCHAR(20) NOT NULL,
  incoterm VARCHAR(10) NOT NULL,
  currency VARCHAR(3) NOT NULL,
  CONSTRAINT fk_orders_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE sales_order_lines (
  order_line_id INTEGER PRIMARY KEY,
  order_id INTEGER NOT NULL,
  product_id INTEGER NOT NULL,
  ordered_tons DECIMAL(10,2) NOT NULL,
  unit_price_per_ton DECIMAL(12,2) NOT NULL,
  promised_ship_date DATE NOT NULL,
  CONSTRAINT fk_order_lines_order FOREIGN KEY (order_id) REFERENCES sales_orders(order_id),
  CONSTRAINT fk_order_lines_product FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE shipments (
  shipment_id INTEGER PRIMARY KEY,
  order_line_id INTEGER NOT NULL,
  plant_id INTEGER NOT NULL,
  ship_date DATE NOT NULL,
  delivered_date DATE,
  shipped_tons DECIMAL(10,2) NOT NULL,
  freight_cost DECIMAL(12,2) NOT NULL,
  delivery_status VARCHAR(20) NOT NULL,
  CONSTRAINT fk_shipments_order_line FOREIGN KEY (order_line_id) REFERENCES sales_order_lines(order_line_id),
  CONSTRAINT fk_shipments_plant FOREIGN KEY (plant_id) REFERENCES plants(plant_id)
);
