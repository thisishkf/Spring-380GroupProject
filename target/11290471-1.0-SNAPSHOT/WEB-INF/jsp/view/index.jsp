<!DOCTYPE html>
<html>
    <head>
        <title>HomePage</title>
        <style>
            ul {list-style: none;}
            li {display: inline;}

        </style>
    </head>
    <body>
        <div style="position: relative; float: right;">Hello, ${user}! 
            <security:authorize access="isAuthenticated()">
                <c:url var="logoutUrl" value="/logout"/>
                <form action="${logoutUrl}" method="post">
                    <input type="submit" value="Log out" />
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                </form>
            </security:authorize>
        </div>
            <div style="clear: both"></div>
        <ul>
            <security:authorize access="!isAuthenticated()">
                <li>
                    <a href="register">Register</a>
                </li>
                <li>
                    <a href="login">Login</a>
                </li>
            </security:authorize>
            <security:authorize access="hasAnyRole('ADMIN','su')">
                <li>
                    admin

                </li>
            </security:authorize>


        </ul>








        <div style="border-bottom: 1px dotted black"></div>

        <div style="text-align: center; background-color: #777; color: white;">Lecture</div>
        <br/>
        <c:if test="${fn:length(lectures) <0}">
            No other materials Available\
        </c:if>
        <c:if test="${fn:length(lectures) >0}">
            <c:forEach var="lecture" items="${lectures}">
                #${lecture.id} : 
                <a href="viewMessage?id=${lecture.id}">${lecture.name}</a><br/>
            </c:forEach>
        </c:if>
        <br/>

        <div style="border-bottom: 1px solid black;"></div>

        <div style="text-align: center; background-color: #777; color: white;">Lab</div>
        <br/>
        <c:if test="${fn:length(labs) <0}">
            No other materials Available\
        </c:if>
        <c:if test="${fn:length(labs) >0}">
            <c:forEach var="lab" items="${labs}">
                #${lab.id} : 
                <a href="viewMessage?id=${lab.id}">${lab.name}</a><br/>
            </c:forEach>
        </c:if>
        <br/>


        <div style="border-bottom: 1px solid black;"></div>
        <div style="text-align: center; background-color: #777; color: white;">Other</div>
        <br/>
        <c:if test="${fn:length(others) <0}">
            No other materials Available\
        </c:if>
        <c:if test="${fn:length(others) >0}">
            <c:forEach var="other" items="${others}">
                #${other.id} : 
                <a href="viewMessage?id=${other.id}">${other.name}</a><br/>
            </c:forEach>
        </c:if>
        <br/>

        <div style="border-bottom: 1px solid black;"></div>
        <br/>
        <form action="vote" method="POST">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <input type="hidden" name="poll_id" value="${poll.id}"/>
            <div style="text-align: center; background-color: #777; color: white;">
                Recent Poll 
            </div>
            [<a href="pollHistory">history</a>] [<a href="createPoll">Create</a>]
            <br/>
            <c:if test="${fn:length(others) <0}">
                <br/>No Poll Available
            </c:if>
            <c:if test="${fn:length(others) >0}">
                <br/>${poll.title}<br/>
                A: ${poll.a}(${poll.countA})
                <security:authorize access="isAuthenticated()">
                    <c:if test="${pollAnswered == null}">
                        <input type="radio" name="answer" value="A" >
                    </c:if>
                </security:authorize>
                <br/>

                B: ${poll.b}(${poll.countB})
                <security:authorize access="isAuthenticated()">
                    <c:if test="${pollAnswered == null}">
                        <input type="radio" name="answer" value="B" >
                    </c:if>
                </security:authorize>
                <br/>

                <c:if test="${! empty poll.c}">
                    C: ${poll.c}(${poll.countC})
                    <security:authorize access="isAuthenticated()">
                        <c:if test="${pollAnswered == null}">

                            <input type="radio" name="answer" value="C" >
                        </c:if>

                    </security:authorize><br/>
                </c:if>
                <c:if test="${! empty poll.c}">  
                    D: ${poll.d}(${poll.countD})
                    <security:authorize access="isAuthenticated()">
                        <c:if test="${pollAnswered == null}">
                            <input type="radio" name="answer" value="D" >
                        </c:if>
                    </security:authorize>
                    <br/>
                </c:if>
                <security:authorize access="isAuthenticated()">  
                    <c:if test="${pollAnswered == null}">
                        You can only vote once.<input type="submit" value="Vote!"/><br/>
                    </c:if>
                </security:authorize>
                Total Vote: ${poll.countA + poll.countB+poll.countC+poll.countD}<br/>
                <c:if test="${pollAnswered != null}">
                    Your Answer: ${pollAnswered.answer}
                </c:if>  
                <c:if test="${pollAnswered == null}">
                    <security:authorize access="!isAuthenticated()">
                        Login to vote. 
                    </security:authorize>
                </c:if> 
            </c:if>

        </form>


    </body>
</html>