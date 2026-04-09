<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Settings</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        body {
            background: linear-gradient(135deg, #e0e0ff, #f5f7fa);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            margin: 0;
        }

        /* Header */
        header {
            background: linear-gradient(90deg, #6610f2, #0d6efd);
            color: #fff;
            padding: 20px 40px;
            text-align: center;
            font-size: 1.8rem;
            font-weight: 600;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }

        /* Main container */
        .container-settings {
            max-width: 600px;
            margin: 40px auto;
            background: #fff;
            border-radius: 16px;
            padding: 30px 25px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .container-settings:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 35px rgba(0,0,0,0.15);
        }

        .settings-header {
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            font-weight: 600;
            color: #6610f2;
            margin-bottom: 25px;
        }

        .settings-header i {
            margin-right: 10px;
        }

        .form-control {
            border-radius: 10px;
            padding: 12px 15px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
        }

        .btn-primary {
            border-radius: 50px;
            padding: 10px 25px;
            background: linear-gradient(90deg, #6610f2, #0d6efd);
            border: none;
            font-weight: 600;
            width: 100%;
            transition: 0.3s;
        }

        .btn-primary:hover {
            background: linear-gradient(90deg, #0d6efd, #6610f2);
        }

        .back-link {
            display: block;
            margin-top: 20px;
            text-align: center;
            color: #6610f2;
            font-weight: 500;
            text-decoration: none;
        }

        .back-link:hover {
            text-decoration: underline;
        }

        footer {
            text-align: center;
            padding: 15px;
            margin-top: 50px;
            color: #777;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>

<header>
    Admin Dashboard
</header>

<div class="container-settings">
    <div class="settings-header">
        <i class="bi bi-gear-fill"></i> System Settings
    </div>
    <form method="post" action="../AdminServlet">
        <div class="mb-3">
            <label for="siteName" class="form-label">Site Name</label>
            <input type="text" id="siteName" name="siteName" class="form-control" value="Advertising Agency System">
        </div>
        <div class="mb-3">
            <label for="email" class="form-label">Admin Contact Email</label>
            <input type="email" id="email" name="email" class="form-control" value="admin@example.com">
        </div>
        <button type="submit" class="btn btn-primary">Save Settings</button>
    </form>
    <a href="dashboard.jsp" class="back-link">⬅ Back to Dashboard</a>
</div>

<footer>
    &copy; 2025 Advertising Agency System
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
