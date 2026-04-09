package dao;

import java.sql.*;
import java.util.*;
import model.Campaign;
import model.Task;
import util.DBConnection;

public class TaskDAO {

    // Add new task
    public static boolean addTask(Task task) {
        String sql = "INSERT INTO Tasks (campaign_id, professional_id, title, description, status, created_at, updated_at) "
                + "VALUES (?,?,?,?,?,GETDATE(),GETDATE())";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, task.getCampaignId());
            ps.setInt(2, task.getProfessionalId());
            ps.setString(3, task.getTitle());
            ps.setString(4, task.getDescription());
            ps.setString(5, task.getStatus() == null ? "Pending" : task.getStatus());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    // TaskDAO.java
    public static List<Task> getTasksByCampaign(int campaignId) {
        List<Task> tasks = new ArrayList<>();
        String sql = "SELECT * FROM Tasks WHERE campaign_id=? ORDER BY created_at";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, campaignId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Task t = new Task();
                t.setTaskId(rs.getInt("task_id"));
                t.setCampaignId(rs.getInt("campaign_id"));
                t.setProfessionalId(rs.getInt("assigned_to")); // match DB column
                t.setTitle(rs.getString("title"));
                t.setDescription(rs.getString("description"));
                t.setStatus(rs.getString("status"));
                t.setCreatedAt(rs.getTimestamp("created_at"));
                t.setUpdatedAt(rs.getTimestamp("completed_at")); // optional
                tasks.add(t);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tasks;
    }

    // Update task status
    public static boolean updateTaskStatus(int taskId, String status) {
        String sql = "UPDATE Tasks SET status=?, updated_at=GETDATE() WHERE task_id=?";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, taskId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    // Get all tasks for a specific campaign
    public List<Task> getTasksByCampaignId(int campaignId) {
        List<Task> tasks = new ArrayList<>();
        String sql = "SELECT * FROM Task WHERE campaignId = ?";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, campaignId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Task t = new Task();
                t.setTaskId(rs.getInt("taskId"));
                t.setCampaignId(rs.getInt("campaignId"));
                t.setTitle(rs.getString("title"));
                t.setDescription(rs.getString("description"));
                t.setStatus(rs.getString("status")); // Pending, In Progress, Completed
                tasks.add(t);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return tasks;
    }
    // Get all approved campaigns (assigned to all professionals)
    public static List<Campaign> getAssignedCampaignsForProfessional(int professionalId) {
        String sql = "SELECT * FROM Campaigns WHERE status='Approved' ORDER BY created_at DESC";
        List<Campaign> campaigns = new ArrayList<>();
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Campaign c = new Campaign();
                c.setCampaignId(rs.getInt("campaign_id"));
                c.setClientId(rs.getInt("client_id"));
                c.setTitle(rs.getString("title"));
                c.setObjective(rs.getString("objective"));
                c.setBudget(rs.getDouble("budget"));
                c.setAudience(rs.getString("audience"));
                c.setStatus(rs.getString("status"));
                c.setEmail(rs.getString("email"));
                c.setContact(rs.getString("contact"));
                c.setCreatedAt(rs.getTimestamp("created_at"));
                c.setMediaFile(rs.getString("media_file"));
                campaigns.add(c);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return campaigns;
    }

    // Get tasks for a campaign **for a specific professional**
    public static List<Task> getTasksByCampaignAndProfessional(int campaignId, int professionalId) {
        List<Task> tasks = new ArrayList<>();
        String sql = "SELECT * FROM Tasks WHERE campaign_id=? AND professional_id=? ORDER BY created_at";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, campaignId);
            ps.setInt(2, professionalId);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Task t = new Task();
                t.setTaskId(rs.getInt("task_id"));
                t.setCampaignId(rs.getInt("campaign_id"));
                t.setProfessionalId(rs.getInt("professional_id"));
                t.setTitle(rs.getString("title"));
                t.setDescription(rs.getString("description"));
                t.setStatus(rs.getString("status"));
                t.setCreatedAt(rs.getTimestamp("created_at"));
                t.setUpdatedAt(rs.getTimestamp("updated_at"));
                tasks.add(t);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tasks;
    }
}
