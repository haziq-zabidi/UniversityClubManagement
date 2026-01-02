<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Activities</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
</head>
<body>
<div class="container mt-5">
    <h2>Manage Club Activities</h2>
    
    <!-- Success/Error Messages -->
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success alert-dismissible fade show">
            ${successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <% session.removeAttribute("successMessage"); %>
    </c:if>
    
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show">
            ${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <% session.removeAttribute("errorMessage"); %>
    </c:if>
    
    <!-- If viewing specific club activities -->
    <c:if test="${not empty club}">
        <h3 class="mb-4">${club.clubName} - Activities</h3>
        
        <!-- Create New Activity Button -->
        <button type="button" class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#createActivityModal">
            <i class="bi bi-plus-circle"></i> Create New Activity
        </button>
        
        <!-- Activities List -->
        <div class="card">
            <div class="card-header bg-primary text-white">
                <h5 class="mb-0">Activities (${fn:length(activitiesList)})</h5>
            </div>
            <div class="card-body">
                <c:if test="${not empty activitiesList}">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>Activity Name</th>
                                    <th>Type</th>
                                    <th>Location</th>
                                    <th>Start Date</th>
                                    <th>End Date</th>
                                    <th>Status</th>
                                    <th>Participants</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${activitiesList}" var="activity">
                                    <tr>
                                        <td><strong>${activity.activityName}</strong></td>
                                        <td>${activity.activityType}</td>
                                        <td>${activity.activityLocation}</td>
                                        <td>${activity.startDate}</td>
                                        <td>${activity.endDate}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${activity.activityStatus == 'Open'}">
                                                    <span class="badge bg-success">Open</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary">Closed</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/committee/manage-activities?action=viewParticipants&activityID=${activity.activityID}" 
                                               class="btn btn-info btn-sm">
                                                <i class="bi bi-people-fill"></i> 
                                                ${activity.currentParticipants}/${activity.maxParticipants}
                                            </a>
                                        </td>
                                        <td>
                                            <button type="button" class="btn btn-warning btn-sm" 
                                                    onclick="editActivity(${activity.activityID}, '${activity.activityName}', '${activity.activityDescription}', '${activity.activityType}', '${activity.activityLocation}', '${activity.startDate}', '${activity.endDate}', ${activity.maxParticipants})">
                                                <i class="bi bi-pencil"></i> Edit
                                            </button>
                                            <form action="${pageContext.request.contextPath}/committee/manage-activities" method="post" style="display:inline;" 
                                                  onsubmit="return confirm('Delete this activity? All attendance records will be lost.');">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="activityID" value="${activity.activityID}">
                                                <input type="hidden" name="clubID" value="${clubID}">
                                                <button type="submit" class="btn btn-danger btn-sm">
                                                    <i class="bi bi-trash"></i> Delete
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:if>
                <c:if test="${empty activitiesList}">
                    <p class="text-muted">No activities created yet. Click "Create New Activity" to get started.</p>
                </c:if>
            </div>
        </div>
        
        <a href="${pageContext.request.contextPath}/committee/dashboard" class="btn btn-secondary mt-3">
            ← Back to Dashboard
        </a>
    </c:if>
    
    <!-- If listing clubs -->
    <c:if test="${empty club}">
        <h3>Select a Club to Manage Activities</h3>
        <c:if test="${not empty clubs}">
            <div class="list-group">
                <c:forEach items="${clubs}" var="club">
                    <a href="${pageContext.request.contextPath}/committee/manage-activities?clubID=${club.clubID}" 
                       class="list-group-item list-group-item-action">
                        <h5>${club.clubName}</h5>
                        <p class="mb-1">${club.clubDescription}</p>
                    </a>
                </c:forEach>
            </div>
        </c:if>
        <c:if test="${empty clubs}">
            <p class="text-muted">You are not managing any clubs</p>
        </c:if>
    </c:if>
</div>

<!-- Create Activity Modal -->
<div class="modal fade" id="createActivityModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Create New Activity</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form action="${pageContext.request.contextPath}/committee/manage-activities" method="post">
                <div class="modal-body">
                    <input type="hidden" name="action" value="create">
                    <input type="hidden" name="clubID" value="${clubID}">
                    
                    <div class="mb-3">
                        <label class="form-label">Activity Name *</label>
                        <input type="text" class="form-control" name="activityName" required>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label">Description</label>
                        <textarea class="form-control" name="activityDescription" rows="3"></textarea>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label">Activity Type *</label>
                        <select class="form-select" name="activityType" required>
                            <option value="">Select Type</option>
                            <option value="Workshop">Workshop</option>
                            <option value="Seminar">Seminar</option>
                            <option value="Lecture">Lecture</option>
                            <option value="Competition">Competition</option>
                            <option value="Social Event">Social Event</option>
                            <option value="Training">Training</option>
                        </select>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label">Location *</label>
                        <input type="text" class="form-control" name="activityLocation" required>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Start Date *</label>
                            <input type="date" class="form-control" name="startDate" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">End Date *</label>
                            <input type="date" class="form-control" name="endDate" required>
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label">Max Participants *</label>
                        <input type="number" class="form-control" name="maxParticipants" min="1" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">Create Activity</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Edit Activity Modal -->
<div class="modal fade" id="editActivityModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Edit Activity</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form action="${pageContext.request.contextPath}/committee/manage-activities" method="post">
                <div class="modal-body">
                    <input type="hidden" name="action" value="edit">
                    <input type="hidden" name="clubID" value="${clubID}">
                    <input type="hidden" name="activityID" id="editActivityID">
                    
                    <div class="mb-3">
                        <label class="form-label">Activity Name *</label>
                        <input type="text" class="form-control" name="activityName" id="editActivityName" required>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label">Description</label>
                        <textarea class="form-control" name="activityDescription" id="editActivityDescription" rows="3"></textarea>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label">Activity Type *</label>
                        <select class="form-select" name="activityType" id="editActivityType" required>
                            <option value="Workshop">Workshop</option>
                            <option value="Seminar">Seminar</option>
                            <option value="Lecture">Lecture</option>
                            <option value="Competition">Competition</option>
                            <option value="Social Event">Social Event</option>
                            <option value="Training">Training</option>
                        </select>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label">Location *</label>
                        <input type="text" class="form-control" name="activityLocation" id="editActivityLocation" required>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Start Date *</label>
                            <input type="date" class="form-control" name="startDate" id="editStartDate" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">End Date *</label>
                            <input type="date" class="form-control" name="endDate" id="editEndDate" required>
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label">Max Participants *</label>
                        <input type="number" class="form-control" name="maxParticipants" id="editMaxParticipants" min="1" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">Update Activity</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
function editActivity(id, name, desc, type, location, startDate, endDate, maxPart) {
    document.getElementById('editActivityID').value = id;
    document.getElementById('editActivityName').value = name;
    document.getElementById('editActivityDescription').value = desc;
    document.getElementById('editActivityType').value = type;
    document.getElementById('editActivityLocation').value = location;
    document.getElementById('editStartDate').value = startDate;
    document.getElementById('editEndDate').value = endDate;
    document.getElementById('editMaxParticipants').value = maxPart;
    
    var editModal = new bootstrap.Modal(document.getElementById('editActivityModal'));
    editModal.show();
}
</script>
</body>
</html>