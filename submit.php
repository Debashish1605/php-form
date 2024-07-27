<?php
$servername = "database-2.chuey2eq2prq.ap-south-1.rds.amazonaws.com";
$username = "admin"; // or your chosen master username
$password = "Devashish2262";
$dbname = "database-2";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Prepare and bind
$stmt = $conn->prepare("INSERT INTO users (name, email, phone) VALUES (?, ?, ?)");
if ($stmt === false) {
    die("Prepare failed: " . $conn->error);
}

$name = htmlspecialchars($_POST['name']);
$email = htmlspecialchars($_POST['email']);
$phone = htmlspecialchars($_POST['phone']);

if (filter_var($email, FILTER_VALIDATE_EMAIL)) {
    $stmt->bind_param("sss", $name, $email, $phone);
    if ($stmt->execute()) {
        echo "New record created successfully";
    } else {
        echo "Execute failed: " . $stmt->error;
    }
} else {
    echo "Invalid email format";
}

$stmt->close();
$conn->close();
?>
