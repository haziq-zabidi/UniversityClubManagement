<%@ page contentType="text/html;charset=UTF-8" %>
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

<!-- ================= CREATE / EDIT FORM ================= -->

<c:choose>
    <c:when test="${not empty editClub}">
        <h2>Edit Club</h2>

        <form action="${pageContext.request.contextPath}/admin/manage-clubs"
              method="post">

            <input type="hidden" name="action" value="update">
            <input type="hidden" name="clubID"
                   value="${editClub.clubID}">

            <label>Name:</label><br>
            <input type="text" name="clubName"
                   value="${editClub.clubName}" required><br><br>

            <label>Description:</label><br>
            <textarea name="clubDescription" rows="4" cols="50">
${editClub.clubDescription}</textarea><br><br>

            <label>Category:</label><br>
            <input type="text" name="clubCategory"
                   value="${editClub.clubCategory}" required><br><br>

            <input type="submit" value="Update Club">
            <a href="${pageContext.request.contextPath}/admin/manage-clubs">
                Cancel
            </a>
        </form>
    </c:when>

    <c:otherwise>
        <h2>Create New Club</h2>

        <form action="${pageContext.request.contextPath}/admin/manage-clubs"
              method="post">

            <input type="hidden" name="action" value="create">

            <label>Name:</label><br>
            <input type="text" name="clubName" required><br><br>

            <label>Description:</label><br>
            <textarea name="clubDescription" rows="4" cols="50"></textarea><br><br>

            <label>Category:</label><br>
            <input type="text" name="clubCategory" required><br><br>

            <input type="submit" value="Create Club">
        </form>
    </c:otherwise>
</c:choose>

<hr>

<!-- ================= CLUB LIST ================= -->

<h2>All Clubs</h2>

<table border="1" cellpadding="8">
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Description</th>
        <th>Category</th>
        <th>Actions</th>
    </tr>

    <c:forEach var="club" items="${clubs}">
        <tr>
            <td>${club.clubID}</td>
            <td>${club.clubName}</td>
            <td>${club.clubDescription}</td>
            <td>${club.clubCategory}</td>
            <td>
                <a href="${pageContext.request.contextPath}/admin/manage-clubs?editID=${club.clubID}">
                    Edit
                </a>
                |
                <form action="${pageContext.request.contextPath}/admin/manage-clubs"
                      method="post" style="display:inline">

                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="clubID"
                           value="${club.clubID}">

                    <button type="submit"
                            onclick="return confirm('Delete this club?')">
                        Delete
                    </button>
                </form>
            </td>
        </tr>
    </c:forEach>
</table>

<p>
    <a href="${pageContext.request.contextPath}/admin/dashboard">
        Back to Dashboard
    </a>
</p>

</body>
</html>
