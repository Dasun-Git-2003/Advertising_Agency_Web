package model;

import java.util.Date;

public class Task {
    private int taskId;
    private int campaignId;
    private int professionalId; // matches DB column professional_id
    private String title;
    private String description;
    private String status;
    private Date createdAt;
    private Date updatedAt;

    // Optional: track completion time
    private Date completedAt;

    public Task() {}

    public Task(int taskId, int campaignId, int professionalId, String title, String description, String status, Date createdAt, Date updatedAt, Date completedAt) {
        this.taskId = taskId;
        this.campaignId = campaignId;
        this.professionalId = professionalId;
        this.title = title;
        this.description = description;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.completedAt = completedAt;
    }

    // Getters & Setters
    public int getTaskId() { return taskId; }
    public void setTaskId(int taskId) { this.taskId = taskId; }

    public int getCampaignId() { return campaignId; }
    public void setCampaignId(int campaignId) { this.campaignId = campaignId; }

    public int getProfessionalId() { return professionalId; }
    public void setProfessionalId(int professionalId) { this.professionalId = professionalId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }

    public Date getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Date updatedAt) { this.updatedAt = updatedAt; }

    public Date getCompletedAt() { return completedAt; }
    public void setCompletedAt(Date completedAt) { this.completedAt = completedAt; }
}
