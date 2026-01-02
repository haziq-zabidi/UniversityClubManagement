package com.mycompany.controller;

import com.mycompany.dao.ActivityDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/admin/activities")
public class AdminActivityController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("roleID") == null ||
                (Integer) session.getAttribute("roleID") != 1) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            ActivityDAO dao = new ActivityDAO();
            request.setAttribute("activities", dao.getAllActivities());

            RequestDispatcher rd =
                    request.getRequestDispatcher("/views/admin/activities.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            ActivityDAO dao = new ActivityDAO();

            if ("delete".equals(action)) {
                int activityID = Integer.parseInt(request.getParameter("activityID"));
                dao.deleteActivity(activityID);
            }

            if ("status".equals(action)) {
                int activityID = Integer.parseInt(request.getParameter("activityID"));
                String status = request.getParameter("activityStatus");
                dao.updateActivityStatus(activityID, status);
            }

            response.sendRedirect(request.getContextPath() + "/admin/activities");

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
