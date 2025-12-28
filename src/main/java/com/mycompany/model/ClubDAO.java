package com.mycompany.model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ClubDAO {

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

    public boolean deleteClub(int clubID) throws SQLException, ClassNotFoundException {
        Connection conn = DBConnect.getConnection();
        PreparedStatement ps = conn.prepareStatement("DELETE FROM club WHERE clubID=?");
        ps.setInt(1, clubID);
        boolean deleted = ps.executeUpdate() > 0;
        DBConnect.closeConnection(conn);
        return deleted;
    }
}
