package com.mycompany.dao;

import com.mycompany.model.Activity;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ActivityDAO {

    // Add a new activity
    public boolean addActivity(Activity a) throws SQLException, ClassNotFoundException {
        Connection conn = DBConnect.getConnection();
        PreparedStatement ps = conn.prepareStatement(
            "INSERT INTO activity (activityName, activityDescription, startDate, endDate, activityLocation, activityType, activityStatus, maxParticipants, clubID) VALUES (?,?,?,?,?,?,?,?,?)"
        );
        ps.setString(1, a.getActivityName());
        ps.setString(2, a.getActivityDescription());
        ps.setDate(3, Date.valueOf(a.getStartDate()));
        ps.setDate(4, Date.valueOf(a.getEndDate()));
        ps.setString(5, a.getActivityLocation());
        ps.setString(6, a.getActivityType());
        ps.setString(7, a.getActivityStatus());
        ps.setInt(8, a.getMaxParticipants());
        ps.setInt(9, a.getClubID());
        boolean inserted = ps.executeUpdate() > 0;
        DBConnect.closeConnection(conn);
        return inserted;
    }

    // Get all activities
    public List<Activity> getAllActivities() throws SQLException, ClassNotFoundException {
        List<Activity> list = new ArrayList<>();
        Connection conn = DBConnect.getConnection();
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM activity");
        while (rs.next()) {
            Activity a = new Activity();
            a.setActivityID(rs.getInt("activityID"));
            a.setActivityName(rs.getString("activityName"));
            a.setActivityDescription(rs.getString("activityDescription"));
            a.setStartDate(rs.getDate("startDate").toLocalDate());
            a.setEndDate(rs.getDate("endDate").toLocalDate());
            a.setActivityLocation(rs.getString("activityLocation"));
            a.setActivityType(rs.getString("activityType"));
            a.setActivityStatus(rs.getString("activityStatus"));
            a.setMaxParticipants(rs.getInt("maxParticipants"));
            a.setClubID(rs.getInt("clubID"));
            list.add(a);
        }
        DBConnect.closeConnection(conn);
        return list;
    }

    // Update activity
    public boolean updateActivity(Activity a) throws SQLException, ClassNotFoundException {
        Connection conn = DBConnect.getConnection();
        PreparedStatement ps = conn.prepareStatement(
            "UPDATE activity SET activityName=?, activityDescription=?, startDate=?, endDate=?, activityLocation=?, activityType=?, activityStatus=?, maxParticipants=? WHERE activityID=?"
        );
        ps.setString(1, a.getActivityName());
        ps.setString(2, a.getActivityDescription());
        ps.setDate(3, Date.valueOf(a.getStartDate()));
        ps.setDate(4, Date.valueOf(a.getEndDate()));
        ps.setString(5, a.getActivityLocation());
        ps.setString(6, a.getActivityType());
        ps.setString(7, a.getActivityStatus());
        ps.setInt(8, a.getMaxParticipants());
        ps.setInt(9, a.getActivityID());
        boolean updated = ps.executeUpdate() > 0;
        DBConnect.closeConnection(conn);
        return updated;
    }

    // Delete activity
    public boolean deleteActivity(int activityID) throws SQLException, ClassNotFoundException {
        Connection conn = DBConnect.getConnection();
        PreparedStatement ps = conn.prepareStatement("DELETE FROM activity WHERE activityID=?");
        ps.setInt(1, activityID);
        boolean deleted = ps.executeUpdate() > 0;
        DBConnect.closeConnection(conn);
        return deleted;
    }

    // Get activities by club
    public List<Activity> getActivitiesByClub(int clubID) throws SQLException, ClassNotFoundException {
        List<Activity> list = new ArrayList<>();
        Connection conn = DBConnect.getConnection();
        PreparedStatement ps = conn.prepareStatement("SELECT * FROM activity WHERE clubID=?");
        ps.setInt(1, clubID);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Activity a = new Activity();
            a.setActivityID(rs.getInt("activityID"));
            a.setActivityName(rs.getString("activityName"));
            a.setActivityDescription(rs.getString("activityDescription"));
            a.setStartDate(rs.getDate("startDate").toLocalDate());
            a.setEndDate(rs.getDate("endDate").toLocalDate());
            a.setActivityLocation(rs.getString("activityLocation"));
            a.setActivityType(rs.getString("activityType"));
            a.setActivityStatus(rs.getString("activityStatus"));
            a.setMaxParticipants(rs.getInt("maxParticipants"));
            a.setClubID(rs.getInt("clubID"));
            list.add(a);
        }
        DBConnect.closeConnection(conn);
        return list;
    }
}
