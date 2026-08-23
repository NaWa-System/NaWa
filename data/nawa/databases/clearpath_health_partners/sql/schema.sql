CREATE TABLE clinics (
  clinic_id INTEGER PRIMARY KEY,
  clinic_name VARCHAR(100) NOT NULL,
  city VARCHAR(100) NOT NULL,
  state VARCHAR(50) NOT NULL,
  region VARCHAR(50) NOT NULL
);

CREATE TABLE clinicians (
  clinician_id INTEGER PRIMARY KEY,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  specialty VARCHAR(100) NOT NULL,
  clinic_id INTEGER NOT NULL,
  employment_type VARCHAR(50) NOT NULL,
  FOREIGN KEY (clinic_id) REFERENCES clinics(clinic_id)
);

CREATE TABLE patients (
  patient_id INTEGER PRIMARY KEY,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  date_of_birth DATE NOT NULL,
  gender VARCHAR(20) NOT NULL,
  payer_type VARCHAR(50) NOT NULL,
  zip_code VARCHAR(20) NOT NULL,
  registration_date DATE NOT NULL
);

CREATE TABLE service_types (
  service_type_id INTEGER PRIMARY KEY,
  service_name VARCHAR(150) NOT NULL,
  category VARCHAR(100) NOT NULL,
  standard_fee DECIMAL(10,2) NOT NULL
);

CREATE TABLE appointments (
  appointment_id INTEGER PRIMARY KEY,
  patient_id INTEGER NOT NULL,
  clinician_id INTEGER NOT NULL,
  clinic_id INTEGER NOT NULL,
  appointment_date DATE NOT NULL,
  appointment_status VARCHAR(50) NOT NULL,
  service_type_id INTEGER NOT NULL,
  FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
  FOREIGN KEY (clinician_id) REFERENCES clinicians(clinician_id),
  FOREIGN KEY (clinic_id) REFERENCES clinics(clinic_id),
  FOREIGN KEY (service_type_id) REFERENCES service_types(service_type_id)
);

CREATE TABLE billing_records (
  billing_id INTEGER PRIMARY KEY,
  appointment_id INTEGER NOT NULL,
  billed_amount DECIMAL(10,2) NOT NULL,
  payer_type VARCHAR(50) NOT NULL,
  payment_status VARCHAR(50) NOT NULL,
  amount_paid DECIMAL(10,2) NOT NULL,
  billing_date DATE NOT NULL,
  FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id)
);

CREATE TABLE patient_outcomes (
  outcome_id INTEGER PRIMARY KEY,
  appointment_id INTEGER NOT NULL,
  diagnosis_code VARCHAR(20) NOT NULL,
  diagnosis_description VARCHAR(200) NOT NULL,
  outcome_status VARCHAR(50) NOT NULL,
  follow_up_required BOOLEAN NOT NULL,
  FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id)
);
