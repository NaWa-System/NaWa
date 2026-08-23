CREATE TABLE policy_types (
    policy_type_id INTEGER PRIMARY KEY,
    type_code VARCHAR(20) NOT NULL UNIQUE,
    type_name VARCHAR(100) NOT NULL,
    line_of_business VARCHAR(50) NOT NULL
);

CREATE TABLE agents (
    agent_id INTEGER PRIMARY KEY,
    agent_name VARCHAR(100) NOT NULL,
    channel VARCHAR(30) NOT NULL,
    region VARCHAR(50) NOT NULL,
    active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    state VARCHAR(2) NOT NULL,
    customer_since DATE NOT NULL,
    customer_segment VARCHAR(30) NOT NULL
);

CREATE TABLE policies (
    policy_id INTEGER PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    policy_type_id INTEGER NOT NULL,
    agent_id INTEGER NOT NULL,
    policy_number VARCHAR(30) NOT NULL UNIQUE,
    effective_date DATE NOT NULL,
    expiry_date DATE NOT NULL,
    annual_premium DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (policy_type_id) REFERENCES policy_types(policy_type_id),
    FOREIGN KEY (agent_id) REFERENCES agents(agent_id)
);

CREATE TABLE premiums_collected (
    payment_id INTEGER PRIMARY KEY,
    policy_id INTEGER NOT NULL,
    payment_date DATE NOT NULL,
    amount_paid DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(30) NOT NULL,
    FOREIGN KEY (policy_id) REFERENCES policies(policy_id)
);

CREATE TABLE claims (
    claim_id INTEGER PRIMARY KEY,
    policy_id INTEGER NOT NULL,
    claim_date DATE NOT NULL,
    incident_date DATE NOT NULL,
    claim_type VARCHAR(50) NOT NULL,
    claimed_amount DECIMAL(10,2) NOT NULL,
    approved_amount DECIMAL(10,2),
    status VARCHAR(20) NOT NULL,
    resolution_date DATE,
    FOREIGN KEY (policy_id) REFERENCES policies(policy_id)
);

CREATE TABLE renewals (
    renewal_id INTEGER PRIMARY KEY,
    policy_id INTEGER NOT NULL,
    renewal_offer_date DATE NOT NULL,
    renewal_decision VARCHAR(20) NOT NULL,
    new_premium DECIMAL(10,2),
    decision_date DATE,
    FOREIGN KEY (policy_id) REFERENCES policies(policy_id)
);
