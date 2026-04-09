package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    // JDBC details
    private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=AdvertisingAgency;encrypt=true;trustServerCertificate=true";
    private static final String USER = "sa";
    private static final String PASSWORD = "1234";

    // Singleton instance
    private static DBConnection instance;
    private Connection connection;

    // Private constructor (prevents direct creation)
    private DBConnection() throws SQLException {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            this.connection = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("SQL Server JDBC Driver not found!", e);
        }
    }

    // Get the Singleton instance
    public static DBConnection getInstance() throws SQLException {
        if (instance == null || instance.connection.isClosed()) {
            synchronized (DBConnection.class) {
                if (instance == null || instance.connection.isClosed()) {
                    instance = new DBConnection();
                }
            }
        }
        return instance;
    }

    // Get the active connection
    public Connection getConnection() {
        return connection;
    }

    // Optional: Close connection
    public void closeConnection() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Test
    public static void main(String[] args) {
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            if (conn != null && !conn.isClosed()) {
                System.out.println("✅ Singleton DB Connection successful!");
            }
        } catch (SQLException e) {
            System.err.println("❌ Connection failed: " + e.getMessage());
        }
    }
}
