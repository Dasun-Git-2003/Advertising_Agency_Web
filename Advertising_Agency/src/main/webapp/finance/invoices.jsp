<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dao.PaymentDAO" %>
<%@ page import="model.Payment" %>
<%
    String paymentIdStr = request.getParameter("paymentId");
    PaymentDAO paymentDAO = new PaymentDAO();
    Payment p = null;

    if (paymentIdStr != null) {
        int paymentId = Integer.parseInt(paymentIdStr);
        p = paymentDAO.getPaymentById(paymentId);
    }
%>

<% if (p != null) { %>
<h2>Invoice</h2>
<p><strong>Invoice ID:</strong> INV-<%= p.getPaymentId() %></p>
<p><strong>User ID:</strong> <%= p.getUserId() %></p>
<p><strong>Campaign ID:</strong> <%= p.getCampaignId() %></p>
<p><strong>Amount:</strong> $<%= p.getAmount() %></p>
<p><strong>Payment Method:</strong> <%= p.getMethod() %></p>
<p><strong>Status:</strong> <%= p.getStatus() %></p>
<p><strong>Date:</strong> <%= p.getDate() %></p>
<hr>
<p>Thank you for your payment!</p>
<% } else { %>
<p>Invoice not found.</p>
<% } %>
