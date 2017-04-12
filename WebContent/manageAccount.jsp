<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Manage Account</title>
</head>
<body>
	
	<%String registration = "10-120";
	request.setAttribute("registration", registration);%>
	<h1>Manage Account</h1>
        <div align="center">
            <form action="manageAccountQuery.jsp" method="post">
            	<br/>Name (optional):<input type="text" name="name"  value="${user}">
            	<br/>Phone Number (optional):<input type="text" name="phone">
				<br/>Address (optional):<input type ="text" name ="address">
      			<br>
				<input type="checkbox" name="forwardToEmail" value="fEmail">Forward messages to email<br>
				<input type="checkbox" name="forWardToTest" value="fText">Forward messages to phone text messages<br> 
				<br>
			  	<input type="radio" name="infoVis" value="t"> Make info visible to other users.<br>
 				 <input type="radio" name="infoVis" value="f"> Don't make info visible to other users.<br>
            
            <br/><input type="submit" value="Submit">
            </form>
        
        </div>

</body>
</html>