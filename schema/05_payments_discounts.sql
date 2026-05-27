-- PAYMENTS TABLE
CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,

    order_id INT REFERENCES orders(order_id) ON DELETE CASCADE,

    payment_method VARCHAR(30)
    CHECK(payment_method IN (
        'credit_card',
        'debit_card',
        'upi',
        'net_banking',
        'wallet',
        'cod'
    )),

    payment_status VARCHAR(20)
    CHECK(payment_status IN (
        'pending',
        'success',
        'failed',
        'refunded'
    )),

    amount NUMERIC(10,2) NOT NULL CHECK(amount >= 0),

    gateway_reference VARCHAR(200),

    paid_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- PAYMENT TRANSACTIONS TABLE
CREATE TABLE payment_transactions (
    transaction_id SERIAL PRIMARY KEY,

    payment_id INT REFERENCES payments(payment_id) ON DELETE CASCADE,

    transaction_status VARCHAR(20)
    CHECK(transaction_status IN (
        'initiated',
        'success',
        'failed'
    )),

    transaction_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    response_message TEXT
);

-- INVOICES TABLE
CREATE TABLE invoices (
    invoice_id SERIAL PRIMARY KEY,

    order_id INT UNIQUE REFERENCES orders(order_id) ON DELETE CASCADE,

    invoice_number VARCHAR(100) UNIQUE NOT NULL,

    invoice_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    total_amount NUMERIC(10,2) NOT NULL
);

-- COUPONS TABLE
CREATE TABLE coupons (
    coupon_id SERIAL PRIMARY KEY,

    coupon_code VARCHAR(50) UNIQUE NOT NULL,

    discount_type VARCHAR(20)
    CHECK(discount_type IN (
        'flat',
        'percentage'
    )),

    discount_value NUMERIC(10,2) NOT NULL,

    minimum_order_value NUMERIC(10,2) DEFAULT 0,

    max_uses INT DEFAULT 1,

    used_count INT DEFAULT 0,

    expiry_date DATE,

    is_active BOOLEAN DEFAULT TRUE
);

-- COUPON USAGE TABLE
CREATE TABLE coupon_usage (
    usage_id SERIAL PRIMARY KEY,

    coupon_id INT REFERENCES coupons(coupon_id) ON DELETE CASCADE,

    customer_id INT REFERENCES customer_profiles(customer_id),

    order_id INT REFERENCES orders(order_id),

    used_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);