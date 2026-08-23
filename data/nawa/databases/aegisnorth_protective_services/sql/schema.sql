CREATE TABLE regions (
  region_id INTEGER PRIMARY KEY,
  region_name VARCHAR(50) NOT NULL
);

CREATE TABLE clients (
  client_id INTEGER PRIMARY KEY,
  client_name VARCHAR(120) NOT NULL,
  industry VARCHAR(60) NOT NULL,
  region_id INTEGER NOT NULL,
  start_date DATE NOT NULL,
  status VARCHAR(20) NOT NULL,
  FOREIGN KEY (region_id) REFERENCES regions(region_id)
);

CREATE TABLE sites (
  site_id INTEGER PRIMARY KEY,
  client_id INTEGER NOT NULL,
  site_name VARCHAR(120) NOT NULL,
  city VARCHAR(60) NOT NULL,
  state VARCHAR(20) NOT NULL,
  risk_level VARCHAR(10) NOT NULL,
  status VARCHAR(20) NOT NULL,
  FOREIGN KEY (client_id) REFERENCES clients(client_id)
);

CREATE TABLE officers (
  officer_id INTEGER PRIMARY KEY,
  full_name VARCHAR(120) NOT NULL,
  hire_date DATE NOT NULL,
  region_id INTEGER NOT NULL,
  employment_status VARCHAR(20) NOT NULL,
  hourly_cost DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (region_id) REFERENCES regions(region_id)
);

CREATE TABLE contracts (
  contract_id INTEGER PRIMARY KEY,
  client_id INTEGER NOT NULL,
  contract_type VARCHAR(30) NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE,
  billing_rate_hourly DECIMAL(10,2) NOT NULL,
  minimum_hours_per_month INTEGER NOT NULL,
  status VARCHAR(20) NOT NULL,
  FOREIGN KEY (client_id) REFERENCES clients(client_id)
);

CREATE TABLE shifts (
  shift_id INTEGER PRIMARY KEY,
  site_id INTEGER NOT NULL,
  officer_id INTEGER NOT NULL,
  contract_id INTEGER NOT NULL,
  shift_date DATE NOT NULL,
  hours_worked DECIMAL(5,2) NOT NULL,
  shift_type VARCHAR(20) NOT NULL,
  hourly_bill_rate DECIMAL(10,2) NOT NULL,
  status VARCHAR(20) NOT NULL,
  FOREIGN KEY (site_id) REFERENCES sites(site_id),
  FOREIGN KEY (officer_id) REFERENCES officers(officer_id),
  FOREIGN KEY (contract_id) REFERENCES contracts(contract_id)
);

CREATE TABLE incidents (
  incident_id INTEGER PRIMARY KEY,
  site_id INTEGER NOT NULL,
  incident_datetime TIMESTAMP NOT NULL,
  incident_type VARCHAR(30) NOT NULL,
  severity VARCHAR(10) NOT NULL,
  reported_by_officer_id INTEGER,
  resolved_flag CHAR(1) NOT NULL,
  resolution_notes VARCHAR(300),
  FOREIGN KEY (site_id) REFERENCES sites(site_id),
  FOREIGN KEY (reported_by_officer_id) REFERENCES officers(officer_id)
);
