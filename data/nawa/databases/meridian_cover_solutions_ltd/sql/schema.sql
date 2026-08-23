CREATE TABLE insurers (
  insurer_id INTEGER PRIMARY KEY,
  insurer_name VARCHAR(120) NOT NULL,
  panel_status VARCHAR(20) NOT NULL,
  commission_rate_pct DECIMAL(5,2) NOT NULL,
  speciality_line VARCHAR(80)
);

CREATE TABLE clients (
  client_id INTEGER PRIMARY KEY,
  company_name VARCHAR(150) NOT NULL,
  sector VARCHAR(80) NOT NULL,
  region VARCHAR(60) NOT NULL,
  account_manager_id INTEGER NOT NULL,
  client_since DATE NOT NULL,
  client_status VARCHAR(20) NOT NULL
);

CREATE TABLE account_managers (
  account_manager_id INTEGER PRIMARY KEY,
  full_name VARCHAR(100) NOT NULL,
  region VARCHAR(60) NOT NULL,
  team VARCHAR(60) NOT NULL
);

CREATE TABLE policies (
  policy_id INTEGER PRIMARY KEY,
  client_id INTEGER NOT NULL,
  insurer_id INTEGER NOT NULL,
  product_line VARCHAR(80) NOT NULL,
  inception_date DATE NOT NULL,
  expiry_date DATE NOT NULL,
  gross_written_premium DECIMAL(10,2) NOT NULL,
  arrangement_fee DECIMAL(8,2) NOT NULL DEFAULT 0.00,
  policy_status VARCHAR(30) NOT NULL,
  FOREIGN KEY (client_id) REFERENCES clients(client_id),
  FOREIGN KEY (insurer_id) REFERENCES insurers(insurer_id)
);

CREATE TABLE renewals (
  renewal_id INTEGER PRIMARY KEY,
  policy_id INTEGER NOT NULL,
  renewal_date DATE NOT NULL,
  prior_gwp DECIMAL(10,2) ,
  renewed_gwp DECIMAL(10,2),
  renewal_status VARCHAR(30) NOT NULL,
  retention_flag BOOLEAN NOT NULL DEFAULT FALSE,
  FOREIGN KEY (policy_id) REFERENCES policies(policy_id)
);

CREATE TABLE claims (
  claim_id INTEGER PRIMARY KEY,
  policy_id INTEGER NOT NULL,
  claim_date DATE NOT NULL,
  claim_type VARCHAR(80) NOT NULL,
  claimed_amount DECIMAL(10,2) NOT NULL,
  settled_amount DECIMAL(10,2),
  claim_status VARCHAR(30) NOT NULL,
  FOREIGN KEY (policy_id) REFERENCES policies(policy_id)
);

CREATE TABLE commission_ledger (
  ledger_id INTEGER PRIMARY KEY,
  policy_id INTEGER NOT NULL,
  ledger_date DATE NOT NULL,
  commission_type VARCHAR(40) NOT NULL,
  gross_written_premium DECIMAL(10,2) NOT NULL,
  commission_rate_pct DECIMAL(5,2) NOT NULL,
  commission_earned DECIMAL(10,2) NOT NULL,
  arrangement_fee DECIMAL(8,2) NOT NULL DEFAULT 0.00,
  total_income DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (policy_id) REFERENCES policies(policy_id)
);

CREATE TABLE client_contacts (
  contact_id INTEGER PRIMARY KEY,
  client_id INTEGER NOT NULL,
  contact_name VARCHAR(100) NOT NULL,
  contact_role VARCHAR(60) NOT NULL,
  email VARCHAR(150) NOT NULL,
  phone VARCHAR(30),
  is_primary BOOLEAN NOT NULL DEFAULT FALSE,
  FOREIGN KEY (client_id) REFERENCES clients(client_id)
);
