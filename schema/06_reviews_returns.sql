-- REVIEWS TABLE
CREATE TABLE reviews (
    review_id SERIAL PRIMARY KEY,

    product_id INT REFERENCES products(product_id) ON DELETE CASCADE,

    customer_id INT REFERENCES customer_profiles(customer_id),

    review_title VARCHAR(200),

    review_body TEXT,

    verified_purchase BOOLEAN DEFAULT FALSE,

    helpful_votes INT DEFAULT 0,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- RATINGS TABLE
CREATE TABLE ratings (
    rating_id SERIAL PRIMARY KEY,

    product_id INT REFERENCES products(product_id) ON DELETE CASCADE,

    customer_id INT REFERENCES customer_profiles(customer_id),

    rating_value INT
    CHECK(rating_value BETWEEN 1 AND 5),

    moderation_status VARCHAR(20)
    CHECK(moderation_status IN (
        'pending',
        'approved',
        'rejected'
    )) DEFAULT 'pending',

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- RETURNS TABLE
CREATE TABLE returns (
    return_id SERIAL PRIMARY KEY,

    order_item_id INT REFERENCES order_items(order_item_id),

    return_reason TEXT,

    item_condition VARCHAR(50),

    return_status VARCHAR(20)
    CHECK(return_status IN (
        'requested',
        'approved',
        'rejected',
        'completed'
    )) DEFAULT 'requested',

    requested_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- REFUNDS TABLE
CREATE TABLE refunds (
    refund_id SERIAL PRIMARY KEY,

    return_id INT REFERENCES returns(return_id) ON DELETE CASCADE,

    payment_id INT REFERENCES payments(payment_id),

    refund_amount NUMERIC(10,2)
    CHECK(refund_amount >= 0),

    refund_method VARCHAR(30)
    CHECK(refund_method IN (
        'original_payment',
        'wallet',
        'bank_transfer'
    )),

    processed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);