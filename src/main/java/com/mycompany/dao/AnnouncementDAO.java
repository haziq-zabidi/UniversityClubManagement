package com.mycompany.dao;

import com.mycompany.model.Announcement;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AnnouncementDAO {

    // Get total announcement count
public int getTotalAnnouncementCount() throws SQLException, ClassNotFoundException {
    int count = 0;
    String sql = "SELECT COUNT(*) as total FROM announcement";
    
    try (Connection conn = DBConnect.getConnection();
         Statement stmt = conn.createStatement();
         ResultSet rs = stmt.executeQuery(sql)) {
        if (rs.next()) {
            count = rs.getInt("total");
        }
    }
    return count;
}
    // Add new announcement
    public boolean addAnnouncement(Announcement a) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO announcement (announcementTitle, announcementMessage, publishDate, clubID, authorUserID) VALUES (?,?,?,?,?)";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, a.getAnnouncementTitle());
            ps.setString(2, a.getAnnouncementMessage());
            ps.setDate(3, Date.valueOf(a.getPublishDate())); // LocalDate → java.sql.Date
            ps.setInt(4, a.getClubID());
            ps.setInt(5, a.getAuthorUserID());

            return ps.executeUpdate() > 0;
        }
    }

    // Get all announcements for a specific club
    public List<Announcement> getAnnouncementsByClub(int clubID) throws SQLException, ClassNotFoundException {
        List<Announcement> list = new ArrayList<>();
        String sql = "SELECT * FROM announcement WHERE clubID=? ORDER BY publishDate DESC";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, clubID);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Announcement a = new Announcement();
                    a.setAnnouncementID(rs.getInt("announcementID"));
                    a.setAnnouncementTitle(rs.getString("announcementTitle"));
                    a.setAnnouncementMessage(rs.getString("announcementMessage"));
                    a.setPublishDate(rs.getDate("publishDate").toLocalDate());
                    a.setClubID(rs.getInt("clubID"));
                    a.setAuthorUserID(rs.getInt("authorUserID"));
                    list.add(a);
                }
            }
        }
        return list;
    }

    // Get single announcement by ID (needed for edit)
    public Announcement getAnnouncementByID(int announcementID) throws SQLException, ClassNotFoundException {
        Announcement a = null;
        String sql = "SELECT * FROM announcement WHERE announcementID=?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, announcementID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    a = new Announcement();
                    a.setAnnouncementID(rs.getInt("announcementID"));
                    a.setAnnouncementTitle(rs.getString("announcementTitle"));
                    a.setAnnouncementMessage(rs.getString("announcementMessage"));
                    a.setPublishDate(rs.getDate("publishDate").toLocalDate());
                    a.setClubID(rs.getInt("clubID"));
                    a.setAuthorUserID(rs.getInt("authorUserID"));
                }
            }
        }
        return a;
    }

    // Update announcement
    public boolean updateAnnouncement(Announcement a) throws SQLException, ClassNotFoundException {
        String sql = "UPDATE announcement SET announcementTitle=?, announcementMessage=? WHERE announcementID=?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, a.getAnnouncementTitle());
            ps.setString(2, a.getAnnouncementMessage());
            ps.setInt(3, a.getAnnouncementID());

            return ps.executeUpdate() > 0;
        }
    }

    // Delete announcement
    public boolean deleteAnnouncement(int announcementID) throws SQLException, ClassNotFoundException {
        String sql = "DELETE FROM announcement WHERE announcementID=?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, announcementID);
            return ps.executeUpdate() > 0;
        }
    }
    
    public List<Announcement> getAllAnnouncements()
        throws SQLException, ClassNotFoundException {

    List<Announcement> list = new ArrayList<>();
    String sql = """
        SELECT a.*, c.clubName, u.userName
        FROM announcement a
        JOIN club c ON a.clubID = c.clubID
        JOIN user u ON a.authorUserID = u.userID
        ORDER BY a.publishDate DESC
    """;

    try (Connection conn = DBConnect.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {
            Announcement a = new Announcement();
            a.setAnnouncementID(rs.getInt("announcementID"));
            a.setAnnouncementTitle(rs.getString("announcementTitle"));
            a.setAnnouncementMessage(rs.getString("announcementMessage"));
            a.setPublishDate(rs.getDate("publishDate").toLocalDate());
            a.setClubID(rs.getInt("clubID"));
            a.setAuthorUserID(rs.getInt("authorUserID"));

            // admin-only extra fields
            a.setClubName(rs.getString("clubName"));
            a.setAuthorName(rs.getString("userName"));

            list.add(a);
        }
    }
    return list;
}

    public Announcement getAnnouncementWithDetails(int id)
        throws SQLException, ClassNotFoundException {

    Announcement a = null;
    String sql = """
        SELECT a.*, c.clubName, u.userName
        FROM announcement a
        JOIN club c ON a.clubID = c.clubID
        JOIN user u ON a.authorUserID = u.userID
        WHERE a.announcementID=?
    """;

    try (Connection conn = DBConnect.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            a = new Announcement();
            a.setAnnouncementID(rs.getInt("announcementID"));
            a.setAnnouncementTitle(rs.getString("announcementTitle"));
            a.setAnnouncementMessage(rs.getString("announcementMessage"));
            a.setPublishDate(rs.getDate("publishDate").toLocalDate());
            a.setClubID(rs.getInt("clubID"));
            a.setAuthorUserID(rs.getInt("authorUserID"));
            a.setClubName(rs.getString("clubName"));
            a.setAuthorName(rs.getString("userName"));
        }
    }
    return a;
}
    
    public void adminUpdateAnnouncement(Announcement a)
        throws SQLException, ClassNotFoundException {

    String sql = """
        UPDATE announcement
        SET announcementTitle=?,
            announcementMessage=?,
            publishDate=?
        WHERE announcementID=?
    """;

    try (Connection conn = DBConnect.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setString(1, a.getAnnouncementTitle());
        ps.setString(2, a.getAnnouncementMessage());
        ps.setDate(3, java.sql.Date.valueOf(a.getPublishDate()));
        ps.setInt(4, a.getAnnouncementID());

        ps.executeUpdate();
    }
}

public void adminDeleteAnnouncement(int id)
        throws SQLException, ClassNotFoundException {

    String sql = "DELETE FROM announcement WHERE announcementID=?";

    try (Connection conn = DBConnect.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setInt(1, id);
        ps.executeUpdate();
    }
}

// Add this method to AnnouncementDAO.java
public int getAnnouncementCount(int clubID) throws SQLException, ClassNotFoundException {
    int count = 0;
    String sql = "SELECT COUNT(*) as total FROM announcement WHERE clubID = ?";
    
    try (Connection conn = DBConnect.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, clubID);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            count = rs.getInt("total");
        }
    }
    return count;
}

}
