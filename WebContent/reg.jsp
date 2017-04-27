<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Registration</title>
</head>
<body>
	<h1>Register Here</h1>
        <div align="center">
            <h2>Registration</h2>
            <form action="regQuery.jsp" method="post">
            <br/>Username:<input type="text" name="username">
            <br/>RU Email:<input type="text" name="email">
            <br/>Password:<input type="password" name="password">
            <br/>Confirm Password:<input type="password" name="conpassword">
            <br/>Name (optional):<input type="text" name="name">
            <br/>Phone Number (optional):<input type="text" name="phone">
			<br/>Address (optional):<input type ="text" name ="address">
      		<br>
			<input type="checkbox" name="forwardToEmail" value="fEmail">Forward messages to email<br>
			<input type="checkbox" name="forwardToTest" value="fText">Forward messages to phone text messages<br> 
			<br>
			  <input type="radio" name="infoVis" value="t" checked> Make info visible to other users.<br>
  <input type="radio" name="infoVis" value="f"> Don't make info visible to other users.<br>
            
            <br/><input type="submit" value="Submit">
            </form>
        
        </div>





</body>
</html>