<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Poll History</title>
        <style>
            ul {list-style: none;padding: 0; margin: 0}
            li {display: inline; 
                background-color: 
                    darkgrey; padding: 
                    2px; padding-left:4px; 
                padding-right: 4px;}
            li a {text-decoration: none; color: white}
        </style>
    </head>
    <body>
        <jsp:include page="menu.jsp" />
        <div style="text-align: left; background-color: #DCDCDC; color: black;">    
            <h1>PollHistory</h1>
        </div>
        <div style="border-bottom: 1px dotted black"></div>
        <c:if test="${fn:length(pollList) == 0}">
            <p>There is no previous polls.</p>
        </c:if>
        <c:if test="${fn:length(pollList) > 0}">
            <c:forEach var="poll" items="${pollList}">
                #<c:out value="${poll.id}" escapeXml="true" />:<c:out value="${poll.title}" escapeXml="true" /><br /><br />
                Answer A: &nbsp;<c:out value="${poll.a}" escapeXml="true" /> (${poll.countA})<br />
                Answer B: &nbsp;<c:out value="${poll.b}" escapeXml="true" /> (${poll.countB})<br />
                Answer C: &nbsp;<c:out value="${poll.c}" escapeXml="true" /> (${poll.countC})<br />
                Answer D: &nbsp;<c:out value="${poll.d}" escapeXml="true" /> (${poll.countD})<br /><br />
                Total Vote: ${poll.countA + poll.countB+poll.countC+poll.countD}
                <div style="border-bottom:1px solid black"></div>
            </c:forEach>
        </c:if>




        <div style="border-bottom: 1px soild black"></div>
    </body>
</html>
