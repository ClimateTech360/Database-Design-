-- Create Database
CREATE DATABASE IF NOT EXISTS ShopTrend;
USE ShopTrend;

-- brand Table
CREATE TABLE brand (
    brand_id INT PRIMARY KEY AUTO_INCREMENT,
    brand_name VARCHAR(100) NOT NULL,
    description TEXT
);

-- product_category Table
CREATE TABLE product_category (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL,
    parent_category_id INT,
    FOREIGN KEY (parent_category_id) REFERENCES product_category(category_id)
);

-- product Table
CREATE TABLE product (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(200) NOT NULL,
    description TEXT,
    brand_id INT,
    category_id INT,
    FOREIGN KEY (brand_id) REFERENCES brand(brand_id),
    FOREIGN KEY (category_id) REFERENCES product_category(category_id)
);

--  color Table 
CREATE TABLE color (
    color_id INT PRIMARY KEY AUTO_INCREMENT,
    color_name VARCHAR(50) NOT NULL,
    hex_code VARCHAR(7)
);

-- size_category Table 
CREATE TABLE size_category (
    size_category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50) NOT NULL
);

-- size_option Table
CREATE TABLE size_option (
    size_option_id INT PRIMARY KEY AUTO_INCREMENT,
    size_category_id INT,
    size_value VARCHAR(20) NOT NULL,
    FOREIGN KEY (size_category_id) REFERENCES size_category(size_category_id)
);

-- product_item Table
CREATE TABLE product_item (
    product_item_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    sku VARCHAR(50) UNIQUE NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT NOT NULL,
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

-- product_variation Table
CREATE TABLE product_variation (
    variation_id INT PRIMARY KEY AUTO_INCREMENT,
    product_item_id INT,
    color_id INT,
    size_option_id INT,
    FOREIGN KEY (product_item_id) REFERENCES product_item(product_item_id),
    FOREIGN KEY (color_id) REFERENCES color(color_id),
    FOREIGN KEY (size_option_id) REFERENCES size_option(size_option_id)
);

-- product_image Table
CREATE TABLE product_image (
    image_id INT PRIMARY KEY AUTO_INCREMENT,
    product_item_id INT,
    image_url VARCHAR(255) NOT NULL,
    is_primary BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (product_item_id) REFERENCES product_item(product_item_id)
);

-- attribute_category Table
CREATE TABLE attribute_category (
    attribute_category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL
);

-- attribute_type Table
CREATE TABLE attribute_type (
    attribute_type_id INT PRIMARY KEY AUTO_INCREMENT,
    attribute_category_id INT,
    attribute_name VARCHAR(100) NOT NULL,
    FOREIGN KEY (attribute_category_id) REFERENCES attribute_category(attribute_category_id)
);

-- product_attribute Table
CREATE TABLE product_attribute (
    product_attribute_id INT PRIMARY KEY AUTO_INCREMENT,
    product_item_id INT,
    attribute_type_id INT,
    attribute_value VARCHAR(255) NOT NULL,
    FOREIGN KEY (product_item_id) REFERENCES product_item(product_item_id),
    FOREIGN KEY (attribute_type_id) REFERENCES attribute_type(attribute_type_id)
);

-- This section is for inserting data. This is just a Dummy Data

-- Brands
INSERT INTO brand (brand_name, description) VALUES
('Nike', 'Leading sportswear brand'),
('Adidas', 'Global athletic apparel company'),
('Zara', 'Fashion retail');

-- Product Categories
INSERT INTO product_category (category_name, parent_category_id) VALUES
('Clothing', NULL),
('Footwear', NULL),
('Mens Shirts', 1),
('Running Shoes', 2);

-- Products
INSERT INTO product (product_name, description, brand_id, category_id) VALUES
('Air Max 270', 'Comfortable running shoes', 1, 4),
('Cotton T-Shirt', 'Casual mens t-shirt', 3, 3),
('Ultraboost', 'High-performance running shoes', 2, 4);

-- Colors
INSERT INTO color (color_name, hex_code) VALUES
('Black', '#000000'),
('White', '#FFFFFF'),
('Blue', '#0000FF');

-- Size Categories
INSERT INTO size_category (category_name) VALUES
('Clothing'),
('Shoes');

-- Size Options
INSERT INTO size_option (size_category_id, size_value) VALUES
(1, 'M'),
(1, 'L'),
(2, '9'),
(2, '10');

-- Product Items
INSERT INTO product_item (product_id, sku, price, stock_quantity) VALUES
(1, 'NIKE-AM270-BLK-9', 129.99, 50),
(2, 'ZARA-TSH-WHT-M', 29.99, 100),
(3, 'ADI-UB-BLU-10', 149.99, 30);

-- Product Variations
INSERT INTO product_variation (product_item_id, color_id, size_option_id) VALUES
(1, 1, 3),
(2, 2, 1),
(3, 3, 4);

-- Product Images
INSERT INTO product_image (product_item_id, image_url, is_primary) VALUES
(1, 'https://example.com/images/am270-blk.jpg', TRUE),
(2, 'https://example.com/images/tshirt-wht.jpg', TRUE),
(3, 'https://example.com/images/ultraboost-blu.jpg', TRUE);

-- Attribute Categories
INSERT INTO attribute_category (category_name) VALUES
('Material'),
('Features');

-- Attribute Types
INSERT INTO attribute_type (attribute_category_id, attribute_name) VALUES
(1, 'Fabric'),
(1, 'Sole Material'),
(2, 'Technology');

-- Product Attributes
INSERT INTO product_attribute (product_item_id, attribute_type_id, attribute_value) VALUES
(1, 2, 'Rubber'),
(2, 1, '100% Cotton'),
(3, 3, 'Boost Cushioning');
