<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Send a message</title>
</head>

<h1>Send a message here</h1>

 <div align="center">

 <form action="sendMsgQuery.jsp" method="post">
  To:<br>
  <input type="text" name="receiver" ><br>
	Message:
  <input type="text" name="message" size="100"><br><br>
  <input type="submit" value="Submit">
</form> 
</div>