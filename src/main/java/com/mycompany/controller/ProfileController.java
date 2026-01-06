package com.mycompany.controller;

import com.mycompany.dao.UsersDAO;
import com.mycompany.model.User;
import com.mycompany.util.PasswordUtil; // ADD THIS IMPORT
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/user/profile")
public class ProfileController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setHeader("Cache-Control","no-cache, no-store, must-revalidate"); 
        response.setHeader("Pragma","no-cache");
        response.setDateHeader("Expires", 0);
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("roleID") == null || 
            (Integer)session.getAttribute("roleID") != 2) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        if (session == null || session.getAttribute("userID") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        int userID = (Integer) session.getAttribute("userID");
        
        try {
            UsersDAO userDAO = new UsersDAO();
            User user = userDAO.getUserByID(userID);
            
            if (user != null) {
                request.setAttribute("user", user);
                request.setAttribute("userName", user.getUserName());
            }
            
            String success = request.getParameter("success");
            String error = request.getParameter("error");
            
            if (success != null) {
                switch (success) {
                    case "profile_updated":
                        request.setAttribute("successMessage", "Profile updated successfully!");
                        break;
                    case "password_updated":
                        request.setAttribute("successMessage", "Password changed successfully!");
                        break;
                }
            }
            
            if (error != null) {
                switch (error) {
                    case "email_exists":
                        request.setAttribute("errorMessage", "Email already exists. Please use a different email.");
                        break;
                    case "password_mismatch":
                        request.setAttribute("errorMessage", "Current password is incorrect.");
                        break;
                    case "new_password_mismatch":
                        request.setAttribute("errorMessage", "New passwords do not match.");
                        break;
                    case "update_failed":
                        request.setAttribute("errorMessage", "Failed to update profile. Please try again.");
                        break;
                }
            }
            
            RequestDispatcher rd = request.getRequestDispatcher("/views/user/profile.jsp");
            rd.forward(request, response);
            
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error loading profile: " + e.getMessage());
            RequestDispatcher rd = request.getRequestDispatcher("/views/error.jsp");
            rd.forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        if (session == null || session.getAttribute("userID") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        int userID = (Integer) session.getAttribute("userID");
        String action = request.getParameter("action");
        
        try {
            UsersDAO userDAO = new UsersDAO();
            
            if ("update_profile".equals(action)) {
                String userName = request.getParameter("userName");
                String userEmail = request.getParameter("userEmail");
                String matricNo = request.getParameter("matricNo");
                String faculty = request.getParameter("faculty");
                String programme = request.getParameter("programme");
                
                if (userDAO.isEmailExists(userEmail, userID)) {
                    response.sendRedirect(request.getContextPath() + "/user/profile?error=email_exists");
                    return;
                }
                
                User user = new User();
                user.setUserID(userID);
                user.setUserName(userName);
                user.setUserEmail(userEmail);
                user.setMatricNo(matricNo);
                user.setFaculty(faculty);
                user.setProgramme(programme);
                
                boolean success = userDAO.updateUserProfile(user);
                
                if (success) {
                    session.setAttribute("userName", userName);
                    response.sendRedirect(request.getContextPath() + "/user/profile?success=profile_updated");
                } else {
                    response.sendRedirect(request.getContextPath() + "/user/profile?error=update_failed");
                }
                
            } else if ("change_password".equals(action)) {
                String currentPassword = request.getParameter("currentPassword");
                String newPassword = request.getParameter("newPassword");
                String confirmPassword = request.getParameter("confirmPassword");
                
                User user = userDAO.getUserByID(userID);
                
                // VERIFY CURRENT PASSWORD USING HASH
                if (user == null || !PasswordUtil.verifyPassword(currentPassword, user.getUserPassword())) {
                    response.sendRedirect(request.getContextPath() + "/user/profile?error=password_mismatch");
                    return;
                }
                
                if (!newPassword.equals(confirmPassword)) {
                    response.sendRedirect(request.getContextPath() + "/user/profile?error=new_password_mismatch");
                    return;
                }
                
                // HASH NEW PASSWORD BEFORE SAVING
                boolean success = userDAO.updatePassword(userID, PasswordUtil.hashPassword(newPassword));
                
                if (success) {
                    response.sendRedirect(request.getContextPath() + "/user/profile?success=password_updated");
                } else {
                    response.sendRedirect(request.getContextPath() + "/user/profile?error=update_failed");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/user/profile");
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/user/profile?error=system_error");
        }
    }
}