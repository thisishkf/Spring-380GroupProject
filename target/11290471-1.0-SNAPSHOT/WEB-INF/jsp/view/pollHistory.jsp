<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>PollHistory</h1>
        <div style="border-bottom: 1px dotted black"></div>
        <c:if test="${fn:length(pollList) == 0}">
            <p>There is no previous polls.</p>
        </c:if>
        <c:if test="${fn:length(pollList) > 0}">
            <c:forEach var="poll" items="${pollList}">
                #<c:out value="${poll.id}" escapeXml="true" />:<c:out value="${poll.title}" escapeXml="true" /><br />
                Answer A: <c:out value="${poll.a}" escapeXml="true" /> (${poll.countA})<br />
                Answer B: <c:out value="${poll.b}" escapeXml="true" /> (${poll.countB})<br />
                Answer C: <c:out value="${poll.c}" escapeXml="true" /> (${poll.countC})<br />
                Answer D: <c:out value="${poll.d}" escapeXml="true" /> (${poll.countD})<br />
                Total Vote: ${poll.countA + poll.countB+poll.countC+poll.countD}
                <div style="border-bottom:1px solid black"></div>
            </c:forEach>
        </c:if>
        
        
        
        
        <div style="border-bottom: 1px soild black"></div>
    </body>
</html>
