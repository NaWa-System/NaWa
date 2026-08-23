CREATE TABLE regions (
  region_id INTEGER PRIMARY KEY,
  region_name VARCHAR(100) NOT NULL,
  country VARCHAR(100) NOT NULL
);

CREATE TABLE customers (
  customer_id INTEGER PRIMARY KEY,
  customer_name VARCHAR(200) NOT NULL,
  customer_type VARCHAR(50) NOT NULL,
  hq_region_id INTEGER NOT NULL,
  account_tier VARCHAR(20) NOT NULL,
  contract_start_date DATE NOT NULL,
  FOREIGN KEY (hq_region_id) REFERENCES regions(region_id)
);

CREATE TABLE product_catalog (
  product_id INTEGER PRIMARY KEY,
  product_name VARCHAR(200) NOT NULL,
  product_category VARCHAR(60) NOT NULL,
  unit_of_measure VARCHAR(30) NOT NULL,
  list_price_usd DECIMAL(12,2) NOT NULL
);

CREATE TABLE projects (
  project_id INTEGER PRIMARY KEY,
  customer_id INTEGER NOT NULL,
  region_id INTEGER NOT NULL,
  project_name VARCHAR(200) NOT NULL,
  start_date DATE NOT NULL,
  planned_end_date DATE NOT NULL,
  actual_end_date DATE,
  project_status VARCHAR(30) NOT NULL,
  contract_value_usd DECIMAL(14,2) NOT NULL,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
  FOREIGN KEY (region_id) REFERENCES regions(region_id)
);

CREATE TABLE work_orders (
  work_order_id INTEGER PRIMARY KEY,
  project_id INTEGER NOT NULL,
  work_order_date DATE NOT NULL,
  work_order_type VARCHAR(60) NOT NULL,
  status VARCHAR(30) NOT NULL,
  FOREIGN KEY (project_id) REFERENCES projects(project_id)
);

CREATE TABLE project_deliveries (
  delivery_id INTEGER PRIMARY KEY,
  project_id INTEGER NOT NULL,
  delivery_date DATE NOT NULL,
  product_id INTEGER NOT NULL,
  quantity INTEGER NOT NULL,
  unit_price_usd DECIMAL(12,2) NOT NULL,
  delivery_status VARCHAR(30) NOT NULL,
  FOREIGN KEY (project_id) REFERENCES projects(project_id),
  FOREIGN KEY (product_id) REFERENCES product_catalog(product_id)
);

CREATE TABLE project_milestones (
  milestone_id INTEGER PRIMARY KEY,
  project_id INTEGER NOT NULL,
  milestone_name VARCHAR(200) NOT NULL,
  due_date DATE NOT NULL,
  completion_date DATE,
  milestone_status VARCHAR(30) NOT NULL,
  invoice_amount_usd DECIMAL(14,2) NOT NULL,
  invoice_status VARCHAR(30) NOT NULL,
  FOREIGN KEY (project_id) REFERENCES projects(project_id)
);
