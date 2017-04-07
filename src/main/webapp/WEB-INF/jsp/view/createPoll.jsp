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
        <title>CreatePoll | 380</title>
    </head>
    <body>
        <h1>Register</h1>
        <c:if test="${param.status == null}">
            <form action="createPoll" method="POST">
                <label for="title">Poll title:</label><br/>
                <input type="text" id="username" name="title" /><br/><br/>
                <label for="a">Option A</label><br/>
                <input type="text" id="a" name="a" /><br/><br/>
                <label for="b">Option B</label><br/>
                <input type="text" id="b" name="b" /><br/><br/>
                <label for="c">Option C</label><br/>
                <input type="text" id="c" name="c" /><br/><br/>
                <label for="d">Option D</label><br/>
                <input type="text" id="d" name="d" /><br/><br/>
                
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <input type="submit" value="Create"/>
            </form>
        </c:if>
        <c:if test="${param.status =='ok'}">Create Success</c:if>
        <c:if test="${param.status =='error'}">Create Fail</c:if>
    </body>
</html>
