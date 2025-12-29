package com.mycompany.controller;

import com.mycompany.dao.AnnouncementDAO;
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

        String clubIDStr = request.getParameter("clubID");
        if (clubIDStr == null || clubIDStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/committee/dashboard");
            return;
        }

        int clubID = Integer.parseInt(clubIDStr);

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
        if (session == null || session.getAttribute("userID") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int authorUserID = (Integer) session.getAttribute("userID");
        String clubIDStr = request.getParameter("clubID");
        String action = request.getParameter("action");

        if (clubIDStr == null || clubIDStr.isEmpty() || action == null) {
            response.sendRedirect(request.getContextPath() + "/committee/dashboard");
            return;
        }

        int clubID = Integer.parseInt(clubIDStr);

        try {
            AnnouncementDAO announcementDAO = new AnnouncementDAO();

            switch (action) {
                case "create":
                    String title = request.getParameter("title").trim();
                    String message = request.getParameter("message").trim();
                    if (!title.isEmpty() && !message.isEmpty()) {
                        Announcement a = new Announcement();
                        a.setAnnouncementTitle(title);
                        a.setAnnouncementMessage(message);
                        a.setPublishDate(LocalDate.now());
                        a.setClubID(clubID);
                        a.setAuthorUserID(authorUserID);
                        announcementDAO.addAnnouncement(a);
                    }
                    break;

                case "edit":
                    String editIdStr = request.getParameter("announcementID");
                    if (editIdStr != null && !editIdStr.isEmpty()) {
                        int announcementID = Integer.parseInt(editIdStr);
                        Announcement a = announcementDAO.getAnnouncementByID(announcementID);
                        if (a != null) {
                            String newTitle = request.getParameter("title").trim();
                            String newMessage = request.getParameter("message").trim();
                            if (!newTitle.isEmpty() && !newMessage.isEmpty()) {
                                a.setAnnouncementTitle(newTitle);
                                a.setAnnouncementMessage(newMessage);
                                announcementDAO.updateAnnouncement(a);
                            }
                        }
                    }
                    break;

                case "delete":
                    String deleteIdStr = request.getParameter("announcementID");
                    if (deleteIdStr != null && !deleteIdStr.isEmpty()) {
                        int announcementID = Integer.parseInt(deleteIdStr);
                        Announcement a = announcementDAO.getAnnouncementByID(announcementID);
                        if (a != null) {
                            announcementDAO.deleteAnnouncement(announcementID);
                        }
                    }
                    break;

                default:
                    // Unknown action
                    break;
            }

            response.sendRedirect(request.getContextPath() + "/committee/manage-announcements?clubID=" + clubID);

        } catch (SQLException | ClassNotFoundException e) {
            throw new ServletException(e);
        }
    }
}
