<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, model.Campaign" %>

<%
    List<Campaign> campaigns = (List<Campaign>) request.getAttribute("campaigns");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Assigned Campaigns</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f0f4f8;
            margin: 0;
            padding: 0;
            color: #333;
        }

        header {
            background: linear-gradient(90deg, #0d6efd, #6610f2);
            color: #fff;
            text-align: center;
            padding: 25px 0;
            font-size: 2rem;
            font-weight: 600;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }

        .container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 15px;
        }

        h2 {
            color: #0d6efd;
            margin-bottom: 30px;
            text-align: center;
        }

        .campaign-card {
            background: #fff;
            border-radius: 16px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.08);
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .campaign-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
        }

        .campaign-row {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            align-items: center;
        }

        .campaign-info {
            flex: 1 1 65%;
        }

        .campaign-actions {
            flex: 1 1 30%;
            text-align: right;
        }

        .campaign-info p {
            margin: 4px 0;
        }

        .btn {
            padding: 6px 12px;
            font-weight: 500;
            border-radius: 10px;
            transition: transform 0.2s, box-shadow 0.2s;
            text-decoration: none;
        }

        .btn-primary {
            background: #0d6efd;
            color: #fff;
        }

        .btn-primary:hover {
            transform: scale(1.05);
            box-shadow: 0 6px 15px rgba(13,110,253,0.3);
        }

        .btn-success {
            background: #198754;
            color: #fff;
        }

        .btn-success:hover {
            transform: scale(1.05);
            box-shadow: 0 6px 15px rgba(25,135,84,0.3);
        }

        .file-link {
            color: #0d6efd;
            text-decoration: none;
            font-weight: 500;
        }

        .file-link:hover {
            text-decoration: underline;
        }

        @media (max-width: 768px) {
            .campaign-actions {
                text-align: left;
                margin-top: 10px;
            }
        }
    </style>
</head>
<body>

<header>📢 Assigned Campaigns</header>

<div class="container">
    <% if (campaigns == null || campaigns.isEmpty()) { %>
    <div class="alert alert-info text-center">No campaigns assigned yet.</div>
    <% } else { %>
    <% for (Campaign c : campaigns) { %>
    <div class="campaign-card">
        <div class="campaign-row">
            <div class="campaign-info">
                <p><strong>ID:</strong> <%= c.getCampaignId() %></p>
                <p><strong>Title:</strong> <%= c.getTitle() %></p>
                <p><strong>Objective:</strong> <%= c.getObjective() %></p>
                <p><strong>Budget:</strong> $<%= c.getBudget() %></p>
                <p><strong>Audience:</strong> <%= c.getAudience() %></p>
                <p><strong>Client Email:</strong> <%= c.getEmail() %></p>
                <p><strong>Contact:</strong> <%= c.getContact() %></p>
                <p>
                    <strong>Media:</strong>
                    <% if (c.getMediaFile() != null && !c.getMediaFile().isEmpty()) { %>
                    <a class="file-link" href="<%= request.getContextPath() + "/uploads/" + c.getMediaFile() %>" target="_blank">📎 View File</a>
                    <% } else { %>
                    No file
                    <% } %>
                </p>
            </div>
            <div class="campaign-actions">
                <a href="<%= request.getContextPath() %>/MessageServlet?campaignId=<%= c.getCampaignId() %>" class="btn btn-primary mb-2">💬 View Messages</a>
            </div>
        </div>
    </div>
    <% } %>
    <% } %>
</div>

</body>
</html>
