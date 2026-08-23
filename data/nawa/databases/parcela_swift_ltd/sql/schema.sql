CREATE TABLE regions (
  region_id INTEGER PRIMARY KEY,
  region_name VARCHAR(100) NOT NULL,
  country VARCHAR(50) NOT NULL
);

CREATE TABLE depots (
  depot_id INTEGER PRIMARY KEY,
  depot_name VARCHAR(150) NOT NULL,
  region_id INTEGER NOT NULL,
  address VARCHAR(255),
  FOREIGN KEY (region_id) REFERENCES regions(region_id)
);

CREATE TABLE customers (
  customer_id INTEGER PRIMARY KEY,
  customer_name VARCHAR(150) NOT NULL,
  customer_type VARCHAR(50) NOT NULL,
  account_manager VARCHAR(100),
  region_id INTEGER NOT NULL,
  contract_start_date DATE,
  FOREIGN KEY (region_id) REFERENCES regions(region_id)
);

CREATE TABLE service_types (
  service_id INTEGER PRIMARY KEY,
  service_name VARCHAR(100) NOT NULL,
  standard_days INTEGER NOT NULL,
  base_rate_gbp DECIMAL(8,2) NOT NULL
);

CREATE TABLE shipments (
  shipment_id INTEGER PRIMARY KEY,
  customer_id INTEGER NOT NULL,
  depot_id INTEGER NOT NULL,
  service_id INTEGER NOT NULL,
  shipment_date DATE NOT NULL,
  promised_delivery_date DATE NOT NULL,
  actual_delivery_date DATE,
  status VARCHAR(50) NOT NULL,
  weight_kg DECIMAL(6,2) NOT NULL,
  declared_value_gbp DECIMAL(10,2),
  revenue_gbp DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
  FOREIGN KEY (depot_id) REFERENCES depots(depot_id),
  FOREIGN KEY (service_id) REFERENCES service_types(service_id)
);

CREATE TABLE delivery_exceptions (
  exception_id INTEGER PRIMARY KEY,
  shipment_id INTEGER NOT NULL,
  exception_type VARCHAR(100) NOT NULL,
  exception_date DATE NOT NULL,
  resolved BOOLEAN NOT NULL DEFAULT FALSE,
  resolution_notes VARCHAR(255),
  FOREIGN KEY (shipment_id) REFERENCES shipments(shipment_id)
);

CREATE TABLE vehicles (
  vehicle_id INTEGER PRIMARY KEY,
  depot_id INTEGER NOT NULL,
  registration VARCHAR(20) NOT NULL,
  vehicle_type VARCHAR(50) NOT NULL,
  capacity_kg DECIMAL(8,2) NOT NULL,
  owned_or_contracted VARCHAR(20) NOT NULL,
  FOREIGN KEY (depot_id) REFERENCES depots(depot_id)
);

CREATE TABLE depot_performance (
  performance_id INTEGER PRIMARY KEY,
  depot_id INTEGER NOT NULL,
  report_month DATE NOT NULL,
  total_shipments INTEGER NOT NULL,
  on_time_deliveries INTEGER NOT NULL,
  failed_deliveries INTEGER NOT NULL,
  total_revenue_gbp DECIMAL(12,2) NOT NULL,
  operating_cost_gbp DECIMAL(12,2) NOT NULL,
  FOREIGN KEY (depot_id) REFERENCES depots(depot_id)
);
