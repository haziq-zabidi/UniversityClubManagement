package com.mycompany.controller;

import com.mycompany.dao.UsersDAO;
import com.mycompany.model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/admin/manage-users")
public class ManageUsersController extends HttpServlet {

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
            UsersDAO dao = new UsersDAO();
            List<User> users = dao.getAllUsers();
            request.setAttribute("usersList", users);
            RequestDispatcher rd = request.getRequestDispatcher("/views/admin/manageUsers.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        UsersDAO dao = new UsersDAO();

        try {
            if ("create".equals(action)) {

                User u = new User();
                u.setUserName(request.getParameter("name"));
                u.setUserEmail(request.getParameter("email"));
                u.setUserPassword(request.getParameter("password"));
                u.setMatricNo(request.getParameter("matric"));
                u.setFaculty(request.getParameter("faculty"));
                u.setProgramme(request.getParameter("programme"));
                u.setRoleID(Integer.parseInt(request.getParameter("role")));

                dao.addUser(u);
            }

            else if ("update".equals(action)) {

                User u = new User();
                u.setUserName(request.getParameter("name"));
                u.setUserEmail(request.getParameter("email"));
                u.setUserPassword(request.getParameter("password"));
                u.setFaculty(request.getParameter("faculty"));
                u.setProgramme(request.getParameter("programme"));
                u.setRoleID(Integer.parseInt(request.getParameter("role")));

                dao.updateUser(u);
            }

            else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("userID"));
                dao.deleteUser(id);
            }

            response.sendRedirect(request.getContextPath() + "/admin/manage-users");

        } catch (SQLException | ClassNotFoundException e) {
            throw new ServletException(e);
        }
    }
}
