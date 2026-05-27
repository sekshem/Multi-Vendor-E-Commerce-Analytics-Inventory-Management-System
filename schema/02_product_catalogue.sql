-- CATEGORIES TABLE
CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL,
    parent_category_id INT REFERENCES categories(category_id)
);

-- BRANDS TABLE
CREATE TABLE brands (
    brand_id SERIAL PRIMARY KEY,
    brand_name VARCHAR(100) UNIQUE NOT NULL,
    verified BOOLEAN DEFAULT FALSE
);

-- PRODUCTS TABLE
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    seller_id INT REFERENCES seller_profiles(seller_id),
    brand_id INT REFERENCES brands(brand_id),

    product_name VARCHAR(200) NOT NULL,
    sku VARCHAR(100) UNIQUE NOT NULL,
    slug VARCHAR(200) UNIQUE,
    description TEXT,

    base_price NUMERIC(10,2) NOT NULL CHECK(base_price > 0),

    status VARCHAR(20)
    CHECK(status IN ('active', 'inactive', 'out_of_stock')),

    average_rating NUMERIC(3,2) DEFAULT 0,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- PRODUCT CATEGORIES (MANY TO MANY)
CREATE TABLE product_categories (
    product_id INT REFERENCES products(product_id) ON DELETE CASCADE,
    category_id INT REFERENCES categories(category_id) ON DELETE CASCADE,

    PRIMARY KEY(product_id, category_id)
);

-- PRODUCT IMAGES
CREATE TABLE product_images (
    image_id SERIAL PRIMARY KEY,

    product_id INT REFERENCES products(product_id) ON DELETE CASCADE,

    image_url TEXT NOT NULL,

    sort_order INT DEFAULT 1
);