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
        <jsp:include page="menu.jsp" />
        <h1>Edit User</h1>

        <c:if test="${param.status == null}">
            <div style="border: 1px dotted black; padding : 2px;">
                <form action="editUser" method="POST">
                    <input type="hidden" id="username" name="username" value="${user.name}"/><br/>
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

                    User name : ${user.name}<br/>
                    Password:
                    <input type="password" name ="password" value="${user.password}"/><br />
                    Role
                    <c:set var="containsUser" value="false" />
                    <c:set var="containsAdmin" value="false" />

                    <c:forEach var="role" items="${user.role}">

                        <c:if test="${role eq 'ROLE_USER'}">
                            <c:set var="containsUser" value="true" />
                        </c:if>

                        <c:if test="${role eq 'ROLE_ADMIN'}">
                            <c:set var="containsAdmin" value="true" />
                        </c:if>

                    </c:forEach>

                    <c:if test="${containsUser}">
                        <input type="checkbox" name="role" value="ROLE_USER" checked/>User 
                    </c:if>

                    <c:if test="${! containsUser}">
                        <input type="checkbox" name="role" value="ROLE_USER"/>User 
                    </c:if>

                    <c:if test="${containsAdmin}">
                        <input type="checkbox" name="role" value="ROLE_ADMIN" checked/>Admin 
                    </c:if>

                    <c:if test="${! containsAdmin}">
                        <input type="checkbox" name="role" value="ROLE_ADMIN"/>Admin 
                    </c:if>
                    <br />
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <input type="submit" value="Edit"/>

                </form>
            </div>
        </c:if>
        <c:if test="${param.status =='ok'}">Register Success</c:if>
        <c:if test="${param.status =='error'}">Register Fail</c:if>
    </body>
</html>
