package com.mycompany.controller;

import com.mycompany.dao.AnnouncementDAO;
import com.mycompany.model.Announcement;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/announcement/view")
public class AdminViewAnnouncementController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("roleID") == null ||
            (Integer) session.getAttribute("roleID") != 1) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int id = Integer.parseInt(request.getParameter("id"));

        try {
            AnnouncementDAO dao = new AnnouncementDAO();
            Announcement announcement = dao.getAnnouncementWithDetails(id);

            request.setAttribute("announcement", announcement);

            RequestDispatcher rd =
                request.getRequestDispatcher("/views/admin/announcement-view.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
