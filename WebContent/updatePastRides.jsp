<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Moving Old Rides</title>
</head>
<body>
	<%
	
		Calendar now = Calendar.getInstance();
	
	String url = "jdbc:mysql://example.cl8qfbhvsols.us-east-1.rds.amazonaws.com:3306/RideShare";
	
	Class.forName("com.mysql.jdbc.Driver");
	
	Connection con = DriverManager.getConnection(url, "root", "password");
	
	Statement stmt = con.createStatement();
	
	String str = "SELECT * FROM Ride";
	
	ResultSet rs = stmt.executeQuery(str);
	
	String datestr = new String();
	String[] parts = new String[3];
	
	
	while(rs.next()){
		
		datestr = rs.getString("rideDate");
		
		parts = datestr.split("/");
		
		
		
		int day = Integer.parseInt(parts[0]);
		
		int month = Integer.parseInt(parts[1]);
		
		 
		int year =  Integer.parseInt(parts[2]);
		
		
		//out.println(parts[0]);
		//out.println(parts[1]);
		//out.println(parts[2]);
		
		Calendar rideDate = Calendar.getInstance();
		
		rideDate.set(year,month,day);
		
		
		if(rideDate.after(now)){
			
			Statement stmt2 = con.createStatement();
			
			String ins = "INSERT INTO pastRides(rideDate, pickUpTime, pickUpLocation, dropOffLocation, driver, passengers, carName)  SELECT rideDate, pickUpTime, pickUpLocation, dropOffLocation, driver, passengers, carName FROM Ride WHERE rideID = " + Integer.toString(rs.getInt("rideID"));
			
			stmt2.executeUpdate(ins);
			
			String delrequest = ("DELETE FROM Ride WHERE rideID = ?");
			PreparedStatement del1 = con.prepareStatement(delrequest);

			
			del1.setString(1, Integer.toString(rs.getInt("rideID")));
			del1.executeUpdate();
			
		}

		
		
	}
		
		
		%>