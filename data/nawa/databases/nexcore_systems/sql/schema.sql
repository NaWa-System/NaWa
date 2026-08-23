CREATE TABLE categories (
  category_id INTEGER PRIMARY KEY,
  category_name VARCHAR(100) NOT NULL,
  parent_category_id INTEGER REFERENCES categories(category_id)
);

CREATE TABLE products (
  product_id INTEGER PRIMARY KEY,
  sku VARCHAR(50) NOT NULL UNIQUE,
  product_name VARCHAR(200) NOT NULL,
  category_id INTEGER NOT NULL REFERENCES categories(category_id),
  unit_cost DECIMAL(10,2) NOT NULL,
  unit_price DECIMAL(10,2) NOT NULL,
  stock_quantity INTEGER NOT NULL DEFAULT 0,
  is_active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE customers (
  customer_id INTEGER PRIMARY KEY,
  customer_name VARCHAR(150) NOT NULL,
  customer_type VARCHAR(20) NOT NULL CHECK (customer_type IN ('individual','business')),
  email VARCHAR(150) NOT NULL,
  region VARCHAR(50) NOT NULL,
  registered_date DATE NOT NULL
);

CREATE TABLE orders (
  order_id INTEGER PRIMARY KEY,
  customer_id INTEGER NOT NULL REFERENCES customers(customer_id),
  order_date DATE NOT NULL,
  channel VARCHAR(20) NOT NULL CHECK (channel IN ('online','in-store')),
  status VARCHAR(20) NOT NULL CHECK (status IN ('completed','pending','cancelled','returned')),
  shipping_cost DECIMAL(8,2) NOT NULL DEFAULT 0.00
);

CREATE TABLE order_items (
  item_id INTEGER PRIMARY KEY,
  order_id INTEGER NOT NULL REFERENCES orders(order_id),
  product_id INTEGER NOT NULL REFERENCES products(product_id),
  quantity INTEGER NOT NULL,
  unit_price DECIMAL(10,2) NOT NULL,
  discount_pct DECIMAL(5,2) NOT NULL DEFAULT 0.00
);

CREATE TABLE warranty_plans (
  plan_id INTEGER PRIMARY KEY,
  plan_name VARCHAR(100) NOT NULL,
  duration_months INTEGER NOT NULL,
  annual_fee DECIMAL(8,2) NOT NULL
);

CREATE TABLE warranty_subscriptions (
  subscription_id INTEGER PRIMARY KEY,
  customer_id INTEGER NOT NULL REFERENCES customers(customer_id),
  plan_id INTEGER NOT NULL REFERENCES warranty_plans(plan_id),
  product_id INTEGER NOT NULL REFERENCES products(product_id),
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  status VARCHAR(20) NOT NULL CHECK (status IN ('active','expired','cancelled'))
);
