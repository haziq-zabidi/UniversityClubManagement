/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.model;

/**
 *
 * @author TUF
 */
public class Membership {
    private int membershipID;
    private String joinDate;
    private String membershipStatus;
    private int userID;
    private int clubID;

    public Membership() {
    }

    public Membership(int membershipID, String joinDate, String membershipStatus, int userID, int clubID) {
        this.membershipID = membershipID;
        this.joinDate = joinDate;
        this.membershipStatus = membershipStatus;
        this.userID = userID;
        this.clubID = clubID;
    }

    public int getMembershipID() {
        return membershipID;
    }

    public String getJoinDate() {
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

    public void setJoinDate(String joinDate) {
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
    
    
}
