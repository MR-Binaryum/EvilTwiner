<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Received Data</title>
</head>
<body>
    <h1>Received Data</h1>
    <pre>
        <?php
        // Display the data stored in data.txt
        if (file_exists('data.txt')) {
            echo nl2br(htmlspecialchars(file_get_contents('data.txt')));
        } else {
            echo "No data has been submitted yet.";
        }
        ?>
    </pre>
</body>
</html>