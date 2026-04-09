package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Campaign;
import model.Payment;
import service.PaymentService;
import dao.CampaignDAO;

import java.io.File;
import java.io.IOException;
import java.util.List;

@WebServlet("/client/UserPaymentServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024)
public class UserPaymentServlet extends HttpServlet {

    private final PaymentService paymentService = new PaymentService();
    private final CampaignDAO campaignDAO = new CampaignDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        List<Payment> payments = paymentService.getUserPayments(userId);
        List<Campaign> campaigns = campaignDAO.getCampaignsByClient(userId);

        request.setAttribute("campaigns", campaigns);
        request.setAttribute("payments", payments);
        request.getRequestDispatcher("/client/payments.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        int campaignId = Integer.parseInt(request.getParameter("campaignId"));
        double amount = Double.parseDouble(request.getParameter("amount"));
        String method = request.getParameter("method");

        Payment p = new Payment();
        p.setUserId(userId);
        p.setCampaignId(campaignId);
        p.setAmount(amount);

        boolean success = false;

        if ("Card".equalsIgnoreCase(method)) {
            String cardNumber = request.getParameter("cardNumber");
            success = paymentService.makeCardPayment(p, cardNumber);
        } else if ("BankTransfer".equalsIgnoreCase(method)) {
            Part slipPart = request.getPart("slip");
            if (slipPart != null && slipPart.getSize() > 0) {
                String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdirs();

                String fileName = System.currentTimeMillis() + "_" + slipPart.getSubmittedFileName();
                slipPart.write(uploadPath + File.separator + fileName);

                success = paymentService.makeBankTransfer(p, "uploads/" + fileName);
            }
        }

        if (success) {
            session.setAttribute("paymentSuccess", true);
        } else {
            session.setAttribute("paymentSuccess", false);
        }

        // Always redirect to doGet to reload payment history
        response.sendRedirect(request.getContextPath() + "/client/UserPaymentServlet");
    }
}
