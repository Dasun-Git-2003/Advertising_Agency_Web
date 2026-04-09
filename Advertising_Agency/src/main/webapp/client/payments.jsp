<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.Payment" %>
<%@ page import="model.Campaign" %>
<%
    // Ensure user is logged in
    Integer sessionUserId = (Integer) session.getAttribute("userId");
    String sessionRole = (String) session.getAttribute("role");
    if (sessionUserId == null || sessionRole == null || !"Client".equalsIgnoreCase(sessionRole)) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    List<Payment> payments = (List<Payment>) request.getAttribute("payments");
    if (payments == null) payments = new ArrayList<>();

    List<Campaign> campaigns = (List<Campaign>) request.getAttribute("campaigns");
    if (campaigns == null) campaigns = new ArrayList<>();
%>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<div class="container mt-5">
    <h2 class="mb-4">📢 My Campaigns & Payments</h2>

    <!-- ================= Campaigns Table ================= -->
    <h4 class="mt-3">My Campaigns</h4>
    <table class="table table-striped table-hover shadow-sm">
        <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Budget</th>
            <th>Status</th>
            <th>Pay</th>
        </tr>
        </thead>
        <tbody>
        <%
            if (!campaigns.isEmpty()) {
                for (Campaign c : campaigns) {
        %>
        <tr>
            <td><%= c.getCampaignId() %></td>
            <td><%= c.getTitle() %></td>
            <td>$<%= c.getBudget() %></td>
            <td><%= c.getStatus() %></td>
            <td>
                <button type="button" class="btn btn-success btn-sm"
                        data-bs-toggle="modal" data-bs-target="#paymentModal"
                        onclick="setCampaignId(<%= c.getCampaignId() %>)">
                    Pay Now
                </button>
            </td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="5" class="text-center">No campaigns found.</td>
        </tr>
        <% } %>
        </tbody>
    </table>

    <!-- ================= Payment Modal ================= -->
    <div class="modal fade" id="paymentModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <form action="<%= request.getContextPath() %>/client/UserPaymentServlet" method="post" enctype="multipart/form-data">
                    <div class="modal-header">
                        <h5 class="modal-title">New Payment</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <!-- Hidden Campaign ID -->
                        <input type="hidden" name="campaignId" id="campaignId">

                        <div class="mb-3">
                            <label class="form-label">Amount</label>
                            <input type="number" step="0.01" class="form-control" name="amount" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Payment Method</label>
                            <select class="form-select" name="method" id="method" onchange="togglePaymentFields()">
                                <option value="Card">Card</option>
                                <option value="BankTransfer">Bank Transfer</option>
                            </select>
                        </div>

                        <!-- Card -->
                        <div class="mb-3" id="cardDiv">
                            <label class="form-label">Card Number</label>
                            <input type="text" class="form-control" name="cardNumber">
                        </div>

                        <!-- Bank Transfer -->
                        <div class="mb-3" id="slipDiv" style="display:none;">
                            <div class="bank-details">
                                <h6>Bank Details</h6>
                                <p><strong>Bank:</strong> BOC Bank</p>
                                <p><strong>Account No:</strong> 5628789</p>
                                <p><strong>Branch:</strong> Colombo Main</p>
                            </div>
                            <label class="form-label">Upload Bank Slip</label>
                            <input type="file" class="form-control" name="slip" accept=".pdf,.jpg,.png">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-success">Pay</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- ================= Payment History ================= -->
    <h4 class="mt-5 mb-3">Payment History</h4>
    <table class="table table-bordered table-hover shadow-sm">
        <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Campaign</th>
            <th>Amount</th>
            <th>Method</th>
            <th>Status</th>
            <th>Date</th>
            <th>Slip</th>
            <th>Invoice</th>
        </tr>
        </thead>
        <tbody>
        <%
            if (!payments.isEmpty()) {
                for (Payment p : payments) {
        %>
        <tr>
            <td><%= p.getPaymentId() %></td>
            <td><%= p.getCampaignId() %></td>
            <td>$<%= p.getAmount() %></td>
            <td><%= p.getMethod() %></td>
            <td>
                <% if("Pending".equalsIgnoreCase(p.getStatus())) { %>
                <span class="badge bg-warning text-dark">Pending</span>
                <% } else if("Approved".equalsIgnoreCase(p.getStatus())) { %>
                <span class="badge bg-success">Approved</span>
                <% } else if("Rejected".equalsIgnoreCase(p.getStatus())) { %>
                <span class="badge bg-danger">Rejected</span>
                <% } else { %>
                <span class="badge bg-secondary"><%= p.getStatus() %></span>
                <% } %>
            </td>
            <td><%= p.getDate() %></td>
            <td>
                <%= (p.getSlipPath() != null) ? "<a href='" + request.getContextPath() + "/" + p.getSlipPath() + "' target='_blank'>View</a>" : "N/A" %>
            </td>
            <td>
                <%= ("Approved".equalsIgnoreCase(p.getStatus()) && p.getInvoicePath() != null)
                        ? "<a href='" + request.getContextPath() + "/" + p.getInvoicePath() + "' target='_blank'>View</a>"
                        : "N/A" %>
            </td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="8" class="text-center">No payments found.</td>
        </tr>
        <% } %>
        </tbody>
    </table>

    <a href="<%= request.getContextPath() %>/client/dashboard.jsp" class="btn btn-secondary mt-3">⬅ Back to Dashboard</a>
</div>

<script>
    // Assign campaignId into modal hidden input
    function setCampaignId(id) {
        document.getElementById("campaignId").value = id;
    }

    function togglePaymentFields() {
        const method = document.getElementById('method').value;
        document.getElementById('cardDiv').style.display = (method === 'Card') ? 'block' : 'none';
        document.getElementById('slipDiv').style.display = (method === 'BankTransfer') ? 'block' : 'none';
    }
</script>
