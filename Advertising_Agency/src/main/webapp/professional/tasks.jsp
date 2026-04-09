<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.Campaign, model.Task" %>

<%
    List<Campaign> campaigns = (List<Campaign>) request.getAttribute("campaigns");
    Map<Integer, List<Task>> campaignTasks = (Map<Integer, List<Task>>) request.getAttribute("campaignTasks");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Tasks</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">

    <a href="<%= request.getContextPath() %>/professional/dashboard.jsp" class="btn btn-secondary mb-3">
        ⬅ Back to Dashboard
    </a>

    <h2 class="text-center mb-4">📋 My Campaign Tasks</h2>


    <% if (campaigns != null && !campaigns.isEmpty()) {
        for (Campaign c : campaigns) {
            List<Task> tasks = campaignTasks.get(c.getCampaignId());
            if (tasks == null) tasks = new ArrayList<>();
    %>
    <div class="card mb-3">
        <div class="card-header bg-primary text-white">
            <%= c.getTitle() %> — Progress: <%= tasks.isEmpty() ? 0 : (int)(tasks.stream().filter(t -> "Completed".equalsIgnoreCase(t.getStatus())).count() * 100.0 / tasks.size()) %>%
        </div>
        <div class="card-body">
            <% if (!tasks.isEmpty()) { %>
            <ul class="list-group">
                <% for (Task t : tasks) { %>
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    <div>
                        <strong><%= t.getTitle() %></strong><br>
                        <small><%= t.getDescription() %></small>
                    </div>
                    <div>
                        <span class="badge
                            <%= "Completed".equalsIgnoreCase(t.getStatus()) ? "bg-success" :
                               ("In Progress".equalsIgnoreCase(t.getStatus()) ? "bg-primary" : "bg-warning text-dark") %>">
                            <%= t.getStatus() %>
                        </span>
                        <% if (!"Completed".equalsIgnoreCase(t.getStatus())) { %>
                        <form action="<%= request.getContextPath() %>/TaskServlet" method="get" style="display:inline;">
                            <input type="hidden" name="action" value="complete">
                            <input type="hidden" name="taskId" value="<%= t.getTaskId() %>">
                            <button type="submit" class="btn btn-success btn-sm ms-2">Mark Complete</button>
                        </form>


                        <% } %>
                    </div>
                </li>
                <% } %>
            </ul>
            <% } else { %>
            <div class="alert alert-info mb-0">No tasks for this campaign.</div>
            <% } %>
        </div>
    </div>
    <% } %>
    <% } else { %>
    <div class="alert alert-warning text-center">No campaigns assigned yet.</div>
    <% } %>
</div>
</body>
</html>
