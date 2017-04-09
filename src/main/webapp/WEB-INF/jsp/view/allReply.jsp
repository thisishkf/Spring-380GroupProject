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
                        
                        <c:if test="${fn:length(attachmentDatabase) > 0 }">
                            
                            <c:forEach var="attachment" items="${attachmentDatabase}">
                                <security:authorize access="isAuthenticated()">
                                    <c:if test="${attachment.key eq reply.id}">
                                        Attachment: 
                                        
                                            <c:forEach var="oneAtt" items="${attachment.value}">
                                            <a href="attachment?attachmentID=${oneAtt.id}&reply_id=${reply.id}">
                                            ${oneAtt.name} , 
                                            </c:forEach>
                                        </a>
                                    </c:if>
                                </security:authorize>
                                <security:authorize access="!isAuthenticated()">
                                    ${attachment.name} ,
                                </security:authorize>
                            </c:forEach>
                            <br/>
                        </c:if>
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
            <form:form method="POST" enctype="multipart/form-data"
                       modelAttribute="replyForm">
                <form:hidden path="msg_id"  value="${param.id}"/>
                

                <form:label path="content">Content:</form:label><br/>
                <form:input type="text" path="content"/><br/><br/>

                <b>Attachments</b><br/>
                <input type="file" name="attachments" multiple="multiple"/><br/><br/>
                <input type="submit" value="Submit"/>
            </form:form>
        </security:authorize>
    </body>
</html>