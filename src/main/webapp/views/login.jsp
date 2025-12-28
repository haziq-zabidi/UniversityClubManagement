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
            <label>email</label>
            <input type="text" name="userEmail" required>
            <label>password</label>
            <input type="password" name="userPassword" required>
            <a href="${pageContext.request.contextPath}/register">register</a>
            <input type="submit">
        </form>
    </body>
</html>
