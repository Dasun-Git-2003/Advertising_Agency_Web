package controller;

import dao.AnalyticsDAO;
import model.Analytics;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/AnalyticsServlet")
public class AnalyticsServlet extends HttpServlet {
    private AnalyticsDAO analyticsDAO = new AnalyticsDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int campaignId = Integer.parseInt(request.getParameter("campaign_id"));
        List<Analytics> reports = analyticsDAO.getAnalyticsForCampaign(campaignId);

        request.setAttribute("analytics", reports);
        request.getRequestDispatcher("analyst/analytics_dashboard.jsp").forward(request, response);


    }
}
