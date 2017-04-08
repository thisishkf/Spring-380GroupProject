<!DOCTYPE html>
<html>
    <head>
        <title>Login | 380</title>
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
        <div>
            <c:if test="${param.error != null}">
                <p>Login failed.</p>
            </c:if>
            <c:if test="${param.logout != null}">
                <p>You have logged out.</p>
            </c:if>
            <h2>Login</h2>
            <form action="login" method="POST">
                <label for="username">Username:</label><br/>
                <input type="text" id="username" name="username" /><br/><br/>
                <label for="password">Password:</label><br/>
                <input type="password" id="password" name="password" /><br/><br/>
                <input type="checkbox" id="remember-me" name="remember-me" />
                <label for="remember-me">Remember me</label><br/><br/>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <input type="submit" value="Log In"/>
            </form>
        </div>
    </body>
</html>