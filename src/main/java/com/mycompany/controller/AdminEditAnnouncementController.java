package com.mycompany.controller;

import com.mycompany.dao.AnnouncementDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import com.mycompany.model.Announcement;
import java.time.LocalDate;


@WebServlet("/admin/announcement/edit")
public class AdminEditAnnouncementController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        if (!isAdmin(req, res)) return;

        int id = Integer.parseInt(req.getParameter("id"));

        try {
            AnnouncementDAO dao = new AnnouncementDAO();
            req.setAttribute("announcement", dao.getAnnouncementWithDetails(id));
            req.getRequestDispatcher("/views/admin/announcement-edit.jsp")
               .forward(req, res);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        if (!isAdmin(req, res)) return;

        try {
            Announcement a = new Announcement();
            a.setAnnouncementID(Integer.parseInt(req.getParameter("id")));
            a.setAnnouncementTitle(req.getParameter("title"));
            a.setAnnouncementMessage(req.getParameter("message"));
            a.setPublishDate(LocalDate.now());

            new AnnouncementDAO().adminUpdateAnnouncement(a);
            res.sendRedirect(req.getContextPath() + "/admin/announcements");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private boolean isAdmin(HttpServletRequest r, HttpServletResponse s)
            throws IOException {
        HttpSession session = r.getSession(false);
        if (session == null || (Integer) session.getAttribute("roleID") != 1) {
            s.sendRedirect(r.getContextPath() + "/login");
            return false;
        }
        return true;
    }
}
