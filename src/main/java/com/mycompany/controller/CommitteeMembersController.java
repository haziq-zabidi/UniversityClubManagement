package com.mycompany.controller;

import com.mycompany.dao.MembershipDAO;
import com.mycompany.dao.ClubDAO;
import com.mycompany.model.User;
import com.mycompany.model.Club;
import com.mycompany.model.Membership;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.ArrayList;

@WebServlet("/committee/manage-members")
public class CommitteeMembersController extends HttpServlet {
    
    private MembershipDAO membershipDAO;
    private ClubDAO clubDAO;
    
    @Override
    public void init() throws ServletException {
        membershipDAO = new MembershipDAO();
        clubDAO = new ClubDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        User currentUser = (User) session.getAttribute("user");
        
        // Verify user is committee member (roleID = 3)
        if (currentUser.getRoleID() != 3) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        String clubIDParam = request.getParameter("clubID");
        
        try {
            if ("view".equals(action) && clubIDParam != null) {
                viewMembers(request, response, currentUser, Integer.parseInt(clubIDParam));
            } else {
                // Default: show clubs managed by committee
                List<Club> managedClubs = clubDAO.getClubsByCommittee(currentUser.getUserID());
                request.setAttribute("clubs", managedClubs);
                request.getRequestDispatcher("/views/committee/manageMembers.jsp")
                       .forward(request, response);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/views/committee/manageMembers.jsp")
                   .forward(request, response);
        }
    }
    
    private void viewMembers(HttpServletRequest request, HttpServletResponse response, 
                            User currentUser, int clubID) 
            throws ServletException, IOException, SQLException, ClassNotFoundException {
        
        // Verify committee member has access to this club
        List<Club> managedClubs = clubDAO.getClubsByCommittee(currentUser.getUserID());
        boolean hasAccess = managedClubs.stream()
                                       .anyMatch(club -> club.getClubID() == clubID);
        
        if (!hasAccess) {
            request.setAttribute("errorMessage", "You don't have permission to manage this club");
            doGet(request, response);
            return;
        }
        
        // Get club details
        Club club = clubDAO.getClubById(clubID);
        
        // Get members with their membership details
        List<Membership> memberships = membershipDAO.getMembershipsByClub(clubID);
        
        request.setAttribute("club", club);
        request.setAttribute("memberships", memberships);
        request.setAttribute("clubID", clubID);
        request.getRequestDispatcher("/views/committee/manageMembers.jsp")
               .forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        User currentUser = (User) session.getAttribute("user");
        
        if (currentUser.getRoleID() != 3) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        
        try {
            if ("remove".equals(action)) {
                removeMember(request, response, currentUser);
            } else if ("updateStatus".equals(action)) {
                updateMemberStatus(request, response, currentUser);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            doGet(request, response);
        }
    }
    
    private void removeMember(HttpServletRequest request, HttpServletResponse response, 
                             User currentUser) 
            throws SQLException, ClassNotFoundException, IOException, ServletException {
        
        int membershipID = Integer.parseInt(request.getParameter("membershipID"));
        int clubID = Integer.parseInt(request.getParameter("clubID"));
        
        // Verify committee has access to this club
        List<Club> managedClubs = clubDAO.getClubsByCommittee(currentUser.getUserID());
        boolean hasAccess = managedClubs.stream()
                                       .anyMatch(club -> club.getClubID() == clubID);
        
        if (!hasAccess) {
            request.setAttribute("errorMessage", "Access denied");
            response.sendRedirect(request.getContextPath() + 
                                "/committee/manage-members?action=view&clubID=" + clubID);
            return;
        }
        
        boolean success = membershipDAO.deleteMembership(membershipID);
        
        if (success) {
            request.getSession().setAttribute("successMessage", "Member removed successfully");
        } else {
            request.getSession().setAttribute("errorMessage", "Failed to remove member");
        }
        
        response.sendRedirect(request.getContextPath() + 
                            "/committee/manage-members?action=view&clubID=" + clubID);
    }
    
    private void updateMemberStatus(HttpServletRequest request, HttpServletResponse response, 
                                   User currentUser) 
            throws SQLException, ClassNotFoundException, IOException, ServletException {
        
        int membershipID = Integer.parseInt(request.getParameter("membershipID"));
        int clubID = Integer.parseInt(request.getParameter("clubID"));
        String newStatus = request.getParameter("status");
        
        // Verify committee has access
        List<Club> managedClubs = clubDAO.getClubsByCommittee(currentUser.getUserID());
        boolean hasAccess = managedClubs.stream()
                                       .anyMatch(club -> club.getClubID() == clubID);
        
        if (!hasAccess) {
            request.setAttribute("errorMessage", "Access denied");
            response.sendRedirect(request.getContextPath() + 
                                "/committee/manage-members?action=view&clubID=" + clubID);
            return;
        }
        
        boolean success = membershipDAO.updateMembershipStatus(membershipID, newStatus);
        
        if (success) {
            request.getSession().setAttribute("successMessage", "Member status updated");
        } else {
            request.getSession().setAttribute("errorMessage", "Failed to update status");
        }
        
        response.sendRedirect(request.getContextPath() + 
                            "/committee/manage-members?action=view&clubID=" + clubID);
    }
}