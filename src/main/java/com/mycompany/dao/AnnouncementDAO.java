package com.mycompany.dao;

import com.mycompany.model.Announcement;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AnnouncementDAO {

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

    // Get all announcements (admin or general use)
    public List<Announcement> getAllAnnouncements() throws SQLException, ClassNotFoundException {
        List<Announcement> list = new ArrayList<>();
        String sql = "SELECT * FROM announcement ORDER BY publishDate DESC";
        try (Connection conn = DBConnect.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

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
        return list;
    }

    // Get announcements for a specific club (committee member)
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

    // Get announcements created by a specific user (committee member)
    public List<Announcement> getAnnouncementsByAuthor(int authorUserID) throws SQLException, ClassNotFoundException {
        List<Announcement> list = new ArrayList<>();
        String sql = "SELECT * FROM announcement WHERE authorUserID=? ORDER BY publishDate DESC";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, authorUserID);
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
}
