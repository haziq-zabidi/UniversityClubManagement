package com.mycompany.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/committee/dashboard")
public class CommitteeDashboardController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("roleID") == null ||
            (Integer) session.getAttribute("roleID") != 3) { // roleID 3 = Committee
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Forward to committee dashboard JSP
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/committee/dashboard.jsp");
        dispatcher.forward(request, response);
    }
}
