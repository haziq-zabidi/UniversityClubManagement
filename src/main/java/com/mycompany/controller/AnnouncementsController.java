/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.controller;

import com.mycompany.dao.AnnouncementDAO;
import com.mycompany.dao.ActivityDAO;
import com.mycompany.dao.ClubDAO;
import com.mycompany.dao.MembershipDAO;
import com.mycompany.dao.AttendanceDAO;
import com.mycompany.model.Announcement;
import com.mycompany.model.Activity;
import com.mycompany.model.Club;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author TUF
 */

@WebServlet("/user/announcements")
public class AnnouncementsController extends HttpServlet{
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        // Check if user is logged in
        if (session == null || session.getAttribute("userID") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        int userID = (Integer) session.getAttribute("userID");
        String userName = (String) session.getAttribute("userName");
        String filter = request.getParameter("filter"); // "all", "announcements", "activities"
        
        if (filter == null) {
            filter = "all";
        }
        
        try {
            // Initialize DAOs
            MembershipDAO membershipDAO = new MembershipDAO();
            AnnouncementDAO announcementDAO = new AnnouncementDAO();
            ActivityDAO activityDAO = new ActivityDAO();
            AttendanceDAO attendanceDAO = new AttendanceDAO();
            
            // Step 1: Get all clubs where user is an active member
            List<Club> joinedClubs = membershipDAO.getClubsByUserID(userID);
            
            // Step 2: Create maps to store club names by ID
            Map<Integer, String> clubNames = new HashMap<>();
            for (Club club : joinedClubs) {
                clubNames.put(club.getClubID(), club.getClubName());
            }
            
            // Step 3: Create combined feed based on filter
            List<Map<String, Object>> combinedFeed = new ArrayList<>();
            int announcementCount = 0;
            int activityCount = 0;
            
            if (!joinedClubs.isEmpty()) {
                // Add announcements if filter includes them
                if ("all".equals(filter) || "announcements".equals(filter)) {
                    for (Club club : joinedClubs) {
                        List<Announcement> clubAnnouncements = announcementDAO.getAnnouncementsByClub(club.getClubID());
                        announcementCount += clubAnnouncements.size();
                        for (Announcement ann : clubAnnouncements) {
                            Map<String, Object> item = new HashMap<>();
                            item.put("type", "announcement");
                            item.put("id", ann.getAnnouncementID());
                            item.put("title", ann.getAnnouncementTitle());
                            item.put("message", ann.getAnnouncementMessage());
                            item.put("clubID", ann.getClubID());
                            item.put("clubName", clubNames.get(ann.getClubID()));
                            item.put("date", ann.getPublishDate());
                            combinedFeed.add(item);
                        }
                    }
                }
                
                // Add activities if filter includes them
                if ("all".equals(filter) || "activities".equals(filter)) {
                    for (Club club : joinedClubs) {
                        List<Activity> clubActivities = activityDAO.getActivitiesByClub(club.getClubID());
                        activityCount += clubActivities.size();
                        for (Activity act : clubActivities) {
                            Map<String, Object> item = new HashMap<>();
                            item.put("type", "activity");
                            item.put("id", act.getActivityID());
                            item.put("title", act.getActivityName());
                            item.put("description", act.getActivityDescription());
                            item.put("clubID", act.getClubID());
                            item.put("clubName", clubNames.get(act.getClubID()));
                            item.put("date", act.getStartDate());
                            item.put("endDate", act.getEndDate());
                            item.put("location", act.getActivityLocation());
                            item.put("status", act.getActivityStatus());
                            item.put("maxParticipants", act.getMaxParticipants());
                            
                            // Check attendance
                            boolean hasAttendance = attendanceDAO.hasUserAttendanceForActivity(userID, act.getActivityID());
                            item.put("userAttended", hasAttendance);
                            
                            combinedFeed.add(item);
                        }
                    }
                }
                
                // Sort by date (most recent first)
                combinedFeed.sort((item1, item2) -> {
                    Comparable date1 = (Comparable) item1.get("date");
                    Comparable date2 = (Comparable) item2.get("date");
                    return date2.compareTo(date1);
                });
            }
            
            // Step 4: Set attributes for JSP
            request.setAttribute("userName", userName);
            request.setAttribute("combinedFeed", combinedFeed);
            request.setAttribute("totalCount", combinedFeed.size());
            request.setAttribute("announcementCount", announcementCount);
            request.setAttribute("activityCount", activityCount);
            request.setAttribute("joinedClubs", joinedClubs);
            request.setAttribute("currentFilter", filter);
            
            // Forward to announcements JSP
            RequestDispatcher rd = request.getRequestDispatcher("/views/user/announcements.jsp");
            rd.forward(request, response);
            
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error loading announcements: " + e.getMessage());
            RequestDispatcher rd = request.getRequestDispatcher("/views/error.jsp");
            rd.forward(request, response);
        }
    }
}
