CREATE TABLE regions (
  region_id INTEGER PRIMARY KEY,
  region_name VARCHAR(50) NOT NULL
);

CREATE TABLE plans (
  plan_id INTEGER PRIMARY KEY,
  plan_name VARCHAR(50) NOT NULL,
  billing_cycle VARCHAR(20) NOT NULL,
  monthly_price_usd DECIMAL(10,2) NOT NULL
);

CREATE TABLE users (
  user_id INTEGER PRIMARY KEY,
  signup_date DATE NOT NULL,
  region_id INTEGER NOT NULL,
  acquisition_channel VARCHAR(40) NOT NULL,
  FOREIGN KEY (region_id) REFERENCES regions(region_id)
);

CREATE TABLE subscriptions (
  subscription_id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  plan_id INTEGER NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE,
  status VARCHAR(20) NOT NULL,
  cancel_reason VARCHAR(80),
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  FOREIGN KEY (plan_id) REFERENCES plans(plan_id)
);

CREATE TABLE invoices (
  invoice_id INTEGER PRIMARY KEY,
  subscription_id INTEGER NOT NULL,
  invoice_date DATE NOT NULL,
  period_start DATE NOT NULL,
  period_end DATE NOT NULL,
  amount_usd DECIMAL(10,2) NOT NULL,
  payment_status VARCHAR(20) NOT NULL,
  FOREIGN KEY (subscription_id) REFERENCES subscriptions(subscription_id)
);

CREATE TABLE artists (
  artist_id INTEGER PRIMARY KEY,
  artist_name VARCHAR(100) NOT NULL,
  label_type VARCHAR(30) NOT NULL
);

CREATE TABLE streams (
  stream_id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  artist_id INTEGER NOT NULL,
  stream_date DATE NOT NULL,
  minutes_listened INTEGER NOT NULL,
  device_type VARCHAR(20) NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  FOREIGN KEY (artist_id) REFERENCES artists(artist_id)
);

CREATE TABLE royalty_statements (
  statement_id INTEGER PRIMARY KEY,
  artist_id INTEGER NOT NULL,
  statement_month DATE NOT NULL,
  total_streams INTEGER NOT NULL,
  total_minutes INTEGER NOT NULL,
  rate_per_stream_usd DECIMAL(10,4) NOT NULL,
  royalty_amount_usd DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (artist_id) REFERENCES artists(artist_id)
);
