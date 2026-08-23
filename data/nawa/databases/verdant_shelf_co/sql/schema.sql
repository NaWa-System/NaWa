CREATE TABLE customers (
  customer_id   INTEGER PRIMARY KEY,
  first_name    VARCHAR(50)  NOT NULL,
  last_name     VARCHAR(50)  NOT NULL,
  email         VARCHAR(100) NOT NULL UNIQUE,
  city          VARCHAR(50),
  state         VARCHAR(2),
  channel       VARCHAR(20)  NOT NULL,
  created_at    DATE         NOT NULL
);

CREATE TABLE categories (
  category_id   INTEGER PRIMARY KEY,
  category_name VARCHAR(50) NOT NULL
);

CREATE TABLE products (
  product_id    INTEGER PRIMARY KEY,
  product_name  VARCHAR(100) NOT NULL,
  category_id   INTEGER      NOT NULL REFERENCES categories(category_id),
  unit_cost     NUMERIC(8,2) NOT NULL,
  unit_price    NUMERIC(8,2) NOT NULL,
  is_active     BOOLEAN      NOT NULL DEFAULT TRUE
);

CREATE TABLE subscription_plans (
  plan_id       INTEGER PRIMARY KEY,
  plan_name     VARCHAR(50)  NOT NULL,
  monthly_price NUMERIC(8,2) NOT NULL,
  box_size      VARCHAR(20)  NOT NULL
);

CREATE TABLE subscriptions (
  subscription_id  INTEGER PRIMARY KEY,
  customer_id      INTEGER      NOT NULL REFERENCES customers(customer_id),
  plan_id          INTEGER      NOT NULL REFERENCES subscription_plans(plan_id),
  start_date       DATE         NOT NULL,
  end_date         DATE,
  status           VARCHAR(20)  NOT NULL
);

CREATE TABLE orders (
  order_id      INTEGER PRIMARY KEY,
  customer_id   INTEGER      NOT NULL REFERENCES customers(customer_id),
  order_date    DATE         NOT NULL,
  channel       VARCHAR(20)  NOT NULL,
  status        VARCHAR(20)  NOT NULL,
  discount_amt  NUMERIC(8,2) NOT NULL DEFAULT 0.00,
  shipping_cost NUMERIC(8,2) NOT NULL DEFAULT 0.00
);

CREATE TABLE order_items (
  item_id       INTEGER PRIMARY KEY,
  order_id      INTEGER      NOT NULL REFERENCES orders(order_id),
  product_id    INTEGER      NOT NULL REFERENCES products(product_id),
  quantity      INTEGER      NOT NULL,
  unit_price    NUMERIC(8,2) NOT NULL
);

CREATE TABLE events (
  event_id      INTEGER PRIMARY KEY,
  event_name    VARCHAR(100) NOT NULL,
  event_date    DATE         NOT NULL,
  capacity      INTEGER      NOT NULL,
  tickets_sold  INTEGER      NOT NULL,
  ticket_price  NUMERIC(8,2) NOT NULL
);
