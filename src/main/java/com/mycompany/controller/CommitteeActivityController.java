package com.mycompany.controller;

import com.mycompany.dao.ActivityDAO;
import com.mycompany.dao.AttendanceDAO;
import com.mycompany.dao.ClubDAO;
import com.mycompany.model.Activity;
import com.mycompany.model.Attendance;
import com.mycompany.model.User;
import com.mycompany.model.Club;
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

        // Prevent caching
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("roleID") == null || 
            (Integer) session.getAttribute("roleID") != 3) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        String clubIDParam = request.getParameter("clubID");
        String activityIDParam = request.getParameter("activityID");

        try {
            if ("viewParticipants".equals(action) && activityIDParam != null) {
                viewActivityParticipants(request, response);
            } else if (clubIDParam != null) {
                listActivities(request, response, Integer.parseInt(clubIDParam));
            } else {
                // Show clubs managed by committee
                User currentUser = (User) session.getAttribute("user");
                ClubDAO clubDAO = new ClubDAO();
                List<Club> managedClubs = clubDAO.getClubsByCommittee(currentUser.getUserID());
                request.setAttribute("clubs", managedClubs);
                RequestDispatcher rd = request.getRequestDispatcher("/views/committee/manageActivities.jsp");
                rd.forward(request, response);
            }

        } catch (SQLException | ClassNotFoundException e) {
            throw new ServletException(e);
        }
    }

    private void listActivities(HttpServletRequest request, HttpServletResponse response, int clubID)
            throws ServletException, IOException, SQLException, ClassNotFoundException {

        ActivityDAO activityDAO = new ActivityDAO();
        AttendanceDAO attendanceDAO = new AttendanceDAO();
        ClubDAO clubDAO = new ClubDAO();
        
        // Get club details
        Club club = clubDAO.getClubById(clubID);
        
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
            
            // Get participant count for each activity
            int participantCount = attendanceDAO.getParticipantCount(a.getActivityID());
            a.setCurrentParticipants(participantCount); // Add this field to Activity model if not exists
        }

        request.setAttribute("activitiesList", activities);
        request.setAttribute("club", club);
        request.setAttribute("clubID", clubID);
        RequestDispatcher rd = request.getRequestDispatcher("/views/committee/manageActivities.jsp");
        rd.forward(request, response);
    }

    private void viewActivityParticipants(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, ClassNotFoundException {

        int activityID = Integer.parseInt(request.getParameter("activityID"));
        
        ActivityDAO activityDAO = new ActivityDAO();
        AttendanceDAO attendanceDAO = new AttendanceDAO();
        
        // Get activity details
        Activity activity = activityDAO.getActivityByID(activityID);
        
        // Get all participants (attendances) for this activity
        List<Attendance> participants = attendanceDAO.getAttendancesByActivity(activityID);
        
        request.setAttribute("activity", activity);
        request.setAttribute("participants", participants);
        request.setAttribute("clubID", activity.getClubID());
        
        RequestDispatcher rd = request.getRequestDispatcher("/views/committee/viewActivityParticipants.jsp");
        rd.forward(request, response);
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
                
                session.setAttribute("successMessage", "Activity created successfully!");

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
                    
                    session.setAttribute("successMessage", "Activity updated successfully!");
                }

            } else if ("delete".equals(action)) {
                int activityID = Integer.parseInt(request.getParameter("activityID"));
                activityDAO.deleteActivity(activityID);
                
                session.setAttribute("successMessage", "Activity deleted successfully!");
            }

            response.sendRedirect(request.getContextPath() + "/committee/manage-activities?clubID=" + clubID);

        } catch (SQLException | ClassNotFoundException e) {
            throw new ServletException(e);
        }
    }
}