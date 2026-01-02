<%-- 
    Document   : register
    Created on : 27 Dec 2025, 2:45:42 am
    Author     : TUF
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Page</title>
    </head>
    <body>
        <form method="POST" action="register" id="registerForm">
            <label>username</label>
            <input type="text" name="userName" required>
            <label>email</label>
            <input type="email" name="userEmail" required>
            <label>password</label>
            <input type="password" name="userPassword" id="password" required>
            <label>re-enter password</label>
            <input type="password" name="confirmPassword" id="confirmPassword" required>
            <label>matric no.</label>
            <input type="number" name="matricNo" required>
            <label>faculty</label>
            <select name="faculty">
                <option value="FSKM">FSKM</option> 
                <option value="KPPIM">KPPIM</option>
            </select>
            <label>programme</label>
            <input type="text" name="programme" required>
            <a href="">login</a>
            <input type="submit">
        </form>
        
        <script>
            document.getElementById('registerForm').addEventListener('submit', function(e) {
                var password = document.getElementById('password').value;
                var confirmPassword = document.getElementById('confirmPassword').value;
                
                if (password.length < 8) {
                    e.preventDefault();
                    alert('Password must be at least 8 characters long!');
                    return false;
                }
                
                if (password !== confirmPassword) {
                    e.preventDefault();
                    alert('Passwords do not match!');
                    return false;
                }
                
                return true;
            });
        </script>
    </body>
</html>
