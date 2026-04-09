<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, model.Campaign" %>
<%
    String role = (String) session.getAttribute("role");
    if (role == null || !"Manager".equalsIgnoreCase(role)) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    List<Campaign> campaigns = (List<Campaign>) request.getAttribute("campaigns");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Review Campaigns</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f0f4f8;
            color: #333;
            margin: 0;
            padding: 0;
        }

        header {
            background: linear-gradient(90deg, #0d6efd, #6610f2);
            color: #fff;
            text-align: center;
            padding: 25px 0;
            font-size: 1.8rem;
            font-weight: 600;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }

        .container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 20px;
        }

        h2 {
            color: #0d6efd;
            margin-bottom: 20px;
        }

        a.btn-back {
            display: inline-block;
            text-decoration: none;
            background: #6c757d;
            color: #fff;
            padding: 8px 16px;
            border-radius: 8px;
            font-weight: 500;
            transition: 0.2s;
        }

        a.btn-back:hover {
            background: #5a6268;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: #fff;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 6px 20px rgba(0,0,0,0.1);
        }

        th, td {
            padding: 14px 12px;
            text-align: center;
        }

        th {
            background: #0d6efd;
            color: #fff;
            font-weight: 600;
        }

        tr:nth-child(even) {
            background: #f5f7fa;
        }

        tr:hover {
            background: #e0e7ff;
            transition: 0.2s;
        }

        td a.btn {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 6px;
            text-decoration: none;
            font-size: 0.9rem;
            font-weight: 500;
            color: #fff;
            transition: 0.2s;
        }

        a.btn-primary {
            background: #0d6efd;
        }

        a.btn-primary:hover {
            background: #0b5ed7;
        }

        .no-data {
            text-align: center;
            padding: 20px;
            font-style: italic;
            color: #777;
        }

        footer {
            text-align: center;
            padding: 20px;
            color: #777;
            font-size: 0.9rem;
            background: #f5f7fa;
            border-top: 1px solid #ddd;
            margin-top: 40px;
        }

        @media (max-width: 768px) {
            th, td {
                font-size: 0.85rem;
                padding: 10px 8px;
            }

            a.btn-back {
                padding: 6px 12px;
            }
        }
    </style>
</head>
<body>
<header>
    📢 Review Approved Campaigns
</header>

<div class="container">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>📢 Approved Campaigns</h2>
        <a href="<%= request.getContextPath() %>/manager/dashboard.jsp" class="btn-back">⬅ Back to Dashboard</a>
    </div>

    <% if (campaigns == null || campaigns.isEmpty()) { %>
    <div class="no-data">No approved campaigns available.</div>
    <% } else { %>
    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Objective</th>
            <th>Budget</th>
            <th>Media</th>
            <th>Audience</th>
            <th>Client Email</th>
            <th>Contact</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <% for (Campaign c : campaigns) { %>
        <tr>
            <td><%= c.getCampaignId() %></td>
            <td><%= c.getTitle() %></td>
            <td><%= c.getObjective() %></td>
            <td>$<%= c.getBudget() %></td>
            <td>
                <% if (c.getMediaFile() != null && !c.getMediaFile().isEmpty()) { %>
                <a href="<%= request.getContextPath() + "/uploads/" + c.getMediaFile() %>" target="_blank">📎 View File</a>
                <% } else { %>
                No file
                <% } %>
            </td>
            <td><%= c.getAudience() %></td>
            <td><%= c.getEmail() %></td>
            <td><%= c.getContact() %></td>
            <td>
                <a href="<%= request.getContextPath() %>/MessageServlet?action=view&campaignId=<%= c.getCampaignId() %>"
                   class="btn btn-primary">💬 View Messages</a>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
    <% } %>
</div>

<footer>
    &copy; 2025 Advertising Agency System
</footer>
</body>
</html>
