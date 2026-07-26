<?php
/**
 * FAREED - Application config
 */
session_start();
require_once __DIR__ . '/database.php';
require_once __DIR__ . '/../includes/auth.php';

// Base path for web (e.g. /FAREED or '' if in htdocs root)
define('BASE_PATH', '/FAREED');

// Path to Python script for AI check (absolute path recommended)
define('PYTHON_PATH', 'python');
define('SCRIPT_PATH', realpath(dirname(__DIR__) . '/test_model_python.py'));

// Call AI model: pass JSON via stdin, get JSON from stdout
function fareed_check_similarity(string $title, string $abstract, float $threshold = 0.6): array {
    $input = json_encode(['title' => $title, 'abstract' => $abstract, 'threshold' => $threshold]);
    $script = SCRIPT_PATH;
    if (strtoupper(substr(PHP_OS, 0, 3)) === 'WIN') {
        $cmd = sprintf('"%s" "%s"', PYTHON_PATH, $script);
    } else {
        $cmd = sprintf('%s %s', PYTHON_PATH, escapeshellarg($script));
    }
    $proc = proc_open(
        $cmd,
        [
            0 => ['pipe', 'r'],
            1 => ['pipe', 'w'],
            2 => ['pipe', 'w'],
        ],
        $pipes,
        dirname($script)
    );
    if (!is_resource($proc)) {
        return ['result' => 'error', 'error' => 'Could not run Python script.'];
    }
    fwrite($pipes[0], $input);
    fclose($pipes[0]);
    $stdout = stream_get_contents($pipes[1]);
    $stderr = stream_get_contents($pipes[2]);
    fclose($pipes[1]);
    fclose($pipes[2]);
    proc_close($proc);
    $decoded = @json_decode($stdout, true);
    if ($decoded === null && json_last_error() !== JSON_ERROR_NONE) {
        return ['result' => 'error', 'error' => 'Invalid AI response: ' . ($stderr ?: $stdout)];
    }
    return $decoded ?: ['result' => 'error', 'error' => 'Empty AI response'];
}
