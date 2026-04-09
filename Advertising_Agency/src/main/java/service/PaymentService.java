package service;

import dao.PaymentDAO;
import model.Payment;

import java.util.List;

public class PaymentService {
    private final PaymentDAO dao = new PaymentDAO();

    public boolean makeCardPayment(Payment p, String cardNumber) {
        String masked = cardNumber.replaceAll("\\d{12}(\\d{4})", "************$1");
        p.setCardMasked(masked);
        p.setMethod("Card");
        p.setStatus("Success");
        return dao.addPayment(p);
    }

    public boolean makeBankTransfer(Payment p, String slipPath) {
        p.setSlipPath(slipPath);
        p.setMethod("BankTransfer");
        p.setStatus("Pending");
        return dao.addPayment(p);
    }

    public List<Payment> getUserPayments(int userId) {
        return dao.getPaymentsByUser(userId);
    }

    public List<Payment> getAllPayments() {
        return dao.getAllPayments();
    }

    public boolean updatePaymentStatus(int paymentId, String status) {
        return dao.updatePaymentStatus(paymentId, status);
    }
    public boolean setInvoicePath(int paymentId, String invoicePath) {
        return dao.updateInvoicePath(paymentId, invoicePath);
    }

}
