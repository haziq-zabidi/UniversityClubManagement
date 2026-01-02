package com.mycompany.controller;

import com.mycompany.dao.ClubDAO;
import com.mycompany.model.Club;
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
            ClubDAO dao = new ClubDAO();
            List<Club> clubs = dao.getAllClubs();
            request.setAttribute("clubs", clubs);

            String editID = request.getParameter("editID");
            if (editID != null) {
                Club club = dao.getClubByID(Integer.parseInt(editID));
                request.setAttribute("editClub", club);
            }

            request.getRequestDispatcher("/views/admin/manageClubs.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    if (!isAdmin(request, response)) return;

    String action = request.getParameter("action");

    try {
        ClubDAO dao = new ClubDAO();

        if ("create".equals(action)) {

            Club club = new Club();
            club.setClubName(request.getParameter("clubName"));
            club.setClubDescription(request.getParameter("clubDescription"));
            club.setClubCategory(request.getParameter("clubCategory"));

            // ✅ DO NOT parse adminUserID from request
            club.setAdminUserID(1); // or from session

            dao.addClub(club);

        } else if ("update".equals(action)) {

            String clubIDParam = request.getParameter("clubID");
            if (clubIDParam == null) {
                throw new ServletException("Missing clubID for update");
            }

            Club club = new Club();
            club.setClubID(Integer.parseInt(clubIDParam));
            club.setClubName(request.getParameter("clubName"));
            club.setClubDescription(request.getParameter("clubDescription"));
            club.setClubCategory(request.getParameter("clubCategory"));
            club.setAdminUserID(1);

            dao.updateClub(club);

        } else if ("delete".equals(action)) {

            String clubIDParam = request.getParameter("clubID");
            if (clubIDParam == null) {
                throw new ServletException("Missing clubID for delete");
            }

            dao.deleteClub(Integer.parseInt(clubIDParam));
        }

        response.sendRedirect(request.getContextPath() + "/admin/manage-clubs");

    } catch (Exception e) {
        throw new ServletException(e);
    }
}


    private Club buildClubFromRequest(HttpServletRequest request) {
        Club club = new Club();
        club.setClubName(request.getParameter("clubName"));
        club.setClubDescription(request.getParameter("clubDescription"));
        club.setClubCategory(request.getParameter("clubCategory"));

        // ✅ ADMIN controls ownership
        club.setAdminUserID(1); // or get from session if needed

        return club;
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
