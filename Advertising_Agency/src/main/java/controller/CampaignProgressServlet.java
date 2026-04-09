package controller;

import dao.CampaignDAO;
import dao.TaskDAO;
import model.Campaign;
import model.Task;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/CampaignProgressServlet")
public class CampaignProgressServlet extends HttpServlet {
    private CampaignDAO campaignDAO;
    private TaskDAO taskDAO;

    @Override
    public void init() throws ServletException {
        campaignDAO = new CampaignDAO();
        taskDAO = new TaskDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        String role = (String) session.getAttribute("role");

        if (userId == null || role == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Fetch campaigns assigned to professional
        List<Campaign> campaigns = TaskDAO.getAssignedCampaignsForProfessional(userId);

        // Attach tasks to each campaign
        for (Campaign campaign : campaigns) {
            List<Task> tasks = TaskDAO.getTasksByCampaignAndProfessional(campaign.getCampaignId(), userId);
            campaign.setTasks(tasks);
        }

        request.setAttribute("campaigns", campaigns);
        request.getRequestDispatcher("/professional/campaign_progress.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
