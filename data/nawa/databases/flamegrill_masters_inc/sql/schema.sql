CREATE TABLE locations (
  location_id INT PRIMARY KEY,
  location_name VARCHAR(100),
  region VARCHAR(50),
  open_date DATE
);

CREATE TABLE products (
  product_id INT PRIMARY KEY,
  product_name VARCHAR(100),
  category VARCHAR(50),
  unit_price DECIMAL(5,2)
);

CREATE TABLE orders (
  order_id INT PRIMARY KEY,
  location_id INT,
  order_timestamp DATETIME,
  total_amount DECIMAL(7,2),
  FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

CREATE TABLE order_items (
  item_id INT PRIMARY KEY,
  order_id INT,
  product_id INT,
  quantity INT,
  FOREIGN KEY (order_id) REFERENCES orders(order_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE employees (
  employee_id INT PRIMARY KEY,
  location_id INT,
  role VARCHAR(50),
  hire_date DATE,
  FOREIGN KEY (location_id) REFERENCES locations(location_id)
);
