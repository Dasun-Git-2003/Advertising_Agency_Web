package controller;

import dao.PaymentDAO;
import model.Payment;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {
    private PaymentDAO paymentDAO = new PaymentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("invoice".equals(action)) {
            int paymentId = Integer.parseInt(request.getParameter("paymentId"));
            Payment p = paymentDAO.getPaymentById(paymentId);
            request.setAttribute("payment", p);
            request.getRequestDispatcher("finance/invoice.jsp").forward(request, response);
        } else {
            List<Payment> allPayments = paymentDAO.getAllPayments();
            request.setAttribute("payments", allPayments);
            request.getRequestDispatcher("admin/payments_report.jsp").forward(request, response);
        }
    }
}
