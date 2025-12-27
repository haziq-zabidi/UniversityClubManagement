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
        <form method="POST" action="register">
            <input type="text" name="userName" required>
            <input type="email" name="userEmail" required>
            <input type="password" name="userPassword" required>
            <input type="number" name="matricNo" required>
            <select name="faculty">
                <option value="FSKM">FSKM</option> 
                <option value="KPPIM">KPPIM</option>
            </select>
            <input type="text" name="programme" required>
            
        </form>
    </body>
</html>
