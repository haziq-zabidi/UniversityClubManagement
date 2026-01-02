package com.mycompany.controller;

import com.mycompany.dao.AnnouncementDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/announcements")
public class AdminAnnouncementController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("roleID") == null ||
            (Integer) session.getAttribute("roleID") != 1) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            AnnouncementDAO dao = new AnnouncementDAO();
            request.setAttribute("announcements", dao.getAllAnnouncements());

            RequestDispatcher rd =
                request.getRequestDispatcher("/views/admin/announcements.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
