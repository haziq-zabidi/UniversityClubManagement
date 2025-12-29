<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Manage Users</title>
</head>

<body>

<h1>Admin - Manage Users</h1>

<a href="${pageContext.request.contextPath}/admin/dashboard">Back to Dashboard</a>
<hr/>

<!-- ================= CREATE USER FORM ================= -->
<h2>Create New User</h2>
<form action="${pageContext.request.contextPath}/admin/manage-users" method="post">
    <input type="hidden" name="action" value="create"/>

    Name: <input type="text" name="name" required><br>
    Email: <input type="email" name="email" required><br>
    Password: <input type="text" name="password" required><br>
    Matric No: <input type="text" name="matric"><br>
    Faculty: <input type="text" name="faculty"><br>
    Programme: <input type="text" name="programme"><br>

    Role:
    <select name="role">
        <option value="1">Admin</option>
        <option value="2">Student</option>
    </select>

    <br><br>
    <button type="submit">Create User</button>
</form>

<hr/>

<!-- ================= USERS TABLE ================= -->
<h2>All Users</h2>

<table border="1" cellpadding="8">
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Email</th>
        <th>Matric</th>
        <th>Faculty</th>
        <th>Programme</th>
        <th>Role</th>
        <th>Actions</th>
    </tr>

    <c:forEach var="u" items="${usersList}">
        <tr>
            <td>${u.userID}</td>
            <td>${u.userName}</td>
            <td>${u.userEmail}</td>
            <td>${u.matricNo}</td>
            <td>${u.faculty}</td>
            <td>${u.programme}</td>

            <td>
                <c:choose>
                    <c:when test="${u.roleID == 1}">Admin</c:when>
                    <c:otherwise>Student</c:otherwise>
                </c:choose>
            </td>

            <td>

                <!-- ================= EDIT FORM ================= -->
                <form action="${pageContext.request.contextPath}/admin/manage-users" 
                      method="post" style="display:inline;">
                    <input type="hidden" name="action" value="update"/>

                    <input type="hidden" name="email" value="${u.userEmail}"/>

                    Name: <input type="text" name="name" value="${u.userName}" required>
                    Password: <input type="text" name="password" value="${u.userPassword}" required>
                    Faculty: <input type="text" name="faculty" value="${u.faculty}">
                    Programme: <input type="text" name="programme" value="${u.programme}">
                    Role:
                    <select name="role">
                        <option value="1" ${u.roleID == 1 ? "selected" : ""}>Admin</option>
                        <option value="2" ${u.roleID == 2 ? "selected" : ""}>Student</option>
                    </select>

                    <button type="submit">Update</button>
                </form>

                <!-- ================= DELETE FORM ================= -->
                <form action="${pageContext.request.contextPath}/admin/manage-users" 
                      method="post" style="display:inline;">
                    <input type="hidden" name="action" value="delete"/>
                    <input type="hidden" name="userID" value="${u.userID}"/>

                    <button type="submit" onclick="return confirm('Delete this user?');">
                        Delete
                    </button>
                </form>

            </td>
        </tr>
    </c:forEach>

</table>

</body>
</html>
