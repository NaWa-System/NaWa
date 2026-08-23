CREATE TABLE customers (customer_id INT PRIMARY KEY, name VARCHAR(100), region VARCHAR(50), customer_type VARCHAR(50));

CREATE TABLE products (product_id INT PRIMARY KEY, product_name VARCHAR(100), category VARCHAR(50), unit_price DECIMAL(10,2));

CREATE TABLE orders (order_id INT PRIMARY KEY, customer_id INT, order_date DATE, status VARCHAR(50), FOREIGN KEY (customer_id) REFERENCES customers(customer_id));

CREATE TABLE order_items (order_item_id INT PRIMARY KEY, order_id INT, product_id INT, quantity INT, unit_price DECIMAL(10,2), FOREIGN KEY (order_id) REFERENCES orders(order_id), FOREIGN KEY (product_id) REFERENCES products(product_id));

CREATE TABLE suppliers (supplier_id INT PRIMARY KEY, name VARCHAR(100), country VARCHAR(50));

CREATE TABLE production_batches (batch_id INT PRIMARY KEY, product_id INT, supplier_id INT, production_date DATE, quantity_produced INT, cost_per_unit DECIMAL(10,2), FOREIGN KEY (product_id) REFERENCES products(product_id), FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id));

CREATE TABLE inventory (inventory_id INT PRIMARY KEY, product_id INT, quantity_available INT, last_updated DATE, FOREIGN KEY (product_id) REFERENCES products(product_id));
