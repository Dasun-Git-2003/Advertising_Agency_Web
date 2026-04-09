<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.User" %>
<%
    String sessionRole = (String) session.getAttribute("role");
    Integer sessionUserId = (Integer) session.getAttribute("userId");

    if (sessionRole == null || sessionUserId == null || !"Admin".equalsIgnoreCase(sessionRole)) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    List<User> users = (List<User>) request.getAttribute("users");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin - Manage Users</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #f0f0ff, #f5f7fa);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            margin: 0;
        }

        header {
            background: linear-gradient(90deg, #6610f2, #0d6efd);
            color: #fff;
            padding: 20px 40px;
            text-align: center;
            font-size: 1.8rem;
            font-weight: 600;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }

        .container-users {
            max-width: 900px;
            margin: 40px auto;
            background: #fff;
            border-radius: 16px;
            padding: 30px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
        }

        .table thead {
            background: #6610f2;
            color: #fff;
        }

        .table tbody tr:hover {
            background: #f5f0ff;
        }

        .btn-sm {
            border-radius: 8px;
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
    Admin Dashboard - Manage Users
</header>

<div class="container-users">
    <h3 class="mb-4"><i class="bi bi-people-fill"></i> Users</h3>
    <table class="table table-hover align-middle">
        <thead>
        <tr>
            <th>User ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Role</th>
            <th>Status</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            if (users != null && !users.isEmpty()) {
                for (User u : users) {
                    boolean isActive = "Active".equalsIgnoreCase(u.getStatus());
        %>
        <tr>
            <td><%= u.getUserId() %></td>
            <td><%= u.getName() %></td>
            <td><%= u.getEmail() %></td>
            <td><%= u.getRole() %></td>
            <td><%= u.getStatus() %></td>
            <td>
                <% if (isActive) { %>
                <a href="<%= request.getContextPath() %>/AdminServlet?action=deactivate&id=<%= u.getUserId() %>"
                   class="btn btn-warning btn-sm"><i class="bi bi-x-circle-fill"></i> Deactivate</a>
                <% } else { %>
                <a href="<%= request.getContextPath() %>/AdminServlet?action=activate&id=<%= u.getUserId() %>"
                   class="btn btn-success btn-sm"><i class="bi bi-check-circle-fill"></i> Activate</a>
                <% } %>
                <a href="<%= request.getContextPath() %>/AdminServlet?action=delete&id=<%= u.getUserId() %>"
                   class="btn btn-danger btn-sm"><i class="bi bi-trash-fill"></i> Delete</a>
            </td>
        </tr>
        <%  }
        } else { %>
        <tr>
            <td colspan="6" class="text-center">No users found.</td>
        </tr>
        <% } %>
        </tbody>
    </table>

    <a href="<%= request.getContextPath() %>/AdminServlet?action=dashboard" class="back-link">⬅ Back to Dashboard</a>
</div>

<footer>
    &copy; 2025 Advertising Agency System
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
