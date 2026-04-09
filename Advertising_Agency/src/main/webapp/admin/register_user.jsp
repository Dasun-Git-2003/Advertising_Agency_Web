<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String sessionRole = (String) session.getAttribute("role");
    if (!"Admin".equalsIgnoreCase(sessionRole)) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register User - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #f0f0ff, #f5f7fa);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
        }

        header {
            background: linear-gradient(90deg, #6610f2, #0d6efd);
            color: #fff;
            text-align: center;
            padding: 25px 0;
            font-size: 1.8rem;
            font-weight: 600;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            margin-bottom: 40px;
        }

        .card {
            border-radius: 16px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
        }

        .btn-success {
            border-radius: 8px;
            font-weight: 500;
        }

        .form-control, .form-select {
            border-radius: 8px;
            padding: 10px;
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
    Admin Dashboard - Register User
</header>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-5">
            <div class="card">
                <div class="card-body p-4">
                    <h3 class="text-center mb-4"><i class="bi bi-person-plus-fill"></i> Register New User</h3>

                    <form action="<%= request.getContextPath() %>/RegisterServlet" method="post">

                    <div class="mb-3">
                            <label>Full Name</label>
                            <input type="text" name="fullname" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label>Email</label>
                            <input type="email" name="email" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label>Password</label>
                            <input type="password" name="password" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label>Role</label>
                            <select name="role" class="form-select" required>
                                <option value="client">Client</option>
                                <option value="professional">Professional</option>
                                <option value="manager">Manager</option>
                                <option value="analyst">Analyst</option>
                                <option value="finance">Finance</option>
                                <option value="admin">Admin</option>
                            </select>
                        </div>
                        <button type="submit" class="btn btn-success w-100"><i class="bi bi-check-circle-fill"></i> Register User</button>
                    </form>

                    <a href="dashboard.jsp" class="btn btn-link w-100 mt-3 text-center">⬅ Back to Dashboard</a>
                </div>
            </div>
        </div>
    </div>
</div>

<footer>
    &copy; 2025 Advertising Agency System
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
