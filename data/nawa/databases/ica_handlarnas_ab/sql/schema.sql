CREATE TABLE store_formats (
  format_id INTEGER PRIMARY KEY,
  format_name VARCHAR(50) NOT NULL,
  description VARCHAR(200)
);

CREATE TABLE stores (
  store_id INTEGER PRIMARY KEY,
  store_name VARCHAR(100) NOT NULL,
  format_id INTEGER NOT NULL,
  region VARCHAR(50) NOT NULL,
  city VARCHAR(50) NOT NULL,
  owner_name VARCHAR(100),
  opened_date DATE,
  FOREIGN KEY (format_id) REFERENCES store_formats(format_id)
);

CREATE TABLE product_categories (
  category_id INTEGER PRIMARY KEY,
  category_name VARCHAR(80) NOT NULL,
  is_private_label BOOLEAN DEFAULT FALSE
);

CREATE TABLE products (
  product_id INTEGER PRIMARY KEY,
  product_name VARCHAR(120) NOT NULL,
  category_id INTEGER NOT NULL,
  unit_cost DECIMAL(8,2) NOT NULL,
  unit_price DECIMAL(8,2) NOT NULL,
  supplier_name VARCHAR(100),
  FOREIGN KEY (category_id) REFERENCES product_categories(category_id)
);

CREATE TABLE wholesale_orders (
  order_id INTEGER PRIMARY KEY,
  store_id INTEGER NOT NULL,
  order_date DATE NOT NULL,
  delivery_date DATE,
  status VARCHAR(30) NOT NULL,
  total_amount DECIMAL(12,2) NOT NULL,
  FOREIGN KEY (store_id) REFERENCES stores(store_id)
);

CREATE TABLE wholesale_order_items (
  item_id INTEGER PRIMARY KEY,
  order_id INTEGER NOT NULL,
  product_id INTEGER NOT NULL,
  quantity INTEGER NOT NULL,
  unit_price DECIMAL(8,2) NOT NULL,
  FOREIGN KEY (order_id) REFERENCES wholesale_orders(order_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE loyalty_members (
  member_id INTEGER PRIMARY KEY,
  home_store_id INTEGER NOT NULL,
  joined_date DATE NOT NULL,
  tier VARCHAR(20) NOT NULL,
  total_points INTEGER DEFAULT 0,
  FOREIGN KEY (home_store_id) REFERENCES stores(store_id)
);

CREATE TABLE loyalty_transactions (
  transaction_id INTEGER PRIMARY KEY,
  member_id INTEGER NOT NULL,
  store_id INTEGER NOT NULL,
  transaction_date DATE NOT NULL,
  spend_amount DECIMAL(8,2) NOT NULL,
  points_earned INTEGER NOT NULL,
  FOREIGN KEY (member_id) REFERENCES loyalty_members(member_id),
  FOREIGN KEY (store_id) REFERENCES stores(store_id)
);
