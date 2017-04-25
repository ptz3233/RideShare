<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!-- Author: Zachary Iuso -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Draft</title>
</head>
<body>
	
	
	<h2>Send Message</h2>
	<form action="sendNewMessageQuery.jsp" method="post">
      	Send to:<input type="text" name="userTo"><br>
        Message:<br>
        <textarea name = "content" rows = 6></textarea><br>
        <input type="submit" value="Send"><br>
    </form>
	
	<br><br>
	<a href="home.jsp">Return to Dashboard</a>
	&nbsp;
	<a href="receivedMessages.jsp">View Inbox</a>
	&nbsp;
	<a href="sentMessages.jsp">View Outbox</a>
</body>
</html>