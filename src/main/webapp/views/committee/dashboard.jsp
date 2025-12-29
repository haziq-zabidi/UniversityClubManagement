<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Committee Dashboard</title>
</head>
<body>

<h1>Committee Dashboard</h1>

<a href="${pageContext.request.contextPath}/logout">Logout</a>
<hr/>

<h2>Your Clubs</h2>

<c:choose>
    <c:when test="${empty clubsList}">
        <p>You are not a member of any club as a committee member.</p>
    </c:when>
    <c:otherwise>
        <table border="1" cellpadding="8">
            <tr>
                <th>Club ID</th>
                <th>Club Name</th>
                <th>Category</th>
                <th>Description</th>
                <th>Actions</th>
            </tr>

            <c:forEach var="club" items="${clubsList}">
                <tr>
                    <td>${club.clubID}</td>
                    <td>${club.clubName}</td>
                    <td>${club.clubCategory}</td>
                    <td>${club.clubDescription}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/committee/manage-announcements?clubID=${club.clubID}">Manage Announcements</a> |
                        <a href="${pageContext.request.contextPath}/committee/manage-activities?clubID=${club.clubID}">Manage Activities</a> |
                        <a href="${pageContext.request.contextPath}/committee/manage-members?clubID=${club.clubID}">View Members</a>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </c:otherwise>
</c:choose>

</body>
</html>
