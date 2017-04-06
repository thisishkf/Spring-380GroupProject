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
        <title>Edit User | 380</title>
    </head>
    <body>
        <h1>Edit User</h1>
        <div class="menu">
            <a href="index" class="button">Home</a>
            <a href="register" class="button">Register</a>
            <a href="login" class="button">Login</a>
        </div>
        <c:if test="${param.status == null}">
            <form:form action="editUser" method="POST">
                <input type="hidden" name="status" value="${user.status}"/>
                <input type="hidden" id="username" name="username" value="${user.name}"/><br/>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

                <table border="1">
                    <tr>
                        <td>User name:</td><td>${user.name}</td>
                    </tr>
                    <td>Password:</td>
                    <td><form:password path ="password" value="${user.password}"/></td>
                </tr>
                <tr>
                    <td colspan="2">Role</td>
                </tr>
                <tr>
                    <td><form:checkbox path="check" value="USRR"/>User</td>
                    <td><form:checkbox path="check" value="ADMIN"/>Admin</td>
                </tr>
                    <tr><td colspan="2">
                            <input type="submit" value="Edit"/>
                        </td>
                    </tr>
                </table>
            </form:form>
        </c:if>
        <c:if test="${param.status =='ok'}">Register Success</c:if>
        <c:if test="${param.status =='error'}">Register Fail</c:if>
    </body>
</html>
