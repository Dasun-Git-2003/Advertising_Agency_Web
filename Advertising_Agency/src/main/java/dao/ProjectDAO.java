package dao;

import model.Project;
import util.DBConnection;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class ProjectDAO {

    // Add project
    public boolean addProject(Project project) {
        String sql = "INSERT INTO Projects (name, description, deadline, campaign_id) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, project.getName());
            stmt.setString(2, project.getDescription());
            stmt.setDate(3, Date.valueOf(project.getDeadline())); // ✅ Convert LocalDate to SQL Date
            stmt.setInt(4, project.getCampaignId());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get project by ID
    public Project getProjectById(int id) {
        String sql = "SELECT * FROM Projects WHERE project_id=?";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new Project(
                        rs.getInt("project_id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDate("deadline").toLocalDate(),
                        rs.getInt("campaign_id")
                );
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Get all projects
    public List<Project> getAllProjects() {
        List<Project> projects = new ArrayList<>();
        String sql = "SELECT * FROM Projects";

        try (Connection conn = DBConnection.getInstance().getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                projects.add(new Project(
                        rs.getInt("project_id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDate("deadline").toLocalDate(),
                        rs.getInt("campaign_id")
                ));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return projects;
    }

    // Update project
    public boolean updateProject(Project project) {
        String sql = "UPDATE Projects SET name=?, description=?, deadline=?, campaign_id=? WHERE project_id=?";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, project.getName());
            stmt.setString(2, project.getDescription());
            stmt.setDate(3, Date.valueOf(project.getDeadline()));
            stmt.setInt(4, project.getCampaignId());
            stmt.setInt(5, project.getProjectId());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Delete project
    public boolean deleteProject(int id) {
        String sql = "DELETE FROM Projects WHERE project_id=?";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
