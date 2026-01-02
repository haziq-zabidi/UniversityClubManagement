/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.controller;

import com.mycompany.dao.MembershipDAO;
import com.mycompany.model.Club;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

/**
 *
 * @author TUF
 */

@WebServlet("/user/leave-club")
public class LeaveClubController extends HttpServlet{
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        
        // Prevent Back Button Cache
        response.setHeader("Cache-Control","no-cache, no-store, must-revalidate"); 
        response.setHeader("Pragma","no-cache");
        response.setDateHeader("Expires", 0);
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("roleID") == null || 
            (Integer)session.getAttribute("roleID") != 1) {
            // Not logged in or not admin → redirect to login
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        if (session == null || session.getAttribute("userID") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        int userID = (Integer) session.getAttribute("userID");
        String clubIDParam = request.getParameter("clubID");
        
        if (clubIDParam != null) {
            try {
                int clubID = Integer.parseInt(clubIDParam);
                MembershipDAO membershipDAO = new MembershipDAO();
                
                // Check if user is an active member
                List<Club> activeClubs = membershipDAO.getActiveClubsByUserID(userID);
                boolean isActiveMember = false;
                for (Club club : activeClubs) {
                    if (club.getClubID() == clubID) {
                        isActiveMember = true;
                        break;
                    }
                }
                
                if (!isActiveMember) {
                    response.sendRedirect(request.getContextPath() + "/user/clubs?error=not_active");
                    return;
                }
                
                // Check if already has pending leave request
                List<Club> pendingLeaveClubs = membershipDAO.getPendingLeaveClubsByUserID(userID);
                for (Club club : pendingLeaveClubs) {
                    if (club.getClubID() == clubID) {
                        response.sendRedirect(request.getContextPath() + "/user/clubs?error=already_pending");
                        return;
                    }
                }
                
                // Submit leave request
                boolean success = membershipDAO.submitLeaveRequest(userID, clubID);
                
                if (success) {
                    response.sendRedirect(request.getContextPath() + "/user/clubs?success=leave_requested");
                } else {
                    response.sendRedirect(request.getContextPath() + "/user/clubs?error=request_failed");
                }
                
            } catch (NumberFormatException | SQLException | ClassNotFoundException e) {
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/user/clubs?error=system_error");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/user/clubs");
        }
    }
}
