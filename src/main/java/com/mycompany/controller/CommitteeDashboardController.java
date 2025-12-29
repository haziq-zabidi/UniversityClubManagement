package com.mycompany.controller;

import com.mycompany.dao.ClubDAO;
import com.mycompany.model.Club;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/committee/dashboard")
public class CommitteeDashboardController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userID") == null ||
            session.getAttribute("roleID") == null ||
            (Integer) session.getAttribute("roleID") != 3) { // 3 = Committee
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int userID = (Integer) session.getAttribute("userID");

        try {
            ClubDAO clubDAO = new ClubDAO();
            // Only get clubs where user is committee member
            List<Club> clubs = clubDAO.getClubsByCommittee(userID);

            request.setAttribute("clubsList", clubs);
            RequestDispatcher rd = request.getRequestDispatcher("/views/committee/dashboard.jsp");
            rd.forward(request, response);

        } catch (SQLException | ClassNotFoundException e) {
            throw new ServletException(e);
        }
    }
}
