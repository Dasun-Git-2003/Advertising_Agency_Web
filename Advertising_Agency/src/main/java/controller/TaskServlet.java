package controller;

import dao.TaskDAO;
import model.Campaign;
import model.Task;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.*;

@WebServlet("/TaskServlet")
public class TaskServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        String role = (String) session.getAttribute("role");

        if (userId == null || !"Professional".equalsIgnoreCase(role)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) action = "view";

        switch (action) {
            case "add":
                // Show create task page
                List<Campaign> campaigns = TaskDAO.getAssignedCampaignsForProfessional(userId);
                request.setAttribute("campaigns", campaigns);
                RequestDispatcher rd = request.getRequestDispatcher("/professional/create_task.jsp");
                rd.forward(request, response);
                break;

            case "view":
                // Show all tasks for this professional grouped by campaign
                List<Campaign> assignedCampaigns = TaskDAO.getAssignedCampaignsForProfessional(userId);
                Map<Integer, List<Task>> campaignTasksMap = new HashMap<>();
                for (Campaign c : assignedCampaigns) {
                    campaignTasksMap.put(c.getCampaignId(), TaskDAO.getTasksByCampaignAndProfessional(c.getCampaignId(), userId));
                }
                request.setAttribute("campaigns", assignedCampaigns);
                request.setAttribute("campaignTasks", campaignTasksMap);
                RequestDispatcher rdTasks = request.getRequestDispatcher("/professional/tasks.jsp");
                rdTasks.forward(request, response);
                break;

            case "complete":
                // Mark task as completed
                try {
                    int taskId = Integer.parseInt(request.getParameter("taskId"));
                    TaskDAO.updateTaskStatus(taskId, "Completed");
                } catch (Exception e) {
                    e.printStackTrace();
                }
                response.sendRedirect(request.getContextPath() + "/TaskServlet?action=view");
                break;

            default:
                response.sendRedirect(request.getContextPath() + "/professional/dashboard.jsp");
                break;
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Add new task
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        String role = (String) session.getAttribute("role");

        if (userId == null || !"Professional".equalsIgnoreCase(role)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            int campaignId = Integer.parseInt(request.getParameter("campaignId"));
            String title = request.getParameter("title");
            String description = request.getParameter("description");

            Task task = new Task();
            task.setCampaignId(campaignId);
            task.setProfessionalId(userId);
            task.setTitle(title);
            task.setDescription(description);
            task.setStatus("Pending");

            boolean saved = TaskDAO.addTask(task);

            if (saved) {
                response.sendRedirect(request.getContextPath() + "/TaskServlet?action=view&msg=Task+added+successfully");
            } else {
                request.setAttribute("error", "Unable to add task.");
                doGet(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Invalid input data.");
            doGet(request, response);
        }
    }
}
