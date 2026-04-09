<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.*, model.Campaign, util.DBConnection" %>
<%
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    List<Campaign> campaigns = new ArrayList<>();
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement stmt = conn.prepareStatement(
                 "SELECT campaign_id, title, objective, budget, audience, status, media_file, created_at " +
                         "FROM Campaigns WHERE client_id=? ORDER BY created_at DESC")) {
        stmt.setInt(1, userId);
        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            Campaign c = new Campaign();
            c.setCampaignId(rs.getInt("campaign_id"));
            c.setTitle(rs.getString("title"));
            c.setObjective(rs.getString("objective"));
            c.setBudget(rs.getDouble("budget"));
            c.setAudience(rs.getString("audience"));
            c.setStatus(rs.getString("status"));
            c.setMediaFile(rs.getString("media_file"));
            c.setCreatedAt(rs.getDate("created_at"));
            campaigns.add(c);
        }
    } catch (SQLException e) { e.printStackTrace(); }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Campaigns</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f4f7fa;
            margin: 0;
            padding: 0;
        }
        header {
            background: linear-gradient(90deg,#0d6efd,#6610f2);
            color: #fff;
            text-align: center;
            padding: 25px 0;
            font-size: 1.8rem;
            font-weight: 600;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        .container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 0 20px;
        }
        h2 {
            color: #333;
        }
        .btn {
            padding: 10px 18px;
            border-radius: 10px;
            border: none;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            text-align: center;
            transition: 0.2s;
        }
        .btn-primary { background: #0d6efd; color: #fff; }
        .btn-primary:hover { background: #0b5ed7; }
        .btn-warning { background: #ffc107; color: #212529; }
        .btn-warning:hover { background: #e0a800; }
        .btn-danger { background: #dc3545; color: #fff; }
        .btn-danger:hover { background: #bb2d3b; }
        .btn-info { background: #0dcaf0; color: #fff; }
        .btn-info:hover { background: #31d2f2; }
        .card {
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.05);
            overflow: hidden;
            margin-bottom: 20px;
        }
        .table {
            width: 100%;
            border-collapse: collapse;
        }
        .table th, .table td {
            padding: 12px 15px;
            text-align: left;
        }
        .table thead {
            background: #0d6efd;
            color: #fff;
        }
        .table tbody tr:nth-child(even) {
            background: #f8f9fa;
        }
        .badge {
            padding: 5px 10px;
            border-radius: 10px;
            font-weight: 600;
        }
        .text-warning { background: #ffc107; color: #212529; }
        .text-success { background: #198754; color: #fff; }
        .text-danger { background: #dc3545; color: #fff; }
        main a { margin-right: 5px; }
        @media (max-width: 768px) {
            .table th, .table td { padding: 8px; font-size: 0.9rem; }
            .btn { padding: 8px 14px; font-size: 0.9rem; }
        }
    </style>
</head>
<body>
<header>📢 My Campaigns</header>


<div class="container">

    <div style="margin-bottom:20px;">
        <a href="new_campaign.jsp" class="btn btn-primary">+ Create New Campaign</a>
    </div>

    <div class="card">
        <div class="table-responsive">
            <table class="table">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Title</th>
                    <th>Objective</th>
                    <th>Budget</th>
                    <th>Audience</th>
                    <th>Status</th>
                    <th>Media</th>
                    <th>Created At</th>
                    <th>Actions</th>
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
                    <td><%= c.getObjective() %></td>
                    <td>$<%= c.getBudget() %></td>
                    <td><%= c.getAudience() %></td>
                    <td>
                        <span class="<%=
                            "Pending".equalsIgnoreCase(c.getStatus()) ? "text-warning" :
                            "Approved".equalsIgnoreCase(c.getStatus()) ? "text-success" :
                            "Rejected".equalsIgnoreCase(c.getStatus()) ? "text-danger" : ""
                        %>"><%= c.getStatus() %></span>
                    </td>
                    <td>
                        <% if (c.getMediaFile() != null && !c.getMediaFile().isEmpty()) { %>
                        <a href="<%= request.getContextPath() %>/uploads/<%= c.getMediaFile() %>" target="_blank">View</a>
                        <% } else { %> - <% } %>
                    </td>
                    <td><%= c.getCreatedAt() %></td>
                    <td>
                        <a href="edit_campaign.jsp?campaignId=<%= c.getCampaignId() %>" class="btn btn-warning">Edit</a>
                        <a href="<%= request.getContextPath() %>/CampaignServlet?action=delete&campaignId=<%= c.getCampaignId() %>"
                           class="btn btn-danger" onclick="return confirm('Are you sure?')">Delete</a>
                        <% if ("Approved".equalsIgnoreCase(c.getStatus())) { %>
                        <a href="<%= request.getContextPath() %>/MessageServlet?action=openChat&campaignId=<%= c.getCampaignId() %>"
                           class="btn btn-info">View Messages</a>
                        <% } %>
                    </td>
                </tr>
                <%      }
                } else { %>
                <tr>
                    <td colspan="9" style="text-align:center;">No campaigns found.</td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>
<a href="<%= request.getContextPath() %>/client/dashboard.jsp" class="btn btn-secondary ">
    ⬅ Back to Dashboard
</a>

</body>
</html>
