package com.mycompany.model;

import java.time.LocalDate;

/**
 *
 * @author TUF
 */
public class Membership {
    private int membershipID;
    private LocalDate joinDate;
    private String membershipStatus;
    private int userID;
    private int clubID;
    
    // NEW FIELD - Add this to hold the joined User data for committee management
    private User user;

    public Membership() {
    }

    public Membership(int membershipID, LocalDate joinDate, String membershipStatus, int userID, int clubID) {
        this.membershipID = membershipID;
        this.joinDate = joinDate;
        this.membershipStatus = membershipStatus;
        this.userID = userID;
        this.clubID = clubID;
    }

    public int getMembershipID() {
        return membershipID;
    }

    public LocalDate getJoinDate() {
        return joinDate;
    }

    public String getMembershipStatus() {
        return membershipStatus;
    }

    public int getUserID() {
        return userID;
    }

    public int getClubID() {
        return clubID;
    }

    public void setMembershipID(int membershipID) {
        this.membershipID = membershipID;
    }

    public void setJoinDate(LocalDate joinDate) {
        this.joinDate = joinDate;
    }

    public void setMembershipStatus(String membershipStatus) {
        this.membershipStatus = membershipStatus;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public void setClubID(int clubID) {
        this.clubID = clubID;
    }
    
    // NEW GETTER AND SETTER - Add these methods for committee member management
    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}