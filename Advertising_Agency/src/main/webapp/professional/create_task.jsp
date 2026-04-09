<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, model.Campaign" %>

<%
    List<Campaign> campaigns = (List<Campaign>) request.getAttribute("campaigns");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create Task</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f0f4f8;
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
        main {
            max-width: 600px;
            margin: 40px auto;
        }
        .card {
            border-radius: 16px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.1);
        }
        .card-header {
            background: linear-gradient(135deg, #0d6efd, #6610f2);
            color: #fff;
            font-size: 1.4rem;
            font-weight: 600;
            text-align: center;
        }
        .form-control {
            border-radius: 10px;
            margin-bottom: 15px;
        }
        .btn-primary {
            border-radius: 10px;
        }
        .alert {
            text-align: center;
        }
    </style>
</head>
<body>

<header>➕ Create New Task</header>

<main>
    <a href="<%= request.getContextPath() %>/professional/dashboard.jsp" class="btn btn-warning mb-3">
        ⬅ Back to Dashboard
    </a>
    <div class="card">
        <div class="card-header">Task Details</div>
        <div class="card-body">

            <% if (campaigns == null || campaigns.isEmpty()) { %>
            <div class="alert alert-warning">
                No campaigns assigned yet. Please wait for assignment.
            </div>
            <% } else { %>
            <form action="<%= request.getContextPath() %>/TaskServlet" method="post">
                <input type="hidden" name="action" value="create">

                <label for="campaignId" class="form-label">Campaign</label>
                <select name="campaignId" id="campaignId" class="form-select" required>
                    <option value="">-- Select Campaign --</option>
                    <% for (Campaign c : campaigns) { %>
                    <option value="<%= c.getCampaignId() %>"><%= c.getTitle() %></option>
                    <% } %>
                </select>

                <label for="title" class="form-label">Task Title</label>
                <input type="text" name="title" id="title" class="form-control" placeholder="Enter task title" required>

                <label for="description" class="form-label">Description</label>
                <textarea name="description" id="description" class="form-control" rows="4" placeholder="Enter task description"></textarea>

                <button type="submit" class="btn btn-primary w-100 mt-3">Create Task</button>
            </form>
            <% } %>

            <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger mt-3">
                <%= request.getAttribute("error") %>
            </div>
            <% } %>

        </div>
    </div>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
