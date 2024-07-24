CREATE DATABASE shopapp;
USE shopapp;
CREATE TABLE users(
    id INT PRIMARY KEY AUTO_INCREMENT,
    fullname VARCHAR(100) DEFAULT '',
    phone_number VARCHAR(10) NOT NULL,
    address VARCHAR(200) DEFAULT '',
    password VARCHAR(100) NOT NULL DEFAULT '',
    created_at DATETIME,
    update_at DATETIME,
    is_active TINYINT DEFAULT 1,
    date_of_birth DATE,
    facebook_account_id INT DEFAULT 0,
    google_account_id INT DEFAULT 0
);
ALTER TABLE users ADD COLUMN retype_password VARCHAR(100);

CREATE TABLE roles(
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(20) NOT NULL
);
ALTER TABLE users ADD COLUMN role_id INT;
ALTER TABLE users ADD FOREIGN KEY (role_id) REFERENCES roles (id);
CREATE TABLE tokens(
    id INT PRIMARY KEY AUTO_INCREMENT,
    token VARCHAR(255) UNIQUE NOT NULL,
    token_tyoe VARCHAR(50) NOT NULL,
    expiration_date DATETIME,
    revoked TINYINT NOT NULL,
    expired TINYINT NOT NULL,
    user_id INT,
    FOREIGN KEY(user_id) REFERENCES users(id)
);
CREATE TABLE social_accounts(
    id INT PRIMARY KEY AUTO_INCREMENT,
    provider VARCHAR(20) NOT NULL COMMENT 'Tên nhà social network',
    provider_id VARCHAR(50) NOT NULL,
    email VARCHAR(150) NOT NULL COMMENT 'Email tài khoản',
    name VARCHAR(100) NOT NULL COMMENT 'Tên người dùng',
    user_id INT,
    FOREIGN KEY(user_id) REFERENCES users(id)

);
CREATE TABLE categories(
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL DEFAULT '' COMMENT 'Tên danh mục, đồ điện tử'
);

CREATE TABLE products(
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) COMMENT 'Tên sản phẩm',
    price FLOAT NOT NULL CHECK(price>=0),
    thumbnail VARCHAR(MAX) DEFAULT '',
    description LONGTEXT DEFAULT '',
    created_at DATETIME,
    update_at DATETIME,
    category_id INT, 
    FOREIGN KEY(category_id) REFERENCES categories(id)
);

CREATE TABLE product_images(
    id INT PRIMARY KEY AUTO_INCREMENT;
    product_id INT,
    FOREIGN KEY(product_id) REFERENCES products(id),
    CONSTRAINT fk_product_images_product_id
        FOREIGN KEY (product_id) REFERENCES products (id) ON DELETE CASCADE,
    image_url VARCHAR(300)
);

CREATE TABLE orders(
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    FOREIGN KEY(user_id) REFERENCES users(id)
    fullname VARCHAR(100) DEFAULT '',
    email VARCHAR(100) DEFAULT '',
    phone_number VARCHAR(20) NOT NULL,
    address VARCHAR(200) NOT  NULL,
    note VARCHAR(100) DEFAULT '',
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20),
    total_money FLOAT CHECK(total_money>=0),
);
ALTER TABLE orders ADD COLUMN shipping_method VARCHAR(200);
ALTER TABLE orders ADD COLUMN shipping_address VARCHAR(200);
ALTER TABLE orders ADD COLUMN shipping_date DATE;
ALTER TABLE orders ADD COLUMN tracking_number VARCHAR(100);
ALTER TABLE orders ADD COLUMN payment_method VARCHAR(100);

--xóa 1 đơn hàng=> xóa mềm => thêm trường active
ALTER TABLE orders ADD COLUMN active TINYINT(1);
--Trạng thái đơn hàng chỉ được phép một giá trị cụ thể
ALTER TABLE orders
MODIFY COLUMN status ENUM('pending', 'processing', 'shipped','delivered','cancelled')
COMMENT 'Trạng thái đơn hàng';

CREATE TABLE order_detail(
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    FOREIGN KEY(order_id) REFERENCES orders(id),
    product_id INT,
    FOREIGN KEY(product_id) REFERENCES products(id),
    price FLOAT CHECK(price>=0),
    number_of_product INT CHECK(number_of_product>0),
    total_money FLOAT CHECK(total_money>=0),
    color VARCHAR(20) DEFAULT ''
);
 