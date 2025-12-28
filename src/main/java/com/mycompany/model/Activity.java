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

    public Activity() {
    }

    public Activity(int activityID, String activityName, String activiyDescription, LocalDate startDate, LocalDate endDate, String activityLocation, String activityType, String activityStatus, int maxParticipants, int clubID) {
        this.activityID = activityID;
        this.activityName = activityName;
        this.activityDescription = activiyDescription;
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

    public String getActivityDescription() {
        return activityDescription;
    }

    public LocalDate getStartDate() {
        return startDate;
    }

    public LocalDate getEndDate() {
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

    public void setActivityDescription(String activiyDescription) {
        this.activityDescription = activiyDescription;
    }

    public void setStartDate(LocalDate startDate) {
        this.startDate = startDate;
    }

    public void setEndDate(LocalDate endDate) {
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
