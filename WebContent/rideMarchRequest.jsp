<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Matching Rides</title>
</head>
<body>
	<%
	
	//if an offer matches a request made
	String url = "jdbc:mysql://example.cl8qfbhvsols.us-east-1.rds.amazonaws.com:3306/RideShare";
				
				Class.forName("com.mysql.jdbc.Driver");
				
				Connection con = DriverManager.getConnection(url, "root", "password");
				
						
	String findRequest = ("SELECT  * FROM rideRequest ORDER BY requestID DESC LIMIT 1");			
	Statement stmt = con.createStatement();
	
	ResultSet rs = stmt.executeQuery(findRequest);
	
	String requestDate = new String();
	String pickUpTime = new String();
	String pickUpLocation = new String();
	String dropOffLocation = new String();
	String requester= new String();
	
	String rID = new String();
	
	 while (rs.next()) {
          requestDate = rs.getString("requestDate");
       pickUpTime = rs.getString("pickUpTime");
          pickUpLocation = rs.getString("pickUpLocation");
          dropOffLocation = rs.getString("dropOffLocation");
          requester = rs.getString("requester");
          rID = Integer.toString(rs.getInt("requestID"));
     }
	
	String findMatch = "SELECT * from rideOffers r WHERE  r.offerDate = \"" + requestDate + "\" AND r.pickUpTime =\"" +pickUpTime + "\" AND r.dropOffLocation = \"" + dropOffLocation +  "\" and r.pickUpLocation = \"" + pickUpLocation +"\"";
	//out.println(findMatch);
	
	Statement stmt2 = con.createStatement();
	
	ResultSet r2= stmt2.executeQuery(findMatch);
	//out.println(r2.getString("requester"));
	
	
	while (r2.next()){
		
		String newRide = "INSERT INTO Ride (rideDate, pickUpTime, pickUpLocation, driver, passengers, carName, dropOffLocation)" + "VALUES(?,?,?,?,?,?,?)";
		PreparedStatement ps = con.prepareStatement(newRide);
		ps.setString(1, requestDate);
		ps.setString(2, pickUpTime);
		ps.setString(3, pickUpLocation);
		ps.setString(4, r2.getString("driver"));
		ps.setString(5, requester);
		ps.setString(6, r2.getString("carName"));
		ps.setString(7, dropOffLocation);
		String oID = Integer.toString(r2.getInt("offerID"));
		ps.executeUpdate();
		String delrequest = ("DELETE FROM rideRequest WHERE requestID = ?");
		PreparedStatement del1 = con.prepareStatement(delrequest);

		
		del1.setString(1, rID);
		del1.executeUpdate();
		
		
		String deloffer = ("DELETE FROM rideOffers WHERE offerID = ?");
		PreparedStatement del2 = con.prepareStatement(deloffer);
		
		
		
		
		del2.setString(1, oID);
		del2.executeUpdate();
		
	}
	String findMatchRide = "Select * from Ride r WHERE  r.rideDate = \"" + requestDate + "\" AND r.pickUpTime =\"" +pickUpTime + "\" AND r.dropOffLocation = \"" + dropOffLocation +  "\" and r.pickUpLocation = \"" + pickUpLocation +"\" LIMIT 1";
	
	Statement stmt3 = con.createStatement();
	
	ResultSet r3 = stmt3.executeQuery(findMatchRide);
	String appendC = new String();
	int rideid;
	while(r3.next()){
		rideid = r3.getInt("rideID");
		
		Statement stmt4 = con.createStatement();
		appendC = "UPDATE Ride set passengers = concat (passengers, \" " + requester + "\" ) where rideID = " +Integer.toString(rideid);
		
		stmt4.executeUpdate(appendC);
		String delrequest = ("DELETE FROM rideRequest WHERE requestID = ?");
		PreparedStatement del1 = con.prepareStatement(delrequest);

		
		del1.setString(1, rID);
		del1.executeUpdate();
		
		
		
	}

	out.println("Request succesfully submitted. Ride match database updated");
	

	

	%>
	        
	        
	        
	        
	        
	        
	        
	        
	        