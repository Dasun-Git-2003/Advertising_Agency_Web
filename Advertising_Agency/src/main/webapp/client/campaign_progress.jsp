<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.Campaign, model.Task" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Campaign Progress</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body { background: #f8f9fa; font-family: 'Segoe UI', sans-serif; }
        .card { margin-bottom: 30px; border-radius: 12px; }
        .task-badge { font-size: 0.85rem; }
        .progress { height: 25px; }
        canvas { max-width: 200px; margin-top: 10px; }
        h5 { font-weight: 600; }
    </style>
</head>
<body>

<div class="container mt-5">
    <h2 class="mb-4 text-center">📊 My Campaign Progress</h2>

    <%
        List<Campaign> campaigns = (List<Campaign>) request.getAttribute("campaigns");

        if (campaigns != null && !campaigns.isEmpty()) {
            int chartCounter = 1;
            for (Campaign c : campaigns) {
                List<Task> tasks = c.getTasks() != null ? c.getTasks() : new ArrayList<>();
                int completed = 0;
                for (Task t : tasks) if ("Completed".equalsIgnoreCase(t.getStatus())) completed++;
                int progress = tasks.isEmpty() ? 0 : (completed * 100 / tasks.size());
    %>

    <div class="card shadow-sm">
        <div class="card-body">
            <h5><%= c.getTitle() %> — Progress: <%= progress %>%</h5>
            <p>Total Tasks: <%= tasks.size() %> | Completed: <%= completed %> | Remaining: <%= tasks.size() - completed %></p>

            <div class="progress mb-3">
                <div class="progress-bar <%= progress == 100 ? "bg-success" : "bg-primary" %>"
                     role="progressbar" style="width: <%= progress %>%;"
                     aria-valuenow="<%= progress %>" aria-valuemin="0" aria-valuemax="100">
                    <%= progress %>%
                </div>
            </div>

            <ul class="list-group mb-3">
                <% for (Task t : tasks) { %>
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    <%= t.getTitle() %>
                    <span class="badge
                        <%= "Completed".equalsIgnoreCase(t.getStatus()) ? "bg-success" :
                           ("In Progress".equalsIgnoreCase(t.getStatus()) ? "bg-primary" : "bg-warning text-dark") %> task-badge">
                        <%= t.getStatus() %>
                    </span>
                </li>
                <% } %>
            </ul>

            <canvas id="chart-<%= chartCounter %>"></canvas>
            <script>
                const ctx<%= chartCounter %> = document.getElementById('chart-<%= chartCounter %>').getContext('2d');
                new Chart(ctx<%= chartCounter %>, {
                    type: 'doughnut',
                    data: {
                        labels: ['Completed', 'Remaining'],
                        datasets: [{
                            data: [<%= completed %>, <%= tasks.size() - completed %>],
                            backgroundColor: ['#198754','#ffc107'],
                        }]
                    },
                    options: {
                        plugins: {
                            legend: { position: 'bottom' },
                            tooltip: { enabled: true }
                        },
                        responsive: true,
                        maintainAspectRatio: false
                    }
                });
            </script>
        </div>
    </div>

    <%
            chartCounter++;
        }
    } else {
    %>
    <div class="alert alert-info text-center">No campaigns found.</div>
    <% } %>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
