CREATE TABLE airlines (
  airline_id INTEGER PRIMARY KEY,
  airline_name VARCHAR(100) NOT NULL,
  iata_code CHAR(2) NOT NULL,
  country VARCHAR(60) NOT NULL,
  hub_airport VARCHAR(10) NOT NULL
);

CREATE TABLE airports (
  airport_id INTEGER PRIMARY KEY,
  iata_code CHAR(3) NOT NULL,
  airport_name VARCHAR(120) NOT NULL,
  city VARCHAR(80) NOT NULL,
  country VARCHAR(60) NOT NULL,
  region VARCHAR(60) NOT NULL
);

CREATE TABLE aircraft (
  aircraft_id INTEGER PRIMARY KEY,
  airline_id INTEGER NOT NULL,
  registration VARCHAR(20) NOT NULL,
  model VARCHAR(60) NOT NULL,
  seat_capacity INTEGER NOT NULL,
  aircraft_class VARCHAR(30) NOT NULL,
  FOREIGN KEY (airline_id) REFERENCES airlines(airline_id)
);

CREATE TABLE routes (
  route_id INTEGER PRIMARY KEY,
  airline_id INTEGER NOT NULL,
  origin_airport_id INTEGER NOT NULL,
  destination_airport_id INTEGER NOT NULL,
  distance_km INTEGER NOT NULL,
  route_type VARCHAR(20) NOT NULL,
  FOREIGN KEY (airline_id) REFERENCES airlines(airline_id),
  FOREIGN KEY (origin_airport_id) REFERENCES airports(airport_id),
  FOREIGN KEY (destination_airport_id) REFERENCES airports(airport_id)
);

CREATE TABLE flights (
  flight_id INTEGER PRIMARY KEY,
  route_id INTEGER NOT NULL,
  aircraft_id INTEGER NOT NULL,
  flight_number VARCHAR(10) NOT NULL,
  scheduled_departure DATETIME NOT NULL,
  actual_departure DATETIME,
  scheduled_arrival DATETIME NOT NULL,
  actual_arrival DATETIME,
  status VARCHAR(20) NOT NULL,
  delay_minutes INTEGER DEFAULT 0,
  FOREIGN KEY (route_id) REFERENCES routes(route_id),
  FOREIGN KEY (aircraft_id) REFERENCES aircraft(aircraft_id)
);

CREATE TABLE bookings (
  booking_id INTEGER PRIMARY KEY,
  flight_id INTEGER NOT NULL,
  booking_date DATE NOT NULL,
  passengers INTEGER NOT NULL,
  cabin_class VARCHAR(20) NOT NULL,
  fare_type VARCHAR(30) NOT NULL,
  total_fare DECIMAL(10,2) NOT NULL,
  ancillary_revenue DECIMAL(10,2) DEFAULT 0.00,
  FOREIGN KEY (flight_id) REFERENCES flights(flight_id)
);

CREATE TABLE flight_costs (
  cost_id INTEGER PRIMARY KEY,
  flight_id INTEGER NOT NULL,
  fuel_cost DECIMAL(10,2) NOT NULL,
  crew_cost DECIMAL(10,2) NOT NULL,
  airport_fees DECIMAL(10,2) NOT NULL,
  maintenance_cost DECIMAL(10,2) NOT NULL,
  other_cost DECIMAL(10,2) DEFAULT 0.00,
  FOREIGN KEY (flight_id) REFERENCES flights(flight_id)
);
