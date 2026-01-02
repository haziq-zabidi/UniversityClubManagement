/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.controller;

import com.mycompany.dao.ClubDAO;
import com.mycompany.dao.MembershipDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author TUF
 */

@WebServlet("/user/clubs")
public class ClubsController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        if (session == null || session.getAttribute("userID") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        int userID = (Integer) session.getAttribute("userID");
        String userName = (String) session.getAttribute("userName");
        
        try {
            ClubDAO clubDAO = new ClubDAO();
            MembershipDAO membershipDAO = new MembershipDAO();
            
            // Get all clubs
            List<com.mycompany.model.Club> allClubs = clubDAO.getAllClubs();
            
            // Get user's clubs in different statuses
            List<com.mycompany.model.Club> activeClubs = membershipDAO.getActiveClubsByUserID(userID);
            List<com.mycompany.model.Club> pendingJoinClubs = membershipDAO.getPendingJoinClubsByUserID(userID);
            List<com.mycompany.model.Club> pendingLeaveClubs = membershipDAO.getPendingLeaveClubsByUserID(userID);
            
            // Find available clubs (not in any status)
            List<com.mycompany.model.Club> availableClubs = new ArrayList<>();
            
            for (com.mycompany.model.Club club : allClubs) {
                boolean isInAnyList = false;
                
                // Check if club is in active list
                for (com.mycompany.model.Club activeClub : activeClubs) {
                    if (club.getClubID() == activeClub.getClubID()) {
                        isInAnyList = true;
                        break;
                    }
                }
                
                // Check if club is in pending join list
                if (!isInAnyList) {
                    for (com.mycompany.model.Club pendingClub : pendingJoinClubs) {
                        if (club.getClubID() == pendingClub.getClubID()) {
                            isInAnyList = true;
                            break;
                        }
                    }
                }
                
                // Check if club is in pending leave list
                if (!isInAnyList) {
                    for (com.mycompany.model.Club pendingClub : pendingLeaveClubs) {
                        if (club.getClubID() == pendingClub.getClubID()) {
                            isInAnyList = true;
                            break;
                        }
                    }
                }
                
                if (!isInAnyList) {
                    availableClubs.add(club);
                }
            }
            
            // Check for success/error messages from URL parameters
            String success = request.getParameter("success");
            String error = request.getParameter("error");
            
            if (success != null) {
                switch (success) {
                    case "join_requested":
                        request.setAttribute("successMessage", "Join request submitted! Waiting for committee approval.");
                        break;
                    case "leave_requested":
                        request.setAttribute("successMessage", "Leave request submitted! Waiting for committee approval.");
                        break;
                    case "request_cancelled":
                        request.setAttribute("successMessage", "Request cancelled successfully!");
                        break;
                }
            }
            
            if (error != null) {
                switch (error) {
                    case "already_pending":
                        request.setAttribute("errorMessage", "You already have a pending request for this club.");
                        break;
                    case "already_active":
                        request.setAttribute("errorMessage", "You are already an active member of this club.");
                        break;
                    case "not_active":
                        request.setAttribute("errorMessage", "You are not an active member of this club.");
                        break;
                    case "request_failed":
                        request.setAttribute("errorMessage", "Failed to process your request. Please try again.");
                        break;
                }
            }
            
            // Set attributes for JSP
            request.setAttribute("userName", userName);
            request.setAttribute("availableClubs", availableClubs);
            request.setAttribute("activeClubs", activeClubs);
            request.setAttribute("pendingJoinClubs", pendingJoinClubs);
            request.setAttribute("pendingLeaveClubs", pendingLeaveClubs);
            request.setAttribute("totalClubs", allClubs.size());
            request.setAttribute("availableCount", availableClubs.size());
            request.setAttribute("activeCount", activeClubs.size());
            request.setAttribute("pendingJoinCount", pendingJoinClubs.size());
            request.setAttribute("pendingLeaveCount", pendingLeaveClubs.size());
            
            RequestDispatcher rd = request.getRequestDispatcher("/views/user/clubs.jsp");
            rd.forward(request, response);
            
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error loading clubs: " + e.getMessage());
            RequestDispatcher rd = request.getRequestDispatcher("/views/error.jsp");
            rd.forward(request, response);
        }
    }
}
