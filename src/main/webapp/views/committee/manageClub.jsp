<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Committee Manage Club</title>
</head>
<body>
<h1>Manage Club</h1>
<a href="${pageContext.request.contextPath}/committee/dashboard">Back to Dashboard</a>
<hr/>

<c:if test="${not empty errorMessage}">
    <p style="color:red">${errorMessage}</p>
</c:if>

<c:if test="${not empty club}">
    <h2>Edit Club Info</h2>
    <form method="post" action="${pageContext.request.contextPath}/committee/manage-club">
        <input type="hidden" name="action" value="updateClub"/>
        Name: <input type="text" name="clubName" value="${club.clubName}" required/><br/>
        Description: <input type="text" name="clubDescription" value="${club.clubDescription}" required/><br/>
        Category: <input type="text" name="clubCategory" value="${club.clubCategory}" required/><br/>
        <button type="submit">Update Club</button>
    </form>

    <hr/>
    <h2>Pending Membership Requests</h2>
    <c:forEach var="m" items="${pendingRequests}">
        <p>User ID: ${m.userID} 
            <form method="post" style="display:inline">
                <input type="hidden" name="action" value="approveMember"/>
                <input type="hidden" name="membershipID" value="${m.membershipID}"/>
                <button type="submit">Approve</button>
            </form>
            <form method="post" style="display:inline">
                <input type="hidden" name="action" value="deleteMember"/>
                <input type="hidden" name="userID" value="${m.userID}"/>
                <button type="submit">Reject</button>
            </form>
        </p>
    </c:forEach>

    <hr/>
    <h2>Announcements</h2>
    <h3>Create New Announcement</h3>
    <form method="post" action="${pageContext.request.contextPath}/committee/manage-club">
        <input type="hidden" name="action" value="addAnnouncement"/>
        Title: <input type="text" name="title" required/><br/>
        Message: <textarea name="message" required></textarea><br/>
        <button type="submit">Create</button>
    </form>

    <h3>Existing Announcements</h3>
    <c:forEach var="a" items="${announcements}">
        <form method="post" action="${pageContext.request.contextPath}/committee/manage-club">
            <input type="hidden" name="action" value="updateAnnouncement"/>
            <input type="hidden" name="announcementID" value="${a.announcementID}"/>
            Title: <input type="text" name="title" value="${a.announcementTitle}" required/><br/>
            Message: <textarea name="message" required>${a.announcementMessage}</textarea><br/>
            <button type="submit">Update</button>
        </form>
        <form method="post" action="${pageContext.request.contextPath}/committee/manage-club">
            <input type="hidden" name="action" value="deleteAnnouncement"/>
            <input type="hidden" name="announcementID" value="${a.announcementID}"/>
            <button type="submit" onclick="return confirm('Delete this announcement?');">Delete</button>
        </form>
        <hr/>
    </c:forEach>
</c:if>
</body>
</html>
