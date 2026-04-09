package controller;

import dao.PaymentDAO;
import model.Payment;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/finance/verify_payments")
public class FinancePaymentServlet extends HttpServlet {

    private final PaymentDAO paymentDAO = new PaymentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null || !"Finance".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Handle approve/reject actions
        String action = request.getParameter("action");
        String idStr = request.getParameter("id");

        if (action != null && idStr != null) {
            int paymentId = Integer.parseInt(idStr);
            if ("approve".equalsIgnoreCase(action)) {
                paymentDAO.updatePaymentStatus(paymentId, "Approved");
            } else if ("reject".equalsIgnoreCase(action)) {
                paymentDAO.updatePaymentStatus(paymentId, "Rejected");
            }
            response.sendRedirect(request.getContextPath() + "/finance/verify_payments");
            return;
        }

        // Load all payments
        List<Payment> payments = paymentDAO.getAllPayments();
        request.setAttribute("payments", payments);

        request.getRequestDispatcher("/finance/verify_payments.jsp").forward(request, response);
    }
}
