package com.mycompany.controller;

import com.mycompany.dao.ClubDAO;
import com.mycompany.dao.UsersDAO;
import com.mycompany.model.Club;
import com.mycompany.model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/admin/manage-clubs")
public class ManageClubsController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isAdmin(request, response)) return;
        
        try {
            ClubDAO clubDAO = new ClubDAO();
            UsersDAO usersDAO = new UsersDAO();
            
            // Get all clubs
            List<Club> clubs = clubDAO.getAllClubs();
            request.setAttribute("clubs", clubs);
            
            // Get all users for the dropdown
            List<User> allUsers = usersDAO.getAllUsers();
            request.setAttribute("allUsers", allUsers);
            
            // Check if editing
            String editID = request.getParameter("editID");
            if (editID != null) {
                Club editClub = clubDAO.getClubByID(Integer.parseInt(editID));
                request.setAttribute("editClub", editClub);
            }
            
            request.getRequestDispatcher("/views/admin/manageClubs.jsp")
                   .forward(request, response);
                   
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error: " + e.getMessage());
            request.getRequestDispatcher("/views/admin/manageClubs.jsp")
                   .forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isAdmin(request, response)) return;
        
        String action = request.getParameter("action");
        
        try {
            ClubDAO clubDAO = new ClubDAO();
            
            if ("create".equals(action)) {
                String clubName = request.getParameter("clubName");
                String clubDescription = request.getParameter("clubDescription");
                String clubCategory = request.getParameter("clubCategory");
                String adminUserID = request.getParameter("adminUserID");
                
                // Validate that adminUserID is provided
                if (adminUserID == null || adminUserID.trim().isEmpty()) {
                    request.setAttribute("errorMessage", "Please select a committee member");
                    doGet(request, response);
                    return;
                }
                
                Club newClub = new Club();
                newClub.setClubName(clubName);
                newClub.setClubDescription(clubDescription);
                newClub.setClubCategory(clubCategory);
                newClub.setAdminUserID(Integer.parseInt(adminUserID));
                
                clubDAO.addClub(newClub);
                
                // Also update the user's roleID to 3 (Committee)
                UsersDAO usersDAO = new UsersDAO();
                User user = usersDAO.getUserById(Integer.parseInt(adminUserID));
                if (user != null && user.getRoleID() != 3) {
                    user.setRoleID(3);
                    usersDAO.updateUser(user);
                }
                
                response.sendRedirect(request.getContextPath() + "/admin/manage-clubs");
                
            } else if ("update".equals(action)) {
                String clubIDParam = request.getParameter("clubID");
                if (clubIDParam == null) {
                    throw new ServletException("Missing clubID for update");
                }
                
                String clubName = request.getParameter("clubName");
                String clubDescription = request.getParameter("clubDescription");
                String clubCategory = request.getParameter("clubCategory");
                String adminUserID = request.getParameter("adminUserID");
                
                // Validate that adminUserID is provided
                if (adminUserID == null || adminUserID.trim().isEmpty()) {
                    request.setAttribute("errorMessage", "Please select a committee member");
                    doGet(request, response);
                    return;
                }
                
                Club updateClub = new Club();
                updateClub.setClubID(Integer.parseInt(clubIDParam));
                updateClub.setClubName(clubName);
                updateClub.setClubDescription(clubDescription);
                updateClub.setClubCategory(clubCategory);
                updateClub.setAdminUserID(Integer.parseInt(adminUserID));
                
                clubDAO.updateClub(updateClub);
                
                // Also update the user's roleID to 3 (Committee)
                UsersDAO usersDAO = new UsersDAO();
                User user = usersDAO.getUserById(Integer.parseInt(adminUserID));
                if (user != null && user.getRoleID() != 3) {
                    user.setRoleID(3);
                    usersDAO.updateUser(user);
                }
                
                response.sendRedirect(request.getContextPath() + "/admin/manage-clubs");
                
            } else if ("delete".equals(action)) {
                String clubIDParam = request.getParameter("clubID");
                if (clubIDParam == null) {
                    throw new ServletException("Missing clubID for delete");
                }
                clubDAO.deleteClub(Integer.parseInt(clubIDParam));
                response.sendRedirect(request.getContextPath() + "/admin/manage-clubs");
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error: " + e.getMessage());
            doGet(request, response);
        }
    }
    
    private boolean isAdmin(HttpServletRequest r, HttpServletResponse s)
            throws IOException {
        HttpSession session = r.getSession(false);
        if (session == null ||
            session.getAttribute("roleID") == null ||
            (Integer) session.getAttribute("roleID") != 1) {
            s.sendRedirect(r.getContextPath() + "/login");
            return false;
        }
        return true;
    }
}