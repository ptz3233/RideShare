<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Offer</title>
</head>
<body>
	<%
	String date = request.getParameter("date");
	String time = request.getParameter("time");
	String pickUpLocation = request.getParameter("pickUpLocation");
	String dropOffLocation = request.getParameter("dropOffLocation");

	String requester = session.getAttribute("user").toString();
	
	
	
	String url = "jdbc:mysql://example.cl8qfbhvsols.us-east-1.rds.amazonaws.com:3306/RideShare";
	
	Class.forName("com.mysql.jdbc.Driver");
	
	Connection con = DriverManager.getConnection(url, "root", "password");
	
	
	
	Statement stmt = con.createStatement();
	
	String str = "SELECT * FROM rideRequest";
	
	ResultSet result = stmt.executeQuery(str);
	int id =0;
	
	while (result.next()) {
		id++;
	}
	
	
	id++;
	
	String insert = "INSERT INTO rideRequest(requestID, requestDate, pickUpTime,pickUpLocation, dropOffLocation,requester) " + "VALUES (?, ?, ?, ?,?,?)";
	PreparedStatement ps = con.prepareStatement(insert);
	
	ps.setInt(1, id);
	
	
	
	ps.setString(2, date);
	
	ps.setString(3, time);
	
	ps.setString(4, pickUpLocation);
	
	ps.setString(5, dropOffLocation);
	
	ps.setString(6, requester);
	

	
	ps.executeUpdate();
	
	con.close();
	
	out.print("Request succesfully submitted");
	
	
	
	
	
	
	%>