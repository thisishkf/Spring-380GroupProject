<!DOCTYPE html>
<html>
    <head>
        <title>HomePage</title>
            <jsp:include page="css.jsp" />
    </head>
    <body>
        <jsp:include page="menu.jsp" />

        <div style="text-align: center; background-color: #bcbcbc; color: white;"><font size="5">Lecture</font></div>
        <br/>
        <c:if test="${fn:length(lectures) <0}">
            No other materials Available
        </c:if>
        <c:if test="${fn:length(lectures) >0}">
            <c:forEach var="lecture" items="${lectures}">
                #${lecture.id} : 
                <a href="viewMessage?id=${lecture.id}">${lecture.name}</a><br/>
            </c:forEach>
        </c:if>
        <br/>

        <div style="border-bottom: 1px solid black;"></div>

        <div style="text-align: center; background-color: #bcbcbc; color: white;"><font size="5">Lab</font></div>
        <br/>
        <c:if test="${fn:length(labs) <0}">
            No other materials Available
        </c:if>
        <c:if test="${fn:length(labs) >0}">
            <c:forEach var="lab" items="${labs}">
                #${lab.id} : 
                <a href="viewMessage?id=${lab.id}">${lab.name}</a><br/>
            </c:forEach>
        </c:if>
        <br/>


        <div style="border-bottom: 1px solid black;"></div>
        <div style="text-align: center; background-color: #bcbcbc; color: white;"><font size="5">Other</font></div>
        <br/>
        <c:if test="${fn:length(others) <0}">
            No other materials Available
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
            <div  style="text-align: center; background-color: #bcbcbc; color: white;">
                <font size="4">Recent Poll </font>
            </div>
            [<a href="pollHistory">history</a>] 
            <security:authorize access="hasRole('ADMIN')">
                [<a href="createPoll">Create</a>]
            </security:authorize>
            <br/>
            <c:if test="${fn:length(others) <0}">
                <br/>No Poll Available
            </c:if>
            <c:if test="${fn:length(others) >0}">
                <br/><strong>Poll title: </strong>${poll.title}<br/><br/>
                &nbsp;&nbsp;A: ${poll.a}(${poll.countA})
                <security:authorize access="isAuthenticated()">
                    <c:if test="${pollAnswered == null}">
                        <input type="radio" name="answer" value="A" >
                    </c:if>
                </security:authorize>
                <br/>

                &nbsp;&nbsp;B: ${poll.b}(${poll.countB})
                <security:authorize access="isAuthenticated()">
                    <c:if test="${pollAnswered == null}">
                        <input type="radio" name="answer" value="B" >
                    </c:if>
                </security:authorize>
                <br/>

                <c:if test="${! empty poll.c}">
                    &nbsp;&nbsp;C: ${poll.c}(${poll.countC})
                    <security:authorize access="isAuthenticated()">
                        <c:if test="${pollAnswered == null}">

                            <input type="radio" name="answer" value="C" >
                        </c:if>

                    </security:authorize><br/>
                </c:if>
                <c:if test="${! empty poll.c}">  
                    &nbsp;&nbsp;D: ${poll.d}(${poll.countD})
                    <security:authorize access="isAuthenticated()">
                        <c:if test="${pollAnswered == null}">
                            <input type="radio" name="answer" value="D" >
                        </c:if>
                    </security:authorize>
                    <br/><br/>
                </c:if>
                <security:authorize access="isAuthenticated()">  
                    <c:if test="${pollAnswered == null}">
                        You can only vote once.&nbsp;&nbsp;<input type="submit" value="Vote!"/><br/>
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

            <jsp:include page="footer.jsp" />
    </body>
</html>