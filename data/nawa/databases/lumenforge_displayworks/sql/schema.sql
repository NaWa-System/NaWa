CREATE TABLE regions (
  region_id INTEGER PRIMARY KEY,
  region_name VARCHAR(50) NOT NULL
);

CREATE TABLE channels (
  channel_id INTEGER PRIMARY KEY,
  channel_name VARCHAR(50) NOT NULL
);

CREATE TABLE customers (
  customer_id INTEGER PRIMARY KEY,
  customer_name VARCHAR(120) NOT NULL,
  customer_type VARCHAR(20) NOT NULL, -- 'Consumer' or 'Business'
  region_id INTEGER NOT NULL,
  channel_id INTEGER NOT NULL,
  created_date DATE NOT NULL,
  FOREIGN KEY (region_id) REFERENCES regions(region_id),
  FOREIGN KEY (channel_id) REFERENCES channels(channel_id)
);

CREATE TABLE products (
  product_id INTEGER PRIMARY KEY,
  sku VARCHAR(30) NOT NULL UNIQUE,
  model_name VARCHAR(80) NOT NULL,
  screen_size_in INTEGER NOT NULL,
  panel_type VARCHAR(30) NOT NULL, -- e.g., 'OLED', 'QLED', 'LED'
  series VARCHAR(30) NOT NULL,     -- e.g., 'Nova', 'Apex', 'Core'
  launch_date DATE NOT NULL,
  msrp DECIMAL(10,2) NOT NULL
);

CREATE TABLE orders (
  order_id INTEGER PRIMARY KEY,
  order_date DATE NOT NULL,
  customer_id INTEGER NOT NULL,
  channel_id INTEGER NOT NULL,
  region_id INTEGER NOT NULL,
  order_status VARCHAR(20) NOT NULL, -- 'Shipped','Delivered','Returned'
  shipped_date DATE,
  delivered_date DATE,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
  FOREIGN KEY (channel_id) REFERENCES channels(channel_id),
  FOREIGN KEY (region_id) REFERENCES regions(region_id)
);

CREATE TABLE order_items (
  order_item_id INTEGER PRIMARY KEY,
  order_id INTEGER NOT NULL,
  product_id INTEGER NOT NULL,
  quantity INTEGER NOT NULL,
  unit_price DECIMAL(10,2) NOT NULL,
  unit_cost DECIMAL(10,2) NOT NULL,
  warranty_years INTEGER NOT NULL DEFAULT 0,
  warranty_price DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  FOREIGN KEY (order_id) REFERENCES orders(order_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE returns (
  return_id INTEGER PRIMARY KEY,
  order_id INTEGER NOT NULL,
  product_id INTEGER NOT NULL,
  return_date DATE NOT NULL,
  return_reason VARCHAR(40) NOT NULL, -- 'DOA','PanelDefect','BuyerRemorse','ShippingDamage','Other'
  return_status VARCHAR(20) NOT NULL, -- 'Received','Refunded','Rejected'
  refund_amount DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (order_id) REFERENCES orders(order_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

