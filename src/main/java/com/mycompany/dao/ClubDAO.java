package com.mycompany.dao;

import com.mycompany.model.Club;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ClubDAO {

    // Get all clubs
    public List<Club> getAllClubs() throws SQLException, ClassNotFoundException {
        List<Club> list = new ArrayList<>();
        Connection conn = DBConnect.getConnection();
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM club");
        while (rs.next()) {
            Club c = new Club();
            c.setClubID(rs.getInt("clubID"));
            c.setClubName(rs.getString("clubName"));
            c.setClubDescription(rs.getString("clubDescription"));
            c.setClubCategory(rs.getString("clubCategory"));
            c.setAdminUserID(rs.getInt("adminUserID"));
            list.add(c);
        }
        DBConnect.closeConnection(conn);
        return list;
    }

    // Get club by clubID
    public Club getClubByID(int clubID) throws SQLException, ClassNotFoundException {
        Club c = null;
        Connection conn = DBConnect.getConnection();
        PreparedStatement ps = conn.prepareStatement("SELECT * FROM club WHERE clubID=?");
        ps.setInt(1, clubID);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            c = new Club();
            c.setClubID(rs.getInt("clubID"));
            c.setClubName(rs.getString("clubName"));
            c.setClubDescription(rs.getString("clubDescription"));
            c.setClubCategory(rs.getString("clubCategory"));
            c.setAdminUserID(rs.getInt("adminUserID"));
        }
        DBConnect.closeConnection(conn);
        return c;
    }

    // Get club by adminUserID
    public Club getClubByAdminUserID(int adminUserID) throws SQLException, ClassNotFoundException {
        Club c = null;
        Connection conn = DBConnect.getConnection();
        PreparedStatement ps = conn.prepareStatement("SELECT * FROM club WHERE adminUserID=?");
        ps.setInt(1, adminUserID);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            c = new Club();
            c.setClubID(rs.getInt("clubID"));
            c.setClubName(rs.getString("clubName"));
            c.setClubDescription(rs.getString("clubDescription"));
            c.setClubCategory(rs.getString("clubCategory"));
            c.setAdminUserID(rs.getInt("adminUserID"));
        }
        DBConnect.closeConnection(conn);
        return c;
    }

    // --- NEW METHOD ---
    // Get all clubs where a user is a committee member
    public List<Club> getClubsByCommittee(int userID) throws SQLException, ClassNotFoundException {
        List<Club> list = new ArrayList<>();
        String sql = "SELECT c.* FROM club c "
                   + "JOIN membership m ON c.clubID = m.clubID "
                   + "WHERE m.userID = ? AND m.membershipStatus = 'Active'";
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userID);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Club c = new Club();
                    c.setClubID(rs.getInt("clubID"));
                    c.setClubName(rs.getString("clubName"));
                    c.setClubDescription(rs.getString("clubDescription"));
                    c.setClubCategory(rs.getString("clubCategory"));
                    c.setAdminUserID(rs.getInt("adminUserID"));
                    list.add(c);
                }
            }
        }
        return list;
    }

    // Add a new club
    public boolean addClub(Club c) throws SQLException, ClassNotFoundException {
        Connection conn = DBConnect.getConnection();
        PreparedStatement ps = conn.prepareStatement(
            "INSERT INTO club (clubName, clubDescription, clubCategory, adminUserID) VALUES (?,?,?,?)"
        );
        ps.setString(1, c.getClubName());
        ps.setString(2, c.getClubDescription());
        ps.setString(3, c.getClubCategory());
        ps.setInt(4, c.getAdminUserID());
        boolean inserted = ps.executeUpdate() > 0;
        DBConnect.closeConnection(conn);
        return inserted;
    }

    // Update club
    public boolean updateClub(Club c) throws SQLException, ClassNotFoundException {
        Connection conn = DBConnect.getConnection();
        PreparedStatement ps = conn.prepareStatement(
            "UPDATE club SET clubName=?, clubDescription=?, clubCategory=?, adminUserID=? WHERE clubID=?"
        );
        ps.setString(1, c.getClubName());
        ps.setString(2, c.getClubDescription());
        ps.setString(3, c.getClubCategory());
        ps.setInt(4, c.getAdminUserID());
        ps.setInt(5, c.getClubID());
        boolean updated = ps.executeUpdate() > 0;
        DBConnect.closeConnection(conn);
        return updated;
    }

    // Delete club
    public boolean deleteClub(int clubID) throws SQLException, ClassNotFoundException {
        Connection conn = DBConnect.getConnection();
        PreparedStatement ps = conn.prepareStatement("DELETE FROM club WHERE clubID=?");
        ps.setInt(1, clubID);
        boolean deleted = ps.executeUpdate() > 0;
        DBConnect.closeConnection(conn);
        return deleted;
    }
}
