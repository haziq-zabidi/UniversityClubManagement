<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Manage Announcements</title>
</head>
<body>

<h1>Club Announcements</h1>
<a href="${pageContext.request.contextPath}/committee/dashboard">Back to Dashboard</a>
<hr/>

<h2>Create Announcement</h2>
<form action="${pageContext.request.contextPath}/committee/manage-announcements" method="post">
    <input type="hidden" name="action" value="create"/>
    <input type="hidden" name="clubID" value="${clubID}"/>
    Title: <input type="text" name="title" required><br>
    Message: <textarea name="message" required></textarea><br>
    <button type="submit">Create Announcement</button>
</form>

<hr/>

<h2>All Announcements</h2>
<c:forEach var="a" items="${announcementsList}">
    <div style="border:1px solid #000; padding:10px; margin-bottom:10px;">
        <h3>${a.announcementTitle}</h3>
        <p>${a.announcementMessage}</p>
        <p><i>Published on: ${a.publishDate}</i></p>

        <!-- Edit Form -->
        <form action="${pageContext.request.contextPath}/committee/manage-announcements" method="post" style="margin-top:5px;">
            <input type="hidden" name="action" value="edit"/>
            <input type="hidden" name="clubID" value="${clubID}"/>
            <input type="hidden" name="announcementID" value="${a.announcementID}"/>
            Title: <input type="text" name="title" value="${a.announcementTitle}" required><br>
            Message: <textarea name="message" required>${a.announcementMessage}</textarea><br>
            <button type="submit">Save</button>
        </form>

        <!-- Delete Form -->
        <form action="${pageContext.request.contextPath}/committee/manage-announcements" method="post" style="margin-top:5px;">
            <input type="hidden" name="action" value="delete"/>
            <input type="hidden" name="clubID" value="${clubID}"/>
            <input type="hidden" name="announcementID" value="${a.announcementID}"/>
            <button type="submit" onclick="return confirm('Are you sure you want to delete this announcement?')">Delete</button>
        </form>
    </div>
</c:forEach>

</body>
</html>
