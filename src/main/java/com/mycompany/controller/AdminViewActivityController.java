package com.mycompany.controller;

import com.mycompany.dao.ActivityDAO;
import com.mycompany.model.Activity;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/admin/activity/view")
public class AdminViewActivityController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("roleID") == null ||
                (Integer) session.getAttribute("roleID") != 1) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int activityID = Integer.parseInt(request.getParameter("id"));

        try {
            ActivityDAO dao = new ActivityDAO();
            Activity activity = dao.getActivityByID(activityID);

            request.setAttribute("activity", activity);

            RequestDispatcher rd =
                    request.getRequestDispatcher("/views/admin/activity-view.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
