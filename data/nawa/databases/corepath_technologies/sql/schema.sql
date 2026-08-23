CREATE TABLE customers (
  customer_id INTEGER PRIMARY KEY,
  company_name VARCHAR(150) NOT NULL,
  industry_vertical VARCHAR(100),
  region VARCHAR(50),
  account_manager VARCHAR(100),
  customer_since DATE,
  tier VARCHAR(20)
);

CREATE TABLE products (
  product_id INTEGER PRIMARY KEY,
  product_name VARCHAR(150) NOT NULL,
  category VARCHAR(50) NOT NULL,
  unit_cost DECIMAL(10,2) NOT NULL,
  unit_price DECIMAL(10,2) NOT NULL,
  is_active INTEGER DEFAULT 1
);

CREATE TABLE service_plans (
  plan_id INTEGER PRIMARY KEY,
  plan_name VARCHAR(100) NOT NULL,
  plan_tier VARCHAR(30) NOT NULL,
  monthly_fee DECIMAL(10,2) NOT NULL,
  max_devices INTEGER,
  includes_mdm INTEGER DEFAULT 0,
  includes_applecare INTEGER DEFAULT 0
);

CREATE TABLE subscriptions (
  subscription_id INTEGER PRIMARY KEY,
  customer_id INTEGER NOT NULL,
  plan_id INTEGER NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE,
  status VARCHAR(20) NOT NULL,
  device_count INTEGER NOT NULL,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
  FOREIGN KEY (plan_id) REFERENCES service_plans(plan_id)
);

CREATE TABLE sales_orders (
  order_id INTEGER PRIMARY KEY,
  customer_id INTEGER NOT NULL,
  order_date DATE NOT NULL,
  status VARCHAR(30) NOT NULL,
  sales_rep VARCHAR(100),
  shipping_region VARCHAR(50),
  discount_pct DECIMAL(5,2) DEFAULT 0.00,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
  item_id INTEGER PRIMARY KEY,
  order_id INTEGER NOT NULL,
  product_id INTEGER NOT NULL,
  quantity INTEGER NOT NULL,
  unit_price DECIMAL(10,2) NOT NULL,
  unit_cost DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (order_id) REFERENCES sales_orders(order_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE support_tickets (
  ticket_id INTEGER PRIMARY KEY,
  customer_id INTEGER NOT NULL,
  subscription_id INTEGER,
  opened_date DATE NOT NULL,
  closed_date DATE,
  priority VARCHAR(20) NOT NULL,
  category VARCHAR(50) NOT NULL,
  status VARCHAR(20) NOT NULL,
  resolution_hours DECIMAL(6,2),
  assigned_agent VARCHAR(100),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
  FOREIGN KEY (subscription_id) REFERENCES subscriptions(subscription_id)
);

CREATE TABLE invoices (
  invoice_id INTEGER PRIMARY KEY,
  customer_id INTEGER NOT NULL,
  order_id INTEGER,
  subscription_id INTEGER,
  invoice_date DATE NOT NULL,
  due_date DATE NOT NULL,
  amount DECIMAL(10,2) NOT NULL,
  paid_date DATE,
  status VARCHAR(20) NOT NULL,
  invoice_type VARCHAR(30) NOT NULL,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
  FOREIGN KEY (order_id) REFERENCES sales_orders(order_id),
  FOREIGN KEY (subscription_id) REFERENCES subscriptions(subscription_id)
);
