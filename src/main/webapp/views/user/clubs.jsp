<%-- 
    Document   : joinClubList
    Created on : 2 Jan 2026, 2:17:49 am
    Author     : TUF
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Join Club</title>
    </head>
    <body>
        <h1>Welcome, ${userName}!</h1>
        <a href="${pageContext.request.contextPath}/user/dashboard">← Back to Dashboard</a> | 
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
        <hr/>

        <!-- Success/Error Messages -->
        <c:if test="${not empty successMessage}">
            <div style="border: 1px solid green; padding: 10px; margin: 10px 0; background: #e6ffe6;">
                ${successMessage}
            </div>
        </c:if>

        <c:if test="${not empty errorMessage}">
            <div style="border: 1px solid red; padding: 10px; margin: 10px 0; background: #ffe6e6;">
                ${errorMessage}
            </div>
        </c:if>

        <h2>Browse All Clubs</h2>

        <p>
            <strong>Total Clubs:</strong> ${totalClubs} | 
            <strong>Active Memberships:</strong> ${activeCount} clubs | 
            <strong>Pending Requests:</strong> ${pendingCount} clubs | 
            <strong>Available to Join:</strong> ${availableCount} clubs
        </p>

        <!-- My Active Clubs Section -->
        <h3>My Active Clubs (${activeCount})</h3>
        <c:choose>
            <c:when test="${empty activeClubs}">
                <p>You don't have any active club memberships.</p>
            </c:when>
            <c:otherwise>
                <c:forEach var="club" items="${activeClubs}">
                    <div style="border: 1px solid #4CAF50; padding: 10px; margin: 10px 0; background: #f9f9f9;">
                        <h4>${club.clubName} <span style="color: #4CAF50;">(Active ✓)</span></h4>
                        <p><strong>Category:</strong> ${club.clubCategory}</p>
                        <p><strong>Description:</strong> ${club.clubDescription}</p>
                        <p><strong>Status:</strong> <span style="color: #4CAF50;">Active Member</span></p>
                        <p>
                            <a href="${pageContext.request.contextPath}/user/leave-club?clubID=${club.clubID}" 
                               onclick="return confirm('Request to leave ${club.clubName}? This requires committee approval.')"
                               style="color: red;">
                                Request to Leave Club
                            </a>
                        </p>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>

        <!-- My Pending Requests Section -->
        <c:if test="${not empty pendingClubs}">
            <h3>My Pending Requests (${pendingCount})</h3>
            <c:forEach var="club" items="${pendingClubs}">
                <div style="border: 1px solid #FF9800; padding: 10px; margin: 10px 0; background: #fff3e0;">
                    <h4>${club.clubName} <span style="color: #FF9800;">(Pending ⏳)</span></h4>
                    <p><strong>Category:</strong> ${club.clubCategory}</p>
                    <p><strong>Description:</strong> ${club.clubDescription}</p>
                    <p><strong>Status:</strong> <span style="color: #FF9800;">Pending Committee Approval</span></p>
                    <p>
                        <a href="${pageContext.request.contextPath}/user/cancel-request?clubID=${club.clubID}" 
                           onclick="return confirm('Cancel your request to join ${club.clubName}?')"
                           style="color: #FF5722;">
                            Cancel Request
                        </a>
                    </p>
                </div>
            </c:forEach>
        </c:if>

        <!-- Available Clubs Section -->
        <h3>Available Clubs to Join (${availableCount})</h3>
        <c:choose>
            <c:when test="${empty availableClubs}">
                <p>No clubs available to join. You've either joined or requested to join all clubs!</p>
            </c:when>
            <c:otherwise>
                <c:forEach var="club" items="${availableClubs}">
                    <div style="border: 1px solid #ccc; padding: 10px; margin: 10px 0;">
                        <h4>${club.clubName}</h4>
                        <p><strong>Category:</strong> ${club.clubCategory}</p>
                        <p><strong>Description:</strong> ${club.clubDescription}</p>
                        <p>
                            <a href="${pageContext.request.contextPath}/user/join-club?clubID=${club.clubID}" 
                               onclick="return confirm('Request to join ${club.clubName}? This requires committee approval.')"
                               style="color: #4CAF50; font-weight: bold;">
                                Request to Join Club
                            </a>
                        </p>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>

        <hr/>
        <a href="${pageContext.request.contextPath}/user/dashboard">← Dashboard</a>
        <a href="${pageContext.request.contextPath}/user/announcements">← Announcement</a>
        <a href="${pageContext.request.contextPath}/user/profile">← Profile</a>
        <a href="${pageContext.request.contextPath}/user/clubs">← Clubs</a>

        <script>
            // Auto-hide messages after 5 seconds
            setTimeout(function() {
                var messages = document.querySelectorAll('[style*="border: 1px solid green"], [style*="border: 1px solid red"]');
                messages.forEach(function(message) {
                    message.style.display = 'none';
                });
            }, 5000);
        </script>
    </body>
</html>
