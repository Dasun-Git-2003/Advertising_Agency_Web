package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

public class ReportServlet extends HttpServlet {

    // Database connection details
    private static final String JDBC_URL = "jdbc:sqlserver://localhost:1433;databaseName=AdvertisingAgency;encrypt=false";
    private static final String JDBC_USER = "sa";
    private static final String JDBC_PASSWORD = "your_password";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String type = request.getParameter("type"); // users, campaigns, payments, analytics
        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
            out.println("<html><head><title>Report</title>");
            out.println("<link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css'>");
            out.println("</head><body class='container mt-4'>");

            if (type == null) {
                out.println("<h3 class='text-danger'>⚠ Report type not specified!</h3>");
            } else {
                switch (type) {
                    case "users":
                        generateUserReport(out);
                        break;
                    case "campaigns":
                        generateCampaignReport(out);
                        break;
                    case "payments":
                        generatePaymentReport(out);
                        break;
                    case "analytics":
                        generateAnalyticsReport(out);
                        break;
                    default:
                        out.println("<h3 class='text-danger'>⚠ Invalid report type!</h3>");
                }
            }

            out.println("<a href='admin/reports.jsp' class='btn btn-secondary mt-3'>⬅ Back to Reports</a>");
            out.println("</body></html>");
        }
    }

    private void generateUserReport(PrintWriter out) {
        out.println("<h2>👥 User Report</h2>");
        String sql = "SELECT id, name, email, role FROM Users";
        printTable(out, sql, new String[]{"ID", "Name", "Email", "Role"});
    }

    private void generateCampaignReport(PrintWriter out) {
        out.println("<h2>📢 Campaign Report</h2>");
        String sql = "SELECT id, title, startDate, endDate FROM Campaigns";
        printTable(out, sql, new String[]{"ID", "Title", "Start Date", "End Date"});
    }

    private void generatePaymentReport(PrintWriter out) {
        out.println("<h2>💳 Payment Report</h2>");
        String sql = "SELECT id, userId, amount, paymentDate FROM Payments";
        printTable(out, sql, new String[]{"ID", "User ID", "Amount", "Payment Date"});
    }

    private void generateAnalyticsReport(PrintWriter out) {
        out.println("<h2>📊 Analytics Report</h2>");
        String sql = "SELECT campaignId, views, clicks FROM Analytics";
        printTable(out, sql, new String[]{"Campaign ID", "Views", "Clicks"});
    }

    private void printTable(PrintWriter out, String query, String[] headers) {
        try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            out.println("<table class='table table-bordered table-striped mt-3'>");
            out.println("<thead><tr>");
            for (String h : headers) {
                out.println("<th>" + h + "</th>");
            }
            out.println("</tr></thead><tbody>");

            while (rs.next()) {
                out.println("<tr>");
                for (String h : headers) {
                    out.println("<td>" + rs.getString(h.replace(" ", "")) + "</td>");
                }
                out.println("</tr>");
            }
            out.println("</tbody></table>");

        } catch (Exception e) {
            out.println("<p class='text-danger'>Error: " + e.getMessage() + "</p>");
        }
    }
}
