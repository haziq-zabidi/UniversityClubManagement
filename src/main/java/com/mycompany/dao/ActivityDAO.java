package com.mycompany.dao;

import com.mycompany.model.Activity;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ActivityDAO {

    // Add a new activity and return generated ID
    public int addActivity(Activity a) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO activity (activityName, activityDescription, startDate, endDate, activityLocation, activityType, activityStatus, maxParticipants, clubID) VALUES (?,?,?,?,?,?,?,?,?)";
        int generatedID = -1;

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, a.getActivityName());
            ps.setString(2, a.getActivityDescription());
            ps.setDate(3, Date.valueOf(a.getStartDate()));
            ps.setDate(4, Date.valueOf(a.getEndDate()));
            ps.setString(5, a.getActivityLocation());
            ps.setString(6, a.getActivityType());
            ps.setString(7, a.getActivityStatus());
            ps.setInt(8, a.getMaxParticipants());
            ps.setInt(9, a.getClubID());

            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        generatedID = rs.getInt(1);
                    }
                }
            }
        }
        return generatedID;
    }

    // Get activities by club
    public List<Activity> getActivitiesByClub(int clubID) throws SQLException, ClassNotFoundException {
        List<Activity> list = new ArrayList<>();
        String sql = "SELECT * FROM activity WHERE clubID=?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, clubID);
            try (ResultSet rs = ps.executeQuery()) {
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
            }
        }
        return list;
    }

    // Get single activity by ID
    public Activity getActivityByID(int activityID) throws SQLException, ClassNotFoundException {
        Activity a = null;
        String sql = "SELECT * FROM activity WHERE activityID=?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, activityID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    a = new Activity();
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
                }
            }
        }
        return a;
    }

    // Update entire activity
    public boolean updateActivity(Activity a) throws SQLException, ClassNotFoundException {
        String sql = "UPDATE activity SET activityName=?, activityDescription=?, startDate=?, endDate=?, activityLocation=?, activityType=?, activityStatus=?, maxParticipants=? WHERE activityID=?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, a.getActivityName());
            ps.setString(2, a.getActivityDescription());
            ps.setDate(3, Date.valueOf(a.getStartDate()));
            ps.setDate(4, Date.valueOf(a.getEndDate()));
            ps.setString(5, a.getActivityLocation());
            ps.setString(6, a.getActivityType());
            ps.setString(7, a.getActivityStatus());
            ps.setInt(8, a.getMaxParticipants());
            ps.setInt(9, a.getActivityID());

            return ps.executeUpdate() > 0;
        }
    }

    // Update only status
    public boolean updateActivityStatus(int activityID, String status) throws SQLException, ClassNotFoundException {
        String sql = "UPDATE activity SET activityStatus=? WHERE activityID=?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, activityID);
            return ps.executeUpdate() > 0;
        }
    }

    // Delete activity
    public boolean deleteActivity(int activityID) throws SQLException, ClassNotFoundException {
        String sql = "DELETE FROM activity WHERE activityID=?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, activityID);
            return ps.executeUpdate() > 0;
        }
    }
}
