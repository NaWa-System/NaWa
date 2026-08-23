CREATE TABLE clients (
  client_id INTEGER PRIMARY KEY,
  client_name VARCHAR(120) NOT NULL,
  industry VARCHAR(60) NOT NULL,
  region VARCHAR(60) NOT NULL,
  account_manager VARCHAR(80) NOT NULL,
  client_since DATE NOT NULL,
  status VARCHAR(20) NOT NULL
);

CREATE TABLE service_lines (
  service_line_id INTEGER PRIMARY KEY,
  service_line_name VARCHAR(80) NOT NULL,
  category VARCHAR(40) NOT NULL,
  standard_day_rate NUMERIC(10,2) NOT NULL
);

CREATE TABLE consultants (
  consultant_id INTEGER PRIMARY KEY,
  full_name VARCHAR(80) NOT NULL,
  role_title VARCHAR(60) NOT NULL,
  seniority VARCHAR(20) NOT NULL,
  service_line_id INTEGER NOT NULL,
  hourly_cost NUMERIC(10,2) NOT NULL,
  hire_date DATE NOT NULL,
  active BOOLEAN NOT NULL,
  FOREIGN KEY (service_line_id) REFERENCES service_lines(service_line_id)
);

CREATE TABLE projects (
  project_id INTEGER PRIMARY KEY,
  project_name VARCHAR(120) NOT NULL,
  client_id INTEGER NOT NULL,
  service_line_id INTEGER NOT NULL,
  engagement_type VARCHAR(30) NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE,
  status VARCHAR(20) NOT NULL,
  contracted_value NUMERIC(12,2) NOT NULL,
  FOREIGN KEY (client_id) REFERENCES clients(client_id),
  FOREIGN KEY (service_line_id) REFERENCES service_lines(service_line_id)
);

CREATE TABLE project_assignments (
  assignment_id INTEGER PRIMARY KEY,
  project_id INTEGER NOT NULL,
  consultant_id INTEGER NOT NULL,
  assigned_date DATE NOT NULL,
  role_on_project VARCHAR(60) NOT NULL,
  FOREIGN KEY (project_id) REFERENCES projects(project_id),
  FOREIGN KEY (consultant_id) REFERENCES consultants(consultant_id)
);

CREATE TABLE timesheets (
  timesheet_id INTEGER PRIMARY KEY,
  assignment_id INTEGER NOT NULL,
  week_ending DATE NOT NULL,
  billable_hours NUMERIC(6,2) NOT NULL,
  non_billable_hours NUMERIC(6,2) NOT NULL,
  FOREIGN KEY (assignment_id) REFERENCES project_assignments(assignment_id)
);

CREATE TABLE invoices (
  invoice_id INTEGER PRIMARY KEY,
  project_id INTEGER NOT NULL,
  invoice_date DATE NOT NULL,
  amount NUMERIC(12,2) NOT NULL,
  status VARCHAR(20) NOT NULL,
  due_date DATE NOT NULL,
  paid_date DATE,
  FOREIGN KEY (project_id) REFERENCES projects(project_id)
);

CREATE TABLE managed_service_retainers (
  retainer_id INTEGER PRIMARY KEY,
  client_id INTEGER NOT NULL,
  service_line_id INTEGER NOT NULL,
  monthly_fee NUMERIC(10,2) NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE,
  status VARCHAR(20) NOT NULL,
  FOREIGN KEY (client_id) REFERENCES clients(client_id),
  FOREIGN KEY (service_line_id) REFERENCES service_lines(service_line_id)
);
