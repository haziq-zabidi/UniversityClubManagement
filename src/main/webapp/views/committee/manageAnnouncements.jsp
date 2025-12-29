<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Manage Announcements & Activities</title>
</head>
<body>

<h1>Club Announcements & Activities</h1>
<a href="${pageContext.request.contextPath}/committee/dashboard">Back to Dashboard</a>
<hr/>

<h2>Create Announcement</h2>
<form action="${pageContext.request.contextPath}/committee/manage-announcements" method="post">
    <input type="hidden" name="action" value="createAnnouncement"/>
    <input type="hidden" name="clubID" value="${clubID}"/>

    Title: <input type="text" name="title" required><br>
    Message: <textarea name="message" required></textarea><br>
    <button type="submit">Create Announcement</button>
</form>

<hr/>

<h2>Create Activity</h2>
<form action="${pageContext.request.contextPath}/committee/manage-announcements" method="post">
    <input type="hidden" name="action" value="createActivity"/>
    <input type="hidden" name="clubID" value="${clubID}"/>

    Name: <input type="text" name="activityName" required><br>
    Description: <textarea name="activityDescription"></textarea><br>
    Type: <input type="text" name="activityType"><br>
    Location: <input type="text" name="activityLocation"><br>
    Start Date: <input type="date" name="startDate" required><br>
    End Date: <input type="date" name="endDate" required><br>
    Max Participants: <input type="number" name="maxParticipants" required><br>
    <button type="submit">Create Activity</button>
</form>

<hr/>

<h2>All Announcements</h2>
<c:forEach var="a" items="${announcementsList}">
    <div style="border:1px solid #000; padding:10px; margin-bottom:10px;">
        <h3>${a.announcementTitle}</h3>
        <p>${a.announcementMessage}</p>
        <p><i>Published on: ${a.publishDate}</i></p>
    </div>
</c:forEach>

</body>
</html>
