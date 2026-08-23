CREATE TABLE regions (
  region_id INTEGER PRIMARY KEY,
  region_name VARCHAR(100) NOT NULL,
  state_coverage VARCHAR(255)
);

CREATE TABLE customers (
  customer_id INTEGER PRIMARY KEY,
  company_name VARCHAR(150) NOT NULL,
  industry_segment VARCHAR(100),
  region_id INTEGER NOT NULL,
  account_type VARCHAR(50),
  onboarded_date DATE,
  FOREIGN KEY (region_id) REFERENCES regions(region_id)
);

CREATE TABLE drivers (
  driver_id INTEGER PRIMARY KEY,
  full_name VARCHAR(100) NOT NULL,
  license_class VARCHAR(20),
  region_id INTEGER NOT NULL,
  employment_type VARCHAR(50),
  hire_date DATE,
  status VARCHAR(30),
  FOREIGN KEY (region_id) REFERENCES regions(region_id)
);

CREATE TABLE vehicles (
  vehicle_id INTEGER PRIMARY KEY,
  plate_number VARCHAR(20) NOT NULL,
  vehicle_type VARCHAR(50),
  capacity_kg DECIMAL(8,2),
  region_id INTEGER NOT NULL,
  ownership_type VARCHAR(30),
  status VARCHAR(30),
  FOREIGN KEY (region_id) REFERENCES regions(region_id)
);

CREATE TABLE shipments (
  shipment_id INTEGER PRIMARY KEY,
  customer_id INTEGER NOT NULL,
  driver_id INTEGER,
  vehicle_id INTEGER,
  origin_city VARCHAR(100),
  destination_city VARCHAR(100),
  region_id INTEGER NOT NULL,
  service_type VARCHAR(50),
  scheduled_date DATE,
  delivered_date DATE,
  status VARCHAR(30),
  weight_kg DECIMAL(8,2),
  freight_charge DECIMAL(10,2),
  fuel_surcharge DECIMAL(10,2),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
  FOREIGN KEY (driver_id) REFERENCES drivers(driver_id),
  FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id),
  FOREIGN KEY (region_id) REFERENCES regions(region_id)
);

CREATE TABLE delivery_events (
  event_id INTEGER PRIMARY KEY,
  shipment_id INTEGER NOT NULL,
  event_type VARCHAR(50),
  event_timestamp TIMESTAMP,
  notes VARCHAR(255),
  FOREIGN KEY (shipment_id) REFERENCES shipments(shipment_id)
);

CREATE TABLE invoices (
  invoice_id INTEGER PRIMARY KEY,
  customer_id INTEGER NOT NULL,
  invoice_date DATE,
  due_date DATE,
  total_amount DECIMAL(10,2),
  paid_amount DECIMAL(10,2),
  status VARCHAR(30),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE invoice_shipments (
  id INTEGER PRIMARY KEY,
  invoice_id INTEGER NOT NULL,
  shipment_id INTEGER NOT NULL,
  FOREIGN KEY (invoice_id) REFERENCES invoices(invoice_id),
  FOREIGN KEY (shipment_id) REFERENCES shipments(shipment_id)
);
