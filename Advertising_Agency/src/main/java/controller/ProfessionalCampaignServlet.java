package controller;

import dao.CampaignDAO;
import model.Campaign;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/ProfessionalCampaignServlet")
public class ProfessionalCampaignServlet extends HttpServlet {

    private CampaignDAO campaignDAO;

    @Override
    public void init() throws ServletException {
        campaignDAO = new CampaignDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null || session.getAttribute("role") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        Integer professionalId = (Integer) session.getAttribute("userId");
        String role = (String) session.getAttribute("role");

        if (!"Professional".equalsIgnoreCase(role)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Fetch all approved campaigns assigned to this professional
        List<Campaign> campaigns = campaignDAO.getApprovedCampaigns(); // Or customize for assigned campaigns

        request.setAttribute("campaigns", campaigns);
        request.getRequestDispatcher("/professional/assigned_campaigns.jsp").forward(request, response);
    }
}
