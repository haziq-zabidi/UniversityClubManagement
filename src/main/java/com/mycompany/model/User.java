/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.model;

/**
 *
 * @author TUF
 */
public class User {
    private int userID;
    private String userName;
    private String userEmail;
    private String userPassword;
    private String matricNo;
    private String faculty;
    private String programme;
    private int roleID;

    public User() {
    }

    public User(int userID, String userName, String userEmail, String userPassword, String matricNo, String faculty, String programme, int roleID) {
        this.userID = userID;
        this.userName = userName;
        this.userEmail = userEmail;
        this.userPassword = userPassword;
        this.matricNo = matricNo;
        this.faculty = faculty;
        this.programme = programme;
        this.roleID = roleID;
    }

    public int getUserID() {
        return userID;
    }

    public String getUserName() {
        return userName;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public String getUserPassword() {
        return userPassword;
    }

    public String getMatricNo() {
        return matricNo;
    }

    public String getFaculty() {
        return faculty;
    }

    public String getProgramme() {
        return programme;
    }

    public int getRoleID() {
        return roleID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public void setUserPassword(String userPassword) {
        this.userPassword = userPassword;
    }

    public void setMatricNo(String matricNo) {
        this.matricNo = matricNo;
    }

    public void setFaculty(String faculty) {
        this.faculty = faculty;
    }

    public void setProgramme(String programme) {
        this.programme = programme;
    }

    public void setRoleID(int roleID) {
        this.roleID = roleID;
    }
    
}
