<div class="menu" style="background-color: antiquewhite; padding: 5px;margin-bottom: 10px">
    <div style="position: relative; float: right;">
        <security:authorize access="isAuthenticated()">
            <c:url var="logoutUrl" value="/logout"/>
            <form action="${logoutUrl}" method="post">
                <input type="submit" value="Log out" />
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            </form>
        </security:authorize>
    </div>
    <div style="position: relative; float: left;">
        <div style="clear: both"></div>
        <ul>
            <li>
                <a href="home">Home</a>
            </li>
            <security:authorize access="!isAuthenticated()">
                <li style="border-left: 1px solid white">
                    <a href="register">Register</a>
                </li>
                <li style="border-left: 1px solid white">
                    <a href="login">Login</a>
                </li>
            </security:authorize>
            <security:authorize access="hasRole('ADMIN')">
                <li style="border-left: 1px solid white">
                    <a href="admin">Admin</a>
                </li>
            </security:authorize>
        </ul>
    </div>
    <div style="clear: both;"></div>
</div>
