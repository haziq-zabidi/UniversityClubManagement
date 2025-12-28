package com.mycompany.model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UsersDAO {

    // Get all users (for admin user management)
    public List<User> getAllUsers() throws SQLException, ClassNotFoundException {
        List<User> list = new ArrayList<>();
        Connection conn = DBConnect.getConnection();
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM user");
        while (rs.next()) {
            User u = new User();
            u.setUserID(rs.getInt("userID"));
            u.setUserName(rs.getString("userName"));
            u.setUserEmail(rs.getString("userEmail"));
            u.setUserPassword(rs.getString("userPassword"));
            u.setMatricNo(rs.getString("matricNo"));
            u.setFaculty(rs.getString("faculty"));
            u.setProgramme(rs.getString("programme"));
            u.setRoleID(rs.getInt("roleID"));
            list.add(u);
        }
        DBConnect.closeConnection(conn);
        return list;
    }

    // Get a single user by email (for login)
    public User getUserByEmail(String email) throws SQLException, ClassNotFoundException {
        User u = null;
        Connection conn = DBConnect.getConnection();
        PreparedStatement ps = conn.prepareStatement("SELECT * FROM user WHERE userEmail=?");
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            u = new User();
            u.setUserID(rs.getInt("userID"));
            u.setUserName(rs.getString("userName"));
            u.setUserEmail(rs.getString("userEmail"));
            u.setUserPassword(rs.getString("userPassword"));
            u.setMatricNo(rs.getString("matricNo"));
            u.setFaculty(rs.getString("faculty"));
            u.setProgramme(rs.getString("programme"));
            u.setRoleID(rs.getInt("roleID"));
        }
        DBConnect.closeConnection(conn);
        return u;
    }

    // Insert new user (register)
    public boolean addUser(User u) throws SQLException, ClassNotFoundException {
        Connection conn = DBConnect.getConnection();
        PreparedStatement ps = conn.prepareStatement(
            "INSERT INTO user (userName, userEmail, userPassword, matricNo, faculty, programme, roleID) VALUES (?,?,?,?,?,?,?)"
        );
        ps.setString(1, u.getUserName());
        ps.setString(2, u.getUserEmail());
        ps.setString(3, u.getUserPassword());
        ps.setString(4, u.getMatricNo());
        ps.setString(5, u.getFaculty());
        ps.setString(6, u.getProgramme());
        ps.setInt(7, u.getRoleID());
        boolean inserted = ps.executeUpdate() > 0;
        DBConnect.closeConnection(conn);
        return inserted;
    }

    // Update user info (admin/user edit)
    public boolean updateUser(User u) throws SQLException, ClassNotFoundException {
        Connection conn = DBConnect.getConnection();
        PreparedStatement ps = conn.prepareStatement(
            "UPDATE user SET userName=?, userPassword=?, faculty=?, programme=?, roleID=? WHERE userEmail=?"
        );
        ps.setString(1, u.getUserName());
        ps.setString(2, u.getUserPassword());
        ps.setString(3, u.getFaculty());
        ps.setString(4, u.getProgramme());
        ps.setInt(5, u.getRoleID());
        ps.setString(6, u.getUserEmail());
        boolean updated = ps.executeUpdate() > 0;
        DBConnect.closeConnection(conn);
        return updated;
    }

    // Delete user (admin)
    public boolean deleteUser(int userID) throws SQLException, ClassNotFoundException {
        Connection conn = DBConnect.getConnection();
        PreparedStatement ps = conn.prepareStatement("DELETE FROM user WHERE userID=?");
        ps.setInt(1, userID);
        boolean deleted = ps.executeUpdate() > 0;
        DBConnect.closeConnection(conn);
        return deleted;
    }
}
