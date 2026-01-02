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

@WebServlet("/login")
public class LoginController extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Show login page
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/login.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Trim inputs
        String email = request.getParameter("userEmail").trim();
        String password = request.getParameter("userPassword").trim();

        request.setAttribute("userEmail", email);

        // Check empty fields
        if (email.isEmpty() || password.isEmpty()) {
            request.setAttribute("errorMessage", "Email and password are required!");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/views/login.jsp");
            dispatcher.forward(request, response);
            return;
        }

        try {
            UsersDAO usersDAO = new UsersDAO();
            User user = usersDAO.getUserByEmail(email);

            if (user != null && user.getUserPassword().equals(password)) {

                // Create session
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                session.setAttribute("userName", user.getUserName());
                session.setAttribute("userEmail", user.getUserEmail());
                session.setAttribute("userID", user.getUserID());
                session.setAttribute("roleID", user.getRoleID());

                // Set session timeout (30 minutes)
                session.setMaxInactiveInterval(1800);

                // Redirect based on role
                switch (user.getRoleID()) {
                    case 1 -> response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                    case 2 -> response.sendRedirect(request.getContextPath() + "/user/dashboard");
                    case 3 -> response.sendRedirect(request.getContextPath() + "/committee/dashboard");
                    default -> response.sendRedirect(request.getContextPath() + "/login");
                }

            } else {
                // Invalid credentials
                request.setAttribute("errorMessage", "Invalid email or password!");
                RequestDispatcher dispatcher = request.getRequestDispatcher("/views/login.jsp");
                dispatcher.forward(request, response);
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error occurred. Please try again later.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/views/login.jsp");
            dispatcher.forward(request, response);
        }
    }
}
