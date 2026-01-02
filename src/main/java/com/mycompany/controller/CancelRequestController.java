/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.controller;

import com.mycompany.dao.MembershipDAO;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

/**
 *
 * @author TUF
 */
@WebServlet("/user/cancel-request")
public class CancelRequestController extends HttpServlet{
    
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
                
                // Cancel pending request
                boolean success = membershipDAO.cancelPendingRequest(userID, clubID);
                
                if (success) {
                    response.sendRedirect(request.getContextPath() + "/user/clubs?success=request_cancelled");
                } else {
                    response.sendRedirect(request.getContextPath() + "/user/clubs?error=request_failed");
                }
                
            } catch (NumberFormatException e) {
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/user/clubs?error=system_error");
            } catch (SQLException ex) {
                System.getLogger(CancelRequestController.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
            } catch (ClassNotFoundException ex) {
                System.getLogger(CancelRequestController.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/user/clubs");
        }
    }
}
