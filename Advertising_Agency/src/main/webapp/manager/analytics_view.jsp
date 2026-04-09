<%@ page import="java.util.List, model.Analytics, model.Campaign" %>
<%
    List<Analytics> analytics = (List<Analytics>) request.getAttribute("analytics");
    List<Campaign> campaigns = (List<Campaign>) request.getAttribute("campaigns");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Analytics Overview</title>
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
            max-width: 1000px;
            margin: 40px auto;
            padding: 0 20px;
        }

        h2 {
            margin-bottom: 20px;
            font-size: 1.8rem;
            color: #0d6efd;
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

        td {
            font-size: 0.95rem;
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
            table, th, td {
                font-size: 0.85rem;
            }
        }
    </style>
</head>
<body>

<header>
    📈 Analytics Overview
</header>

<div class="container">
    <table>
        <thead>
        <tr>
            <th>Campaign</th>
            <th>Impressions</th>
            <th>Clicks</th>
            <th>Conversions</th>
            <th>Conversion Rate</th>
            <th>ROI</th>
        </tr>
        </thead>
        <tbody>
        <%
            if (analytics != null && !analytics.isEmpty()) {
                for (Analytics a : analytics) {
                    String campaignTitle = "";
                    for (Campaign c : campaigns) {
                        if (c.getCampaignId() == a.getCampaignId()) {
                            campaignTitle = c.getTitle();
                            break;
                        }
                    }
        %>
        <tr>
            <td><%= campaignTitle %></td>
            <td><%= a.getImpressions() %></td>
            <td><%= a.getClicks() %></td>
            <td><%= a.getConversions() %></td>
            <td><%= a.getConversionRate() %> %</td>
            <td>$<%= a.getRoi() %></td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="6" class="no-data">No analytics data available.</td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>

<footer>
    &copy; 2025 Advertising Agency System
</footer>

</body>
</html>
