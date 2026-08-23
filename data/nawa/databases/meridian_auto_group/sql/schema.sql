CREATE TABLE locations (
  location_id INTEGER PRIMARY KEY,
  location_name VARCHAR(100) NOT NULL,
  city VARCHAR(100) NOT NULL,
  state VARCHAR(50) NOT NULL,
  region VARCHAR(50) NOT NULL
);

CREATE TABLE vehicles (
  vehicle_id INTEGER PRIMARY KEY,
  make VARCHAR(50) NOT NULL,
  model VARCHAR(100) NOT NULL,
  year INTEGER NOT NULL,
  segment VARCHAR(50) NOT NULL,
  acquisition_cost NUMERIC(10,2) NOT NULL,
  reconditioning_cost NUMERIC(10,2) NOT NULL,
  list_price NUMERIC(10,2) NOT NULL,
  certified BOOLEAN NOT NULL DEFAULT FALSE,
  location_id INTEGER NOT NULL,
  FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

CREATE TABLE customers (
  customer_id INTEGER PRIMARY KEY,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  email VARCHAR(150) NOT NULL,
  phone VARCHAR(30),
  city VARCHAR(100),
  state VARCHAR(50),
  acquisition_channel VARCHAR(50) NOT NULL
);

CREATE TABLE sales (
  sale_id INTEGER PRIMARY KEY,
  vehicle_id INTEGER NOT NULL,
  customer_id INTEGER NOT NULL,
  location_id INTEGER NOT NULL,
  sale_date DATE NOT NULL,
  sale_price NUMERIC(10,2) NOT NULL,
  salesperson_name VARCHAR(100) NOT NULL,
  days_in_inventory INTEGER NOT NULL,
  FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
  FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

CREATE TABLE finance_products (
  finance_product_id INTEGER PRIMARY KEY,
  product_name VARCHAR(100) NOT NULL,
  product_type VARCHAR(50) NOT NULL,
  provider VARCHAR(100) NOT NULL
);

CREATE TABLE sale_finance (
  sale_finance_id INTEGER PRIMARY KEY,
  sale_id INTEGER NOT NULL,
  finance_product_id INTEGER NOT NULL,
  amount NUMERIC(10,2) NOT NULL,
  commission NUMERIC(10,2) NOT NULL,
  FOREIGN KEY (sale_id) REFERENCES sales(sale_id),
  FOREIGN KEY (finance_product_id) REFERENCES finance_products(finance_product_id)
);

CREATE TABLE trade_ins (
  trade_in_id INTEGER PRIMARY KEY,
  sale_id INTEGER NOT NULL,
  make VARCHAR(50) NOT NULL,
  model VARCHAR(100) NOT NULL,
  year INTEGER NOT NULL,
  mileage INTEGER NOT NULL,
  condition VARCHAR(20) NOT NULL,
  acquired_value NUMERIC(10,2) NOT NULL,
  FOREIGN KEY (sale_id) REFERENCES sales(sale_id)
);

CREATE TABLE inventory_snapshot (
  snapshot_id INTEGER PRIMARY KEY,
  snapshot_date DATE NOT NULL,
  location_id INTEGER NOT NULL,
  segment VARCHAR(50) NOT NULL,
  units_available INTEGER NOT NULL,
  avg_days_in_inventory NUMERIC(6,1) NOT NULL,
  FOREIGN KEY (location_id) REFERENCES locations(location_id)
);
