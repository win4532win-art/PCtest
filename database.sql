CREATE DATABASE IF NOT EXISTS pctest CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE pctest;
CREATE TABLE IF NOT EXISTS users (
 id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(120) NOT NULL, email VARCHAR(190) NOT NULL UNIQUE,
 phone VARCHAR(30) DEFAULT NULL, password VARCHAR(255) NOT NULL,
 role ENUM('user','admin') NOT NULL DEFAULT 'user', address TEXT DEFAULT NULL,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS categories (
 id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(100) NOT NULL UNIQUE
);
CREATE TABLE IF NOT EXISTS products (
 id INT AUTO_INCREMENT PRIMARY KEY, category_id INT DEFAULT NULL, name VARCHAR(180) NOT NULL,
 description TEXT, price DECIMAL(10,2) NOT NULL DEFAULT 0, stock INT NOT NULL DEFAULT 0,
 image VARCHAR(255) DEFAULT NULL, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE SET NULL
);
CREATE TABLE IF NOT EXISTS cart_items (
 id INT AUTO_INCREMENT PRIMARY KEY, user_id INT NOT NULL, product_id INT NOT NULL,
 quantity INT NOT NULL DEFAULT 1, UNIQUE KEY user_product (user_id,product_id),
 FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
 FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS orders (
 id INT AUTO_INCREMENT PRIMARY KEY, user_id INT NOT NULL, total DECIMAL(10,2) NOT NULL,
 shipping_name VARCHAR(120) NOT NULL, shipping_phone VARCHAR(30) NOT NULL,
 shipping_address TEXT NOT NULL, payment_method VARCHAR(60) NOT NULL DEFAULT 'โอนเงิน',
 status ENUM('pending','paid','shipping','completed','cancelled') DEFAULT 'pending',
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY (user_id) REFERENCES users(id)
);
CREATE TABLE IF NOT EXISTS order_items (
 id INT AUTO_INCREMENT PRIMARY KEY, order_id INT NOT NULL, product_id INT DEFAULT NULL,
 product_name VARCHAR(180) NOT NULL, price DECIMAL(10,2) NOT NULL, quantity INT NOT NULL,
 FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
 FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE SET NULL
);
CREATE TABLE IF NOT EXISTS wishlist (
 id INT AUTO_INCREMENT PRIMARY KEY, user_id INT NOT NULL, product_id INT NOT NULL,
 UNIQUE KEY user_product (user_id,product_id),
 FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
 FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS activity_logs (
 id INT AUTO_INCREMENT PRIMARY KEY, user_id INT DEFAULT NULL, action VARCHAR(255) NOT NULL,
 details TEXT, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
);
INSERT IGNORE INTO categories(name) VALUES ('CPU'),('GPU'),('RAM'),('Mainboard'),('Storage'),('Power Supply'),('Case'),('Accessories');
-- Create an account through register.php, then grant admin privileges using:
-- UPDATE users SET role='admin' WHERE email='your-email@example.com';
