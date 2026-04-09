package controller;

import dao.CampaignDAO;
import dao.MessageDAO;
import dao.UserDAO;
import model.User;
import model.Message;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/AdminServlet")
public class AdminServlet extends HttpServlet {

    private CampaignDAO campaignDAO;
    private UserDAO userDAO;
    private MessageDAO messageDAO;

    @Override
    public void init() throws ServletException {
        campaignDAO = new CampaignDAO();
        userDAO = new UserDAO();
        messageDAO = new MessageDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession(false);

        // Check session and role
        if (session == null || !"Admin".equalsIgnoreCase((String) session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            if (action == null) {
                response.sendRedirect("AdminServlet?action=dashboard");
                return;
            }

            switch (action.toLowerCase()) {
                case "approve":
                    approveCampaign(request, response);
                    break;

                case "reject":
                    rejectCampaign(request, response);
                    break;

                case "activate":
                    activateUser(request, response);
                    break;

                case "deactivate":
                    deactivateUser(request, response);
                    break;

                case "delete":
                    deleteUser(request, response);
                    break;

                case "dashboard":
                    int adminId = (Integer) session.getAttribute("userId");

                    // ✅ Fetch unread messages for admin
                    List<Message> unreadMessages = messageDAO.getUnreadMessagesByUser(adminId, "Admin");
                    request.setAttribute("unreadMessages", unreadMessages);

                    request.getRequestDispatcher("admin/dashboard.jsp").forward(request, response);
                    break;

                case "manage_users":
                    List<User> users = userDAO.getAllUsers();
                    request.setAttribute("users", users);
                    request.getRequestDispatcher("admin/manage_users.jsp").forward(request, response);
                    break;

                default:
                    response.sendRedirect("AdminServlet?action=dashboard");
                    break;
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private void approveCampaign(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int campaignId = Integer.parseInt(request.getParameter("id"));
        campaignDAO.updateStatus(campaignId, "Approved");

        HttpSession session = request.getSession();
        Integer adminId = (Integer) session.getAttribute("userId");

        // ✅ Send system message using correct method
        Message systemMessage = new Message();
        systemMessage.setCampaignId(campaignId);
        systemMessage.setSenderId(adminId);
        systemMessage.setSenderRole("Admin");
        systemMessage.setContent("Group chat created for this campaign.");

        messageDAO.addMessage(systemMessage); // Fixed

        response.sendRedirect("AdminServlet?action=dashboard");
    }


    private void rejectCampaign(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int campaignId = Integer.parseInt(request.getParameter("id"));
        campaignDAO.updateStatus(campaignId, "Rejected");
        response.sendRedirect("AdminServlet?action=dashboard");
    }

    private void deactivateUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int userId = Integer.parseInt(request.getParameter("id"));
        userDAO.updateStatus(userId, "Inactive");
        response.sendRedirect("AdminServlet?action=manage_users");
    }

    private void activateUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int userId = Integer.parseInt(request.getParameter("id"));
        userDAO.updateStatus(userId, "Active");
        response.sendRedirect("AdminServlet?action=manage_users");
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int userId = Integer.parseInt(request.getParameter("id"));
        userDAO.deleteUser(userId);
        response.sendRedirect("AdminServlet?action=manage_users");
    }


}
