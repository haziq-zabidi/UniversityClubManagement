/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.model;

/**
 *
 * @author TUF
 */
public class Announcement {
    private int announcementID;
    private String announcementTitle;
    private String announcementMessage;
    private String publishDate;
    private int clubID;
    private int authorUserID;

    public Announcement() {
    }

    public Announcement(int announcementID, String announcementTitle, String announcementMessage, String publishDate, int clubID, int authorUserID) {
        this.announcementID = announcementID;
        this.announcementTitle = announcementTitle;
        this.announcementMessage = announcementMessage;
        this.publishDate = publishDate;
        this.clubID = clubID;
        this.authorUserID = authorUserID;
    }

    public int getAnnouncementID() {
        return announcementID;
    }

    public String getAnnouncementTitle() {
        return announcementTitle;
    }

    public String getAnnouncementMessage() {
        return announcementMessage;
    }

    public String getPublishDate() {
        return publishDate;
    }

    public int getClubID() {
        return clubID;
    }

    public int getAuthorUserID() {
        return authorUserID;
    }

    public void setAnnouncementID(int announcementID) {
        this.announcementID = announcementID;
    }

    public void setAnnouncementTitle(String announcementTitle) {
        this.announcementTitle = announcementTitle;
    }

    public void setAnnouncementMessage(String announcementMessage) {
        this.announcementMessage = announcementMessage;
    }

    public void setPublishDate(String publishDate) {
        this.publishDate = publishDate;
    }

    public void setClubID(int clubID) {
        this.clubID = clubID;
    }

    public void setAuthorUserID(int authorUserID) {
        this.authorUserID = authorUserID;
    }
    
}
