CREATE TABLE regions (
  region_id INTEGER PRIMARY KEY,
  region_name VARCHAR(50) NOT NULL
);

CREATE TABLE customers (
  customer_id INTEGER PRIMARY KEY,
  customer_name VARCHAR(120) NOT NULL,
  customer_type VARCHAR(30) NOT NULL,
  region_id INTEGER NOT NULL,
  security_tier VARCHAR(20) NOT NULL,
  FOREIGN KEY (region_id) REFERENCES regions(region_id)
);

CREATE TABLE product_lines (
  product_line_id INTEGER PRIMARY KEY,
  product_line_name VARCHAR(80) NOT NULL,
  domain VARCHAR(40) NOT NULL
);

CREATE TABLE products (
  product_id INTEGER PRIMARY KEY,
  product_name VARCHAR(120) NOT NULL,
  product_line_id INTEGER NOT NULL,
  unit_of_measure VARCHAR(20) NOT NULL,
  is_software BOOLEAN NOT NULL,
  list_price DECIMAL(12,2) NOT NULL,
  standard_unit_cost DECIMAL(12,2) NOT NULL,
  FOREIGN KEY (product_line_id) REFERENCES product_lines(product_line_id)
);

CREATE TABLE contracts (
  contract_id INTEGER PRIMARY KEY,
  contract_code VARCHAR(30) NOT NULL UNIQUE,
  customer_id INTEGER NOT NULL,
  contract_type VARCHAR(30) NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  contract_value DECIMAL(14,2) NOT NULL,
  currency CHAR(3) NOT NULL,
  status VARCHAR(20) NOT NULL,
  region_id INTEGER NOT NULL,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
  FOREIGN KEY (region_id) REFERENCES regions(region_id)
);

CREATE TABLE deliveries (
  delivery_id INTEGER PRIMARY KEY,
  contract_id INTEGER NOT NULL,
  delivery_date DATE NOT NULL,
  delivery_status VARCHAR(20) NOT NULL,
  invoice_date DATE,
  invoice_status VARCHAR(20),
  total_amount DECIMAL(14,2) NOT NULL,
  FOREIGN KEY (contract_id) REFERENCES contracts(contract_id)
);

CREATE TABLE delivery_items (
  delivery_item_id INTEGER PRIMARY KEY,
  delivery_id INTEGER NOT NULL,
  product_id INTEGER NOT NULL,
  quantity INTEGER NOT NULL,
  unit_price DECIMAL(12,2) NOT NULL,
  unit_cost DECIMAL(12,2) NOT NULL,
  FOREIGN KEY (delivery_id) REFERENCES deliveries(delivery_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE service_tickets (
  ticket_id INTEGER PRIMARY KEY,
  contract_id INTEGER NOT NULL,
  opened_date DATE NOT NULL,
  closed_date DATE,
  priority VARCHAR(10) NOT NULL,
  category VARCHAR(40) NOT NULL,
  status VARCHAR(20) NOT NULL,
  resolution_code VARCHAR(40),
  labor_hours DECIMAL(8,2) NOT NULL,
  FOREIGN KEY (contract_id) REFERENCES contracts(contract_id)
);
