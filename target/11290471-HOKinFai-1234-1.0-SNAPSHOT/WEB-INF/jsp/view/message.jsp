<!--
    Created on  : Mar 29, 2017, 10:32:48 PM
    Author      : Ho Kin Fai, Wong Tak Ming, Chow wa wai
    Project     : comps380f
    Purpose     : Lecture Index Page
-->
<!DOCTYPE html>
<html>
    <head>
        <title>Messages | 380</title>
    </head>
    <body>
        <c:url var="logoutUrl" value="/logout"/>
        <form action="${logoutUrl}" method="post">
            <input type="submit" value="Log out" />
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </form>
        <div style="text-align: left; background-color: #DCDCDC; color: black;">    
        <h2>Message</h2>
        </div>



        <ul>
            <li>
                ID : <c:out value="${topic.topic_id}" escapeXml="true" /><br />
                Title:  <c:out value="${topic.title}" escapeXml="true" /><br />
                Category: <c:out value="${topic.category}" escapeXml="true" /><br />
            </li>
        </ul>

    </body>
</html>