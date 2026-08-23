CREATE TABLE stores (
  store_id INTEGER PRIMARY KEY,
  store_name VARCHAR(100) NOT NULL,
  region VARCHAR(50) NOT NULL,
  city VARCHAR(50) NOT NULL,
  opened_date DATE NOT NULL
);

CREATE TABLE product_categories (
  category_id INTEGER PRIMARY KEY,
  category_name VARCHAR(100) NOT NULL,
  department VARCHAR(50) NOT NULL
);

CREATE TABLE products (
  product_id INTEGER PRIMARY KEY,
  product_name VARCHAR(200) NOT NULL,
  category_id INTEGER NOT NULL REFERENCES product_categories(category_id),
  unit_cost DECIMAL(8,2) NOT NULL,
  unit_price DECIMAL(8,2) NOT NULL,
  is_private_label BOOLEAN NOT NULL DEFAULT FALSE,
  is_active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE members (
  member_id INTEGER PRIMARY KEY,
  member_name VARCHAR(150) NOT NULL,
  member_type VARCHAR(20) NOT NULL CHECK (member_type IN ('individual','household','business')),
  region VARCHAR(50) NOT NULL,
  joined_date DATE NOT NULL,
  is_active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE transactions (
  transaction_id INTEGER PRIMARY KEY,
  store_id INTEGER NOT NULL REFERENCES stores(store_id),
  member_id INTEGER REFERENCES members(member_id),
  transaction_date DATE NOT NULL,
  channel VARCHAR(20) NOT NULL CHECK (channel IN ('in-store','click-and-collect')),
  total_amount DECIMAL(10,2) NOT NULL
);

CREATE TABLE transaction_items (
  item_id INTEGER PRIMARY KEY,
  transaction_id INTEGER NOT NULL REFERENCES transactions(transaction_id),
  product_id INTEGER NOT NULL REFERENCES products(product_id),
  quantity INTEGER NOT NULL,
  unit_price DECIMAL(8,2) NOT NULL,
  discount_pct DECIMAL(5,2) NOT NULL DEFAULT 0.00
);

CREATE TABLE supplier_deliveries (
  delivery_id INTEGER PRIMARY KEY,
  store_id INTEGER NOT NULL REFERENCES stores(store_id),
  product_id INTEGER NOT NULL REFERENCES products(product_id),
  delivery_date DATE NOT NULL,
  quantity_delivered INTEGER NOT NULL,
  unit_cost DECIMAL(8,2) NOT NULL,
  supplier_name VARCHAR(150) NOT NULL
);
