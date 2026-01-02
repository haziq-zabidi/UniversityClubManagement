<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>Activity Participants</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
</head>
<body>
<div class="container mt-5">
    <h2>Activity Participants</h2>
    
    <!-- Activity Details -->
    <div class="card mb-4">
        <div class="card-header bg-primary text-white">
            <h4 class="mb-0">${activity.activityName}</h4>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-6">
                    <p><strong>Type:</strong> ${activity.activityType}</p>
                    <p><strong>Location:</strong> ${activity.activityLocation}</p>
                    <p><strong>Description:</strong> ${activity.activityDescription}</p>
                </div>
                <div class="col-md-6">
                    <p><strong>Start Date:</strong> ${activity.startDate}</p>
                    <p><strong>End Date:</strong> ${activity.endDate}</p>
                    <p><strong>Status:</strong> 
                        <c:choose>
                            <c:when test="${activity.activityStatus == 'Open'}">
                                <span class="badge bg-success">Open</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-secondary">Closed</span>
                            </c:otherwise>
                        </c:choose>
                    </p>
                    <p><strong>Capacity:</strong> ${fn:length(participants)} / ${activity.maxParticipants} participants</p>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Participants List -->
    <div class="card">
        <div class="card-header bg-success text-white">
            <h5 class="mb-0">
                <i class="bi bi-people-fill"></i> 
                Registered Participants (${fn:length(participants)})
            </h5>
        </div>
        <div class="card-body">
            <c:if test="${not empty participants}">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Matric No</th>
                                <th>Faculty</th>
                                <th>Programme</th>
                                <th>Registration Date</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${participants}" var="attendance" varStatus="status">
                                <tr>
                                    <td>${status.index + 1}</td>
                                    <td><strong>${attendance.user.userName}</strong></td>
                                    <td>${attendance.user.userEmail}</td>
                                    <td>${attendance.user.matricNo}</td>
                                    <td>${attendance.user.faculty}</td>
                                    <td>${attendance.user.programme}</td>
                                    <td>${attendance.attendanceDate}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${attendance.attendanceStatus == 'Present'}">
                                                <span class="badge bg-success">
                                                    <i class="bi bi-check-circle"></i> Registered
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-warning">
                                                    <i class="bi bi-clock"></i> ${attendance.attendanceStatus}
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                
                <!-- Export Options -->
                <div class="mt-3">
                    <button class="btn btn-outline-success" onclick="exportToCSV()">
                        <i class="bi bi-file-earmark-spreadsheet"></i> Export to CSV
                    </button>
                    <button class="btn btn-outline-primary" onclick="window.print()">
                        <i class="bi bi-printer"></i> Print List
                    </button>
                </div>
            </c:if>
            
            <c:if test="${empty participants}">
                <div class="alert alert-info">
                    <i class="bi bi-info-circle"></i> 
                    No participants have registered for this activity yet.
                </div>
            </c:if>
        </div>
    </div>
    
    <!-- Statistics Card -->
    <c:if test="${not empty participants}">
        <div class="row mt-4">
            <div class="col-md-4">
                <div class="card text-center">
                    <div class="card-body">
                        <h5 class="card-title">Total Registered</h5>
                        <h2 class="text-primary">${fn:length(participants)}</h2>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card text-center">
                    <div class="card-body">
                        <h5 class="card-title">Capacity</h5>
                        <h2 class="text-info">${activity.maxParticipants}</h2>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card text-center">
                    <div class="card-body">
                        <h5 class="card-title">Slots Remaining</h5>
                        <h2 class="text-success">${activity.maxParticipants - fn:length(participants)}</h2>
                    </div>
                </div>
            </div>
        </div>
    </c:if>
    
    <div class="mt-4">
        <a href="${pageContext.request.contextPath}/committee/manage-activities?clubID=${clubID}" 
           class="btn btn-secondary">
            <i class="bi bi-arrow-left"></i> Back to Activities
        </a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
function exportToCSV() {
    var csv = 'Name,Email,Matric No,Faculty,Programme,Registration Date,Status\n';
    
    <c:forEach items="${participants}" var="attendance">
        csv += '"${attendance.user.userName}",';
        csv += '"${attendance.user.userEmail}",';
        csv += '"${attendance.user.matricNo}",';
        csv += '"${attendance.user.faculty}",';
        csv += '"${attendance.user.programme}",';
        csv += '"${attendance.attendanceDate}",';
        csv += '"${attendance.attendanceStatus}"\n';
    </c:forEach>
    
    var blob = new Blob([csv], { type: 'text/csv' });
    var url = window.URL.createObjectURL(blob);
    var a = document.createElement('a');
    a.href = url;
    a.download = '${activity.activityName}_participants.csv';
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
}
</script>

<style>
@media print {
    .btn, .card-header { display: none !important; }
}
</style>
</body>
</html>