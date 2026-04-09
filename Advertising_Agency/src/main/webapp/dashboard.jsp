<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");

    if (role == null) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title><%= role %> Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../assets/css/style.css">
    <style>
        body {
            min-height: 100vh;
            overflow-x: hidden;
        }
        .sidebar {
            min-height: 100vh;
            border-right: 1px solid #ddd;
        }
        .sidebar .nav-link {
            color: #333;
            font-weight: 500;
            padding: 10px 15px;
            border-radius: 8px;
        }
        .sidebar .nav-link:hover,
        .sidebar .nav-link.active {
            background-color: #0d6efd;
            color: #fff;
        }
        .main-content {
            padding: 30px;
        }
        .card-dashboard {
            border-radius: 12px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.08);
        }
    </style>
</head>
<body>

<!-- Top Navbar -->
<header class="navbar navbar-expand-lg navbar-dark bg-dark px-4">
    <a class="navbar-brand fw-bold" href="#">MySystem</a>
    <div class="ms-auto text-white">
        <span class="me-3">👋 Welcome, <b><%= username %></b></span>
        <a href="../LogoutServlet" class="btn btn-sm btn-outline-light">Logout</a>
    </div>
</header>

<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <aside class="col-md-2 bg-light sidebar py-4">
            <h6 class="px-3 text-uppercase text-muted mb-3">
                <%= role.substring(0,1).toUpperCase() + role.substring(1) %> Menu
            </h6>
            <nav class="nav flex-column px-2">
                <a class="nav-link active" href="dashboard.jsp">📊 Dashboard</a>
                <a class="nav-link" href="profile.jsp">👤 Profile</a>
                <a class="nav-link" href="settings.jsp">⚙️ Settings</a>
                <a class="nav-link text-danger" href="../LogoutServlet">🚪 Logout</a>
            </nav>
        </aside>

        <!-- Main Content -->
        <main class="col-md-10 main-content">
            <h1 class="mb-4"><%= role.substring(0,1).toUpperCase() + role.substring(1) %> Dashboard</h1>
            <p class="text-muted">Here’s an overview of your system activities.</p>

            <!-- Dashboard Cards -->
            <div class="row g-4 mb-4">
                <div class="col-md-4">
                    <div class="card card-dashboard text-center p-3">
                        <h5>Total Projects</h5>
                        <h2 class="text-primary">12</h2>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card card-dashboard text-center p-3">
                        <h5>Pending Tasks</h5>
                        <h2 class="text-warning">5</h2>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card card-dashboard text-center p-3">
                        <h5>Completed</h5>
                        <h2 class="text-success">7</h2>
                    </div>
                </div>
            </div>

            <!-- Example Table -->
            <div class="card card-dashboard p-3">
                <h5 class="mb-3">Recent Activities</h5>
                <div class="table-responsive">
                    <table class="table table-bordered table-hover">
                        <thead class="table-dark">
                        <tr><th>ID</th><th>Name</th><th>Status</th></tr>
                        </thead>
                        <tbody>
                        <tr><td>1</td><td>Sample</td><td><span class="badge bg-success">Active</span></td></tr>
                        <tr><td>2</td><td>Test</td><td><span class="badge bg-warning text-dark">Pending</span></td></tr>
                        </tbody>
                    </table>
                </div>
            </div>

        </main>
    </div>
</div>

</body>
</html>
