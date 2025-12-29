<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Committee Dashboard</title>
</head>
<body>

<h1>Welcome, Committee Member!</h1>

<p>Use the menu below to manage your club, members, and announcements.</p>

<ul>
    <li><a href="${pageContext.request.contextPath}/committee/manage-club">Manage Club</a></li>
    <li><a href="${pageContext.request.contextPath}/committee/manage-members">Manage Members</a></li>
    <li><a href="${pageContext.request.contextPath}/committee/manage-announcements">Manage Announcements</a></li>
</ul>

<a href="${pageContext.request.contextPath}/logout">Logout</a>

</body>
</html>
