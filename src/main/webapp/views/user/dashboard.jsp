<%-- 
    Document   : dashboard
    Created on : 30 Dec 2025, 1:09:17 pm
    Author     : TUF
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Dashboard</title>
    </head>
    <body>
        <h1>Welcome, ${userName}!</h1>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
        <hr/>

        <h2>Latest Updates from Your Clubs (${feedCount} items)</h2>

        <c:choose>
            <c:when test="${empty combinedFeed}">
                <p>No updates from your clubs yet.</p>
            </c:when>
            <c:otherwise>
                <c:forEach var="item" items="${combinedFeed}">
                    <c:if test="${item.type == 'announcement'}">
                        <div style="border: 1px solid #ccc; padding: 10px; margin: 10px 0;">
                            <h3>📢 ${item.title}</h3>
                            <p><strong>Club:</strong> ${item.clubName}</p>
                            <p>${item.message}</p>
                            <p><em>Published: ${item.date}</em></p>
                        </div>
                    </c:if>

                    <c:if test="${item.type == 'activity'}">
                        <div style="border: 1px solid #ccc; padding: 10px; margin: 10px 0;">
                            <h3>📅 ${item.title}</h3>
                            <p><strong>Club:</strong> ${item.clubName}</p>
                            <p>${item.description}</p>
                            <p><strong>Date:</strong> ${item.date} 
                                <c:if test="${item.endDate != null}">to ${item.endDate}</c:if>
                            </p>
                            <p><strong>Location:</strong> ${item.location}</p>
                            <p><strong>Status:</strong> ${item.status}</p>

                            <c:choose>
                                <c:when test="${item.status == 'Completed' or item.status == 'Cancelled'}">
                                    <p><em>Activity ${item.status}</em></p>
                                </c:when>
                                <c:when test="${item.userAttended}">
                                    <p><strong>✓ You have marked attendance</strong></p>
                                    <a href="${pageContext.request.contextPath}/user/record-attendance?activityID=${item.id}&action=remove" 
                                       onclick="return confirm('Remove attendance?')">
                                        Remove Attendance
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/user/record-attendance?activityID=${item.id}" 
                                       onclick="return confirm('Mark attendance?')">
                                        Mark Attendance
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:if>
                </c:forEach>
            </c:otherwise>
        </c:choose>
        <a href="${pageContext.request.contextPath}/user/announcements">← Announcement</a>
    </body>
</html>
