-- WAREHOUSES TABLE
CREATE TABLE warehouses (
    warehouse_id SERIAL PRIMARY KEY,

    warehouse_name VARCHAR(150) NOT NULL,

    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100),

    storage_capacity INT CHECK(storage_capacity > 0)
);

-- INVENTORY TABLE
CREATE TABLE inventory (
    inventory_id SERIAL PRIMARY KEY,

    product_id INT REFERENCES products(product_id) ON DELETE CASCADE,

    warehouse_id INT REFERENCES warehouses(warehouse_id) ON DELETE CASCADE,

    quantity_available INT NOT NULL CHECK(quantity_available >= 0),

    reorder_threshold INT DEFAULT 10,

    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    UNIQUE(product_id, warehouse_id)
);

-- STOCK MOVEMENTS TABLE
CREATE TABLE stock_movements (
    movement_id SERIAL PRIMARY KEY,

    inventory_id INT REFERENCES inventory(inventory_id) ON DELETE CASCADE,

    movement_type VARCHAR(20)
    CHECK(movement_type IN (
        'stock_in',
        'stock_out',
        'damaged',
        'returned'
    )),

    quantity INT NOT NULL CHECK(quantity > 0),

    movement_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    remarks TEXT
);