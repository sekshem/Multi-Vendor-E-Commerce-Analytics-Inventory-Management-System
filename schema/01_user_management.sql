CREATE TABLE users ( 
    user_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    role VARCHAR(20) CHECK(role IN ('customer', 'seller', 'admin')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE seller_profiles (
    customer_id SERIAL PRIMARY KEY,
    user_id INT UNIQUE REFERENCES users(user_id),
    loyality_points INT DEFAULT 0,
    date_of_birth DATE
);

CREATE TABLE seller_profiles (
    seller_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id),
    address_line TEXT NOT NULL,
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100),
    postal_code VARCHAR(20)
);