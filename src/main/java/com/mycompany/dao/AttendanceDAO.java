package com.mycompany.dao;

import com.mycompany.model.Attendance;
import com.mycompany.model.User;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AttendanceDAO {

    public boolean addAttendance(Attendance a) throws SQLException, ClassNotFoundException {
        String sql = """
            INSERT INTO attendance (attendanceDate, attendanceStatus, activityID, userID)
            VALUES (?, ?, ?, ?)
        """;

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setDate(1, Date.valueOf(a.getAttendanceDate()));
            ps.setString(2, a.getAttendanceStatus());
            ps.setInt(3, a.getActivityID());
            ps.setInt(4, a.getUserID());

            return ps.executeUpdate() > 0;
        }
    }

    public List<Attendance> getAttendancesByActivity(int activityID)
        throws SQLException, ClassNotFoundException {

    List<Attendance> attendances = new ArrayList<>();

    String sql = """
        SELECT
            a.attendanceID,
            a.attendanceDate,
            a.attendanceStatus,
            a.activityID,
            u.userID,
            u.userName,
            u.userEmail,
            u.matricNo,
            u.faculty,
            u.programme
        FROM attendance a
        JOIN `user` u ON a.userID = u.userID
        WHERE a.activityID = ?
        ORDER BY a.attendanceDate DESC
    """;

    try (Connection conn = DBConnect.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setInt(1, activityID);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Attendance attendance = new Attendance();
            attendance.setAttendanceID(rs.getInt("attendanceID"));

            Date d = rs.getDate("attendanceDate");
            attendance.setAttendanceDate(d != null ? d.toLocalDate() : null);

            attendance.setAttendanceStatus(rs.getString("attendanceStatus"));
            attendance.setActivityID(rs.getInt("activityID"));

            User user = new User();
            user.setUserID(rs.getInt("userID"));
            user.setUserName(rs.getString("userName"));
            user.setUserEmail(rs.getString("userEmail"));
            user.setMatricNo(rs.getString("matricNo"));
            user.setFaculty(rs.getString("faculty"));
            user.setProgramme(rs.getString("programme"));

            attendance.setUser(user);
            attendances.add(attendance);
        }
    }

    return attendances;
}


    public List<Attendance> getAttendanceByUser(int userID)
            throws SQLException, ClassNotFoundException {

        List<Attendance> list = new ArrayList<>();
        String sql = "SELECT * FROM attendance WHERE userID = ?";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Attendance a = new Attendance();
                a.setAttendanceID(rs.getInt("attendanceID"));

                Date d = rs.getDate("attendanceDate");
                a.setAttendanceDate(d != null ? d.toLocalDate() : null);

                a.setAttendanceStatus(rs.getString("attendanceStatus"));
                a.setActivityID(rs.getInt("activityID"));
                a.setUserID(rs.getInt("userID"));
                list.add(a);
            }
        }

        return list;
    }

    public boolean hasUserAttendanceForActivity(int userID, int activityID)
            throws SQLException, ClassNotFoundException {

        String sql = """
            SELECT 1 FROM attendance
            WHERE userID = ? AND activityID = ?
        """;

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userID);
            ps.setInt(2, activityID);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        }
    }

    public boolean removeAttendance(int userID, int activityID)
            throws SQLException, ClassNotFoundException {

        String sql = "DELETE FROM attendance WHERE userID = ? AND activityID = ?";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userID);
            ps.setInt(2, activityID);
            return ps.executeUpdate() > 0;
        }
    }

    public int getParticipantCount(int activityID)
            throws SQLException, ClassNotFoundException {

        String sql = "SELECT COUNT(*) FROM attendance WHERE activityID = ?";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, activityID);
            ResultSet rs = ps.executeQuery();
            return rs.next() ? rs.getInt(1) : 0;
        }
    }
}
