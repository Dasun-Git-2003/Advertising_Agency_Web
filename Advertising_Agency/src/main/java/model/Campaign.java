package model;

import java.util.Date;
import java.util.List;

public class Campaign {
    private int campaignId;
    private int clientId;
    private String title;
    private String objective;
    private double budget;
    private String audience;
    private String status;
    private String email;
    private String contact;
    private Date createdAt;
    private String mediaFile;

    private List<Task> tasks; // add this field



    // Default constructor
    public Campaign() {}

    // Full constructor
    public Campaign(int campaignId, int clientId, String title, String objective, double budget,
                    String audience, String status, String email, String contact, Date createdAt, String mediaFile) {
        this.campaignId = campaignId;
        this.clientId = clientId;
        this.title = title;
        this.objective = objective;
        this.budget = budget;
        this.audience = audience;
        this.status = status;
        this.email = email;
        this.contact = contact;
        this.createdAt = createdAt;
        this.mediaFile = mediaFile;
    }

    // Constructor for creating new campaigns
    public Campaign(int clientId, String title, String objective, double budget,
                    String audience, String status, String email, String contact, String mediaFile) {
        this.clientId = clientId;
        this.title = title;
        this.objective = objective;
        this.budget = budget;
        this.audience = audience;
        this.status = status;
        this.email = email;
        this.contact = contact;
        this.mediaFile = mediaFile;
        this.createdAt = new Date();
    }
    public List<Task> getTasks() {
        return tasks;
    }

    public void setTasks(List<Task> tasks) {
        this.tasks = tasks;
    }
    // --- Getters and Setters ---
    public int getCampaignId() { return campaignId; }
    public void setCampaignId(int campaignId) { this.campaignId = campaignId; }

    public int getClientId() { return clientId; }
    public void setClientId(int clientId) { this.clientId = clientId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getObjective() { return objective; }
    public void setObjective(String objective) { this.objective = objective; }

    public double getBudget() { return budget; }
    public void setBudget(double budget) { this.budget = budget; }

    public String getAudience() { return audience; }
    public void setAudience(String audience) { this.audience = audience; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getContact() { return contact; }
    public void setContact(String contact) { this.contact = contact; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }

    public String getMediaFile() { return mediaFile; }
    public void setMediaFile(String mediaFile) { this.mediaFile = mediaFile; }
}
