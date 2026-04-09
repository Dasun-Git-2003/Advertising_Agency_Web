<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Reports</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <style>
        .report-card {
            transition: transform 0.2s;
        }
        .report-card:hover {
            transform: scale(1.03);
            box-shadow: 0 0 15px rgba(0,0,0,0.2);
        }
    </style>
</head>
<body>

<%@ include file="../includes/header.jsp" %>

<div class="container mt-4">
    <h2>📊 System Reports</h2>
    <div class="row mt-3">
        <div class="col-md-3">
            <div class="card report-card">
                <div class="card-body text-center">
                    <h5 class="card-title">User Report</h5>
                    <p class="card-text">Download a PDF of all users.</p>
                    <a href="<%= request.getContextPath() %>/ReportServlet?type=users" class="btn btn-primary">Download PDF</a>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card report-card">
                <div class="card-body text-center">
                    <h5 class="card-title">Campaign Report</h5>
                    <p class="card-text">Download a PDF of all campaigns.</p>
                    <a href="<%= request.getContextPath() %>/ReportServlet?type=campaigns" class="btn btn-primary">Download PDF</a>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card report-card">
                <div class="card-body text-center">
                    <h5 class="card-title">Payment Report</h5>
                    <p class="card-text">Download a PDF of all payments.</p>
                    <a href="<%= request.getContextPath() %>/ReportServlet?type=payments" class="btn btn-primary">Download PDF</a>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card report-card">
                <div class="card-body text-center">
                    <h5 class="card-title">Analytics Report</h5>
                    <p class="card-text">Download an analytics summary PDF.</p>
                    <a href="<%= request.getContextPath() %>/ReportServlet?type=analytics" class="btn btn-primary">Download PDF</a>
                </div>
            </div>
        </div>
    </div>

    <a href="dashboard.jsp" class="btn btn-link mt-4">⬅ Back to Dashboard</a>
</div>

<%@ include file="../includes/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
