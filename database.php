<?php
/**
 * FAREED - Database configuration for XAMPP/MySQL
 */
define('DB_HOST', 'localhost');
define('DB_NAME', 'fareed_db');
define('DB_USER', 'root');
define('DB_PASS', '');  // default XAMPP has no password
define('DB_CHARSET', 'utf8mb4');

function getDB(): PDO {
    static $pdo = null;
    if ($pdo === null) {
        $dsn = 'mysql:host=' . DB_HOST . ';dbname=' . DB_NAME . ';charset=' . DB_CHARSET;
        $opts = [
            PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        ];
        $pdo = new PDO($dsn, DB_USER, DB_PASS, $opts);
    }
    return $pdo;
}
