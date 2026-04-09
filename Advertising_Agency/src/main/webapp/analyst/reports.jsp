<%@ page import="java.util.List" %>
<%@ page import="model.Campaign,model.Analytics" %>
<%
    String view = request.getParameter("view");
%>

<html>
<head>
    <title>Analyst Reports</title>
</head>
<body>
<h2>Analyst Reports</h2>
<nav>
    <a href="../ReportServlet?type=campaigns">Campaign Performance</a> |
    <a href="../ReportServlet?type=analytics">Detailed Analytics</a>
</nav>
<hr/>

<% if ("campaigns".equals(view)) { %>
<h3>Campaign Performance</h3>
<table border="1">
    <tr><th>ID</th><th>Title</th><th>Objective</th><th>Budget</th><th>Status</th></tr>
    <%
        List<Campaign> campaigns = (List<Campaign>) request.getAttribute("campaigns");
        if (campaigns != null) {
            for (Campaign c : campaigns) {
    %>
    <tr>
        <td><%= c.getCampaignId() %></td>
        <td><%= c.getTitle() %></td>
        <td><%= c.getObjective() %></td>
        <td><%= c.getBudget() %></td>
        <td><%= c.getStatus() %></td>
    </tr>
    <% } } %>
</table>
<% } else if ("analytics".equals(view)) { %>
<h3>Analytics Report</h3>
<table border="1">
    <tr><th>ID</th><th>Campaign</th><th>Impressions</th><th>Clicks</th><th>Conversions</th><th>ROI</th></tr>
    <%
        List<Analytics> analytics = (List<Analytics>) request.getAttribute("analytics");
        if (analytics != null) {
            for (Analytics a : analytics) {
    %>
    <tr>
        <td><%= a.getAnalyticsId() %></td>
        <td><%= a.getCampaignId() %></td>
        <td><%= a.getImpressions() %></td>
        <td><%= a.getClicks() %></td>
        <td><%= a.getConversions() %></td>
        <td><%= a.getRoi() %></td>
    </tr>
    <% } } %>
</table>
<% } else { %>
<p>Select a report type from above.</p>
<% } %>
</body>
</html>
