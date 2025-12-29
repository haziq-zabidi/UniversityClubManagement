package com.mycompany.dao;

import com.mycompany.model.Membership;
import com.mycompany.model.User;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.time.LocalDate;


public class MembershipDAO {

    // Add user to club
    public boolean addMembership(Membership m) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO membership (joinDate, membershipStatus, userID, clubID) VALUES (?,?,?,?)";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setDate(1, java.sql.Date.valueOf(m.getJoinDate())); // Convert LocalDate to java.sql.Date
            ps.setString(2, m.getMembershipStatus());
            ps.setInt(3, m.getUserID());
            ps.setInt(4, m.getClubID());

            return ps.executeUpdate() > 0;
        }
    }

    // Remove user from club
    public boolean removeMembership(int userID, int clubID) throws SQLException, ClassNotFoundException {
        String sql = "DELETE FROM membership WHERE userID=? AND clubID=?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userID);
            ps.setInt(2, clubID);

            return ps.executeUpdate() > 0;
        }
    }

    // Get all memberships of a user
    public List<Membership> getMembershipsByUser(int userID) throws SQLException, ClassNotFoundException {
        List<Membership> list = new ArrayList<>();
        String sql = "SELECT * FROM membership WHERE userID=?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userID);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Membership m = new Membership();
                    m.setMembershipID(rs.getInt("membershipID"));
                    m.setJoinDate(rs.getDate("joinDate").toLocalDate());
                    m.setMembershipStatus(rs.getString("membershipStatus"));
                    m.setUserID(rs.getInt("userID"));
                    m.setClubID(rs.getInt("clubID"));
                    list.add(m);
                }
            }
        }
        return list;
    }

    // Get all members of a club
    public List<Membership> getMembersByClub(int clubID) throws SQLException, ClassNotFoundException {
        List<Membership> list = new ArrayList<>();
        String sql = "SELECT * FROM membership WHERE clubID=?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, clubID);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Membership m = new Membership();
                    m.setMembershipID(rs.getInt("membershipID"));
                    m.setJoinDate(rs.getDate("joinDate").toLocalDate());
                    m.setMembershipStatus(rs.getString("membershipStatus"));
                    m.setUserID(rs.getInt("userID"));
                    m.setClubID(rs.getInt("clubID"));
                    list.add(m);
                }
            }
        }
        return list;
    }

    // ================= NEW METHODS FOR COMMITTEE =================

    // Get all pending member requests for a club
    public List<Membership> getPendingMembers(int clubID) throws SQLException, ClassNotFoundException {
        List<Membership> list = new ArrayList<>();
        String sql = "SELECT * FROM membership WHERE clubID=? AND membershipStatus='PENDING'";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, clubID);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Membership m = new Membership();
                    m.setMembershipID(rs.getInt("membershipID"));
                    m.setJoinDate(rs.getDate("joinDate").toLocalDate());
                    m.setMembershipStatus(rs.getString("membershipStatus"));
                    m.setUserID(rs.getInt("userID"));
                    m.setClubID(rs.getInt("clubID"));
                    list.add(m);
                }
            }
        }
        return list;
    }

    // Approve a pending member
    public boolean approveMember(int userID, int clubID) throws SQLException, ClassNotFoundException {
        String sql = "UPDATE membership SET membershipStatus='APPROVED' WHERE userID=? AND clubID=?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userID);
            ps.setInt(2, clubID);
            return ps.executeUpdate() > 0;
        }
    }

    // Reject a pending member
    public boolean rejectMember(int userID, int clubID) throws SQLException, ClassNotFoundException {
        String sql = "DELETE FROM membership WHERE userID=? AND clubID=? AND membershipStatus='PENDING'";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userID);
            ps.setInt(2, clubID);
            return ps.executeUpdate() > 0;
        }
    }
    
    // ================= NEW METHOD FOR ACTIVITY ATTENDANCE =================
    public boolean addAttendance(int activityID, int userID, LocalDate attendanceDate, String attendanceStatus)
            throws SQLException, ClassNotFoundException {

        String sql = "INSERT INTO attendance (attendanceDate, attendanceStatus, activityID, userID) VALUES (?,?,?,?)";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setDate(1, java.sql.Date.valueOf(attendanceDate));
            ps.setString(2, attendanceStatus);
            ps.setInt(3, activityID);
            ps.setInt(4, userID);

            return ps.executeUpdate() > 0;
        }
    }
    
    // ================= COMMITTEE MEMBER MANAGEMENT METHODS =================
    
    /**
     * Get all memberships for a specific club with user details joined
     * @param clubID The club ID
     * @return List of Membership objects with User details populated
     */
    public List<Membership> getMembershipsByClub(int clubID) throws SQLException, ClassNotFoundException {
        List<Membership> memberships = new ArrayList<>();
        String sql = "SELECT m.membershipID, m.joinDate, m.membershipStatus, m.userID, m.clubID, " +
                     "u.userName, u.userEmail, u.matricNo, u.faculty, u.programme, u.roleID " +
                     "FROM membership m " +
                     "INNER JOIN user u ON m.userID = u.userID " +
                     "WHERE m.clubID = ? " +
                     "ORDER BY m.joinDate DESC";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, clubID);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                // Create User object
                User user = new User();
                user.setUserID(rs.getInt("userID"));
                user.setUserName(rs.getString("userName"));
                user.setUserEmail(rs.getString("userEmail"));
                user.setMatricNo(rs.getString("matricNo"));
                user.setFaculty(rs.getString("faculty"));
                user.setProgramme(rs.getString("programme"));
                user.setRoleID(rs.getInt("roleID"));
                
                // Create Membership object
                Membership membership = new Membership();
                membership.setMembershipID(rs.getInt("membershipID"));
                membership.setJoinDate(rs.getDate("joinDate").toLocalDate());
                membership.setMembershipStatus(rs.getString("membershipStatus"));
                membership.setUserID(rs.getInt("userID"));
                membership.setClubID(rs.getInt("clubID"));
                membership.setUser(user);  // Set the user object
                
                memberships.add(membership);
            }
        }
        
        return memberships;
    }
    
    /**
     * Delete a membership by membershipID
     * @param membershipID The membership ID to delete
     * @return true if successful, false otherwise
     */
    public boolean deleteMembership(int membershipID) throws SQLException, ClassNotFoundException {
        String sql = "DELETE FROM membership WHERE membershipID = ?";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, membershipID);
            int rowsAffected = pstmt.executeUpdate();
            
            return rowsAffected > 0;
        }
    }
    
    /**
     * Update membership status
     * @param membershipID The membership ID
     * @param status The new status (Active/Inactive)
     * @return true if successful, false otherwise
     */
    public boolean updateMembershipStatus(int membershipID, String status) throws SQLException, ClassNotFoundException {
        String sql = "UPDATE membership SET membershipStatus = ? WHERE membershipID = ?";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, status);
            pstmt.setInt(2, membershipID);
            int rowsAffected = pstmt.executeUpdate();
            
            return rowsAffected > 0;
        }
    }
}