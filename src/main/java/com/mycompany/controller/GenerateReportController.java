package com.mycompany.controller;

import com.mycompany.dao.*;
import com.mycompany.model.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;

@WebServlet("/admin/generate-report")
public class GenerateReportController extends HttpServlet {
    
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
            // Initialize DAOs
            ClubDAO clubDAO = new ClubDAO();
            UsersDAO usersDAO = new UsersDAO();
            ActivityDAO activityDAO = new ActivityDAO();
            AnnouncementDAO announcementDAO = new AnnouncementDAO();
            MembershipDAO membershipDAO = new MembershipDAO();
            AttendanceDAO attendanceDAO = new AttendanceDAO();
            
            // Get current date info
            LocalDate now = LocalDate.now();
            String currentMonth = now.format(DateTimeFormatter.ofPattern("MMMM yyyy"));
            
            // Get all data
            List<Club> allClubs = clubDAO.getAllClubs();
            List<User> allUsers = usersDAO.getAllUsers();
            
            // Calculate statistics
            int totalClubs = allClubs.size();
            int totalUsers = allUsers.size();
            int totalActivities = activityDAO.getTotalActivityCount();
            int totalAnnouncements = announcementDAO.getTotalAnnouncementCount();
            
            // User breakdown by role
            int adminCount = 0;
            int committeeCount = 0;
            int studentCount = 0;
            
            for (User user : allUsers) {
                if (user.getRoleID() == 1) adminCount++;
                else if (user.getRoleID() == 3) committeeCount++;
                else if (user.getRoleID() == 2) studentCount++;
            }
            
            // Faculty distribution
            Map<String, Integer> facultyDistribution = new HashMap<>();
            for (User user : allUsers) {
                String faculty = user.getFaculty();
                if (faculty != null && !faculty.isEmpty()) {
                    facultyDistribution.put(faculty, facultyDistribution.getOrDefault(faculty, 0) + 1);
                }
            }
            
            // Club statistics with member counts
            List<Map<String, Object>> clubStats = new ArrayList<>();
            for (Club club : allClubs) {
                Map<String, Object> stat = new HashMap<>();
                stat.put("clubName", club.getClubName());
                stat.put("category", club.getClubCategory());
                stat.put("memberCount", membershipDAO.getActiveMemberCount(club.getClubID()));
                stat.put("activityCount", activityDAO.getActiveActivityCount(club.getClubID()));
                stat.put("announcementCount", announcementDAO.getAnnouncementCount(club.getClubID()));
                clubStats.add(stat);
            }
            
            // Activity statistics
int activeActivities = 0;
int completedActivities = 0;  // This will count "Closed" activities
int cancelledActivities = 0;

List<Activity> activities = activityDAO.getAllActivities();
for (Activity activity : activities) {
    String status = activity.getActivityStatus();
    if ("Open".equalsIgnoreCase(status)) activeActivities++;
    else if ("Closed".equalsIgnoreCase(status)) completedActivities++;  // Changed from "Completed" to "Closed"
    else if ("Cancelled".equalsIgnoreCase(status)) cancelledActivities++;
}
            
            // Attendance statistics
            int totalAttendanceRecords = attendanceDAO.getTotalAttendanceCount();
            int presentCount = attendanceDAO.getPresentCount();
            int absentCount = attendanceDAO.getAbsentCount();
            
            // Set all attributes
            request.setAttribute("currentMonth", currentMonth);
            request.setAttribute("reportDate", now.format(DateTimeFormatter.ofPattern("dd MMM yyyy")));
            
            request.setAttribute("totalClubs", totalClubs);
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("totalActivities", totalActivities);
            request.setAttribute("totalAnnouncements", totalAnnouncements);
            
            request.setAttribute("adminCount", adminCount);
            request.setAttribute("committeeCount", committeeCount);
            request.setAttribute("studentCount", studentCount);
            
            request.setAttribute("facultyDistribution", facultyDistribution);
            request.setAttribute("clubStats", clubStats);
            
            request.setAttribute("activeActivities", activeActivities);
            request.setAttribute("completedActivities", completedActivities);
            request.setAttribute("cancelledActivities", cancelledActivities);
            
            request.setAttribute("totalAttendanceRecords", totalAttendanceRecords);
            request.setAttribute("presentCount", presentCount);
            request.setAttribute("absentCount", absentCount);
            
            double attendanceRate = totalAttendanceRecords > 0 ? 
                (double) presentCount / totalAttendanceRecords * 100 : 0;
            request.setAttribute("attendanceRate", String.format("%.1f", attendanceRate));
            
            RequestDispatcher rd = request.getRequestDispatcher("/views/admin/report.jsp");
            rd.forward(request, response);
            
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error generating report: " + e.getMessage());
            RequestDispatcher rd = request.getRequestDispatcher("/views/error.jsp");
            rd.forward(request, response);
        }
    }
}