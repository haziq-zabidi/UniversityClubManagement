/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.model;

/**
 *
 * @author TUF
 */
public class Club {
    private int clubID;
    private String clubName;
    private String clubDescription;
    private String clubCategory;
    private int adminUserID;

    public Club() {
    }

    public Club(int clubID, String clubName, String clubDescription, String clubCategory, int adminUserID) {
        this.clubID = clubID;
        this.clubName = clubName;
        this.clubDescription = clubDescription;
        this.clubCategory = clubCategory;
        this.adminUserID = adminUserID;
    }

    public int getClubID() {
        return clubID;
    }

    public String getClubName() {
        return clubName;
    }

    public String getClubDescription() {
        return clubDescription;
    }

    public String getClubCategory() {
        return clubCategory;
    }

    public int getAdminUserID() {
        return adminUserID;
    }

    public void setClubID(int clubID) {
        this.clubID = clubID;
    }

    public void setClubName(String clubName) {
        this.clubName = clubName;
    }

    public void setClubDescription(String clubDescription) {
        this.clubDescription = clubDescription;
    }

    public void setClubCategory(String clubCategory) {
        this.clubCategory = clubCategory;
    }

    public void setAdminUserID(int adminUserID) {
        this.adminUserID = adminUserID;
    }
    
}
