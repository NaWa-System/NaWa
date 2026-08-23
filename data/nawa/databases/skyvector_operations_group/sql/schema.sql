CREATE TABLE airlines (
  airline_id INTEGER PRIMARY KEY,
  airline_code VARCHAR(10) NOT NULL,
  airline_name VARCHAR(100) NOT NULL,
  hub_airport VARCHAR(10) NOT NULL,
  fleet_size INTEGER NOT NULL,
  contract_start_date DATE NOT NULL,
  monthly_platform_fee DECIMAL(10,2) NOT NULL,
  per_flight_fee DECIMAL(6,2) NOT NULL
);

CREATE TABLE airports (
  airport_id INTEGER PRIMARY KEY,
  iata_code VARCHAR(5) NOT NULL,
  airport_name VARCHAR(120) NOT NULL,
  city VARCHAR(80) NOT NULL,
  country VARCHAR(60) NOT NULL,
  timezone VARCHAR(50) NOT NULL
);

CREATE TABLE aircraft (
  aircraft_id INTEGER PRIMARY KEY,
  airline_id INTEGER NOT NULL REFERENCES airlines(airline_id),
  tail_number VARCHAR(20) NOT NULL,
  aircraft_type VARCHAR(50) NOT NULL,
  seat_capacity INTEGER NOT NULL,
  status VARCHAR(20) NOT NULL
);

CREATE TABLE flights (
  flight_id INTEGER PRIMARY KEY,
  airline_id INTEGER NOT NULL REFERENCES airlines(airline_id),
  aircraft_id INTEGER NOT NULL REFERENCES aircraft(aircraft_id),
  flight_number VARCHAR(15) NOT NULL,
  origin_airport_id INTEGER NOT NULL REFERENCES airports(airport_id),
  destination_airport_id INTEGER NOT NULL REFERENCES airports(airport_id),
  scheduled_departure TIMESTAMP NOT NULL,
  actual_departure TIMESTAMP,
  scheduled_arrival TIMESTAMP NOT NULL,
  actual_arrival TIMESTAMP,
  flight_status VARCHAR(30) NOT NULL,
  delay_minutes INTEGER,
  delay_category VARCHAR(50),
  passengers_boarded INTEGER
);

CREATE TABLE crew_assignments (
  assignment_id INTEGER PRIMARY KEY,
  flight_id INTEGER NOT NULL REFERENCES flights(flight_id),
  crew_member_id INTEGER NOT NULL,
  crew_role VARCHAR(30) NOT NULL,
  duty_start TIMESTAMP NOT NULL,
  duty_end TIMESTAMP,
  assignment_status VARCHAR(20) NOT NULL
);

CREATE TABLE irregularity_events (
  event_id INTEGER PRIMARY KEY,
  flight_id INTEGER NOT NULL REFERENCES flights(flight_id),
  event_type VARCHAR(50) NOT NULL,
  event_description TEXT NOT NULL,
  reported_at TIMESTAMP NOT NULL,
  resolved_at TIMESTAMP,
  resolution_code VARCHAR(50),
  cost_impact DECIMAL(10,2)
);

CREATE TABLE billing_records (
  billing_id INTEGER PRIMARY KEY,
  airline_id INTEGER NOT NULL REFERENCES airlines(airline_id),
  billing_month DATE NOT NULL,
  platform_fee DECIMAL(10,2) NOT NULL,
  flights_dispatched INTEGER NOT NULL,
  per_flight_charges DECIMAL(10,2) NOT NULL,
  addon_charges DECIMAL(10,2) NOT NULL DEFAULT 0,
  total_billed DECIMAL(10,2) NOT NULL,
  payment_status VARCHAR(20) NOT NULL
);

