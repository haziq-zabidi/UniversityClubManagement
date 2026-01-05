package com.mycompany.dao;

import com.mycompany.model.User;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UsersDAO {

    // Get total user count
public int getTotalUserCount() throws SQLException, ClassNotFoundException {
    int count = 0;
    String sql = "SELECT COUNT(*) as total FROM user";
    
    try (Connection conn = DBConnect.getConnection();
         Statement stmt = conn.createStatement();
         ResultSet rs = stmt.executeQuery(sql)) {
        if (rs.next()) {
            count = rs.getInt("total");
        }
    }
    return count;
}

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
        "UPDATE user SET userName=?, userEmail=?, userPassword=?, matricNo=?, faculty=?, programme=?, roleID=? WHERE userID=?"
    );
    ps.setString(1, u.getUserName());
    ps.setString(2, u.getUserEmail());
    ps.setString(3, u.getUserPassword());
    ps.setString(4, u.getMatricNo());
    ps.setString(5, u.getFaculty());
    ps.setString(6, u.getProgramme());
    ps.setInt(7, u.getRoleID());
    ps.setInt(8, u.getUserID());
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
    
    // Get user by ID
    public User getUserByID(int userID) throws SQLException, ClassNotFoundException {
        User user = null;
        String sql = "SELECT * FROM user WHERE userID = ?";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    user = new User();
                    user.setUserID(rs.getInt("userID"));
                    user.setUserName(rs.getString("userName"));
                    user.setUserEmail(rs.getString("userEmail"));
                    user.setUserPassword(rs.getString("userPassword"));
                    user.setMatricNo(rs.getString("matricNo"));
                    user.setFaculty(rs.getString("faculty"));
                    user.setProgramme(rs.getString("programme"));
                }
            }
        }
        return user;
    }
    
    // Update user profile (without password)
    public boolean updateUserProfile(User user) throws SQLException, ClassNotFoundException {
        String sql = "UPDATE user SET userName = ?, userEmail = ?, matricNo = ?, " +
                     "faculty = ?, programme = ? WHERE userID = ?";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getUserName());
            ps.setString(2, user.getUserEmail());
            ps.setString(3, user.getMatricNo());
            ps.setString(4, user.getFaculty());
            ps.setString(5, user.getProgramme());
            ps.setInt(6, user.getUserID());
            
            return ps.executeUpdate() > 0;
        }
    }
    
    // Update password
    public boolean updatePassword(int userID, String newPassword) throws SQLException, ClassNotFoundException {
        String sql = "UPDATE user SET userPassword = ? WHERE userID = ?";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newPassword);
            ps.setInt(2, userID);
            
            return ps.executeUpdate() > 0;
        }
    }
    
    // Get user by ID (alias method for compatibility)
public User getUserById(int userID) throws SQLException, ClassNotFoundException {
    return getUserByID(userID); // Just calls your existing method
}
    // Check if email already exists (for other users)
    public boolean isEmailExists(String email, int excludeUserID) throws SQLException, ClassNotFoundException {
        String sql = "SELECT COUNT(*) FROM user WHERE userEmail = ? AND userID != ?";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setInt(2, excludeUserID);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        }
    }
}
