package dao;

import model.Payment;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PaymentDAO {



    /**
     * Get all payments of a specific user
     */
    public List<Payment> getPaymentsByUser(int userId) {
        List<Payment> payments = new ArrayList<>();
        String sql = "SELECT * FROM Payments WHERE user_id = ? ORDER BY payment_date DESC";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                payments.add(mapRow(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return payments;
    }

    /**
     * Add a new payment to the database
     */
    public boolean addPayment(Payment payment) {
        String sql = "INSERT INTO Payments " +
                "(user_id, campaign_id, amount, method, status, payment_date, card_masked, slip_path, invoice_path) " +
                "VALUES (?, ?, ?, ?, ?, GETDATE(), ?, ?, ?)";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, payment.getUserId());
            stmt.setInt(2, payment.getCampaignId());
            stmt.setDouble(3, payment.getAmount());
            stmt.setString(4, payment.getMethod());
            stmt.setString(5, payment.getStatus());
            stmt.setString(6, payment.getCardMasked());   // nullable
            stmt.setString(7, payment.getSlipPath());     // nullable
            stmt.setString(8, payment.getInvoicePath());  // initially null

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }


    /**
     * Get all payments (for finance/admin)
     */
    public List<Payment> getAllPayments() {
        List<Payment> payments = new ArrayList<>();
        String sql = "SELECT * FROM Payments ORDER BY payment_date DESC";

        try (Connection conn = DBConnection.getInstance().getConnection();
             Statement stmt = conn.createStatement()) {

            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                payments.add(mapRow(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return payments;
    }

    /**
     * Update payment status (Approved / Rejected / Pending)
     */
    public boolean updatePaymentStatus(int paymentId, String status) {
        String sql = "UPDATE Payments SET status = ? WHERE payment_id = ?";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            stmt.setInt(2, paymentId);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    /**
     * Update invoice path after Finance approves payment
     */
    public boolean updateInvoicePath(int paymentId, String invoicePath) {
        String sql = "UPDATE Payments SET invoice_path = ? WHERE payment_id = ?";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, invoicePath);
            stmt.setInt(2, paymentId);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    /**
     * Get a single payment by ID
     */
    public Payment getPaymentById(int paymentId) {
        String sql = "SELECT * FROM Payments WHERE payment_id = ?";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, paymentId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return mapRow(rs);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    /**
     * Optional: Get payments by status
     */
    public List<Payment> getPaymentsByStatus(String status) {
        List<Payment> payments = new ArrayList<>();
        String sql = "SELECT * FROM Payments WHERE status = ? ORDER BY payment_date DESC";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                payments.add(mapRow(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return payments;
    }

    /**
     * Map ResultSet row → Payment object
     */
    private Payment mapRow(ResultSet rs) throws SQLException {
        Payment p = new Payment();
        p.setPaymentId(rs.getInt("payment_id"));
        p.setUserId(rs.getInt("user_id"));
        p.setCampaignId(rs.getInt("campaign_id"));
        p.setAmount(rs.getDouble("amount"));
        p.setMethod(rs.getString("method"));
        p.setStatus(rs.getString("status"));
        p.setDate(rs.getTimestamp("payment_date"));
        p.setCardMasked(rs.getString("card_masked"));
        p.setSlipPath(rs.getString("slip_path"));
        p.setInvoicePath(rs.getString("invoice_path"));
        return p;
    }
}
