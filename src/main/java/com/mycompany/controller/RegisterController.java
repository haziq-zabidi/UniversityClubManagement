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

@WebServlet("/register")
public class RegisterController extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Show registration page
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/register.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Trim inputs to avoid whitespace issues
        String userName = request.getParameter("userName").trim();
        String userEmail = request.getParameter("userEmail").trim();
        String userPassword = request.getParameter("userPassword").trim();
        String matricNo = request.getParameter("matricNo").trim();
        String faculty = request.getParameter("faculty").trim();
        String programme = request.getParameter("programme").trim();

        // Keep values in request in case of error
        request.setAttribute("userName", userName);
        request.setAttribute("userEmail", userEmail);
        request.setAttribute("matricNo", matricNo);
        request.setAttribute("faculty", faculty);
        request.setAttribute("programme", programme);

        try {
            UsersDAO usersDAO = new UsersDAO();

            // Optional: check if email already exists
            User existingUser = usersDAO.getUserByEmail(userEmail);
            if (existingUser != null) {
                request.setAttribute("errorMessage", "Email already registered!");
                RequestDispatcher dispatcher = request.getRequestDispatcher("/views/register.jsp");
                dispatcher.forward(request, response);
                return;
            }

            // Create new user
            User newUser = new User();
            newUser.setUserName(userName);
            newUser.setUserEmail(userEmail);
            newUser.setUserPassword(userPassword); // In production, hash this!
            newUser.setMatricNo(matricNo);
            newUser.setFaculty(faculty);
            newUser.setProgramme(programme);
            newUser.setRoleID(2); // Default to student

            boolean isInserted = usersDAO.addUser(newUser);

            if (isInserted) {
                // Redirect to login page (new request) instead of forward
                response.sendRedirect(request.getContextPath() + "/login");
            } else {
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
