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
import java.io.IOException;
import java.sql.SQLException;

/**
 *
 * @author TUF
 */
@WebServlet("/register")
public class RegisterController extends HttpServlet{
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/register.jsp"); 
        dispatcher.forward(request, response);
    }
    
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userName = request.getParameter("userName");
        String userEmail = request.getParameter("userEmail");
        String userPassword = request.getParameter("userPassword");
        String matricNo = request.getParameter("matricNo");
        String faculty = request.getParameter("faculty");
        String programme = request.getParameter("programme");
        
        request.setAttribute("userName", userName);
        request.setAttribute("userEmail", userEmail);
        request.setAttribute("matricNo", matricNo);
        request.setAttribute("faculty", faculty);
        request.setAttribute("programme", programme);
        
        if (userPassword.length() < 8) {
            request.setAttribute("errorMessage", "Password must be at least 8 characters!");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/views/register.jsp");
            dispatcher.forward(request, response);
            return;
        }
        
        try {
            // Step 1: Check if email already exists
            UsersDAO usersDAO = new UsersDAO();
            
            // Step 2: Create User object
            User newUser = new User();
            newUser.setUserName(userName);
            newUser.setUserEmail(userEmail);
            newUser.setUserPassword(userPassword); // In production, hash this!
            newUser.setMatricNo(matricNo);
            newUser.setFaculty(faculty);
            newUser.setProgramme(programme);
            
            // Step 3: Set default role (e.g., 2 for student, 1 for admin)
            // Assuming roleID 2 = Student, 1 = Admin
            newUser.setRoleID(2); // Default to student role
            
            // Step 4: Use DAO to insert into database
            boolean isInserted = usersDAO.addUser(newUser);
            
            if (isInserted) {
                RequestDispatcher dispatcher = request.getRequestDispatcher("/views/login.jsp");
                dispatcher.forward(request, response);
            
            } else {
                // Registration failed
                request.setAttribute("errorMessage", "Registration failed. Please try again.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("/views/register.jsp");
                dispatcher.forward(request, response);
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("/views/register.jsp");
            dispatcher.forward(request, response);
        }
    }
}
