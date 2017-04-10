<!DOCTYPE html>
<html>
    <head>
        <title>Create Topic | 380</title>
    </head>
    <body>
        <c:url var="logoutUrl" value="/logout"/>
        <form action="${logoutUrl}" method="post">
            <input type="submit" value="Log out" />
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </form>

        <h1>Create a Topic</h1>

        <form action="add" method="POST">
            <table>
                <tr><td>Title</td>
                    <td><input type="text" id="title" name="title" required placeholder="Enter a Topic title"/>
                    </td></tr>
                <tr><td></td><td><input type="submit" value="Change"/></td></tr>
            </table>

        </form>
    </body>
</html>