<?php
/**
 * API: Run AI similarity check. POST title, abstract; returns JSON.
 */
require_once __DIR__ . '/../config/config.php';
header('Content-Type: application/json; charset=utf-8');

function word_count(string $text): int {
    $parts = preg_split('/\s+/', trim($text));
    $parts = array_filter($parts, fn($w) => $w !== '');
    return count($parts);
}

if (!isLoggedIn()) {
    echo json_encode(['result' => 'error', 'error' => 'Unauthorized']);
    exit;
}
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode(['result' => 'error', 'error' => 'Method not allowed']);
    exit;
}

$input = json_decode(file_get_contents('php://input'), true) ?: [];
$title = trim($input['title'] ?? '');
$abstract = trim($input['abstract'] ?? '');
$platformUsed = trim($input['platform_used'] ?? '');
$methodology = trim($input['methodology'] ?? '');
$threshold = (float)($input['threshold'] ?? 0.25);

$titleWords = word_count($title);
$abstractWords = word_count($abstract);

if ($title === '' || $abstract === '') {
    echo json_encode(['result' => 'error', 'error' => 'Project title and abstract are required.']);
    exit;
}
if ($titleWords < 3 || $titleWords > 20) {
    echo json_encode(['result' => 'error', 'error' => 'Project title must be between 3 and 20 words.']);
    exit;
}
if ($abstractWords < 30 || $abstractWords > 200) {
    echo json_encode(['result' => 'error', 'error' => 'Abstract must be between 30 and 200 words.']);
    exit;
}

// Optional fields are included in semantic check context when provided.
$extraContext = trim(
    ($platformUsed !== '' ? (' Platform used: ' . $platformUsed . '.') : '') .
    ($methodology !== '' ? (' Methodology: ' . $methodology . '.') : '')
);
$abstractForCheck = trim($abstract . $extraContext);

$result = fareed_check_similarity($title, $abstractForCheck, $threshold);
echo json_encode($result);
