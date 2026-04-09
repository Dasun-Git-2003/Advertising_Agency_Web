package dao;

import model.Campaign;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CampaignDAO {

    // Insert new campaign
    public boolean addCampaign(Campaign campaign) {
        String sql = "INSERT INTO Campaigns (client_id, title, objective, budget, audience, email, contact, status, created_at, media_file) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, campaign.getClientId());
            stmt.setString(2, campaign.getTitle());
            stmt.setString(3, campaign.getObjective());
            stmt.setDouble(4, campaign.getBudget());
            stmt.setString(5, campaign.getAudience());
            stmt.setString(6, campaign.getEmail());
            stmt.setString(7, campaign.getContact());
            stmt.setString(8, campaign.getStatus());
            stmt.setTimestamp(9, new Timestamp(campaign.getCreatedAt().getTime()));
            stmt.setString(10, campaign.getMediaFile());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get campaign by ID
    public Campaign getCampaignById(int id) {
        String sql = "SELECT * FROM Campaigns WHERE campaign_id = ?";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return mapResultSetToCampaign(rs);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Get all campaigns
    public List<Campaign> getAllCampaigns() {
        List<Campaign> campaigns = new ArrayList<>();
        String sql = "SELECT * FROM Campaigns";
        try (Connection conn = DBConnection.getInstance().getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) campaigns.add(mapResultSetToCampaign(rs));

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return campaigns;
    }
    // Get campaigns assigned to a professional
    public static List<Campaign> getAssignedCampaignsForProfessional(int professionalId) {
        List<Campaign> campaigns = new ArrayList<>();
        String sql = "SELECT c.* FROM Campaigns c " +
                "JOIN Tasks t ON c.campaign_id = t.campaign_id " +
                "WHERE t.professional_id = ? " +
                "GROUP BY c.campaign_id, c.client_id, c.title, c.objective, c.budget, c.audience, c.status, c.email, c.contact, c.created_at, c.media_file";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, professionalId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                campaigns.add(new Campaign(
                        rs.getInt("campaign_id"),
                        rs.getInt("client_id"),
                        rs.getString("title"),
                        rs.getString("objective"),
                        rs.getDouble("budget"),
                        rs.getString("audience"),
                        rs.getString("status"),
                        rs.getString("email"),
                        rs.getString("contact"),
                        rs.getTimestamp("created_at"),
                        rs.getString("media_file")
                ));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return campaigns;
    }
    public static List<Campaign> getCampaignsByClient(int clientId) {
        List<Campaign> campaigns = new ArrayList<>();
        String sql = "SELECT * FROM Campaigns WHERE client_id = ?";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, clientId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Campaign c = new Campaign();
                c.setCampaignId(rs.getInt("campaign_id"));
                c.setTitle(rs.getString("title"));
                c.setBudget(rs.getDouble("budget"));
                c.setStatus(rs.getString("status"));
                campaigns.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return campaigns;
    }

    // Get campaigns by client ID
    public List<Campaign> getCampaignsByClientId(int clientId) {
        List<Campaign> campaigns = new ArrayList<>();
        String sql = "SELECT * FROM Campaigns WHERE client_id = ?";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, clientId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                campaigns.add(new Campaign(
                        rs.getInt("campaign_id"),
                        rs.getInt("client_id"),
                        rs.getString("title"),
                        rs.getString("objective"),
                        rs.getDouble("budget"),
                        rs.getString("audience"),
                        rs.getString("status"),
                        rs.getString("email"),
                        rs.getString("contact"),
                        rs.getTimestamp("created_at"),
                        rs.getString("media_file")  // correct column name
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return campaigns;
    }

    // Update campaign
    public boolean updateCampaign(Campaign campaign) {
        String sql = "UPDATE Campaigns SET title=?, objective=?, budget=?, audience=?, email=?, contact=?, status=?, media_file=? " +
                "WHERE campaign_id=?";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, campaign.getTitle());
            stmt.setString(2, campaign.getObjective());
            stmt.setDouble(3, campaign.getBudget());
            stmt.setString(4, campaign.getAudience());
            stmt.setString(5, campaign.getEmail());
            stmt.setString(6, campaign.getContact());
            stmt.setString(7, campaign.getStatus());
            stmt.setString(8, campaign.getMediaFile());
            stmt.setInt(9, campaign.getCampaignId());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // CampaignDAO.java method
    public boolean updateStatus(int campaignId, String status) {
        String sql = "UPDATE Campaigns SET status=? WHERE campaign_id=?";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setInt(2, campaignId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete campaign
    public boolean deleteCampaign(int id) {
        String sql = "DELETE FROM Campaigns WHERE campaign_id=?";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Campaign> getCampaignsByStatus(String status) {
        List<Campaign> list = new ArrayList<>();
        String sql = "SELECT * FROM Campaigns WHERE status = ?";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(mapResultSetToCampaign(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    public List<Campaign> getApprovedCampaigns() {
        List<Campaign> campaigns = new ArrayList<>();
        String sql = "SELECT * FROM Campaigns WHERE status = 'Approved' ORDER BY created_at DESC";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

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
                c.setMediaFile(rs.getString("media_file")); // can be null
                campaigns.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return campaigns;
    }
    // Get approved campaigns for a specific user
    public List<Campaign> getApprovedCampaignsByUser(int userId) {
        List<Campaign> campaigns = new ArrayList<>();
        String sql = "SELECT * FROM Campaign WHERE status='Approved' AND userId = ?";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Campaign c = new Campaign();
                c.setCampaignId(rs.getInt("campaignId"));
                c.setTitle(rs.getString("title"));
                c.setObjective(rs.getString("description"));
                c.setStatus(rs.getString("status"));
                campaigns.add(c);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return campaigns;
    }
    // Helper method to map ResultSet to Campaign object
    private Campaign mapResultSetToCampaign(ResultSet rs) throws SQLException {
        return new Campaign(
                rs.getInt("campaign_id"),
                rs.getInt("client_id"),
                rs.getString("title"),
                rs.getString("objective"),
                rs.getDouble("budget"),
                rs.getString("audience"),
                rs.getString("status"),
                rs.getString("email"),
                rs.getString("contact"),
                rs.getTimestamp("created_at"),
                rs.getString("media_file")
        );
    }
}
