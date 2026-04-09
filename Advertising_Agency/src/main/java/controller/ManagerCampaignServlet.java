package controller;

import dao.CampaignDAO;
import model.Campaign;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/ManagerCampaignServlet")
public class ManagerCampaignServlet extends HttpServlet {

    private CampaignDAO campaignDAO;

    @Override
    public void init() {
        campaignDAO = new CampaignDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");

        if (role == null || !"Manager".equalsIgnoreCase(role)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // ✅ Get all approved campaigns
        List<Campaign> campaigns = campaignDAO.getCampaignsByStatus("Approved");
        request.setAttribute("campaigns", campaigns);

        // Forward to JSP
        request.getRequestDispatcher("/manager/review_campaigns.jsp").forward(request, response);
    }
}
