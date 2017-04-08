<!DOCTYPE html>
<html>
    <head>
        <title>Messages | 380</title>
        <style>
            ul {list-style: none;padding: 0; margin: 0}
            li {display: inline; 
                background-color: 
                    darkgrey; padding: 
                    2px; padding-left:4px; 
                padding-right: 4px;}
            li a {text-decoration: none; color: white}
        </style>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    </head>
    <body>
        <jsp:include page="menu.jsp" />
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
                        <security:authorize access="hasRole('ADMIN')">
                            [<a href="deleteReply?id=${reply.id}&msg_id=${param.id}">Delete</a>]
                        </security:authorize>
                    </c:if>
                </c:forEach>
                <div style="border-bottom:1px solid black"></div>
            </c:forEach>
        </c:if>
                <br/>
        <security:authorize access="hasAnyRole('ADMIN','USER')">
            <form action="AddCommit" id="usrform" method="post" enctype="multipart/form-data">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <input type="hidden" name="msg_id" value="${param.id}"/>
                <div style="border: 1px dotted black; padding : 2px;">
                New Reply<br/>
                <textarea rows="4" cols="50" name="comment" form="usrform" placeholder="Enter your reply here."></textarea><br/>
                Attachment: <input type="file" name="attachments" multiple="multiple"/><br/><br/>
                <input type="submit" value="submit"/>
                </div>
            </form>
        </security:authorize>
    </body>
</html>