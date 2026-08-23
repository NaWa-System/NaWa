CREATE TABLE regions (
  region_id INTEGER PRIMARY KEY,
  region_name VARCHAR(50) NOT NULL
);

CREATE TABLE customers (
  customer_id INTEGER PRIMARY KEY,
  customer_name VARCHAR(120) NOT NULL,
  industry VARCHAR(80) NOT NULL,
  region_id INTEGER NOT NULL,
  credit_terms VARCHAR(20) NOT NULL,
  FOREIGN KEY (region_id) REFERENCES regions(region_id)
);

CREATE TABLE vehicles (
  vehicle_id INTEGER PRIMARY KEY,
  vin VARCHAR(32) NOT NULL UNIQUE,
  make VARCHAR(40) NOT NULL,
  model VARCHAR(60) NOT NULL,
  model_year INTEGER NOT NULL,
  region_id INTEGER NOT NULL,
  purchase_date DATE NOT NULL,
  status VARCHAR(20) NOT NULL,
  FOREIGN KEY (region_id) REFERENCES regions(region_id)
);

CREATE TABLE drivers (
  driver_id INTEGER PRIMARY KEY,
  driver_name VARCHAR(120) NOT NULL,
  license_class VARCHAR(10) NOT NULL,
  region_id INTEGER NOT NULL,
  hire_date DATE NOT NULL,
  employment_status VARCHAR(20) NOT NULL,
  FOREIGN KEY (region_id) REFERENCES regions(region_id)
);

CREATE TABLE shipments (
  shipment_id INTEGER PRIMARY KEY,
  customer_id INTEGER NOT NULL,
  vehicle_id INTEGER NOT NULL,
  driver_id INTEGER NOT NULL,
  origin_city VARCHAR(80) NOT NULL,
  destination_city VARCHAR(80) NOT NULL,
  shipment_date DATE NOT NULL,
  scheduled_delivery_date DATE NOT NULL,
  actual_delivery_date DATE,
  status VARCHAR(20) NOT NULL,
  distance_miles INTEGER NOT NULL,
  weight_tons DECIMAL(6,2) NOT NULL,
  rate_type VARCHAR(20) NOT NULL,
  revenue DECIMAL(12,2) NOT NULL,
  fuel_cost DECIMAL(12,2) NOT NULL,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
  FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id),
  FOREIGN KEY (driver_id) REFERENCES drivers(driver_id)
);

CREATE TABLE parts (
  part_id INTEGER PRIMARY KEY,
  part_name VARCHAR(120) NOT NULL,
  part_category VARCHAR(60) NOT NULL,
  unit_cost DECIMAL(10,2) NOT NULL,
  unit_price DECIMAL(10,2) NOT NULL
);

CREATE TABLE maintenance_work_orders (
  work_order_id INTEGER PRIMARY KEY,
  vehicle_id INTEGER NOT NULL,
  work_order_date DATE NOT NULL,
  work_type VARCHAR(30) NOT NULL,
  odometer_miles INTEGER NOT NULL,
  labor_hours DECIMAL(6,2) NOT NULL,
  labor_rate DECIMAL(10,2) NOT NULL,
  parts_cost DECIMAL(12,2) NOT NULL,
  total_cost DECIMAL(12,2) NOT NULL,
  downtime_days DECIMAL(5,2) NOT NULL,
  status VARCHAR(20) NOT NULL,
  FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id)
);

CREATE TABLE maintenance_work_order_parts (
  work_order_id INTEGER NOT NULL,
  part_id INTEGER NOT NULL,
  quantity INTEGER NOT NULL,
  unit_price DECIMAL(10,2) NOT NULL,
  extended_price DECIMAL(12,2) NOT NULL,
  PRIMARY KEY (work_order_id, part_id),
  FOREIGN KEY (work_order_id) REFERENCES maintenance_work_orders(work_order_id),
  FOREIGN KEY (part_id) REFERENCES parts(part_id)
);

