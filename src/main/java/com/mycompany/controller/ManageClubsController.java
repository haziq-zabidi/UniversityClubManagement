package com.mycompany.controller;

import com.mycompany.dao.ClubDAO;
import com.mycompany.model.Club;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/admin/manage-clubs")
public class ManageClubsController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            ClubDAO dao = new ClubDAO();
            List<Club> clubs = dao.getAllClubs();
            request.setAttribute("clubs", clubs);

            // If editing, load the club
            String editID = request.getParameter("editID");
            if (editID != null) {
                int clubID = Integer.parseInt(editID);
                Club club = dao.getClubByID(clubID);
                request.setAttribute("editClub", club);
            }

            RequestDispatcher dispatcher = request.getRequestDispatcher("/views/admin/manageClubs.jsp");
            dispatcher.forward(request, response);

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("/views/admin/manageClubs.jsp");
            dispatcher.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            ClubDAO dao = new ClubDAO();

            if ("create".equals(action)) {
                Club club = new Club();
                club.setClubName(request.getParameter("clubName"));
                club.setClubDescription(request.getParameter("clubDescription"));
                club.setClubCategory(request.getParameter("clubCategory"));
                club.setAdminUserID(Integer.parseInt(request.getParameter("adminUserID")));
                dao.addClub(club);

            } else if ("update".equals(action)) {
                Club club = new Club();
                club.setClubID(Integer.parseInt(request.getParameter("clubID")));
                club.setClubName(request.getParameter("clubName"));
                club.setClubDescription(request.getParameter("clubDescription"));
                club.setClubCategory(request.getParameter("clubCategory"));
                club.setAdminUserID(Integer.parseInt(request.getParameter("adminUserID")));
                dao.updateClub(club);

            } else if ("delete".equals(action)) {
                int clubID = Integer.parseInt(request.getParameter("clubID"));
                dao.deleteClub(clubID);
            }

            // Redirect back to manage-clubs page
            response.sendRedirect(request.getContextPath() + "/admin/manage-clubs");

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("/views/admin/manageClubs.jsp");
            dispatcher.forward(request, response);
        }
    }
}
