package com.mycompany.controller;

import com.mycompany.dao.AnnouncementDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;


@WebServlet("/admin/announcement/delete")
public class AdminDeleteAnnouncementController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || (Integer) session.getAttribute("roleID") != 1) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        try {
            int id = Integer.parseInt(req.getParameter("id"));
            new AnnouncementDAO().adminDeleteAnnouncement(id);
            res.sendRedirect(req.getContextPath() + "/admin/announcements");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
