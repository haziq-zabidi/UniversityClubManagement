package com.mycompany.model;

import java.time.LocalDate;

public class Attendance {

    private int attendanceID;
    private LocalDate attendanceDate;
    private String attendanceStatus;
    private int activityID;
    private int userID;

    private User user; // <-- REQUIRED for participants view

    public Attendance() {}

    public Attendance(int attendanceID, LocalDate attendanceDate,
                      String attendanceStatus, int activityID, int userID) {
        this.attendanceID = attendanceID;
        this.attendanceDate = attendanceDate;
        this.attendanceStatus = attendanceStatus;
        this.activityID = activityID;
        this.userID = userID;
    }

    public int getAttendanceID() {
        return attendanceID;
    }

    public void setAttendanceID(int attendanceID) {
        this.attendanceID = attendanceID;
    }

    public LocalDate getAttendanceDate() {
        return attendanceDate;
    }

    public void setAttendanceDate(LocalDate attendanceDate) {
        this.attendanceDate = attendanceDate;
    }

    public String getAttendanceStatus() {
        return attendanceStatus;
    }

    public void setAttendanceStatus(String attendanceStatus) {
        this.attendanceStatus = attendanceStatus;
    }

    public int getActivityID() {
        return activityID;
    }

    public void setActivityID(int activityID) {
        this.activityID = activityID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    // 🔑 REQUIRED FOR JSP
    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}
