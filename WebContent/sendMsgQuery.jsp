<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Sending</title>
</head>
<body>
	<%
	

	String sender = session.getAttribute("user").toString();
	String message = request.getParameter("message");
	String receiver = request.getParameter("receiver");
	
	
	String url = "jdbc:mysql://example.cl8qfbhvsols.us-east-1.rds.amazonaws.com:3306/RideShare";
	
	Class.forName("com.mysql.jdbc.Driver");
	
	Connection con = DriverManager.getConnection(url, "root", "password");
	
	
	
	Statement stmt = con.createStatement();
	
	String str = "INSERT INTO messages(userFrom, userTo, content,isNew )  VALUES(?,?,?,1)";
	PreparedStatement ps = con.prepareStatement(str);
	
	ps.setString(1,sender);
	ps.setString(2, receiver);
	ps.setString(3, message);
	
	ps.executeUpdate();
	
	con.close();
	
	out.print("Message sent");
	
	%>