<!DOCTYPE html>
<html>
    <head>
        <title>Messages | 380</title>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    </head>
    <body>
        <div style="text-align: center; background-color: #777; color: white;">
        Topic #${param.id}
        </div>
        <div style="border-bottom:1px solid black"></div>
        <c:if test="${fn:length(messages) == 0}">
            <p>There is no message yet.</p>
        </c:if>
        <c:if test="${fn:length(messages) > 0}">
            <c:forEach var="message" items="${messages}">
                #<c:out value="${message.id}" escapeXml="true" />
                :<c:out value="${message.title}" escapeXml="true" /><br />
                Content: <c:out value="${message.content}" escapeXml="true" /><br />
                Attachment: 
                <security:authorize access="isAuthenticated()">
                    
                </security:authorize>
                <security:authorize access="!isAuthenticated()">
                    
                </security:authorize>
                <br/>
                Owner: <c:out value="${message.username}" escapeXml="true" /><br />
                <a href="discussion?id=${message.id}">Go to discuss</a>

                [<a href="deleteMsg?id=${message.id}&topic_id=${param.id}">Delete</a>]

                <div style="border-bottom:1px solid black"></div>
            </c:forEach>
        </c:if>
                <br />
        <form action="AddMessage" id="usrform" method="post">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <input type="hidden" name="topic_id" value="${param.id}"/>
            <div style="border: 1px dotted black; padding : 2px;">
            New Message <br />
            Title: <input type="text" name="title"/> <br />
            Content: <input type="text" name="content"/> <br />
            <input type="submit" value="submit"/>
            </div>
        </form>
    </body>
</html>