CREATE TABLE branches (
  branch_id INTEGER PRIMARY KEY,
  branch_name VARCHAR(100) NOT NULL,
  city VARCHAR(100) NOT NULL,
  state VARCHAR(50) NOT NULL,
  is_airport_location BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE vehicle_categories (
  category_id INTEGER PRIMARY KEY,
  category_name VARCHAR(50) NOT NULL,
  daily_base_rate DECIMAL(8,2) NOT NULL
);

CREATE TABLE vehicles (
  vehicle_id INTEGER PRIMARY KEY,
  branch_id INTEGER NOT NULL,
  category_id INTEGER NOT NULL,
  make VARCHAR(50) NOT NULL,
  model VARCHAR(50) NOT NULL,
  year INTEGER NOT NULL,
  license_plate VARCHAR(20) NOT NULL UNIQUE,
  status VARCHAR(20) NOT NULL DEFAULT 'available',
  FOREIGN KEY (branch_id) REFERENCES branches(branch_id),
  FOREIGN KEY (category_id) REFERENCES vehicle_categories(category_id)
);

CREATE TABLE customers (
  customer_id INTEGER PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  phone VARCHAR(20),
  customer_type VARCHAR(20) NOT NULL DEFAULT 'leisure',
  loyalty_tier VARCHAR(20) NOT NULL DEFAULT 'standard',
  registration_date DATE NOT NULL
);

CREATE TABLE rentals (
  rental_id INTEGER PRIMARY KEY,
  customer_id INTEGER NOT NULL,
  vehicle_id INTEGER NOT NULL,
  branch_id INTEGER NOT NULL,
  pickup_date DATE NOT NULL,
  return_date DATE NOT NULL,
  actual_return_date DATE,
  rental_days INTEGER NOT NULL,
  daily_rate DECIMAL(8,2) NOT NULL,
  base_rental_amount DECIMAL(10,2) NOT NULL,
  status VARCHAR(20) NOT NULL DEFAULT 'active',
  booking_channel VARCHAR(30) NOT NULL DEFAULT 'online',
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
  FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id),
  FOREIGN KEY (branch_id) REFERENCES branches(branch_id)
);

CREATE TABLE ancillary_charges (
  charge_id INTEGER PRIMARY KEY,
  rental_id INTEGER NOT NULL,
  charge_type VARCHAR(50) NOT NULL,
  charge_amount DECIMAL(8,2) NOT NULL,
  FOREIGN KEY (rental_id) REFERENCES rentals(rental_id)
);

CREATE TABLE payments (
  payment_id INTEGER PRIMARY KEY,
  rental_id INTEGER NOT NULL,
  payment_date DATE NOT NULL,
  total_amount DECIMAL(10,2) NOT NULL,
  payment_method VARCHAR(30) NOT NULL,
  payment_status VARCHAR(20) NOT NULL DEFAULT 'completed',
  FOREIGN KEY (rental_id) REFERENCES rentals(rental_id)
);

CREATE TABLE fleet_maintenance (
  maintenance_id INTEGER PRIMARY KEY,
  vehicle_id INTEGER NOT NULL,
  maintenance_date DATE NOT NULL,
  maintenance_type VARCHAR(50) NOT NULL,
  cost DECIMAL(8,2) NOT NULL,
  days_out_of_service INTEGER NOT NULL DEFAULT 1,
  FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id)
);
