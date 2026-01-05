package com.mycompany.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnect {

    private static final String url = "jdbc:mariadb://localhost:3307/club_management_db"; // your DB
    private static final String username = "root"; // default XAMPP username
    private static final String password = ""; // default XAMPP password

    public static Connection getConnection() throws ClassNotFoundException, SQLException {
        Class.forName("org.mariadb.jdbc.Driver");
        return DriverManager.getConnection(url, username, password);
    }

    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try { conn.close(); } 
            catch (SQLException e) { e.printStackTrace(); }
        }
    }
}
