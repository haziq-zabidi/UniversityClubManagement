package com.mycompany.dao;

import java.sql.Connection;
import java.sql.SQLException;

public class DBTest {
    public static void main(String[] args) {
        try {
            Connection conn = DBConnect.getConnection();
            if (conn != null) {
                System.out.println("Connection successful!");
                conn.close();
            } else {
                System.out.println("Connection failed!");
            }
        } catch (ClassNotFoundException e) {
            System.out.println("Driver not found: " + e.getMessage());
        } catch (SQLException e) {
            System.out.println("SQL error: " + e.getMessage());
        }
    }
}
