/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author TUF
 */
@WebServlet("/login")
public class LoginController extends HttpServlet{
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/login.jsp"); 
        dispatcher.forward(request, response);
    }
    
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String url = "jdbc:mariadb://localhost:3307/club_management_db";
            String username = "root";
            String password = "";
            
            Class.forName("org.mariadb.jdbc.Driver");
            
            java.sql.Connection conn = DriverManager.getConnection(url, username, password);
            
            Statement stmt = conn.createStatement();
            
            ResultSet rs = stmt.executeQuery("select * from users");
            
            /**
            while(rs.next()){
                response.getWriter().println("nama: " + rs.getString("name"));
            }
            
            stmt.executeUpdate("INSERT INTO `users` (`id`, `name`, `email`, `password`) VALUES (NULL, 'Amadi', 'ahmad@gmail.com', SHA1('test456'))");
            **/
            stmt.close();
            conn.close();
            
        } catch (ClassNotFoundException ex) {
            System.getLogger(LoginController.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
        } catch (SQLException ex) {
            System.getLogger(LoginController.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
        }
        
    }
    
}
