package com.mycompany.dao;

import com.mycompany.model.Announcement;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AnnouncementDAO {

    // Add new announcement
    public boolean addAnnouncement(Announcement a) throws SQLException, ClassNotFoundException {
        Connection conn = DBConnect.getConnection();
        PreparedStatement ps = conn.prepareStatement(
            "INSERT INTO announcement (announcementTitle, announcementMessage, publishDate, clubID, authorUserID) VALUES (?,?,?,?,?)"
        );
        ps.setString(1, a.getAnnouncementTitle());
        ps.setString(2, a.getAnnouncementMessage());
        ps.setDate(3, Date.valueOf(a.getPublishDate()));
        ps.setInt(4, a.getClubID());
        ps.setInt(5, a.getAuthorUserID());
        boolean inserted = ps.executeUpdate() > 0;
        DBConnect.closeConnection(conn);
        return inserted;
    }

    // Get all announcements
    public List<Announcement> getAllAnnouncements() throws SQLException, ClassNotFoundException {
        List<Announcement> list = new ArrayList<>();
        Connection conn = DBConnect.getConnection();
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM announcement");
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
        DBConnect.closeConnection(conn);
        return list;
    }

    // Get announcements by club
    public List<Announcement> getAnnouncementsByClub(int clubID) throws SQLException, ClassNotFoundException {
        List<Announcement> list = new ArrayList<>();
        Connection conn = DBConnect.getConnection();
        PreparedStatement ps = conn.prepareStatement("SELECT * FROM announcement WHERE clubID=?");
        ps.setInt(1, clubID);
        ResultSet rs = ps.executeQuery();
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
        DBConnect.closeConnection(conn);
        return list;
    }

    // Update announcement
    public boolean updateAnnouncement(Announcement a) throws SQLException, ClassNotFoundException {
        Connection conn = DBConnect.getConnection();
        PreparedStatement ps = conn.prepareStatement(
            "UPDATE announcement SET announcementTitle=?, announcementMessage=? WHERE announcementID=?"
        );
        ps.setString(1, a.getAnnouncementTitle());
        ps.setString(2, a.getAnnouncementMessage());
        ps.setInt(3, a.getAnnouncementID());
        boolean updated = ps.executeUpdate() > 0;
        DBConnect.closeConnection(conn);
        return updated;
    }

    // Delete announcement
    public boolean deleteAnnouncement(int announcementID) throws SQLException, ClassNotFoundException {
        Connection conn = DBConnect.getConnection();
        PreparedStatement ps = conn.prepareStatement("DELETE FROM announcement WHERE announcementID=?");
        ps.setInt(1, announcementID);
        boolean deleted = ps.executeUpdate() > 0;
        DBConnect.closeConnection(conn);
        return deleted;
    }
}
