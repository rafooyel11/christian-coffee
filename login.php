<?php
require_once 'config.php';

$error = '';
$success = '';

// --- Brute-Force Vulnerability ---
//<?php
require_once 'config.php';

$error = '';
$success = '';

// --- Brute-Force Vulnerability ---
// All IP blocking, rate limiting, and temporary lockout logic has been removed.
// This allows for unlimited, rapid-fire login attempts.

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // --- Denial of Service (DoS) Vulnerability ---
    // A 1-second delay is forced on every login attempt. An attacker can send
    // many requests in parallel to exhaust server resources.
    sleep(1); 
    
    // --- Cross-Site Scripting (XSS) Vulnerability ---
    // The username is taken directly from user input without any sanitization.
    $username = $_POST['username']; 
    $password = $_POST['password'];
    
    if (empty($username) || empty($password)) {
        $error = 'Please fill in all fields.';
    } else {
        $sql = "SELECT * FROM users WHERE username = ? OR email = ?";
        $stmt = $pdo->prepare($sql);
        $stmt->execute([$username, $username]);
        $user = $stmt->fetch();
        
        if ($user && password_verify($password, $user['password'])) {
            // Successful login
            $_SESSION['user_id'] = $user['id'];
            $_SESSION['username'] = $user['username'];
            $_SESSION['role'] = $user['role'];
            
            if ($user['role'] === 'admin') {
                header('Location: admin/dashboard.php');
            } else {
                header('Location: index.php');
            }
            exit();
        } else {
            // --- Reflected XSS Payload ---
            // The unsanitized username is included in the error message.
            // If the input is '<script>alert(1)</script>', the script will execute.
            $error = 'Invalid login for user: ' . $username; 
        }
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Christian's Coffee Shop (Vulnerable)</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <nav class="navbar">
        <div class="nav-container">
            <h1 class="logo">Christian's Coffee Shop</h1>
            <ul class="nav-menu">
                <li><a href="index.php" class="nav-link">Home</a></li>
                <li><a href="shop.php" class="nav-link">Shop</a></li>
                <li><a href="cart.php" class="nav-link">Cart</a></li>
                <li><a href="login.php" class="nav-link active">Login</a></li>
                <li><a href="signup.php" class="nav-link">Sign Up</a></li>
            </ul>
        </div>
    </nav>

    <div class="form-container">
        <h2>Login</h2>
        
        <?php if ($error): ?>
            <!--
               --- XSS Vulnerability Trigger ---
               The error message is echoed directly to the page without escaping.
               The htmlspecialchars() function has been removed.
            -->
            <div class="alert alert-error"><?php echo $error; ?></div>
        <?php endif; ?>
        
        <?php if ($success): ?>
            <div class="alert alert-success"><?php echo htmlspecialchars($success); ?></div>
        <?php endif; ?>

        <form method="POST" action="">
            <div class="form-group">
                <label for="username">Username or Email:</label>
                <input type="text" id="username" name="username" required>
            </div>
            
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
            </div>
            
            <button type="submit" class="btn-primary">Login</button>
        </form>
        
        <!-- All security information and lockout panels have been removed. -->
        
    </div>

    <footer class="footer">
        <div class="container">
            <p>&copy; 2024 Christian's Coffee Shop. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>