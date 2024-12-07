<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Incorrect Data</title>
    <script>
        // Wait 3 seconds before redirecting
        function redirect() {
            setTimeout(function() {
                window.location.href = 'http://10.0.0.1';
            }, 3000); // Wait for 3000 milliseconds (3 seconds)
        }
    </script>
</head>
<body onload="redirect()">
    <h1>Restarting the form, please wait a moment...</h1>
    
    <script>
        // Show an alert message
        alert('Invalid Wi-Fi password. Please try again.');
    </script>
</body>
</html>