-- CART TABLE
CREATE TABLE cart (
    cart_id SERIAL PRIMARY KEY,

    user_id INT REFERENCES users(user_id) ON DELETE CASCADE,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    expires_at TIMESTAMP
);

-- CART ITEMS TABLE
CREATE TABLE cart_items (
    cart_item_id SERIAL PRIMARY KEY,

    cart_id INT REFERENCES cart(cart_id) ON DELETE CASCADE,

    product_id INT REFERENCES products(product_id),

    quantity INT NOT NULL CHECK(quantity > 0),

    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ORDERS TABLE
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,

    customer_id INT REFERENCES customer_profiles(customer_id),

    order_status VARCHAR(20)
    CHECK(order_status IN (
        'pending',
        'confirmed',
        'shipped',
        'delivered',
        'cancelled'
    )),

    total_amount NUMERIC(10,2) NOT NULL CHECK(total_amount >= 0),

    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    shipping_address_id INT REFERENCES addresses(address_id)
);

-- ORDER ITEMS TABLE
CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,

    order_id INT REFERENCES orders(order_id) ON DELETE CASCADE,

    product_id INT REFERENCES products(product_id),

    quantity INT NOT NULL CHECK(quantity > 0),

    unit_price NUMERIC(10,2) NOT NULL CHECK(unit_price > 0),

    subtotal NUMERIC(10,2)
);