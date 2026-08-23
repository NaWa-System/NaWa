CREATE TABLE branches (
    branch_id INTEGER PRIMARY KEY,
    branch_name VARCHAR(100) NOT NULL,
    country VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL,
    branch_type VARCHAR(30) NOT NULL,
    opened_date DATE NOT NULL,
    employee_count INTEGER NOT NULL
);

CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    customer_type VARCHAR(20) NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    company_name VARCHAR(100),
    country VARCHAR(50) NOT NULL,
    segment VARCHAR(30) NOT NULL,
    onboarding_date DATE NOT NULL,
    primary_branch_id INTEGER NOT NULL,
    relationship_manager_id INTEGER,
    risk_rating VARCHAR(10) NOT NULL,
    FOREIGN KEY (primary_branch_id) REFERENCES branches(branch_id)
);

CREATE TABLE products (
    product_id INTEGER PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    product_category VARCHAR(50) NOT NULL,
    product_type VARCHAR(50) NOT NULL,
    interest_rate_base DECIMAL(5,3),
    fee_annual DECIMAL(10,2),
    is_active BOOLEAN NOT NULL
);

CREATE TABLE accounts (
    account_id INTEGER PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    account_number VARCHAR(30) NOT NULL,
    currency VARCHAR(3) NOT NULL,
    opened_date DATE NOT NULL,
    current_balance DECIMAL(15,2) NOT NULL,
    status VARCHAR(20) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE loans (
    loan_id INTEGER PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    loan_amount DECIMAL(15,2) NOT NULL,
    outstanding_balance DECIMAL(15,2) NOT NULL,
    interest_rate DECIMAL(5,3) NOT NULL,
    term_months INTEGER NOT NULL,
    disbursement_date DATE NOT NULL,
    maturity_date DATE NOT NULL,
    collateral_type VARCHAR(50),
    loan_status VARCHAR(20) NOT NULL,
    days_past_due INTEGER DEFAULT 0,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE transactions (
    transaction_id INTEGER PRIMARY KEY,
    account_id INTEGER NOT NULL,
    transaction_date DATE NOT NULL,
    transaction_type VARCHAR(30) NOT NULL,
    channel VARCHAR(30) NOT NULL,
    amount DECIMAL(15,2) NOT NULL,
    currency VARCHAR(3) NOT NULL,
    fee_amount DECIMAL(10,2) DEFAULT 0,
    status VARCHAR(20) NOT NULL,
    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

CREATE TABLE fee_income (
    fee_id INTEGER PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    fee_type VARCHAR(50) NOT NULL,
    fee_category VARCHAR(30) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    currency VARCHAR(3) NOT NULL,
    transaction_date DATE NOT NULL,
    related_product_id INTEGER,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (related_product_id) REFERENCES products(product_id)
);

CREATE TABLE loan_provisions (
    provision_id INTEGER PRIMARY KEY,
    loan_id INTEGER NOT NULL,
    provision_date DATE NOT NULL,
    provision_stage INTEGER NOT NULL,
    provision_amount DECIMAL(15,2) NOT NULL,
    provision_reason VARCHAR(100),
    FOREIGN KEY (loan_id) REFERENCES loans(loan_id)
);
