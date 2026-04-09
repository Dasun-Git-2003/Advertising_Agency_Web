<%@ page import="java.util.List" %>
<%@ page import="model.Campaign" %>
<%@ page import="dao.CampaignDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Integer adminId = (Integer) session.getAttribute("userId");
    String role = (String) session.getAttribute("role");
    if (adminId == null || !"Admin".equalsIgnoreCase(role)) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    CampaignDAO campaignDAO = new CampaignDAO();
    List<Campaign> campaigns = campaignDAO.getAllCampaigns(); // Fetch all campaigns
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin - Approve Campaigns</title>
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

        .container-campaigns {
            max-width: 950px;
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
    Admin Dashboard - Approve Campaigns
</header>

<div class="container-campaigns">
    <h3 class="mb-4"><i class="bi bi-card-checklist"></i> Campaign Approvals</h3>
    <table class="table table-hover align-middle">
        <thead>
        <tr>
            <th>Campaign ID</th>
            <th>Title</th>
            <th>Client</th>
            <th>Budget</th>
            <th>Status</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <%
            if (campaigns != null && !campaigns.isEmpty()) {
                for (Campaign c : campaigns) {
        %>
        <tr>
            <td><%= c.getCampaignId() %></td>
            <td><%= c.getTitle() %></td>
            <td><%= c.getEmail() %></td>
            <td>$<%= c.getBudget() %></td>
            <td><%= c.getStatus() %></td>
            <td>
                <% if ("Pending".equalsIgnoreCase(c.getStatus())) { %>
                <a href="<%= request.getContextPath() %>/AdminServlet?action=approve&id=<%= c.getCampaignId() %>"
                   class="btn btn-success btn-sm"><i class="bi bi-check-circle-fill"></i> Approve</a>
                <a href="<%= request.getContextPath() %>/AdminServlet?action=reject&id=<%= c.getCampaignId() %>"
                   class="btn btn-danger btn-sm"><i class="bi bi-x-circle-fill"></i> Reject</a>
                <% } else if ("Approved".equalsIgnoreCase(c.getStatus())) { %>
                <a href="<%= request.getContextPath() %>/MessageServlet?action=openChat&campaignId=<%= c.getCampaignId() %>"
                   class="btn btn-primary btn-sm"><i class="bi bi-chat-dots-fill"></i> Chat</a>
                <% } else { %>
                <span class="text-muted">Rejected</span>
                <% } %>
            </td>
        </tr>
        <%      }
        } else { %>
        <tr>
            <td colspan="6" class="text-center">No campaigns found.</td>
        </tr>
        <% } %>
        </tbody>
    </table>

    <a href="dashboard.jsp" class="back-link">⬅ Back to Dashboard</a>
</div>

<footer>
    &copy; 2025 Advertising Agency System
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
