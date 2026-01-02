<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Admin - Manage Activities</title>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
</head>
<body class="container mt-4">

<h2>Manage Activities</h2>

<a href="${pageContext.request.contextPath}/admin/dashboard"
   class="btn btn-secondary mb-3">Back to Dashboard</a>

<table class="table table-bordered table-striped">
    <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Status</th>
            <th>Club ID</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach items="${activities}" var="a">
            <tr>
                <td>${a.activityID}</td>
                <td>${a.activityName}</td>
                <td>${a.activityStatus}</td>
                <td>${a.clubID}</td>
                <td class="d-flex gap-2">

                    <!-- Update Status -->
                    <form method="post" action="${pageContext.request.contextPath}/admin/activities">
                        <input type="hidden" name="action" value="status">
                        <input type="hidden" name="activityID" value="${a.activityID}">
                        <select name="activityStatus" class="form-select form-select-sm">
                            <option ${a.activityStatus=='Open'?'selected':''}>Open</option>
                            <option ${a.activityStatus=='Closed'?'selected':''}>Closed</option>
                            <option ${a.activityStatus=='Cancelled'?'selected':''}>Cancelled</option>
                        </select>
                        <button class="btn btn-sm btn-primary mt-1">Update</button>
                    </form>

                   <a class="btn btn-sm btn-info"
   href="${pageContext.request.contextPath}/admin/activity/view?id=${a.activityID}">
   View
</a>


                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

</body>
</html>
