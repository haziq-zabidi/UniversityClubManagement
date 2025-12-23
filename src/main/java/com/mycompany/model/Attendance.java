/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.model;

/**
 *
 * @author TUF
 */
public class Attendance {
    private int anttendanceID;
    private String attendanceDate;
    private String attendanceStatus;
    private int activityID;
    private int userID;

    public Attendance() {
    }

    public Attendance(int anttendanceID, String attendanceDate, String attendanceStatus, int activityID, int userID) {
        this.anttendanceID = anttendanceID;
        this.attendanceDate = attendanceDate;
        this.attendanceStatus = attendanceStatus;
        this.activityID = activityID;
        this.userID = userID;
    }

    public int getAnttendanceID() {
        return anttendanceID;
    }

    public String getAttendanceDate() {
        return attendanceDate;
    }

    public String getAttendanceStatus() {
        return attendanceStatus;
    }

    public int getActivityID() {
        return activityID;
    }

    public int getUserID() {
        return userID;
    }

    public void setAnttendanceID(int anttendanceID) {
        this.anttendanceID = anttendanceID;
    }

    public void setAttendanceDate(String attendanceDate) {
        this.attendanceDate = attendanceDate;
    }

    public void setAttendanceStatus(String attendanceStatus) {
        this.attendanceStatus = attendanceStatus;
    }

    public void setActivityID(int activityID) {
        this.activityID = activityID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }
    
}
