CREATE TABLE regions (
  region_id INTEGER PRIMARY KEY,
  region_name VARCHAR(50) NOT NULL
);

CREATE TABLE channels (
  channel_id INTEGER PRIMARY KEY,
  channel_name VARCHAR(50) NOT NULL
);

CREATE TABLE products (
  product_id INTEGER PRIMARY KEY,
  sku VARCHAR(30) NOT NULL UNIQUE,
  product_name VARCHAR(120) NOT NULL,
  category VARCHAR(60) NOT NULL,
  unit_cost DECIMAL(10,2) NOT NULL,
  list_price DECIMAL(10,2) NOT NULL,
  is_active BOOLEAN NOT NULL
);

CREATE TABLE customers (
  customer_id INTEGER PRIMARY KEY,
  customer_name VARCHAR(120) NOT NULL,
  customer_type VARCHAR(30) NOT NULL,  -- 'Consumer' | 'Retailer' | 'Installer'
  region_id INTEGER NOT NULL,
  created_date DATE NOT NULL,
  CONSTRAINT fk_customers_region
    FOREIGN KEY (region_id) REFERENCES regions(region_id)
);

CREATE TABLE orders (
  order_id INTEGER PRIMARY KEY,
  order_date DATE NOT NULL,
  customer_id INTEGER NOT NULL,
  channel_id INTEGER NOT NULL,
  order_status VARCHAR(20) NOT NULL, -- 'Booked' | 'Shipped' | 'Delivered' | 'Cancelled'
  ship_date DATE,
  delivery_date DATE,
  region_id INTEGER NOT NULL,
  CONSTRAINT fk_orders_customer
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
  CONSTRAINT fk_orders_channel
    FOREIGN KEY (channel_id) REFERENCES channels(channel_id),
  CONSTRAINT fk_orders_region
    FOREIGN KEY (region_id) REFERENCES regions(region_id)
);

CREATE TABLE order_items (
  order_item_id INTEGER PRIMARY KEY,
  order_id INTEGER NOT NULL,
  product_id INTEGER NOT NULL,
  quantity INTEGER NOT NULL,
  unit_price DECIMAL(10,2) NOT NULL,
  discount_pct DECIMAL(5,2) NOT NULL, -- 0.00 to 100.00
  CONSTRAINT fk_items_order
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
  CONSTRAINT fk_items_product
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE service_tickets (
  ticket_id INTEGER PRIMARY KEY,
  ticket_date DATE NOT NULL,
  order_id INTEGER,
  product_id INTEGER NOT NULL,
  region_id INTEGER NOT NULL,
  issue_category VARCHAR(60) NOT NULL, -- e.g., 'Cooling', 'Noise', 'Leak', 'Electronics'
  severity VARCHAR(10) NOT NULL,       -- 'Low' | 'Med' | 'High'
  status VARCHAR(20) NOT NULL,         -- 'Open' | 'Resolved' | 'Closed'
  resolution_days INTEGER,
  warranty_covered BOOLEAN NOT NULL,
  parts_cost DECIMAL(10,2) NOT NULL,
  labor_cost DECIMAL(10,2) NOT NULL,
  CONSTRAINT fk_tickets_order
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
  CONSTRAINT fk_tickets_product
    FOREIGN KEY (product_id) REFERENCES products(product_id),
  CONSTRAINT fk_tickets_region
    FOREIGN KEY (region_id) REFERENCES regions(region_id)
);

