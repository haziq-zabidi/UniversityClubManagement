<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Members - Committee Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
        }
        h1, h2 {
            color: #333;
        }
        .message {
            padding: 10px;
            margin: 10px 0;
            border-radius: 4px;
        }
        .success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        .btn {
            padding: 8px 16px;
            margin: 2px;
            cursor: pointer;
            border: none;
            border-radius: 4px;
            text-decoration: none;
            display: inline-block;
        }
        .btn-primary {
            background-color: #007bff;
            color: white;
        }
        .btn-danger {
            background-color: #dc3545;
            color: white;
        }
        .btn-warning {
            background-color: #ffc107;
            color: black;
        }
        .btn-back {
            background-color: #6c757d;
            color: white;
        }
        .btn:hover {
            opacity: 0.8;
        }
        .club-card {
            border: 1px solid #ddd;
            padding: 15px;
            margin: 10px 0;
            border-radius: 4px;
        }
        .status-active {
            color: green;
            font-weight: bold;
        }
        .status-inactive {
            color: red;
            font-weight: bold;
        }
        select {
            padding: 5px;
            border-radius: 4px;
        }
    </style>
    <script>
        function confirmRemove(memberName) {
            return confirm("Are you sure you want to remove " + memberName + " from this club?");
        }
    </script>
</head>
<body>
    <div class="container">
        <h1>Manage Club Members</h1>
        
        <!-- Success/Error Messages -->
        <c:if test="${not empty sessionScope.successMessage}">
            <div class="message success">
                ${sessionScope.successMessage}
            </div>
            <c:remove var="successMessage" scope="session"/>
        </c:if>
        
        <c:if test="${not empty sessionScope.errorMessage}">
            <div class="message error">
                ${sessionScope.errorMessage}
            </div>
            <c:remove var="errorMessage" scope="session"/>
        </c:if>
        
        <c:if test="${not empty errorMessage}">
            <div class="message error">
                ${errorMessage}
            </div>
        </c:if>
        
        <!-- Club Selection View -->
        <c:if test="${empty club}">
            <h2>Select a Club to Manage</h2>
            
            <c:if test="${empty clubs}">
                <p>You are not managing any clubs currently.</p>
            </c:if>
            
            <c:forEach var="club" items="${clubs}">
                <div class="club-card">
                    <h3>${club.clubName}</h3>
                    <p>${club.clubDescription}</p>
                    <p><strong>Category:</strong> ${club.clubCategory}</p>
                    <a href="${pageContext.request.contextPath}/committee/manage-members?action=view&clubID=${club.clubID}" 
                       class="btn btn-primary">Manage Members</a>
                </div>
            </c:forEach>
            
            <br><br>
            <a href="${pageContext.request.contextPath}/committee/dashboard" class="btn btn-back">Back to Dashboard</a>
        </c:if>
        
        <!-- Members List View -->
        <c:if test="${not empty club}">
            <h2>Members of ${club.clubName}</h2>
            <p><strong>Category:</strong> ${club.clubCategory}</p>
            <p><strong>Description:</strong> ${club.clubDescription}</p>
            
            <br>
            
            <c:if test="${empty memberships}">
                <p>No members in this club yet.</p>
            </c:if>
            
            <c:if test="${not empty memberships}">
                <table>
                    <thead>
                        <tr>
                            <th>Member ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Matric No</th>
                            <th>Faculty</th>
                            <th>Programme</th>
                            <th>Join Date</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="membership" items="${memberships}">
                            <tr>
                                <td>${membership.user.userID}</td>
                                <td>${membership.user.userName}</td>
                                <td>${membership.user.userEmail}</td>
                                <td>${membership.user.matricNo}</td>
                                <td>${membership.user.faculty}</td>
                                <td>${membership.user.programme}</td>
                                <td>${membership.joinDate}</td>
                                <td>
                                    <span class="${membership.membershipStatus == 'Active' ? 'status-active' : 'status-inactive'}">
                                        ${membership.membershipStatus}
                                    </span>
                                </td>
                                <td>
                                    <!-- Update Status Form -->
                                    <form method="post" action="${pageContext.request.contextPath}/committee/manage-members" style="display: inline;">
                                        <input type="hidden" name="action" value="updateStatus">
                                        <input type="hidden" name="membershipID" value="${membership.membershipID}">
                                        <input type="hidden" name="clubID" value="${clubID}">
                                        <select name="status" onchange="this.form.submit()">
                                            <option value="Active" ${membership.membershipStatus == 'Active' ? 'selected' : ''}>Active</option>
                                            <option value="Inactive" ${membership.membershipStatus == 'Inactive' ? 'selected' : ''}>Inactive</option>
                                        </select>
                                    </form>
                                    
                                    <!-- Remove Member Form -->
                                    <form method="post" action="${pageContext.request.contextPath}/committee/manage-members" 
                                          style="display: inline;" 
                                          onsubmit="return confirmRemove('${membership.user.userName}')">
                                        <input type="hidden" name="action" value="remove">
                                        <input type="hidden" name="membershipID" value="${membership.membershipID}">
                                        <input type="hidden" name="clubID" value="${clubID}">
                                        <button type="submit" class="btn btn-danger">Remove</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                
                <p><strong>Total Members:</strong> ${memberships.size()}</p>
            </c:if>
            
            <br>
            <a href="${pageContext.request.contextPath}/committee/manage-members" class="btn btn-back">Back to Club Selection</a>
            <a href="${pageContext.request.contextPath}/committee/dashboard" class="btn btn-back">Back to Dashboard</a>
        </c:if>
    </div>
</body>
</html>