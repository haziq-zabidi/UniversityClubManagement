<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Activity Details</title>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
</head>
<body class="container mt-4">

<h2>Activity Details</h2>

<table class="table table-bordered">
    <tr><th>ID</th><td>${activity.activityID}</td></tr>
    <tr><th>Name</th><td>${activity.activityName}</td></tr>
    <tr><th>Description</th><td>${activity.activityDescription}</td></tr>
    <tr><th>Start Date</th><td>${activity.startDate}</td></tr>
    <tr><th>End Date</th><td>${activity.endDate}</td></tr>
    <tr><th>Location</th><td>${activity.activityLocation}</td></tr>
    <tr><th>Type</th><td>${activity.activityType}</td></tr>
    <tr><th>Status</th><td>${activity.activityStatus}</td></tr>
    <tr><th>Max Participants</th><td>${activity.maxParticipants}</td></tr>
    <tr><th>Club ID</th><td>${activity.clubID}</td></tr>
</table>

<a href="${pageContext.request.contextPath}/admin/activities"
   class="btn btn-secondary">Back</a>

</body>
</html>
