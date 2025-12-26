<%-- 
    Document   : login
    Created on : 26 Dec 2025, 11:51:43 pm
    Author     : TUF
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
    </head>
    <body>
        <form method="POST" action="login">
            <label>username</label>
            <input type="text" name="userName" required>
            <label>password</label>
            <input type="password" name="userPassword" required>
            <a href="">register</a>
            <input type="submit">
        </form>
    </body>
</html>
