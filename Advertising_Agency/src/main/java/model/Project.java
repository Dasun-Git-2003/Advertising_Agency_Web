package model;

import java.time.LocalDate;

public class Project {
    private int projectId;
    private String name;
    private String description;
    private LocalDate deadline;
    private int campaignId;  // link project to campaign

    public Project() {}

    // Constructor for new project
    public Project(String name, String description, LocalDate deadline, int campaignId) {
        this.name = name;
        this.description = description;
        this.deadline = deadline;
        this.campaignId = campaignId;
    }

    // Constructor with ID
    public Project(int projectId, String name, String description, LocalDate deadline, int campaignId) {
        this.projectId = projectId;
        this.name = name;
        this.description = description;
        this.deadline = deadline;
        this.campaignId = campaignId;
    }

    // Getters and Setters
    public int getProjectId() {
        return projectId;
    }

    public void setProjectId(int projectId) {
        this.projectId = projectId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public LocalDate getDeadline() {
        return deadline;
    }

    public void setDeadline(LocalDate deadline) {
        this.deadline = deadline;
    }

    public int getCampaignId() {
        return campaignId;
    }

    public void setCampaignId(int campaignId) {
        this.campaignId = campaignId;
    }
}
