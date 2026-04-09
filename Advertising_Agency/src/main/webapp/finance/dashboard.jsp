<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"Finance".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Finance Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        body { font-family: 'Segoe UI', sans-serif; margin: 0; background: #f4f6f9; }
        .dashboard-header {
            background: linear-gradient(135deg, #6f42c1, #0dcaf0);
            color: #fff; padding: 20px 30px;
            display: flex; justify-content: space-between; align-items: center;
        }
        .dashboard-header h1 { margin: 0; font-size: 1.8rem; }
        .dashboard-header .logout-btn {
            color: #fff; text-decoration: none; font-weight: 500;
            border: 1px solid #fff; padding: 5px 12px; border-radius: 6px;
            transition: 0.3s;
        }
        .dashboard-header .logout-btn:hover { background: #fff; color: #6f42c1; }
        .dashboard-container { display: flex; min-height: calc(100vh - 70px); }
        .sidebar {
            width: 220px; background: #20232a; color: #fff;
            flex-shrink: 0; display: flex; flex-direction: column; padding-top: 20px;
        }
        .sidebar a { color: #fff; text-decoration: none; padding: 12px 20px; display: block; transition: 0.2s; }
        .sidebar a:hover { background: #6f42c1; border-radius: 8px; }
        .main-content { flex-grow: 1; padding: 30px; }
        .banner-img { width: 100%; border-radius: 12px; margin-bottom: 20px; }
        .cards { display: flex; flex-wrap: wrap; gap: 20px; }
        .card {
            flex: 1 1 calc(33.33% - 20px);
            background: #fff; border-radius: 12px; padding: 20px;
            box-shadow: 0 6px 15px rgba(0,0,0,0.1);
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .card:hover { transform: translateY(-5px); box-shadow: 0 10px 30px rgba(0,0,0,0.2); }
        .dashboard-footer { text-align: center; padding: 15px 0; background: #20232a; color: #fff; font-size: 0.9rem; }
        @media(max-width: 992px) { .cards { flex-direction: column; } .card { flex: 1 1 100%; } }
    </style>
</head>
<body>

<!-- Header -->
<div class="dashboard-header">
    <h1>Finance Dashboard - Welcome, <%= user.getName() %></h1>
    <a class="logout-btn" href="<%= request.getContextPath() %>/LogoutServlet">Logout <i class="bi bi-box-arrow-right"></i></a>
</div>

<!-- Sidebar + Main -->
<div class="dashboard-container">
    <!-- Sidebar -->
    <div class="sidebar">
        <a href="<%= request.getContextPath() %>/finance/dashboard.jsp"><i class="bi bi-speedometer2"></i> Dashboard</a>
        <a href="<%= request.getContextPath() %>/finance/invoices.jsp"><i class="bi bi-receipt"></i> Invoices</a>
        <a href="<%= request.getContextPath() %>/finance/verify_payments"><i class="bi bi-cash-stack"></i> Payments</a>
        <a href="<%= request.getContextPath() %>/finance/reports.jsp"><i class="bi bi-bar-chart-line"></i> Reports</a>
        <a href="<%= request.getContextPath() %>/profile.jsp"><i class="bi bi-person-circle"></i> Profile</a>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <img src="<%= request.getContextPath() %>/assets/images/banner.jpg" alt="Banner" class="banner-img">
        <div class="cards">
            <div class="card">
                <h3><i class="bi bi-receipt"></i> Invoices</h3>
                <p>Manage client invoices and billing.</p>
            </div>
            <div class="card">
                <h3><i class="bi bi-cash-stack"></i> Payments</h3>
                <p>Track incoming and outgoing payments.</p>
            </div>
            <div class="card">
                <h3><i class="bi bi-bar-chart-line"></i> Reports</h3>
                <p>Generate financial reports and analytics.</p>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<div class="dashboard-footer">
    &copy; 2025 Advertising Agency. Finance Portal
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
