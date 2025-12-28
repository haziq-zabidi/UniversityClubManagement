/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.controller;

import com.mycompany.dao.UsersDAO;
import com.mycompany.model.User;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
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
@WebServlet("/login")
public class LoginController extends HttpServlet{
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/login.jsp"); 
        dispatcher.forward(request, response);
    }
    
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("userEmail");
        String password = request.getParameter("userPassword");
        
        request.setAttribute("userEmail", email);
        
        if (email == null || email.trim().isEmpty() || 
            password == null || password.trim().isEmpty()) {
            
            request.setAttribute("errorMessage", "Email and password are required!");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/views/login.jsp");
            dispatcher.forward(request, response);
            return;
        }
        
        try {
            UsersDAO usersDAO = new UsersDAO();
            User user = usersDAO.getUserByEmail(email);
            
            if (user != null && user.getUserPassword().equals(password)) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                session.setAttribute("userName", user.getUserName());
                session.setAttribute("userEmail", user.getUserEmail());
                session.setAttribute("userID", user.getUserID());
                session.setAttribute("roleID", user.getRoleID());
                
                // Set session timeout (30 minutes = 1800 seconds)
                session.setMaxInactiveInterval(1800);
                
                // Redirect based on role (example)
                if (user.getRoleID() == 1) {
                    // Admin role
                    response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                } else if (user.getRoleID() == 2) {
                    // Student role
                    response.sendRedirect(request.getContextPath() + "/student/dashboard");
                } else {
                    // Default dashboard
                    response.sendRedirect(request.getContextPath() + "/dashboard");
                }
                
            } else {
                // Invalid credentials
                request.setAttribute("errorMessage", "Invalid email or password!");
                RequestDispatcher dispatcher = request.getRequestDispatcher("/views/login.jsp");
                dispatcher.forward(request, response);
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            // Handle database errors
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error occurred. Please try again later.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/views/login.jsp");
            dispatcher.forward(request, response);
        }
    }
        
}
