package com.mycompany.controller;

import com.mycompany.dao.ActivityDAO;
import com.mycompany.dao.AnnouncementDAO;
import com.mycompany.dao.MembershipDAO;
import com.mycompany.model.Activity;
import com.mycompany.model.Announcement;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/committee/manage-announcements")
public class CommitteeAnnouncementsController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("roleID") == null || (Integer) session.getAttribute("roleID") != 3) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int clubID = Integer.parseInt(request.getParameter("clubID"));
        try {
            AnnouncementDAO announcementDAO = new AnnouncementDAO();
            List<Announcement> announcements = announcementDAO.getAnnouncementsByClub(clubID);

            request.setAttribute("clubID", clubID);
            request.setAttribute("announcementsList", announcements);

            RequestDispatcher rd = request.getRequestDispatcher("/views/committee/manageAnnouncements.jsp");
            rd.forward(request, response);

        } catch (SQLException | ClassNotFoundException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        int authorUserID = (Integer) session.getAttribute("userID");
        int clubID = Integer.parseInt(request.getParameter("clubID"));
        String action = request.getParameter("action");

        try {
            AnnouncementDAO announcementDAO = new AnnouncementDAO();
            ActivityDAO activityDAO = new ActivityDAO();
            MembershipDAO membershipDAO = new MembershipDAO();

            if ("createAnnouncement".equals(action)) {
                Announcement a = new Announcement();
                a.setAnnouncementTitle(request.getParameter("title"));
                a.setAnnouncementMessage(request.getParameter("message"));
                a.setPublishDate(LocalDate.now());
                a.setClubID(clubID);
                a.setAuthorUserID(authorUserID);
                announcementDAO.addAnnouncement(a);
            }

            else if ("createActivity".equals(action)) {
                Activity act = new Activity();
                act.setActivityName(request.getParameter("activityName"));
                act.setActivityDescription(request.getParameter("activityDescription"));
                act.setActivityType(request.getParameter("activityType"));
                act.setActivityLocation(request.getParameter("activityLocation"));
                act.setStartDate(LocalDate.parse(request.getParameter("startDate")));
                act.setEndDate(LocalDate.parse(request.getParameter("endDate")));
                act.setMaxParticipants(Integer.parseInt(request.getParameter("maxParticipants")));
                act.setClubID(clubID);
                activityDAO.addActivity(act);
            }

            else if ("joinActivity".equals(action)) {
                int activityID = Integer.parseInt(request.getParameter("activityID"));
                int userID = Integer.parseInt(request.getParameter("userID"));
                membershipDAO.addAttendance(activityID, userID, LocalDate.now(), "Joined");
            }

            response.sendRedirect(request.getContextPath() + "/committee/manage-announcements?clubID=" + clubID);

        } catch (SQLException | ClassNotFoundException e) {
            throw new ServletException(e);
        }
    }
}
