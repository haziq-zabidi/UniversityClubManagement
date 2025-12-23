/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.model;

/**
 *
 * @author TUF
 */
public class Activity {
    private int activityID;
    private String activityName;
    private String activiyDescription;
    private String startDate;
    private String endDate;
    private String activityLocation;
    private String activityType;
    private String activityStatus;
    private int maxParticipants;
    private int clubID;

    public Activity() {
    }

    public Activity(int activityID, String activityName, String activiyDescription, String startDate, String endDate, String activityLocation, String activityType, String activityStatus, int maxParticipants, int clubID) {
        this.activityID = activityID;
        this.activityName = activityName;
        this.activiyDescription = activiyDescription;
        this.startDate = startDate;
        this.endDate = endDate;
        this.activityLocation = activityLocation;
        this.activityType = activityType;
        this.activityStatus = activityStatus;
        this.maxParticipants = maxParticipants;
        this.clubID = clubID;
    }

    public int getActivityID() {
        return activityID;
    }

    public String getActivityName() {
        return activityName;
    }

    public String getActiviyDescription() {
        return activiyDescription;
    }

    public String getStartDate() {
        return startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public String getActivityLocation() {
        return activityLocation;
    }

    public String getActivityType() {
        return activityType;
    }

    public String getActivityStatus() {
        return activityStatus;
    }

    public int getMaxParticipants() {
        return maxParticipants;
    }

    public int getClubID() {
        return clubID;
    }

    public void setActivityID(int activityID) {
        this.activityID = activityID;
    }

    public void setActivityName(String activityName) {
        this.activityName = activityName;
    }

    public void setActiviyDescription(String activiyDescription) {
        this.activiyDescription = activiyDescription;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public void setActivityLocation(String activityLocation) {
        this.activityLocation = activityLocation;
    }

    public void setActivityType(String activityType) {
        this.activityType = activityType;
    }

    public void setActivityStatus(String activityStatus) {
        this.activityStatus = activityStatus;
    }

    public void setMaxParticipants(int maxParticipants) {
        this.maxParticipants = maxParticipants;
    }

    public void setClubID(int clubID) {
        this.clubID = clubID;
    }
    
}
