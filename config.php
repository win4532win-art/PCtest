<?php
// PCtest configuration - update these credentials for your local MySQL server.
$dbHost = 'localhost';
$dbName = 'pctest';
$dbUser = 'root';
$dbPass = '';

try {
    $pdo = new PDO("mysql:host=$dbHost;dbname=$dbName;charset=utf8mb4", $dbUser, $dbPass, [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    ]);
} catch (PDOException $e) {
    http_response_code(500);
    exit('Database connection failed. Import database.sql and check config.php.');
}
if (session_status() === PHP_SESSION_NONE) session_start();

function h($value) { return htmlspecialchars((string)$value, ENT_QUOTES, 'UTF-8'); }
function user() { return $_SESSION['user'] ?? null; }
function require_login() { if (!user()) { header('Location: login.php'); exit; } }
function require_admin() { if (!user() || user()['role'] !== 'admin') { http_response_code(403); exit('Admin access only.'); } }
function money($n) { return number_format((float)$n, 2); }
function flash($msg) { $_SESSION['flash'] = $msg; }
function get_flash() { $m = $_SESSION['flash'] ?? ''; unset($_SESSION['flash']); return $m; }
?>
