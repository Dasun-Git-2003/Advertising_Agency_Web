package dao;

import model.Message;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MessageDAO {

    // Add a message (user or system)
    public boolean addMessage(Message message) {
        String sql = "INSERT INTO Messages (campaign_id, sender_id, sender_role, content, media_path, created_at, is_deleted, is_edited) " +
                "VALUES (?, ?, ?, ?, ?, GETDATE(), 0, 0)";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, message.getCampaignId());
            stmt.setInt(2, message.getSenderId());
            stmt.setString(3, message.getSenderRole());
            stmt.setString(4, message.getContent());
            stmt.setString(5, message.getMediaPath()); // can be null
            return stmt.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get unread messages by user
    public List<Message> getUnreadMessagesByUser(int userId, String role) {
        List<Message> list = new ArrayList<>();
        String sql = "SELECT * FROM Messages WHERE sender_id != ? AND is_deleted = 0 AND campaign_id IN (" +
                "SELECT campaign_id FROM Campaigns WHERE status = 'Approved') ORDER BY created_at ASC";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    public int getUnreadCount(int userId, String role) {
        String sql = "SELECT COUNT(*) AS cnt FROM Messages " +
                "WHERE is_read = 0 AND (sender_role <> ? OR receiver_role = ?)";

        int count = 0;
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, role);  // exclude messages sent by this user
            stmt.setString(2, role);  // include messages intended for this role if needed

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt("cnt");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    public List<Message> getMessagesByCampaign(int campaignId) {
        List<Message> list = new ArrayList<>();
        String sql = "SELECT * FROM Messages WHERE campaign_id = ? AND is_deleted = 0 ORDER BY created_at ASC";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, campaignId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                list.add(mapRow(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // Send a new message
    public boolean sendMessage(Message message) {
        String sql = "INSERT INTO Messages (campaign_id, sender_id, sender_role, content, media_path, created_at, is_deleted) " +
                "VALUES (?, ?, ?, ?, ?, GETDATE(), 0)";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, message.getCampaignId());
            stmt.setInt(2, message.getSenderId());
            stmt.setString(3, message.getSenderRole());
            stmt.setString(4, message.getContent());
            stmt.setString(5, message.getMediaPath()); // can be null

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get a single message by ID
    public Message getMessageById(int messageId) {
        String sql = "SELECT * FROM Messages WHERE message_id = ?";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, messageId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return mapRow(rs);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Update a message (only content)
    public boolean updateMessage(Message message) {
        String sql = "UPDATE Messages SET content = ?, is_edited = GETDATE() WHERE message_id = ?";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, message.getContent());
            stmt.setInt(2, message.getMessageId());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteMessagePermanent(int messageId) {
        String sql = "DELETE FROM Messages WHERE message_id = ?";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, messageId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }



    // Map ResultSet row → Message object
    private Message mapRow(ResultSet rs) throws SQLException {
        Message m = new Message();
        m.setMessageId(rs.getInt("message_id"));
        m.setCampaignId(rs.getInt("campaign_id"));
        m.setSenderId(rs.getInt("sender_id"));
        m.setSenderRole(rs.getString("sender_role"));
        m.setContent(rs.getString("content"));
        m.setMediaPath(rs.getString("media_path"));
        m.setCreatedAt(rs.getTimestamp("created_at"));
        m.setDeleted(rs.getBoolean("is_deleted"));
        m.setEditedAt(rs.getTimestamp("is_edited"));
        return m;
    }

}
