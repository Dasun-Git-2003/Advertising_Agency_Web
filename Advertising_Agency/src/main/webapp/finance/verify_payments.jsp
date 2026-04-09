<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Payment" %>
<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"Finance".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    List<Payment> payments = (List<Payment>) request.getAttribute("payments");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Verify Payments</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        body {
            background: #f4f6f9;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .page-title {
            text-align: center;
            font-size: 1.8rem;
            font-weight: 600;
            margin: 40px 0 20px 0;
            color: #343a40;
        }
        .card-container {
            background: #fff;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
            padding: 25px;
            max-width: 1200px;
            margin: 0 auto 40px auto;
        }
        table thead {
            background: #0d6efd;
            color: #fff;
        }
        table th, table td {
            vertical-align: middle;
        }
        .badge-status {
            padding: 0.5em 0.75em;
            border-radius: 12px;
            font-size: 0.85rem;
        }
        .btn-sm {
            margin: 2px 2px 2px 0;
        }
        .btn-action {
            min-width: 80px;
        }
        .back-btn {
            display: inline-block;
            margin: 20px auto;
            background: linear-gradient(90deg, #0d6efd, #6610f2);
            color: #fff;
            font-weight: 600;
            padding: 10px 25px;
            border-radius: 12px;
            text-decoration: none;
            transition: all 0.3s ease;
        }
        .back-btn:hover {
            background: linear-gradient(90deg, #6610f2, #0d6efd);
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(0,0,0,0.25);
            color: #fff;
        }
        @media (max-width: 768px) {
            .table-responsive { overflow-x: auto; }
            .btn-action { font-size: 0.8rem; padding: 4px 6px; }
        }
    </style>
</head>
<body>

<div class="page-title">💰 Verify Payments</div>

<div class="card-container table-responsive shadow-sm">
    <table class="table table-striped table-hover align-middle">
        <thead>
        <tr>
            <th>ID</th>
            <th>User</th>
            <th>Campaign</th>
            <th>Amount</th>
            <th>Method</th>
            <th>Status</th>
            <th>Date</th>
            <th>Slip</th>
            <th>Invoice</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            if (payments != null && !payments.isEmpty()) {
                for (Payment p : payments) {
        %>
        <tr>
            <td><%= p.getPaymentId() %></td>
            <td><%= p.getUserId() %></td>
            <td><%= p.getCampaignId() %></td>
            <td>$<%= String.format("%.2f", p.getAmount()) %></td>
            <td><%= p.getMethod() %></td>
            <td>
                <span class="badge badge-status
                    <%= "Approved".equalsIgnoreCase(p.getStatus()) ? "bg-success" :
                        ("Rejected".equalsIgnoreCase(p.getStatus()) ? "bg-danger" : "bg-warning text-dark") %>">
                    <%= p.getStatus() %>
                </span>
            </td>
            <td><%= p.getDate() %></td>
            <td>
                <% if (p.getSlipPath() != null && !p.getSlipPath().isEmpty()) { %>
                <a href="<%= request.getContextPath() + "/" + p.getSlipPath() %>" target="_blank" class="btn btn-outline-primary btn-sm btn-action">View</a>
                <% } else { %> N/A <% } %>
            </td>
            <td>
                <% if ("Approved".equalsIgnoreCase(p.getStatus()) && p.getInvoicePath() != null) { %>
                <a href="<%= request.getContextPath() + "/" + p.getInvoicePath() %>" target="_blank" class="btn btn-outline-secondary btn-sm btn-action">View</a>
                <% } else { %> N/A <% } %>
            </td>
            <td>
                <% if ("Pending".equalsIgnoreCase(p.getStatus())) { %>
                <a href="<%= request.getContextPath() %>/finance/verify_payments?action=approve&id=<%= p.getPaymentId() %>" class="btn btn-success btn-sm btn-action">Approve</a>
                <a href="<%= request.getContextPath() %>/finance/verify_payments?action=reject&id=<%= p.getPaymentId() %>" class="btn btn-danger btn-sm btn-action">Reject</a>
                <% } else { %>
                <span class="text-muted">N/A</span>
                <% } %>
            </td>
        </tr>
        <%  }
        } else { %>
        <tr>
            <td colspan="10" class="text-center text-muted">No payments found.</td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>

<div class="text-center">
    <a href="<%= request.getContextPath() %>/finance/dashboard.jsp" class="back-btn">⬅ Back to Dashboard</a>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
