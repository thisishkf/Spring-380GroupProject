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
            li:hover, li a:hover{
                background-color: white;
                color: black;
            }
        </style>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    </head>
    <body>
        <jsp:include page="menu.jsp" />
        <div style="text-align: center; background-color: #DCDCDC; color: black;">
            <h2>Topic #${param.id}</h2>
        </div>
        <div style="border-bottom:1px solid black"></div>
        <c:if test="${fn:length(messages) == 0}">
            <p>There is no message yet.</p>
        </c:if>
        <c:if test="${fn:length(messages) > 0}">
            <c:forEach var="message" items="${messages}">
                #<c:out value="${message.id}" escapeXml="true" />
                <c:forEach var="user" items="${users}">

                    <c:if test="${user.name eq message.username && user.status != 'active'}">
                        {Show Blocked User - ${message.username}}
                    </c:if>
                    <c:if test="${user.name eq message.username && user.status == 'active'}">
                        :<c:out value="${message.title}" escapeXml="true" /><br />
                        Content: <c:out value="${message.content}" escapeXml="true" /><br />
                        <c:if test="${fn:length(attachmentDatabase) > 0 }">

                            <c:forEach var="attachment" items="${attachmentDatabase}">
                                <security:authorize access="isAuthenticated()">
                                    <c:if test="${attachment.key eq message.id}">
                                        Attachment: 

                                        <c:forEach var="oneAtt" items="${attachment.value}">
                                            <a href="Msgattachment?attachmentID=${oneAtt.id}&message_id=${message.id}">
                                                ${oneAtt.name} , 
                                            </c:forEach>
                                        </a>
                                    </c:if>
                                </security:authorize>
                                <security:authorize access="!isAuthenticated()">
                                    <c:if test="${attachment.key eq message.id}">
                                        Attachment: 

                                        <c:forEach var="oneAtt" items="${attachment.value}">

                                            ${oneAtt.name} , 
                                        </c:forEach>

                                    </c:if>
                                </security:authorize>
                            </c:forEach>
                            <br/>
                        </c:if>
                        Owner: <c:out value="${message.username}" escapeXml="true" /><br />
                        <a href="discussion?id=${message.id}">Go to discuss</a>
                        
                    </c:if>
                </c:forEach>
                        <security:authorize access="hasRole('ADMIN')">
                            [<a href="deleteMsg?id=${message.id}&topic_id=${param.id}">Delete</a>]
                        </security:authorize>
                <div style="border-bottom:1px solid black"></div>
            </c:forEach>
        </c:if>
        <br />
        <security:authorize access="hasAnyRole('ADMIN','USER')">

            <div style="border: 1px dotted black; padding : 2px;">
                <form:form method="POST" enctype="multipart/form-data"
                           modelAttribute="messageForm">

                    <form:hidden path="topic_id" value="${param.id}"/>
                    <form:label path="title"><b>Title:</b></form:label><br/>
                    <form:input type="text" path="title" /><br/><br/>

                    <form:label path="content"><b>Content:</b></form:label><br/>
                    <form:input type="text" path="content"/><br/><br/>

                    <b>Attachments</b><br/>
                    <input type="file" name="attachments" multiple="multiple"/><br/><br/>
                    <input  type="submit" value="Submit"/>
                </form:form>
            </div>

        </security:authorize>



    </body>
</html>