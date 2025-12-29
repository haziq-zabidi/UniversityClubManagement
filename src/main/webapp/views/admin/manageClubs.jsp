<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Manage Clubs</title>
</head>
<body>
<h1>Admin - Manage Clubs</h1>

<c:if test="${not empty errorMessage}">
    <p style="color:red">${errorMessage}</p>
</c:if>

<!-- Create / Edit Form -->
<h2><c:choose>
        <c:when test="${not empty editClub}">Edit Club</c:when>
        <c:otherwise>Create New Club</c:otherwise>
    </c:choose></h2>

<form action="<%= request.getContextPath() %>/admin/manage-clubs" method="post">
    <input type="hidden" name="action" value="<c:choose>
                                                <c:when test='${not empty editClub}'>update</c:when>
                                                <c:otherwise>create</c:otherwise>
                                              </c:choose>">
    <c:if test="${not empty editClub}">
        <input type="hidden" name="clubID" value="${editClub.clubID}">
    </c:if>

    <label>Name:</label><br>
    <input type="text" name="clubName" value="${editClub.clubName}" required><br><br>

    <label>Description:</label><br>
    <textarea name="clubDescription" rows="4" cols="50">${editClub.clubDescription}</textarea><br><br>

    <label>Category:</label><br>
    <input type="text" name="clubCategory" value="${editClub.clubCategory}" required><br><br>

    <label>Admin User ID:</label><br>
    <input type="number" name="adminUserID" value="${editClub.adminUserID}" required><br><br>

    <input type="submit" value="<c:choose>
                                    <c:when test='${not empty editClub}'>Update Club</c:when>
                                    <c:otherwise>Create Club</c:otherwise>
                                </c:choose>">
</form>

<hr>

<!-- List of clubs -->
<h2>All Clubs</h2>
<table border="1">
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Description</th>
        <th>Category</th>
        <th>Admin ID</th>
        <th>Actions</th>
    </tr>
    <c:forEach var="club" items="${clubs}">
        <tr>
            <td>${club.clubID}</td>
            <td>${club.clubName}</td>
            <td>${club.clubDescription}</td>
            <td>${club.clubCategory}</td>
            <td>${club.adminUserID}</td>
            <td>
                <a href="<%= request.getContextPath() %>/admin/manage-clubs?editID=${club.clubID}">Edit</a> |
                <form action="<%= request.getContextPath() %>/admin/manage-clubs" method="post" style="display:inline;">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="clubID" value="${club.clubID}">
                    <input type="submit" value="Delete" onclick="return confirm('Are you sure?')">
                </form>
            </td>
        </tr>
    </c:forEach>
</table>

<p><a href="<%= request.getContextPath() %>/admin/dashboard">Back to Dashboard</a></p>
</body>
</html>
