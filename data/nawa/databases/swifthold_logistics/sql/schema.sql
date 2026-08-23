CREATE TABLE warehouses (
  warehouse_id INT PRIMARY KEY,
  warehouse_name VARCHAR(100) NOT NULL,
  city VARCHAR(100) NOT NULL,
  state CHAR(2) NOT NULL,
  total_pallet_capacity INT NOT NULL
);

CREATE TABLE clients (
  client_id INT PRIMARY KEY,
  client_name VARCHAR(150) NOT NULL,
  industry_segment VARCHAR(100),
  onboarded_date DATE NOT NULL,
  primary_warehouse_id INT NOT NULL,
  account_status VARCHAR(20) NOT NULL,
  FOREIGN KEY (primary_warehouse_id) REFERENCES warehouses(warehouse_id)
);

CREATE TABLE skus (
  sku_id INT PRIMARY KEY,
  client_id INT NOT NULL,
  sku_code VARCHAR(50) NOT NULL,
  description VARCHAR(200),
  unit_weight_lbs DECIMAL(6,2),
  storage_type VARCHAR(50),
  FOREIGN KEY (client_id) REFERENCES clients(client_id)
);

CREATE TABLE inventory_snapshots (
  snapshot_id INT PRIMARY KEY,
  sku_id INT NOT NULL,
  warehouse_id INT NOT NULL,
  snapshot_date DATE NOT NULL,
  units_on_hand INT NOT NULL,
  pallets_occupied DECIMAL(8,2) NOT NULL,
  FOREIGN KEY (sku_id) REFERENCES skus(sku_id),
  FOREIGN KEY (warehouse_id) REFERENCES warehouses(warehouse_id)
);

CREATE TABLE inbound_receipts (
  receipt_id INT PRIMARY KEY,
  client_id INT NOT NULL,
  warehouse_id INT NOT NULL,
  received_date DATE NOT NULL,
  units_received INT NOT NULL,
  pallets_received INT NOT NULL,
  receiving_fee DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (client_id) REFERENCES clients(client_id),
  FOREIGN KEY (warehouse_id) REFERENCES warehouses(warehouse_id)
);

CREATE TABLE outbound_shipments (
  shipment_id INT PRIMARY KEY,
  client_id INT NOT NULL,
  warehouse_id INT NOT NULL,
  ship_date DATE NOT NULL,
  orders_shipped INT NOT NULL,
  units_shipped INT NOT NULL,
  carrier VARCHAR(50),
  service_level VARCHAR(50),
  fulfillment_fee DECIMAL(10,2) NOT NULL,
  shipping_zone INT,
  FOREIGN KEY (client_id) REFERENCES clients(client_id),
  FOREIGN KEY (warehouse_id) REFERENCES warehouses(warehouse_id)
);

CREATE TABLE monthly_billing (
  billing_id INT PRIMARY KEY,
  client_id INT NOT NULL,
  billing_month DATE NOT NULL,
  storage_fee DECIMAL(10,2) NOT NULL,
  fulfillment_fee DECIMAL(10,2) NOT NULL,
  receiving_fee DECIMAL(10,2) NOT NULL,
  value_added_fee DECIMAL(10,2) NOT NULL,
  total_billed DECIMAL(10,2) NOT NULL,
  payment_status VARCHAR(20) NOT NULL,
  FOREIGN KEY (client_id) REFERENCES clients(client_id)
);

CREATE TABLE returns_processing (
  return_id INT PRIMARY KEY,
  client_id INT NOT NULL,
  warehouse_id INT NOT NULL,
  return_date DATE NOT NULL,
  units_returned INT NOT NULL,
  units_restocked INT NOT NULL,
  units_disposed INT NOT NULL,
  returns_fee DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (client_id) REFERENCES clients(client_id),
  FOREIGN KEY (warehouse_id) REFERENCES warehouses(warehouse_id)
);
