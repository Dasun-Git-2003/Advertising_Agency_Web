package model;

import java.sql.Date;

public class Analytics {
    private int analyticsId;
    private int campaignId;
    private int impressions;
    private int clicks;
    private int conversions;   // ✅ Added conversions field
    private double conversionRate;
    private Date reportDate;
    private double roi;

    public Analytics() {}

    // Constructor without ROI
    public Analytics(int analyticsId, int campaignId, int impressions, int clicks, int conversions, Date reportDate) {
        this.analyticsId = analyticsId;
        this.campaignId = campaignId;
        this.impressions = impressions;
        this.clicks = clicks;
        this.conversions = conversions;
        this.reportDate = reportDate;

        // auto-calc conversionRate
        if (impressions > 0) {
            this.conversionRate = (double) conversions / impressions * 100.0;
        } else {
            this.conversionRate = 0.0;
        }
    }

    // Constructor with ROI
    public Analytics(int analyticsId, int campaignId, int impressions, int clicks, int conversions, Date reportDate, double roi) {
        this(analyticsId, campaignId, impressions, clicks, conversions, reportDate);
        this.roi = roi;
    }

    // ✅ Getters & Setters
    public int getAnalyticsId() { return analyticsId; }
    public void setAnalyticsId(int analyticsId) { this.analyticsId = analyticsId; }

    public int getCampaignId() { return campaignId; }
    public void setCampaignId(int campaignId) { this.campaignId = campaignId; }

    public int getImpressions() { return impressions; }
    public void setImpressions(int impressions) { this.impressions = impressions; }

    public int getClicks() { return clicks; }
    public void setClicks(int clicks) { this.clicks = clicks; }

    public int getConversions() { return conversions; }
    public void setConversions(int conversions) { this.conversions = conversions; }

    public double getConversionRate() { return conversionRate; }
    public void setConversionRate(double conversionRate) { this.conversionRate = conversionRate; }

    public Date getReportDate() { return reportDate; }
    public void setReportDate(Date reportDate) { this.reportDate = reportDate; }

    public double getRoi() { return roi; }
    public void setRoi(double roi) { this.roi = roi; }
}
