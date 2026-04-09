package dao;

import model.Analytics;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AnalyticsDAO {

    public List<Analytics> getAnalyticsForCampaign(int campaignId) {
        List<Analytics> analyticsList = new ArrayList<>();
        String sql = "SELECT * FROM Analytics WHERE campaign_id=?";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, campaignId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                analyticsList.add(new Analytics(
                        rs.getInt("analytics_id"),
                        rs.getInt("campaign_id"),
                        rs.getInt("impressions"),
                        rs.getInt("clicks"),
                        rs.getInt("conversions"),  // ✅ now exists in model
                        rs.getDate("report_date")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return analyticsList;
    }

    public List<Analytics> getAllAnalytics() {
        List<Analytics> list = new ArrayList<>();
        String sql = "SELECT * FROM Analytics";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Analytics a = new Analytics();
                a.setAnalyticsId(rs.getInt("analyticsId"));
                a.setCampaignId(rs.getInt("campaign_Id")); // exact column name
                a.setImpressions(rs.getInt("impressions"));
                a.setClicks(rs.getInt("clicks"));
                a.setConversions(rs.getInt("conversions"));
                a.setConversionRate(rs.getDouble("conversionRate"));
                a.setRoi(rs.getDouble("roi"));
                a.setReportDate(rs.getDate("reportDate"));
                list.add(a);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

}
