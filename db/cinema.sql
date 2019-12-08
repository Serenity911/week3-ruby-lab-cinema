DROP TABLE tickets;
DROP TABLE customers;
DROP TABLE films;

CREATE TABLE films (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255),
  price INT
);

CREATE TABLE customers (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  funds INT
);

CREATE TABLE tickets (
  id SERIAL PRIMARY KEY,
  film_id INT NOT NULL REFERENCES films(id) ON DELETE CASCADE,
  customer_id INT NOT NULL REFERENCES customers(id) ON DELETE CASCADE
);
