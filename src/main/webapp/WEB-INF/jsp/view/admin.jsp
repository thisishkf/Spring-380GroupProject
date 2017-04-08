<!DOCTYPE html>
<html>
    <head>
        <title>Admin | 380</title>
    </head>
    <body>
        <jsp:include page="menu.jsp" />
        <h2>Admin panel</h2>
        
        <table>
            <tr>
                <th>User Name</th><th>Password</th><th>Status</th>
                <th></th><th></th><th></th><th></th>
            </tr>
            <c:forEach var="user" items="${users}">
                <tr>
                    <td>${user.name}</td>
                    <td>${user.password}</td>
                    <td>${user.status}</td>
                    <td><a href="deleteUser?name=${user.name}">Delete</a></td>
                    <td><a href="banUser?name=${user.name}">Ban</a></td>
                    <td><a href="unbanUser?name=${user.name}">UnBan</a></td>
                    <td><a href="editUser?name=${user.name}">Edit</a></td>
                </tr>
            </c:forEach>
        </table>
    </body>
</html>