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
        <style>
            ul {list-style: none;padding: 0; margin: 0}
            li {display: inline; 
                background-color: 
                    darkgrey; padding: 
                    2px; padding-left:4px; 
                padding-right: 4px;}
            li a {text-decoration: none; color: white}
        </style>

    </head>
    <body>
        <jsp:include page="menu.jsp" />
        <div style="text-align: left; background-color: #DCDCDC; color: black;">
            <h1>Register</h1>
        </div>
        <c:if test="${param.status == null}">
            <form align="center" action="register" method="POST">
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
