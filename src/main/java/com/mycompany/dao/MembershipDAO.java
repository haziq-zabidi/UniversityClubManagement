package com.mycompany.dao;

import com.mycompany.model.Membership;
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
}
