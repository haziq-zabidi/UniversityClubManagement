<%-- 
    Document   : announcement
    Created on : 30 Dec 2025, 1:18:16 pm
    Author     : TUF
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Announcements & Activities</title>
    </head>
    <body>
        <h1>Welcome, ${userName}!</h1>
        <a href="${pageContext.request.contextPath}/user/dashboard">← Back to Dashboard</a> | 
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
        <hr/>

        <h2>All Announcements & Activities from Your Clubs</h2>

        <p>Showing all updates from your joined clubs (${totalCount} items):</p>
        
        <c:choose>
            <c:when test="${empty combinedFeed}">
                <p>No announcements or activities from your clubs yet.</p>
                <p>Join clubs to see updates!</p>
            </c:when>
            <c:otherwise>
                <!-- Filter Options (Optional) -->
                <p>
                    <strong>Filter by:</strong>
                    <a href="${pageContext.request.contextPath}/user/announcements?filter=all">All</a> |
                    <a href="${pageContext.request.contextPath}/user/announcements?filter=announcements">Announcements Only</a> |
                    <a href="${pageContext.request.contextPath}/user/announcements?filter=activities">Activities Only</a>
                </p>

                <!-- Display all items -->
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
                            <p><strong>Max Participants:</strong> ${item.maxParticipants > 0 ? item.maxParticipants : 'Unlimited'}</p>

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

                <!-- Summary -->
                <p><em>End of list. Total items: ${totalCount}</em></p>
            </c:otherwise>
        </c:choose>

        <hr/>
        <a href="${pageContext.request.contextPath}/user/dashboard">← Dashboard</a>
        <a href="${pageContext.request.contextPath}/user/announcements">← Announcement</a>
        <a href="${pageContext.request.contextPath}/user/profile">← Profile</a>
        <a href="${pageContext.request.contextPath}/user/clubs">← Clubs</a>
    </body>
</html>
