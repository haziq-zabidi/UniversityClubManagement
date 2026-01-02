package com.mycompany.model;

import java.time.LocalDate;

public class Activity {

    private int activityID;
    private String activityName;
    private String activityDescription;
    private LocalDate startDate;
    private LocalDate endDate;
    private String activityLocation;
    private String activityType;
    private String activityStatus;
    private int maxParticipants;
    private int clubID;

    // 🔹 Derived field (NOT stored in DB)
    private int currentParticipants;

    public Activity() {
    }

    public Activity(
            int activityID,
            String activityName,
            String activityDescription,
            LocalDate startDate,
            LocalDate endDate,
            String activityLocation,
            String activityType,
            String activityStatus,
            int maxParticipants,
            int clubID
    ) {
        this.activityID = activityID;
        this.activityName = activityName;
        this.activityDescription = activityDescription;
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

    public void setActivityID(int activityID) {
        this.activityID = activityID;
    }

    public String getActivityName() {
        return activityName;
    }

    public void setActivityName(String activityName) {
        this.activityName = activityName;
    }

    public String getActivityDescription() {
        return activityDescription;
    }

    public void setActivityDescription(String activityDescription) {
        this.activityDescription = activityDescription;
    }

    public LocalDate getStartDate() {
        return startDate;
    }

    public void setStartDate(LocalDate startDate) {
        this.startDate = startDate;
    }

    public LocalDate getEndDate() {
        return endDate;
    }

    public void setEndDate(LocalDate endDate) {
        this.endDate = endDate;
    }

    public String getActivityLocation() {
        return activityLocation;
    }

    public void setActivityLocation(String activityLocation) {
        this.activityLocation = activityLocation;
    }

    public String getActivityType() {
        return activityType;
    }

    public void setActivityType(String activityType) {
        this.activityType = activityType;
    }

    public String getActivityStatus() {
        return activityStatus;
    }

    public void setActivityStatus(String activityStatus) {
        this.activityStatus = activityStatus;
    }

    public int getMaxParticipants() {
        return maxParticipants;
    }

    public void setMaxParticipants(int maxParticipants) {
        this.maxParticipants = maxParticipants;
    }

    public int getClubID() {
        return clubID;
    }

    public void setClubID(int clubID) {
        this.clubID = clubID;
    }

    //required for committee view
    public int getCurrentParticipants() {
        return currentParticipants;
    }

    public void setCurrentParticipants(int currentParticipants) {
        this.currentParticipants = currentParticipants;
    }
}
