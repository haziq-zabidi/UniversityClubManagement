<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Manage Activities</title>
</head>
<body>
<h1>Manage Activities</h1>
<a href="${pageContext.request.contextPath}/committee/dashboard">Back to Dashboard</a>
<hr/>

<!-- Create Activity Form -->
<h3>Create New Activity</h3>
<form method="post" action="${pageContext.request.contextPath}/committee/manage-activities">
    <input type="hidden" name="action" value="create"/>
    <input type="hidden" name="clubID" value="${clubID}"/>
    Name: <input type="text" name="activityName" required/><br/>
    Description: <input type="text" name="activityDescription" required/><br/>
    Type: <input type="text" name="activityType" required/><br/>
    Location: <input type="text" name="activityLocation" required/><br/>
    Start Date: <input type="date" name="startDate" required/><br/>
    End Date: <input type="date" name="endDate" required/><br/>
    Max Participants: <input type="number" name="maxParticipants" required/><br/>
    <button type="submit">Create</button>
</form>
<hr/>

<!-- Existing Activities -->
<h3>Existing Activities</h3>
<c:if test="${not empty activitiesList}">
    <table border="1" cellpadding="5">
        <tr>
            <th>Name</th>
            <th>Description</th>
            <th>Type</th>
            <th>Location</th>
            <th>Start Date</th>
            <th>End Date</th>
            <th>Max</th>
            <th>Status</th>
            <th>Actions</th>
        </tr>
        <c:forEach var="act" items="${activitiesList}">
            <tr>
                <form method="post" action="${pageContext.request.contextPath}/committee/manage-activities">
                    <input type="hidden" name="action" value="edit"/>
                    <input type="hidden" name="activityID" value="${act.activityID}"/>
                    <input type="hidden" name="clubID" value="${act.clubID}"/>
                    <td><input type="text" name="activityName" value="${act.activityName}" required/></td>
                    <td><input type="text" name="activityDescription" value="${act.activityDescription}" required/></td>
                    <td><input type="text" name="activityType" value="${act.activityType}" required/></td>
                    <td><input type="text" name="activityLocation" value="${act.activityLocation}" required/></td>
                    <td><input type="date" name="startDate" value="${act.startDate}" required/></td>
                    <td><input type="date" name="endDate" value="${act.endDate}" required/></td>
                    <td><input type="number" name="maxParticipants" value="${act.maxParticipants}" required/></td>
                    <td>${act.activityStatus}</td>
                    <td>
                        <button type="submit">Update</button>
                </form>
                <form method="post" action="${pageContext.request.contextPath}/committee/manage-activities" style="display:inline;">
                    <input type="hidden" name="action" value="delete"/>
                    <input type="hidden" name="activityID" value="${act.activityID}"/>
                    <input type="hidden" name="clubID" value="${act.clubID}"/>
                    <button type="submit" onclick="return confirm('Delete this activity?')">Delete</button>
                </form>
                    </td>
            </tr>
        </c:forEach>
    </table>
</c:if>
</body>
</html>
