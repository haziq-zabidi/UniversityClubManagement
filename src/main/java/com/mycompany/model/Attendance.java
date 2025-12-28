/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.model;

import java.time.LocalDate;
/**
 *
 * @author TUF
 */
public class Attendance {
    private int attendanceID;
    private LocalDate attendanceDate;
    private String attendanceStatus;
    private int activityID;
    private int userID;

    public Attendance() {
    }

    public Attendance(int anttendanceID, LocalDate attendanceDate, String attendanceStatus, int activityID, int userID) {
        this.attendanceID = anttendanceID;
        this.attendanceDate = attendanceDate;
        this.attendanceStatus = attendanceStatus;
        this.activityID = activityID;
        this.userID = userID;
    }

    public int getAnttendanceID() {
        return attendanceID;
    }

    public LocalDate getAttendanceDate() {
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

    public void setAttendanceID(int anttendanceID) {
        this.attendanceID = anttendanceID;
    }

    public void setAttendanceDate(LocalDate attendanceDate) {
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
