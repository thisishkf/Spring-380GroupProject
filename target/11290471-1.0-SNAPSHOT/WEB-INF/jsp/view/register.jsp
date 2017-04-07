<%-- 
    Created on  : Mar 29, 2017, 10:32:48 PM
    Author      : Ho Kin Fai, Wong Tak Ming, Chow wa wai
    Project     : comps380f
    Purpose     : Website Index Page
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register | 380</title>
    </head>
    <body>
        <h1>Register</h1>
        <c:if test="${param.status == null}">
            <form action="createPoll" method="POST">
                <label for="username">User name:</label><br/>
                <input type="text" id="username" name="username" /><br/><br/>
                <label for="password">Password:</label><br/>
                <input type="password" id="password" name="password" /><br/><br/>
                <label for="confirmpassword">Confirm Password:</label><br/>
                <input type="password" id="confirmPassword" name="confirmPassword" /><br/><br/>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <input type="submit" value="Register"/>
            </form>
        </c:if>
        <c:if test="${param.status =='ok'}">Register Success</c:if>
        <c:if test="${param.status =='error'}">Register Fail</c:if>
    </body>
</html>
