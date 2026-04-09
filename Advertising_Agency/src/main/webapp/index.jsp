<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>AdAgency - Home</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="assets/css/style.css">
    <style>
        * {
            box-sizing: border-box;
            font-family: 'Inter', sans-serif;
        }

        body, html {
            margin: 0;
            padding: 0;
        }

        /* Header */
        header {
            width: 100%;
            background: rgba(0,0,0,0.7);
            position: fixed;
            top: 0;
            left: 0;
            z-index: 999;
        }

        header .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 50px;
        }

        header .navbar a.nav-brand {
            color: #fff;
            font-size: 2rem;
            font-weight: 700;
            text-decoration: none;
        }

        header .navbar .nav-buttons a {
            margin-left: 15px;
            padding: 10px 25px;
            font-weight: 600;
            border-radius: 30px;
            text-decoration: none;
            transition: 0.3s;
        }

        header .navbar .nav-buttons a.login-btn {
            background: transparent;
            color: #fff;
            border: 2px solid #fff;
        }

        header .navbar .nav-buttons a.login-btn:hover {
            background: #fff;
            color: #000;
        }

        header .navbar .nav-buttons a.register-btn {
            background: linear-gradient(90deg, #6610f2, #0d6efd);
            color: #fff;
        }

        header .navbar .nav-buttons a.register-btn:hover {
            background: linear-gradient(90deg, #0d6efd, #6610f2);
        }

        /* Hero Section */
        .hero-section {
            background: url('assets/images/banner.jpg') no-repeat center center/cover;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            color: #fff;
            padding: 0 20px;
        }

        .hero-section h1 {
            font-size: 4rem;
            font-weight: 700;
            background: linear-gradient(90deg, #6610f2, #0d6efd);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .hero-section p {
            font-size: 1.5rem;
            margin: 20px 0 40px;
            color: #fff;
        }

        .hero-section .hero-buttons a {
            margin: 0 10px;
            padding: 15px 40px;
            border-radius: 50px;
            font-weight: 600;
            text-decoration: none;
            transition: 0.3s;
        }

        .hero-section .hero-buttons a.get-started {
            background: linear-gradient(90deg, #6610f2, #0d6efd);
            color: #fff;
        }

        .hero-section .hero-buttons a.get-started:hover {
            background: linear-gradient(90deg, #0d6efd, #6610f2);
        }

        .hero-section .hero-buttons a.join-now {
            background: rgba(255,255,255,0.2);
            color: #fff;
            border: 2px solid #fff;
        }

        .hero-section .hero-buttons a.join-now:hover {
            background: #fff;
            color: #000;
        }

        /* Features Section */
        .features {
            padding: 100px 20px 50px;
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 30px;
            background: #f8f9fa;
        }

        .feature-card {
            flex: 1 1 250px;
            max-width: 300px;
            background: #fff;
            padding: 30px 20px;
            border-radius: 20px;
            text-align: center;
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 12px 30px rgba(0,0,0,0.15);
        }

        .feature-card i {
            font-size: 3rem;
            color: #6610f2;
            margin-bottom: 20px;
        }

        .feature-card h4 {
            font-weight: 700;
            margin-bottom: 10px;
        }

        .feature-card p {
            color: #555;
        }

        /* Footer */
        footer {
            background: #1c1c1c;
            color: #fff;
            text-align: center;
            padding: 25px 20px;
        }

        footer a {
            color: #0d6efd;
            text-decoration: none;
            margin: 0 10px;
        }

        footer a:hover {
            text-decoration: underline;
        }

        /* Responsive */
        @media(max-width:768px) {
            .hero-section h1 {
                font-size: 3rem;
            }

            .hero-section p {
                font-size: 1.2rem;
            }

            header .navbar {
                flex-direction: column;
            }

            header .navbar .nav-buttons {
                margin-top: 10px;
            }

            .features {
                padding: 50px 20px;
            }
        }
    </style>
</head>
<body>

<!-- Header -->
<header>
    <div class="navbar">
        <a class="nav-brand" href="index.jsp">AdAgency</a>
        <div class="nav-buttons">
            <a href="login.jsp" class="login-btn">Login</a>
            <a href="register.jsp" class="register-btn">Register</a>
        </div>
    </div>
</header>

<!-- Hero Section -->
<section class="hero-section">

</section>

<!-- Features Section -->
<section class="features">
    <div class="feature-card">
        <i class="bi bi-person-check-fill"></i>
        <h4>Role-Based Access</h4>
        <p>Separate dashboards for Admin, Client, Manager, and Professional roles.</p>
    </div>
    <div class="feature-card">
        <i class="bi bi-kanban-fill"></i>
        <h4>Campaign Management</h4>
        <p>Create, approve, and track campaigns efficiently in real-time.</p>
    </div>
    <div class="feature-card">
        <i class="bi bi-bar-chart-line-fill"></i>
        <h4>Analytics</h4>
        <p>View detailed performance analytics for every campaign and user.</p>
    </div>
    <div class="feature-card">
        <i class="bi bi-credit-card-fill"></i>
        <h4>Payments</h4>
        <p>Seamlessly manage client payments and track financial transactions.</p>
    </div>
</section>

<!-- Footer -->
<footer>
    &copy; 2025 Advertising Agency. All rights reserved. |
    <a href="#">Privacy Policy</a> | <a href="#">Terms of Service</a>
</footer>

</body>
</html>
