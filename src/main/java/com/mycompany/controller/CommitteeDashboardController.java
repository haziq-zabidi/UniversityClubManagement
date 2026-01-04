package com.mycompany.controller;
import com.mycompany.dao.ClubDAO;
import com.mycompany.dao.MembershipDAO;
import com.mycompany.dao.ActivityDAO;
import com.mycompany.dao.AnnouncementDAO;
import com.mycompany.model.Club;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/committee/dashboard")
public class CommitteeDashboardController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Prevent Back Button Cache
        response.setHeader("Cache-Control","no-cache, no-store, must-revalidate"); 
        response.setHeader("Pragma","no-cache");
        response.setDateHeader("Expires", 0);
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userID") == null ||
            session.getAttribute("roleID") == null ||
            (Integer) session.getAttribute("roleID") != 3) { // 3 = Committee
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        int userID = (Integer) session.getAttribute("userID");
        
        try {
            ClubDAO clubDAO = new ClubDAO();
            MembershipDAO membershipDAO = new MembershipDAO();
            ActivityDAO activityDAO = new ActivityDAO();
            AnnouncementDAO announcementDAO = new AnnouncementDAO();
            
            // Get clubs where user is committee member
            List<Club> clubs = clubDAO.getClubsByCommittee(userID);
            
            // Calculate totals across all clubs
            int totalMembers = 0;
            int totalActivities = 0;
            int totalAnnouncements = 0;
            
            // Create a map to store stats for each club
            Map<Integer, Map<String, Integer>> clubStats = new HashMap<>();
            
            for (Club club : clubs) {
                int clubID = club.getClubID();
                
                // Get counts for this club
                int memberCount = membershipDAO.getActiveMemberCount(clubID);
                int activityCount = activityDAO.getActiveActivityCount(clubID);
                int announcementCount = announcementDAO.getAnnouncementCount(clubID);
                
                // Store stats for this club
                Map<String, Integer> stats = new HashMap<>();
                stats.put("members", memberCount);
                stats.put("activities", activityCount);
                stats.put("announcements", announcementCount);
                clubStats.put(clubID, stats);
                
                // Add to totals
                totalMembers += memberCount;
                totalActivities += activityCount;
                totalAnnouncements += announcementCount;
            }
            
            request.setAttribute("clubsList", clubs);
            request.setAttribute("clubStats", clubStats);
            request.setAttribute("totalMembers", totalMembers);
            request.setAttribute("totalActivities", totalActivities);
            request.setAttribute("totalAnnouncements", totalAnnouncements);
            
            RequestDispatcher rd = request.getRequestDispatcher("/views/committee/dashboard.jsp");
            rd.forward(request, response);
            
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            throw new ServletException(e);
        }
    }
}