package com.mycompany.controller;

import com.mycompany.dao.ClubDAO;
import com.mycompany.dao.UsersDAO;
import com.mycompany.dao.ActivityDAO;
import com.mycompany.dao.AnnouncementDAO;
import com.mycompany.dao.MembershipDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/admin/dashboard")
public class AdminDashboardController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Prevent Back Button Cache
        response.setHeader("Cache-Control","no-cache, no-store, must-revalidate"); 
        response.setHeader("Pragma","no-cache");
        response.setDateHeader("Expires", 0);
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("roleID") == null || 
            (Integer)session.getAttribute("roleID") != 1) {
            // Not logged in or not admin → redirect to login
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            // Initialize DAOs
            ClubDAO clubDAO = new ClubDAO();
            UsersDAO usersDAO = new UsersDAO();
            ActivityDAO activityDAO = new ActivityDAO();
            AnnouncementDAO announcementDAO = new AnnouncementDAO();
            MembershipDAO membershipDAO = new MembershipDAO(); // You'll need to create this
            
            // Get counts
            int totalClubs = clubDAO.getTotalClubCount();
            int totalUsers = usersDAO.getTotalUserCount();
            int totalActivities = activityDAO.getTotalActivityCount();
            int totalAnnouncements = announcementDAO.getTotalAnnouncementCount();
            int activeMembers = membershipDAO.getActiveMembersCount();
            int pendingMembers = membershipDAO.getPendingMembersCount();
            
            // Set attributes
            request.setAttribute("totalClubs", totalClubs);
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("totalActivities", totalActivities);
            request.setAttribute("totalAnnouncements", totalAnnouncements);
            request.setAttribute("activeMembers", activeMembers);
            request.setAttribute("pendingMembers", pendingMembers);
            
            // Forward to admin dashboard JSP
            RequestDispatcher dispatcher = request.getRequestDispatcher("/views/admin/dashboard.jsp");
            dispatcher.forward(request, response);
            
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error loading dashboard: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("/views/error.jsp");
            dispatcher.forward(request, response);
        }
    }
}