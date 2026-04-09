package model;

import java.util.Date;

public class Payment {
    private int paymentId;
    private int userId;
    private int campaignId;
    private double amount;
    private String method;       // Card or BankTransfer
    private String status;       // Pending, Approved, Rejected, Success
    private Date date;
    private String slipPath;     // path to uploaded bank slip
    private String invoicePath;  // path to invoice PDF
    private String cardMasked;   // last 4 digits for card payments

    public Payment() {}

    public Payment(int paymentId, int userId, int campaignId, double amount, String method, String status,
                   Date date, String slipPath, String invoicePath, String cardMasked) {
        this.paymentId = paymentId;
        this.userId = userId;
        this.campaignId = campaignId;
        this.amount = amount;
        this.method = method;
        this.status = status;
        this.date = date;
        this.slipPath = slipPath;
        this.invoicePath = invoicePath;
        this.cardMasked = cardMasked;
    }

    // Getters and Setters
    public int getPaymentId() { return paymentId; }
    public void setPaymentId(int paymentId) { this.paymentId = paymentId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getCampaignId() { return campaignId; }
    public void setCampaignId(int campaignId) { this.campaignId = campaignId; }

    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }

    public String getMethod() { return method; }
    public void setMethod(String method) { this.method = method; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Date getDate() { return date; }
    public void setDate(Date date) { this.date = date; }

    public String getSlipPath() { return slipPath; }
    public void setSlipPath(String slipPath) { this.slipPath = slipPath; }

    public String getInvoicePath() { return invoicePath; }
    public void setInvoicePath(String invoicePath) { this.invoicePath = invoicePath; }

    public String getCardMasked() { return cardMasked; }
    public void setCardMasked(String cardMasked) { this.cardMasked = cardMasked; }
}
