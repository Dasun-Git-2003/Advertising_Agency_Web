package controller;

import dao.CampaignDAO;
import dao.AnalyticsDAO;
import model.Campaign;
import model.Analytics;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/ManagerServlet")
public class ManagerServlet extends HttpServlet {

    private CampaignDAO campaignDAO = new CampaignDAO();
    private AnalyticsDAO analyticsDAO = new AnalyticsDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null || action.equals("dashboard")) {
            // Fetch all campaigns
            List<Campaign> campaigns = campaignDAO.getAllCampaigns();

            // Fetch all analytics
            List<Analytics> analytics = analyticsDAO.getAllAnalytics();

            // Attach to request
            request.setAttribute("campaigns", campaigns);
            request.setAttribute("analytics", analytics);

            // Forward to dashboard
            request.getRequestDispatcher("/manager/dashboard.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
