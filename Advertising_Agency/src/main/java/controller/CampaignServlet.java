package controller;

import dao.CampaignDAO;
import model.Campaign;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;

@WebServlet("/CampaignServlet")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 10 * 1024 * 1024,
        maxRequestSize = 20 * 1024 * 1024
)
public class CampaignServlet extends HttpServlet {

    private CampaignDAO campaignDAO;
    private static final String UPLOAD_DIR = "uploads";

    @Override
    public void init() {
        campaignDAO = new CampaignDAO();
    }

    // Show campaigns
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer clientId = (Integer) session.getAttribute("userId");
        if (clientId == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Handle delete via GET
        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            int campaignId = Integer.parseInt(request.getParameter("campaignId"));
            campaignDAO.deleteCampaign(campaignId);
        }

        // Fetch campaigns for this client
        List<Campaign> campaigns = campaignDAO.getCampaignsByClientId(clientId);
        request.setAttribute("campaigns", campaigns);
        request.getRequestDispatcher("/client/my_campaigns.jsp").forward(request, response);
    }

    // Handle create/update
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if ("create".equals(action)) createCampaign(request, response);
        else if ("update".equals(action)) updateCampaign(request, response);
    }

    private void createCampaign(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        HttpSession session = request.getSession();
        Integer clientId = (Integer) session.getAttribute("userId");
        if (clientId == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String title = request.getParameter("title");
        String objective = request.getParameter("objective");
        double budget = Double.parseDouble(request.getParameter("budget"));
        String audience = request.getParameter("audience");
        String email = request.getParameter("email");
        String contact = request.getParameter("contact");

        // Handle file upload
        Part filePart = request.getPart("mediaFile");
        String fileName = null;
        if (filePart != null && filePart.getSize() > 0) {
            fileName = filePart.getSubmittedFileName();
            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();
            try (InputStream input = filePart.getInputStream()) {
                Files.copy(input, Path.of(uploadPath, fileName));
            }
        }

        Campaign campaign = new Campaign(clientId, title, objective, budget, audience, "Pending", email, contact, fileName);
        campaignDAO.addCampaign(campaign);

        doGet(request, response);
    }

    private void updateCampaign(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        int campaignId = Integer.parseInt(request.getParameter("campaignId"));
        String title = request.getParameter("title");
        String objective = request.getParameter("objective");
        double budget = Double.parseDouble(request.getParameter("budget"));
        String audience = request.getParameter("audience");
        String status = request.getParameter("status");
        String email = request.getParameter("email");
        String contact = request.getParameter("contact");

        // Handle file upload
        Part filePart = request.getPart("mediaFile");
        String fileName = null;
        if (filePart != null && filePart.getSize() > 0) {
            fileName = filePart.getSubmittedFileName();
            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();
            try (InputStream input = filePart.getInputStream()) {
                Files.copy(input, Path.of(uploadPath, fileName));
            }
        }

        Campaign campaign = new Campaign(campaignId, title, objective, budget, audience, status, email, contact, fileName);
        campaignDAO.updateCampaign(campaign);

        doGet(request, response);
    }
}
