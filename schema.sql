-- create DATABASE
CREATE DATABASE subcscription_app;
-- create tables subscriptions
CREATE TABLE subscriptions (
    id SERIAL PRIMARY KEY,
    title TEXT,
    price NUMERIC(8,2),
    recurring INTEGER,
    start_date DATE,
    cancel_date DATE,
    site_url TEXT
);
-- create tables subscriptions and users
CREATE TABLE users (
     id SERIAL PRIMARY KEY,
     user_name TEXT,
     email TEXT,
     password_digest TEXT
);

INSERT INTO subscriptions (title, price,recurring, start_date, cancel_date, site_url) VALUES ('Netflix2',14.50,1,'2019/12/20','2021/12/20','https://www.netflix.com/au/login');

INSERT INTO users (user_name, email, password_digest) VALUES ('Shailesh INSERT INTO users (user_name, email, password_digest) VALUES ('Shailesh Karki','karkishailesh@hotmail.com','p');Karki','karkishailesh@hotmail.com','p');

ALTER TABLE subscriptions ADD COLUMN user_id INTEGER;
UPDATE subscriptions SET user_id = 1;
