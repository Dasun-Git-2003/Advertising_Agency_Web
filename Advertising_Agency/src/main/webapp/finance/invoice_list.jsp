<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="service.PaymentService" %>
<%@ page import="model.Payment" %>
<%@ page import="java.util.List" %>
<%
  // Check session role
  String sessionRole = (String) session.getAttribute("role");
  if (!"Finance".equalsIgnoreCase(sessionRole)) {
    response.sendRedirect(request.getContextPath() + "/login.jsp");
    return;
  }

  // Load all payments
  PaymentService paymentService = new PaymentService();
  List<Payment> payments = paymentService.getAllPayments();
%>
<!DOCTYPE html>
<html>
<head>
  <title>Invoices</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
</head>
<body>
<%@ include file="../includes/sidebar.jsp" %>

<div class="container mt-4">
  <h2>🧾 Invoices</h2>
  <table class="table table-bordered table-striped mt-3">
    <thead class="table-dark">
    <tr>
      <th>Payment ID</th>
      <th>User ID</th>
      <th>Campaign ID</th>
      <th>Amount</th>
      <th>Method</th>
      <th>Status</th>
      <th>Date</th>
      <th>Action</th>
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
      <td>$<%= p.getAmount() %></td>
      <td><%= p.getMethod() %></td>
      <td><%= p.getStatus() %></td>
      <td><%= p.getDate() %></td>
      <td>
        <% if ("Success".equalsIgnoreCase(p.getStatus())) { %>
        <a href="<%= request.getContextPath() %>/finance/generate_invoice.jsp?paymentId=<%= p.getPaymentId() %>"
           class="btn btn-sm btn-primary">Generate Invoice</a>
        <% } else { %>
        <span class="text-muted">Not ready</span>
        <% } %>
      </td>
    </tr>
    <%
      }
    } else {
    %>
    <tr>
      <td colspan="8" class="text-center">No payments found.</td>
    </tr>
    <%
      }
    %>
    </tbody>
  </table>
</div>
</body>
</html>
