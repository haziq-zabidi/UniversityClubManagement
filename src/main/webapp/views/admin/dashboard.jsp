<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
</head>
<body>
    <h1>Welcome, Admin!</h1>
    <p>Use the menu to manage clubs and users:</p>

    <ul>
        <li><a href="${pageContext.request.contextPath}/admin/manage-clubs">Manage Clubs</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/manage-users">Manage Users</a></li>
    </ul>

    <p><a href="${pageContext.request.contextPath}/logout">Logout</a></p>
</body>
</html>
