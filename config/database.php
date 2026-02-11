<?php

/**
 * Database Configuration
 * Reads from environment variables for better security
 */

// Load environment variables from .env file
$envFile = dirname(__DIR__) . '/.env';
if (file_exists($envFile)) {
    $lines = file($envFile, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
    foreach ($lines as $line) {
        // Skip comments
        if (strpos(trim($line), '#') === 0) {
            continue;
        }

        // Parse KEY=VALUE
        if (strpos($line, '=') !== false) {
            list($key, $value) = explode('=', $line, 2);
            $key = trim($key);
            $value = trim($value);

            // Set as environment variable if not already set
            if (!getenv($key)) {
                putenv("$key=$value");
            }
        }
    }
}

// Helper function to get environment variable with fallback
function env($key, $default = '')
{
    $value = getenv($key);
    return $value !== false ? $value : $default;
}

// Define database connection constants
define('DB_SERVER', env('DB_SERVER', 'localhost'));
define('DB_SERVER_USERNAME', env('DB_SERVER_USERNAME', 'root'));
define('DB_SERVER_PASSWORD', env('DB_SERVER_PASSWORD', ''));
define('DB_SERVER_PORT', env('DB_SERVER_PORT', ''));
define('DB_DATABASE', env('DB_DATABASE', 'rukovoditel'));
