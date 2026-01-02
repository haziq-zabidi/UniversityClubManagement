<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Members</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
    <h2>Manage Club Members</h2>
    
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
    
    <!-- If viewing specific club -->
    <c:if test="${not empty club}">
        <h3 class="mb-4">${club.clubName}</h3>
        
        <!-- Pending Join Requests -->
        <div class="card mb-4">
            <div class="card-header bg-info text-white">
                <h5 class="mb-0">Pending Join Requests (${fn:length(pendingJoinRequests)})</h5>
            </div>
            <div class="card-body">
                <c:if test="${not empty pendingJoinRequests}">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Matric No</th>
                                <th>Faculty</th>
                                <th>Request Date</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${pendingJoinRequests}" var="membership">
                                <tr>
                                    <td>${membership.user.userName}</td>
                                    <td>${membership.user.userEmail}</td>
                                    <td>${membership.user.matricNo}</td>
                                    <td>${membership.user.faculty}</td>
                                    <td>${membership.joinDate}</td>
                                    <td>
                                        <form action="${pageContext.request.contextPath}/committee/manage-members" method="post" style="display:inline;">
                                            <input type="hidden" name="action" value="approve">
                                            <input type="hidden" name="membershipID" value="${membership.membershipID}">
                                            <input type="hidden" name="clubID" value="${clubID}">
                                            <button type="submit" class="btn btn-success btn-sm">
                                                ✓ Approve
                                            </button>
                                        </form>
                                        <form action="${pageContext.request.contextPath}/committee/manage-members" method="post" style="display:inline;">
                                            <input type="hidden" name="action" value="reject">
                                            <input type="hidden" name="membershipID" value="${membership.membershipID}">
                                            <input type="hidden" name="clubID" value="${clubID}">
                                            <button type="submit" class="btn btn-danger btn-sm">
                                                ✗ Reject
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>
                <c:if test="${empty pendingJoinRequests}">
                    <p class="text-muted">No pending join requests</p>
                </c:if>
            </div>
        </div>
        
        <!-- Pending Leave Requests -->
        <div class="card mb-4">
            <div class="card-header bg-warning text-dark">
                <h5 class="mb-0">Pending Leave Requests (${fn:length(pendingLeaveRequests)})</h5>
            </div>
            <div class="card-body">
                <c:if test="${not empty pendingLeaveRequests}">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Matric No</th>
                                <th>Faculty</th>
                                <th>Member Since</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${pendingLeaveRequests}" var="membership">
                                <tr>
                                    <td>${membership.user.userName}</td>
                                    <td>${membership.user.userEmail}</td>
                                    <td>${membership.user.matricNo}</td>
                                    <td>${membership.user.faculty}</td>
                                    <td>${membership.joinDate}</td>
                                    <td>
                                        <form action="${pageContext.request.contextPath}/committee/manage-members" method="post" style="display:inline;" onsubmit="return confirm('Approve this leave request? Member will be removed from the club.');">
                                            <input type="hidden" name="action" value="approveLeave">
                                            <input type="hidden" name="membershipID" value="${membership.membershipID}">
                                            <input type="hidden" name="clubID" value="${clubID}">
                                            <button type="submit" class="btn btn-success btn-sm">
                                                ✓ Approve Leave
                                            </button>
                                        </form>
                                        <form action="${pageContext.request.contextPath}/committee/manage-members" method="post" style="display:inline;">
                                            <input type="hidden" name="action" value="rejectLeave">
                                            <input type="hidden" name="membershipID" value="${membership.membershipID}">
                                            <input type="hidden" name="clubID" value="${clubID}">
                                            <button type="submit" class="btn btn-danger btn-sm">
                                                ✗ Reject Leave
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>
                <c:if test="${empty pendingLeaveRequests}">
                    <p class="text-muted">No pending leave requests</p>
                </c:if>
            </div>
        </div>
        
        <!-- Active Members -->
        <div class="card">
            <div class="card-header bg-success text-white">
                <h5 class="mb-0">Active Members (${fn:length(activeMembers)})</h5>
            </div>
            <div class="card-body">
                <c:if test="${not empty activeMembers}">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Matric No</th>
                                <th>Faculty</th>
                                <th>Join Date</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${activeMembers}" var="membership">
                                <tr>
                                    <td>${membership.user.userName}</td>
                                    <td>${membership.user.userEmail}</td>
                                    <td>${membership.user.matricNo}</td>
                                    <td>${membership.user.faculty}</td>
                                    <td>${membership.joinDate}</td>
                                    <td>
                                        <form action="${pageContext.request.contextPath}/committee/manage-members" method="post" onsubmit="return confirm('Remove this member from the club?');">
                                            <input type="hidden" name="action" value="remove">
                                            <input type="hidden" name="membershipID" value="${membership.membershipID}">
                                            <input type="hidden" name="clubID" value="${clubID}">
                                            <button type="submit" class="btn btn-warning btn-sm">
                                                Remove
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>
                <c:if test="${empty activeMembers}">
                    <p class="text-muted">No active members yet</p>
                </c:if>
            </div>
        </div>
        
        <a href="${pageContext.request.contextPath}/committee/manage-members" class="btn btn-secondary mt-3">
            ← Back to Club List
        </a>
    </c:if>
    
    <!-- If listing clubs -->
    <c:if test="${empty club}">
        <h3>Select a Club to Manage</h3>
        <c:if test="${not empty clubs}">
            <div class="list-group">
                <c:forEach items="${clubs}" var="club">
                    <a href="${pageContext.request.contextPath}/committee/manage-members?action=view&clubID=${club.clubID}" 
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>