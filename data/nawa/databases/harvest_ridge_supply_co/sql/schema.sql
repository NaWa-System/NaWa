CREATE TABLE categories (
  category_id INTEGER PRIMARY KEY,
  category_name VARCHAR(100) NOT NULL,
  department VARCHAR(50) NOT NULL
);

CREATE TABLE suppliers (
  supplier_id INTEGER PRIMARY KEY,
  supplier_name VARCHAR(150) NOT NULL,
  contact_email VARCHAR(150),
  region VARCHAR(50),
  active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE products (
  product_id INTEGER PRIMARY KEY,
  product_name VARCHAR(150) NOT NULL,
  category_id INTEGER NOT NULL,
  supplier_id INTEGER NOT NULL,
  unit_cost NUMERIC(10,2) NOT NULL,
  unit_price NUMERIC(10,2) NOT NULL,
  reorder_level INTEGER NOT NULL DEFAULT 20,
  FOREIGN KEY (category_id) REFERENCES categories(category_id),
  FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

CREATE TABLE inventory (
  inventory_id INTEGER PRIMARY KEY,
  product_id INTEGER NOT NULL UNIQUE,
  quantity_on_hand INTEGER NOT NULL DEFAULT 0,
  last_restocked_date DATE,
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE customers (
  customer_id INTEGER PRIMARY KEY,
  customer_name VARCHAR(150) NOT NULL,
  customer_type VARCHAR(30) NOT NULL,
  email VARCHAR(150),
  state VARCHAR(5),
  created_date DATE NOT NULL
);

CREATE TABLE orders (
  order_id INTEGER PRIMARY KEY,
  customer_id INTEGER NOT NULL,
  order_date DATE NOT NULL,
  channel VARCHAR(20) NOT NULL,
  status VARCHAR(20) NOT NULL DEFAULT 'completed',
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
  order_item_id INTEGER PRIMARY KEY,
  order_id INTEGER NOT NULL,
  product_id INTEGER NOT NULL,
  quantity INTEGER NOT NULL,
  unit_price NUMERIC(10,2) NOT NULL,
  unit_cost NUMERIC(10,2) NOT NULL,
  FOREIGN KEY (order_id) REFERENCES orders(order_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE purchase_orders (
  po_id INTEGER PRIMARY KEY,
  supplier_id INTEGER NOT NULL,
  product_id INTEGER NOT NULL,
  order_date DATE NOT NULL,
  quantity_ordered INTEGER NOT NULL,
  unit_cost NUMERIC(10,2) NOT NULL,
  status VARCHAR(20) NOT NULL DEFAULT 'received',
  FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);
