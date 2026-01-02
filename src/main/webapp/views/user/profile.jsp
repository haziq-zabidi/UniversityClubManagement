<%-- 
    Document   : manageUser
    Created on : 2 Jan 2026, 6:12:54 pm
    Author     : TUF
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Profile</title>
    </head>
    <body>
        <h1>Welcome, ${userName}!</h1>
        <a href="${pageContext.request.contextPath}/user/dashboard">← Back to Dashboard</a> | 
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
        <hr>

        <!-- Success/Error Messages -->
        <c:if test="${not empty successMessage}">
            <div>
                <strong>Success:</strong> ${successMessage}
            </div>
            <br>
        </c:if>

        <c:if test="${not empty errorMessage}">
            <div>
                <strong>Error:</strong> ${errorMessage}
            </div>
            <br>
        </c:if>

        <h2>My Profile</h2>

        <!-- Profile Information Section -->
        <h3>Personal Information</h3>
        <form action="${pageContext.request.contextPath}/user/profile" method="POST">
            <input type="hidden" name="action" value="update_profile">
            
            <table>
                <tr>
                    <td><label>Full Name:</label></td>
                    <td><input type="text" name="userName" value="${user.userName}" required></td>
                </tr>
                <tr>
                    <td><label>Email Address:</label></td>
                    <td><input type="email" name="userEmail" value="${user.userEmail}" required></td>
                </tr>
                <tr>
                    <td><label>Matric Number:</label></td>
                    <td><input type="text" name="matricNo" value="${user.matricNo}"></td>
                </tr>
                <tr>
                    <td><label>Faculty:</label></td>
                    <td><input type="text" name="faculty" value="${user.faculty}"></td>
                </tr>
                <tr>
                    <td><label>Programme:</label></td>
                    <td><input type="text" name="programme" value="${user.programme}"></td>
                </tr>
                <tr>
                    <td></td>
                    <td><input type="submit" value="Update Profile"></td>
                </tr>
            </table>
        </form>

        <hr>

        <!-- Change Password Section -->
        <h3>Change Password</h3>
        <form action="${pageContext.request.contextPath}/user/profile" method="POST" id="passwordForm">
            <input type="hidden" name="action" value="change_password">
            
            <table>
                <tr>
                    <td><label>Current Password:</label></td>
                    <td><input type="password" name="currentPassword" required></td>
                </tr>
                <tr>
                    <td><label>New Password:</label></td>
                    <td><input type="password" name="newPassword" id="newPassword" required></td>
                </tr>
                <tr>
                    <td><label>Confirm New Password:</label></td>
                    <td><input type="password" name="confirmPassword" id="confirmPassword" required></td>
                </tr>
                <tr>
                    <td></td>
                    <td><input type="submit" value="Change Password"></td>
                </tr>
            </table>
        </form>

        <hr>
        </table>

        <hr>
        <a href="${pageContext.request.contextPath}/user/dashboard">← Dashboard</a>
        <a href="${pageContext.request.contextPath}/user/announcements">← Announcement</a>
        <a href="${pageContext.request.contextPath}/user/profile">← Profile</a>
        <a href="${pageContext.request.contextPath}/user/clubs">← Clubs</a>

        <script>
            // Auto-hide messages after 5 seconds
            setTimeout(function() {
                var messages = document.querySelectorAll('div');
                messages.forEach(function(message) {
                    if (message.innerHTML.includes('Success:') || message.innerHTML.includes('Error:')) {
                        message.style.display = 'none';
                    }
                });
            }, 5000);
            
            // Password confirmation validation
            document.getElementById('passwordForm').addEventListener('submit', function(e) {
                var newPassword = document.getElementById('newPassword').value;
                var confirmPassword = document.getElementById('confirmPassword').value;
                
                if (newPassword !== confirmPassword) {
                    e.preventDefault();
                    alert('New passwords do not match!');
                    return false;
                }
                
                if (newPassword.length < 8) {
                    e.preventDefault();
                    alert('Password must be at least 8 characters long!');
                    return false;
                }
                
                return true;
            });
        </script>
    </body>
</html>
