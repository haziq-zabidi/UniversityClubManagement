package com.mycompany.controller;

import com.mycompany.dao.ClubDAO;
import com.mycompany.dao.MembershipDAO;
import com.mycompany.dao.AnnouncementDAO;
import com.mycompany.model.Club;
import com.mycompany.model.Membership;
import com.mycompany.model.Announcement;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/committee/manage-club")
public class CommitteeManageClubController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("roleID") == null ||
            (Integer) session.getAttribute("roleID") != 3) { // Committee role = 3
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int userID = (Integer) session.getAttribute("userID");

        try {
            ClubDAO clubDAO = new ClubDAO();
            MembershipDAO membershipDAO = new MembershipDAO();
            AnnouncementDAO announcementDAO = new AnnouncementDAO();

            // Get club managed by this committee member
            Club club = clubDAO.getAllClubs().stream()
                               .filter(c -> c.getAdminUserID() == userID)
                               .findFirst()
                               .orElse(null);

            if (club == null) {
                request.setAttribute("errorMessage", "You are not assigned to any club yet.");
            } else {
                // Members of the club
                List<Membership> members = membershipDAO.getMembersByClub(club.getClubID());

                // Pending requests (membershipStatus = "pending")
                List<Membership> pendingRequests = members.stream()
                        .filter(m -> m.getMembershipStatus().equalsIgnoreCase("pending"))
                        .toList();

                // Announcements of this club
                List<Announcement> announcements = announcementDAO.getAnnouncementsByClub(club.getClubID());

                request.setAttribute("club", club);
                request.setAttribute("members", members);
                request.setAttribute("pendingRequests", pendingRequests);
                request.setAttribute("announcements", announcements);
            }

            RequestDispatcher rd = request.getRequestDispatcher("/views/committee/manageClub.jsp");
            rd.forward(request, response);

        } catch (SQLException | ClassNotFoundException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession(false);
        int userID = (Integer) session.getAttribute("userID");

        try {
            ClubDAO clubDAO = new ClubDAO();
            MembershipDAO membershipDAO = new MembershipDAO();
            AnnouncementDAO announcementDAO = new AnnouncementDAO();

            Club club = clubDAO.getAllClubs().stream()
                               .filter(c -> c.getAdminUserID() == userID)
                               .findFirst()
                               .orElse(null);

            if (club == null) {
                response.sendRedirect(request.getContextPath() + "/committee/dashboard");
                return;
            }

            int clubID = club.getClubID();

            switch (action) {
                case "updateClub":
                    String name = request.getParameter("clubName");
                    String desc = request.getParameter("clubDescription");
                    String category = request.getParameter("clubCategory");
                    club.setClubName(name);
                    club.setClubDescription(desc);
                    club.setClubCategory(category);
                    clubDAO.updateClub(club);
                    break;

                case "approveMember":
                    int membershipID = Integer.parseInt(request.getParameter("membershipID"));
                    List<Membership> pending = membershipDAO.getMembersByClub(clubID);
                    for (Membership m : pending) {
                        if (m.getMembershipID() == membershipID) {
                            m.setMembershipStatus("approved");
                            membershipDAO.removeMembership(m.getUserID(), clubID); // remove old
                            membershipDAO.addMembership(m); // re-add with approved
                            break;
                        }
                    }
                    break;

                case "deleteMember":
                    int userIDToRemove = Integer.parseInt(request.getParameter("userID"));
                    membershipDAO.removeMembership(userIDToRemove, clubID);
                    break;

                case "addAnnouncement":
                    Announcement a = new Announcement();
                    a.setAnnouncementTitle(request.getParameter("title"));
                    a.setAnnouncementMessage(request.getParameter("message"));
                    a.setPublishDate(LocalDate.now());
                    a.setClubID(clubID);
                    a.setAuthorUserID(userID);
                    announcementDAO.addAnnouncement(a);
                    break;

                case "updateAnnouncement":
                    int annID = Integer.parseInt(request.getParameter("announcementID"));
                    Announcement updateAnn = new Announcement();
                    updateAnn.setAnnouncementID(annID);
                    updateAnn.setAnnouncementTitle(request.getParameter("title"));
                    updateAnn.setAnnouncementMessage(request.getParameter("message"));
                    announcementDAO.updateAnnouncement(updateAnn);
                    break;

                case "deleteAnnouncement":
                    int delAnnID = Integer.parseInt(request.getParameter("announcementID"));
                    announcementDAO.deleteAnnouncement(delAnnID);
                    break;
            }

            response.sendRedirect(request.getContextPath() + "/committee/manage-club");

        } catch (SQLException | ClassNotFoundException e) {
            throw new ServletException(e);
        }
    }
}
