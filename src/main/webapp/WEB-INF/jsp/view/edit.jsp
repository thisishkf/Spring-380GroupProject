<!DOCTYPE html>
<html>
    <head>
        <title>Edit | 380</title>
    </head>
    <body>

        <h1>Topic #${topic.topic_id}</h1>
        
        <form action="edit" method="POST">
            <table>
                <tr>
                    <td>Title</td>
                    <td><input type="text" id="title" name="title" value="${topic.title}"/></td>
                </tr>
                <tr><td>Category</td><td><input type="text" id="Category" name="Category" value="${topic.category}"/></td></tr>
                <tr><td>Owner</td><td>${topic.username}</td></tr>
                <tr><td></td><td><input type="submit" value="Change"/></td></tr>
            </table>
            
        </form>
       
    </body>
</html>