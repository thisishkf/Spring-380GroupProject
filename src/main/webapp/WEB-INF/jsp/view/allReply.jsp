<!DOCTYPE html>
<html>
    <head>
        <title>Messages | 380</title>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    </head>
    <body>
        <div style="text-align: center; background-color: #777; color: white;">
            Message #<c:out value="${param.id}" escapeXml="true" />
        </div>
        <div style="border-bottom:1px solid black"></div>
        <c:if test="${fn:length(replys) == 0}">
            <p>There is no message yet.</p>
        </c:if>
        <c:if test="${fn:length(replys) > 0 }">
            <c:forEach var="reply" items="${replys}">
                #<c:out value="${reply.id}" escapeXml="true" /><br />
                <c:forEach var="user" items="${users}">

                    <c:if test="${user.name eq reply.username && user.status != 'active'}">
                        User is banned!
                    </c:if>
                    <c:if test="${user.name eq reply.username && user.status == 'active'}">

                        ${reply.username} : ${reply.content}<br />
                        Attachment: 
                        <security:authorize access="isAuthenticated()">

                        </security:authorize>
                        <security:authorize access="!isAuthenticated()">

                        </security:authorize>
                        <br/>
                        [<a href="deleteReply?id=${reply.id}&msg_id=${param.id}">Delete</a>]
                    </c:if>
                </c:forEach>
                <div style="border-bottom:1px solid black"></div>
            </c:forEach>
        </c:if>
        <form action="AddCommit" id="usrform" method="post">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <input type="hidden" name="msg_id" value="${param.id}"/>
            <h3>New Reply</h3>
            <textarea rows="4" cols="50" name="comment" form="usrform">Enter your comment here.</textarea><br/>
            <input type="submit" value="submit"/>
        </form>
    </body>
</html>