<!DOCTYPE html>
<html>
    <head>
        <title>HomePage</title>
    </head>
    <body>
        <c:url var="logoutUrl" value="/logout"/>
        <form action="${logoutUrl}" method="post">
            <input type="submit" value="Log out" />
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </form>

        <table border="1">
            <tr><td><a href="login">Login</a></td></tr>
            <tr><td><a href="register">Register</a></td></tr>
            <tr><td><a href="admin">Admin</a></td></tr>
        </table>

        <h2>HomePage</h2>

        <table border="1">
            <tr><th colspan="2">Lecture</th></tr>
            <tr><th>ID</th><th>Name</th></tr>
                    <c:if test="${fn:length(lectures) <0}">
                <tr><td colspan="2">No Lecture Available</td></tr>
            </c:if>
            <c:if test="${fn:length(lectures) >0}">
                <c:forEach var="lecture" items="${lectures}">
                    <tr><td>#${lecture.id}</td>
                        <td><a href="viewMessage?id=${lecture.id}">${lecture.name}</a></td></tr>
                </c:forEach>
            </c:if>
        </table>
        <br/>
        <table border="1">
            <tr><th colspan="2">Lab</th></tr>
            <tr><th>ID</th><th>Name</th></tr>
                    <c:if test="${fn:length(labs) <0}">
                <tr><td colspan="2">No Lab Available</td></tr>
            </c:if>
            <c:if test="${fn:length(labs) >0}">
                <c:forEach var="lab" items="${labs}">
                    <tr><td>#${lab.id}</td>
                        <td><a href="viewMessage?id=${lab.id}">${lab.name}</a></td></tr>
                </c:forEach>
            </c:if>
        </table>
        <br/>
        <table border="1">
            <tr><th colspan="2">Other</th></tr>
            <tr><th>ID</th><th>Name</th></tr>
                    <c:if test="${fn:length(others) <0}">
                <tr><td colspan="2">No other materials Available</td></tr>
            </c:if>
            <c:if test="${fn:length(others) >0}">
                <c:forEach var="other" items="${others}">
                    <tr><td>#${other.id}</td>
                        <td><a href="viewMessage?id=${other.id}">${other.name}</a></td></tr>
                </c:forEach>
            </c:if>
        </table>
        <br/>
        <form>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <input type="hidden" name="poll_id" value="${poll.id}"/>
            <table border="1">
                <tr><th colspan="3">Recent Poll</th><th>[<a href="pollHistory">history</a>]</th></tr>
                        <c:if test="${fn:length(others) <0}">
                    <tr><td colspan="4">No Poll Available</td></tr>
                </c:if>
                <c:if test="${fn:length(others) >0}">
                    <tr><th colspan="4">${poll.title}</th></tr>
                    <tr><th>${poll.a}</th><th>${poll.b}</th><th>${poll.c}</th><th>${poll.d}</th></tr>
                    <tr><th>${poll.countA}</th><th>${poll.countB}</th><th>${poll.countC}</th><th>${poll.countD}</th></tr>
                            <security:authorize access="hasAnyRole('USER','ADMIN')">
                        <tr>
                            <td><input type="radio" name="answer" value="a" ></td>
                            <td><input type="radio" name="answer" value="b" ></td>
                            <td><input type="radio" name="answer" value="c" ></td>
                            <td><input type="radio" name="answer" value="d" ></td>
                        </tr>

                                <tr><td colspan="2">You can only vote once.</td><td colspan="2"><input type="submit" value="Vote!"/></td></tr>
                            </security:authorize>
                            <security:authorize access="!hasAnyRole('USER','ADMIN')">
                                    <tr><td colspan="4">Login to vote.</td></tr>    
                                    
                            </security:authorize>
                        </c:if>
            </table>
        </form>


    </body>
</html>