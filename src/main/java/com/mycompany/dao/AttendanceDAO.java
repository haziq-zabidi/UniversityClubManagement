package com.mycompany.dao;

import com.mycompany.model.Attendance;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;


public class AttendanceDAO {

    // Record attendance
    public boolean addAttendance(Attendance a) throws SQLException, ClassNotFoundException {
        Connection conn = DBConnect.getConnection();
        PreparedStatement ps = conn.prepareStatement(
            "INSERT INTO attendance (attendanceDate, attendanceStatus, activityID, userID) VALUES (?,?,?,?)"
        );
        ps.setDate(1, Date.valueOf(a.getAttendanceDate()));
        ps.setString(2, a.getAttendanceStatus());
        ps.setInt(3, a.getActivityID());
        ps.setInt(4, a.getUserID());
        boolean inserted = ps.executeUpdate() > 0;
        DBConnect.closeConnection(conn);
        return inserted;
    }

    // Get attendance by activity
    public List<Attendance> getAttendanceByActivity(int activityID) throws SQLException, ClassNotFoundException {
        List<Attendance> list = new ArrayList<>();
        Connection conn = DBConnect.getConnection();
        PreparedStatement ps = conn.prepareStatement("SELECT * FROM attendance WHERE activityID=?");
        ps.setInt(1, activityID);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Attendance a = new Attendance();
            a.setAttendanceID(rs.getInt("attendanceID"));
            a.setAttendanceDate(rs.getDate("attendanceDate").toLocalDate());
            a.setAttendanceStatus(rs.getString("attendanceStatus"));
            a.setActivityID(rs.getInt("activityID"));
            a.setUserID(rs.getInt("userID"));
            list.add(a);
        }
        DBConnect.closeConnection(conn);
        return list;
    }

    // Get attendance by user
    public List<Attendance> getAttendanceByUser(int userID) throws SQLException, ClassNotFoundException {
        List<Attendance> list = new ArrayList<>();
        Connection conn = DBConnect.getConnection();
        PreparedStatement ps = conn.prepareStatement("SELECT * FROM attendance WHERE userID=?");
        ps.setInt(1, userID);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Attendance a = new Attendance();
            a.setAttendanceID(rs.getInt("attendanceID"));
            a.setAttendanceDate(rs.getDate("attendanceDate").toLocalDate());
            a.setAttendanceStatus(rs.getString("attendanceStatus"));
            a.setActivityID(rs.getInt("activityID"));
            a.setUserID(rs.getInt("userID"));
            list.add(a);
        }
        DBConnect.closeConnection(conn);
        return list;
    }
    
    // Check if user has attendance for specific activity
    public boolean hasUserAttendanceForActivity(int userID, int activityID) throws SQLException, ClassNotFoundException {
        Connection conn = DBConnect.getConnection();
        PreparedStatement ps = conn.prepareStatement("SELECT attendanceID FROM attendance WHERE userID=? AND activityID=?");
        ps.setInt(1, userID);
        ps.setInt(2, activityID);
        ResultSet rs = ps.executeQuery();
        boolean hasAttendance = rs.next();
        DBConnect.closeConnection(conn);
        return hasAttendance;
    }
    
    // Remove attendance record
    public boolean removeAttendance(int userID, int activityID) throws SQLException, ClassNotFoundException {
        Connection conn = DBConnect.getConnection();
        PreparedStatement ps = conn.prepareStatement("DELETE FROM attendance WHERE userID=? AND activityID=?");
        ps.setInt(1, userID);
        ps.setInt(2, activityID);
        boolean deleted = ps.executeUpdate() > 0;
        DBConnect.closeConnection(conn);
        return deleted;
    }
    
    // Get attendance count for activity
    public int getAttendanceCountForActivity(int activityID) throws SQLException, ClassNotFoundException {
        Connection conn = DBConnect.getConnection();
        PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) as count FROM attendance WHERE activityID=?");
        ps.setInt(1, activityID);
        ResultSet rs = ps.executeQuery();
        int count = 0;
        if (rs.next()) {
            count = rs.getInt("count");
        }
        DBConnect.closeConnection(conn);
        return count;
    }
}
