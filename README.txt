PCtest Store - PHP + MySQL starter
===================================
Requirements: PHP 8+ (PDO MySQL enabled), MySQL/MariaDB, Apache (XAMPP recommended)

INSTALL:
1. Copy folder PCtest into XAMPP htdocs (e.g. C:\xampp\htdocs\PCtest).
2. Open phpMyAdmin, import database.sql. It creates database pctest and tables.
3. Check config.php credentials (default XAMPP: root, blank password).
4. Visit http://localhost/PCtest/ and register an account.
5. In phpMyAdmin SQL tab run, replacing the email with your registered account:
   UPDATE users SET role='admin' WHERE email='your-email@example.com';
6. Log out and log in again. Admin link will show. Visit Admin > Products to add products.

FEATURES:
- User register/login with password_hash/password_verify
- User profile, cart, wishlist, order history and order details
- Checkout creates order/items, decrements inventory inside transaction
- Admin dashboard, product CRUD with image upload, orders/status, user list, activity log
- Orange/black responsive theme

NOTES:
- Demo checkout stores selected payment method but does not integrate a payment gateway.
- For production, configure HTTPS, mail/OTP, CSRF protection, stronger rate limiting,
  backups, and restrict uploads/permissions. Never use default database credentials publicly.
