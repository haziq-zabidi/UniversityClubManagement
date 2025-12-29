package com.mycompany.controller;

import com.mycompany.dao.ActivityDAO;
import com.mycompany.model.Activity;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/committee/manage-activities")
public class CommitteeActivityController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("roleID") == null || (Integer) session.getAttribute("roleID") != 3) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int clubID = Integer.parseInt(request.getParameter("clubID"));

        try {
            ActivityDAO activityDAO = new ActivityDAO();
            List<Activity> activities = activityDAO.getActivitiesByClub(clubID);

            // Auto-update status based on date
            LocalDate today = LocalDate.now();
            for (Activity a : activities) {
                String newStatus = a.getEndDate().isBefore(today) ? "Closed" : "Open";
                String currentStatus = a.getActivityStatus();
                if (currentStatus == null || !currentStatus.equals(newStatus)) {
                    activityDAO.updateActivityStatus(a.getActivityID(), newStatus);
                    a.setActivityStatus(newStatus);
                }
            }

            request.setAttribute("activitiesList", activities);
            request.setAttribute("clubID", clubID);
            RequestDispatcher rd = request.getRequestDispatcher("/views/committee/manageActivities.jsp");
            rd.forward(request, response);

        } catch (SQLException | ClassNotFoundException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        int clubID = Integer.parseInt(request.getParameter("clubID"));

        try {
            ActivityDAO activityDAO = new ActivityDAO();
            String action = request.getParameter("action");

            if ("create".equals(action)) {
                Activity a = new Activity();
                a.setActivityName(request.getParameter("activityName"));
                a.setActivityDescription(request.getParameter("activityDescription"));
                a.setActivityType(request.getParameter("activityType"));
                a.setActivityLocation(request.getParameter("activityLocation"));
                a.setStartDate(LocalDate.parse(request.getParameter("startDate")));
                a.setEndDate(LocalDate.parse(request.getParameter("endDate")));
                a.setMaxParticipants(Integer.parseInt(request.getParameter("maxParticipants")));
                a.setClubID(clubID);
                a.setActivityStatus("Open"); // default status
                activityDAO.addActivity(a);

            } else if ("edit".equals(action)) {
                int activityID = Integer.parseInt(request.getParameter("activityID"));
                Activity a = activityDAO.getActivityByID(activityID);
                if (a != null) {
                    a.setActivityName(request.getParameter("activityName"));
                    a.setActivityDescription(request.getParameter("activityDescription"));
                    a.setActivityType(request.getParameter("activityType"));
                    a.setActivityLocation(request.getParameter("activityLocation"));
                    a.setStartDate(LocalDate.parse(request.getParameter("startDate")));
                    a.setEndDate(LocalDate.parse(request.getParameter("endDate")));
                    a.setMaxParticipants(Integer.parseInt(request.getParameter("maxParticipants")));
                    // status will auto-update in GET
                    activityDAO.updateActivity(a);
                }

            } else if ("delete".equals(action)) {
                int activityID = Integer.parseInt(request.getParameter("activityID"));
                activityDAO.deleteActivity(activityID);
            }

            response.sendRedirect(request.getContextPath() + "/committee/manage-activities?clubID=" + clubID);

        } catch (SQLException | ClassNotFoundException e) {
            throw new ServletException(e);
        }
    }
}
