package controller;

import dao.MessageDAO;
import model.Message;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.util.List;

@WebServlet("/MessageServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
        maxFileSize = 1024 * 1024 * 10,               // 10MB
        maxRequestSize = 1024 * 1024 * 50)            // 50MB
public class MessageServlet extends HttpServlet {

    private MessageDAO messageDAO;

    @Override
    public void init() throws ServletException {
        messageDAO = new MessageDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String campaignIdStr = request.getParameter("campaignId");
        if (campaignIdStr == null || campaignIdStr.isEmpty()) {
            String role = (String) session.getAttribute("role");
            response.sendRedirect(request.getContextPath() + "/" + role.toLowerCase() + "/dashboard.jsp");
            return;
        }

        int campaignId = Integer.parseInt(campaignIdStr);
        List<Message> messages = messageDAO.getMessagesByCampaign(campaignId);

        request.setAttribute("messages", messages);
        request.setAttribute("campaignId", campaignId);
        request.getRequestDispatcher("/messages.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        Integer userId = (Integer) session.getAttribute("userId");
        String role = (String) session.getAttribute("role");
        String action = request.getParameter("action");
        if (action == null || action.isEmpty()) action = "send";

        switch (action) {
            case "send":
                handleSend(request, response, userId, role);
                break;

            case "delete":
                handleDelete(request, response, userId);
                break;

            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }

    private void handleSend(HttpServletRequest request, HttpServletResponse response, int userId, String role) throws IOException, ServletException {
        String campaignIdStr = request.getParameter("campaignId");
        String content = request.getParameter("content");
        if (campaignIdStr == null || content == null || content.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid data");
            return;
        }

        int campaignId = Integer.parseInt(campaignIdStr);

        // File upload
        Part filePart = request.getPart("media");
        String mediaPath = null;
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
            String uploadDir = getServletContext().getRealPath("/uploads");
            File uploadDirFile = new File(uploadDir);
            if (!uploadDirFile.exists()) uploadDirFile.mkdirs();
            filePart.write(uploadDir + File.separator + fileName);
            mediaPath = request.getContextPath() + "/uploads/" + fileName;
        }

        Message message = new Message();
        message.setCampaignId(campaignId);
        message.setSenderId(userId);
        message.setSenderRole(role);
        message.setContent(content.trim());
        message.setMediaPath(mediaPath);

        boolean sent = messageDAO.sendMessage(message);
        if (sent) {
            response.sendRedirect(request.getContextPath() + "/MessageServlet?campaignId=" + campaignId);
        } else {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to send message");
        }
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response, int userId) throws IOException {
        String delIdStr = request.getParameter("messageId");
        if (delIdStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid message ID");
            return;
        }

        int delMessageId = Integer.parseInt(delIdStr);
        Message msgToDelete = messageDAO.getMessageById(delMessageId);

        if (msgToDelete == null || msgToDelete.getSenderId() != userId) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "You cannot delete this message");
            return;
        }

        long now = System.currentTimeMillis();
        // Only allow delete within 5 minutes
        if (now - msgToDelete.getCreatedAt().getTime() > 5 * 60 * 1000) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "You cannot delete this message after 5 minutes");
            return;
        }

        boolean deleted = messageDAO.deleteMessagePermanent(delMessageId); // permanent delete
        if (deleted) {
            response.setStatus(HttpServletResponse.SC_OK);
        } else {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to delete message");
        }
    }
}
