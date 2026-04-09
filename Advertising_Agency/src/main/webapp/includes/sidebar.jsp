<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%
    String sessionRole = (String) session.getAttribute("role");
    Integer sessionUserId = (Integer) session.getAttribute("userId");

    if (sessionRole == null || sessionUserId == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    Integer unreadCount = (Integer) request.getAttribute("unreadCount");
    if (unreadCount == null) unreadCount = 0;
%>

<aside class="sidebar">
    <div class="sidebar-header text-center">
        <img src="<%= request.getContextPath() %>/assets/images/default-user.png" class="sidebar-avatar" alt="User">
        <h5 class="mt-2 text-white"><%= sessionRole %></h5>
        <% if (unreadCount > 0) { %>
        <span class="badge bg-warning text-dark mt-1"><%= unreadCount %> new</span>
        <% } %>
    </div>

    <nav class="sidebar-nav">
        <% if ("Admin".equalsIgnoreCase(sessionRole)) { %>
        <a href="<%= request.getContextPath() %>/AdminServlet?action=dashboard">📊 Dashboard</a>
        <a href="<%= request.getContextPath() %>/AdminServlet?action=manage_users">👥 Manage Users</a>
        <a href="<%= request.getContextPath() %>/admin/register_user.jsp">➕ Add User</a>
        <a href="<%= request.getContextPath() %>/admin/approve_campaigns.jsp">📢 Approve Campaigns</a>
        <a href="<%= request.getContextPath() %>/admin/reports.jsp">📑 Reports</a>
        <a href="<%= request.getContextPath() %>/admin/settings.jsp">⚙️ Settings</a>

        <% } else if ("Client".equalsIgnoreCase(sessionRole)) { %>
        <a href="<%= request.getContextPath() %>/client/dashboard.jsp">📊 Dashboard</a>
        <a href="<%= request.getContextPath() %>/CampaignServlet">📢 My Campaigns</a>
        <a href="<%= request.getContextPath() %>/client/new_campaign.jsp">🆕 New Campaign</a>
        <a href="<%= request.getContextPath() %>/client/UserPaymentServlet">💳 Payments</a>

        <% } else if ("Professional".equalsIgnoreCase(sessionRole)) { %>
        <a href="<%= request.getContextPath() %>/professional/dashboard.jsp">📊 Dashboard</a>
        <a href="<%= request.getContextPath() %>/ProfessionalCampaignServlet">🛠 Assigned Campaigns</a>

        <% } else if ("Manager".equalsIgnoreCase(sessionRole)) { %>
        <a href="<%= request.getContextPath() %>/manager/dashboard.jsp">📊 Dashboard</a>
        <a href="<%= request.getContextPath() %>/ManagerCampaignServlet?action=review">📝 Review Campaigns</a>
        <a href="<%= request.getContextPath() %>/manager/analytics_view.jsp">📈 Analytics</a>
        <a href="<%= request.getContextPath() %>/manager/strategy.jsp">🎯 Strategy</a>
        <% } %>

        <hr class="sidebar-divider">
        <a href="<%= request.getContextPath() %>/profile.jsp">👤 Profile</a>
        <a href="<%= request.getContextPath() %>/LogoutServlet" class="text-danger">🚪 Logout</a>
    </nav>
</aside>

<style>
    .sidebar {
        width: 250px;
        min-height: 100vh;
        background: linear-gradient(to bottom, #6610f2, #0d6efd);
        color: #fff;
        padding: 20px 10px;
        position: fixed;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        transition: width 0.3s ease;
    }
    .sidebar-header {
        display: flex;
        flex-direction: column;
        align-items: center;
        margin-bottom: 30px;
    }
    .sidebar-avatar {
        width: 70px;
        height: 70px;
        border-radius: 50%;
        border: 3px solid #fff;
    }
    .sidebar-nav a {
        display: block;
        padding: 12px 15px;
        margin: 5px 0;
        color: #fff;
        text-decoration: none;
        border-radius: 8px;
        font-weight: 500;
        transition: all 0.3s ease;
    }
    .sidebar-nav a:hover {
        background: rgba(255, 255, 255, 0.2);
        color: #fff;
    }
    .sidebar-divider {
        border-top: 1px solid rgba(255,255,255,0.3);
        margin: 15px 0;
    }
</style>
