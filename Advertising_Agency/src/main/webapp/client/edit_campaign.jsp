<%@ page import="model.Campaign" %>
<%@ page import="dao.CampaignDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    int campaignId = Integer.parseInt(request.getParameter("campaignId"));
    CampaignDAO campaignDAO = new CampaignDAO();
    Campaign campaign = campaignDAO.getCampaignById(campaignId);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Campaign</title>
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

        .container {
            display: flex;
            flex-direction: row;
            min-height: 90vh;
        }

        nav.sidebar {
            width: 220px;
            background: #fff;
            padding: 20px;
            box-shadow: 2px 0 6px rgba(0,0,0,0.05);
            border-right: 1px solid #ddd;
        }

        nav.sidebar h3 {
            margin-bottom: 20px;
            color: #0d6efd;
        }

        nav.sidebar ul {
            list-style: none;
            padding: 0;
        }

        nav.sidebar ul li {
            margin: 15px 0;
        }

        nav.sidebar ul li a {
            text-decoration: none;
            color: #333;
            font-weight: 500;
            padding: 8px 12px;
            display: block;
            border-radius: 8px;
            transition: 0.2s;
        }

        nav.sidebar ul li a:hover {
            background: #0d6efd;
            color: #fff;
        }

        main.content {
            flex: 1;
            padding: 40px 60px;
        }

        main.content h2 {
            font-size: 1.8rem;
            margin-bottom: 30px;
        }

        .card {
            background: #fff;
            padding: 30px;
            border-radius: 16px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.1);
            max-width: 800px;
            margin: auto;
        }

        .card form label {
            display: block;
            font-weight: 600;
            margin-bottom: 6px;
            margin-top: 15px;
        }

        .card form input[type="text"],
        .card form input[type="email"],
        .card form input[type="number"],
        .card form input[type="file"],
        .card form select,
        .card form textarea {
            width: 100%;
            padding: 12px 14px;
            border-radius: 10px;
            border: 1px solid #ccc;
            margin-bottom: 10px;
            font-size: 1rem;
            transition: border 0.2s, box-shadow 0.2s;
        }

        .card form input:focus,
        .card form textarea:focus,
        .card form select:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 6px rgba(13,110,253,0.3);
            outline: none;
        }

        .card form button, .card form a {
            margin-top: 20px;
            padding: 14px;
            font-size: 1.1rem;
            border-radius: 12px;
            font-weight: 600;
            width: 48%;
            text-align: center;
            display: inline-block;
            text-decoration: none;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .card form button {
            background: #0d6efd;
            color: #fff;
            border: none;
            cursor: pointer;
        }

        .card form button:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
        }

        .card form a {
            background: #6c757d;
            color: #fff;
        }

        .card form a:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
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

        @media (max-width: 900px) {
            .container {
                flex-direction: column;
            }

            nav.sidebar {
                width: 100%;
                border-right: none;
                box-shadow: 0 2px 8px rgba(0,0,0,0.05);
                margin-bottom: 20px;
            }

            main.content {
                padding: 20px 30px;
            }

            .card form button, .card form a {
                width: 100%;
                margin-bottom: 10px;
            }
        }
    </style>
</head>
<body>

<header>
    ✏️ Edit Campaign
</header>

<div class="container">
    <nav class="sidebar">
        <h3>Dashboard</h3>
        <ul>
            <li><a href="dashboard.jsp">Home</a></li>
            <li><a href="my_campaigns.jsp">My Campaigns</a></li>
            <li><a href="payments.jsp">Payments</a></li>
            <li><a href="profile.jsp">Profile</a></li>
            <li><a href="logout.jsp">Logout</a></li>
        </ul>
    </nav>

    <main class="content">
        <div class="card">
            <form action="<%= request.getContextPath() %>/CampaignServlet" method="post" enctype="multipart/form-data">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="campaignId" value="<%= campaign.getCampaignId() %>">

                <label>Title</label>
                <input type="text" name="title" value="<%= campaign.getTitle() %>" required>

                <label>Objective</label>
                <textarea name="objective" rows="3" required><%= campaign.getObjective() %></textarea>

                <label>Budget</label>
                <input type="number" step="0.01" name="budget" value="<%= campaign.getBudget() %>" required>

                <label>Audience</label>
                <input type="text" name="audience" value="<%= campaign.getAudience() %>" required>

                <label>Status</label>
                <select name="status">
                    <option value="Pending" <%= "Pending".equals(campaign.getStatus()) ? "selected" : "" %>>Pending</option>
                    <option value="Approved" <%= "Approved".equals(campaign.getStatus()) ? "selected" : "" %>>Approved</option>
                    <option value="Rejected" <%= "Rejected".equals(campaign.getStatus()) ? "selected" : "" %>>Rejected</option>
                </select>

                <label>Email</label>
                <input type="email" name="email" value="<%= campaign.getEmail() %>" required>

                <label>Contact</label>
                <input type="text" name="contact" value="<%= campaign.getContact() %>" required>

                <label>Media File</label>
                <input type="file" name="mediaFile">
                <% if (campaign.getMediaFile() != null) { %>
                Current: <a href="<%= request.getContextPath() %>/uploads/<%= campaign.getMediaFile() %>" target="_blank">View</a>
                <% } %>

                <button type="submit">Update Campaign</button>
                <a href="my_campaigns.jsp">Cancel</a>
            </form>
        </div>
    </main>
</div>

<footer>
    &copy; 2025 Advertising Agency System
</footer>

</body>
</html>
