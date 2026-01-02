/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.controller;

import com.mycompany.dao.ActivityDAO;
import com.mycompany.dao.AttendanceDAO;
import com.mycompany.model.Activity;
import com.mycompany.model.Attendance;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;

/**
 *
 * @author TUF
 */
@WebServlet("/user/record-attendance")
public class RecordAttendanceController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userID") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        int userID = (Integer) session.getAttribute("userID");
        String activityIDParam = request.getParameter("activityID");
        String action = request.getParameter("action"); // "record" or "remove"
        
        if (activityIDParam != null) {
            try {
                int activityID = Integer.parseInt(activityIDParam);
                AttendanceDAO attendanceDAO = new AttendanceDAO();
                ActivityDAO activityDAO = new ActivityDAO();
                
                // Get activity to check if it exists and status
                Activity activity = activityDAO.getActivityByID(activityID);
                if (activity == null) {
                    response.sendRedirect(request.getContextPath() + "/user/dashboard?error=activity_not_found");
                    return;
                }
                
                // Check if activity is completed or cancelled
                if ("Completed".equals(activity.getActivityStatus()) || "Cancelled".equals(activity.getActivityStatus())) {
                    response.sendRedirect(request.getContextPath() + "/user/dashboard?error=activity_closed");
                    return;
                }
                
                if ("remove".equals(action)) {
                    // Remove attendance
                    boolean success = attendanceDAO.removeAttendance(userID, activityID);
                    
                    if (success) {
                        response.sendRedirect(request.getContextPath() + "/user/dashboard?success=attendance_removed");
                    } else {
                        response.sendRedirect(request.getContextPath() + "/user/dashboard?error=remove_failed");
                    }
                } else {
                    // Record attendance - check if already attended
                    if (attendanceDAO.hasUserAttendanceForActivity(userID, activityID)) {
                        response.sendRedirect(request.getContextPath() + "/user/dashboard?error=already_attended");
                        return;
                    }
                    
                    Attendance attendance = new Attendance();
                    attendance.setUserID(userID);
                    attendance.setActivityID(activityID);
                    attendance.setAttendanceDate(LocalDate.now());
                    attendance.setAttendanceStatus("Present");
                    
                    boolean success = attendanceDAO.addAttendance(attendance);
                    
                    if (success) {
                        response.sendRedirect(request.getContextPath() + "/user/dashboard?success=attendance_recorded");
                    } else {
                        response.sendRedirect(request.getContextPath() + "/user/dashboard?error=attendance_failed");
                    }
                }
                
            } catch (NumberFormatException | SQLException | ClassNotFoundException e) {
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/user/dashboard?error=system_error");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/user/dashboard");
        }
    }
}
