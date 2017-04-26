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
				
						
	String findOffer = ("SELECT  * FROM rideOffers ORDER BY offerID DESC LIMIT 1");			
	Statement stmt = con.createStatement();
	
	ResultSet rs = stmt.executeQuery(findOffer);
	
	String offerDate = new String();
	String pickUpTime = new String();
	String pickUpLocation = new String();
	String dropOffLocation = new String();
	String driver= new String();
	String carName = new String();
	String oID = new String();
	Boolean recurring = false;
	 while (rs.next()) {
          offerDate = rs.getString("offerDate");
       pickUpTime = rs.getString("pickUpTime");
          pickUpLocation = rs.getString("pickUpLocation");
          dropOffLocation = rs.getString("dropOffLocation");
          driver = rs.getString("driver");
          carName = rs.getString("carName");
          oID = Integer.toString(rs.getInt("offerID"));
          recurring = rs.getBoolean("recurring");
     }
	
	String findMatch = "SELECT * from rideRequest r WHERE  r.requestDate = \"" + offerDate + "\" AND r.pickUpTime =\"" +pickUpTime + "\" AND r.dropOffLocation = \"" + dropOffLocation +  "\" and r.pickUpLocation = \"" + pickUpLocation +"\"";
	//out.println(findMatch);
	
	Statement stmt2 = con.createStatement();
	
	ResultSet r2= stmt2.executeQuery(findMatch);
	//out.println(r2.getString("requester"));
	
	
	while (r2.next()){
		
		if(recurring==true && r2.getBoolean("recurring")== true){
			String newRides = new String();
			
			for(int i = 0; i<5; i++){
				newRides = "INSERT INTO Ride (rideDate, pickUpTime, pickUpLocation, driver, passengers, carName, dropOffLocation)" + "VALUES(?,?,?,?,?,?,?)";
				PreparedStatement ps = con.prepareStatement(newRides);
				ps.setString(1, offerDate);
				ps.setString(2, pickUpTime);
				ps.setString(3, pickUpLocation);
				ps.setString(4, driver);
				ps.setString(5, r2.getString("requester"));
				ps.setString(6, carName);
				ps.setString(7, dropOffLocation);
				
				ps.executeUpdate();
				
				String[] parts = offerDate.split("/");
				
				int days = Integer.parseInt(parts[1]);
				
				days = days+7;
				
				if(days>31){
					days = days - 31;
					int month = Integer.parseInt(parts[0]);
					month++;
					parts[0] = Integer.toString(month);
					
				}
				parts[1] = Integer.toString(days);
								
				offerDate = parts[0] + "/" + parts[1] + "/" + parts[2];
			}
			
			
		}else{
		
		
		String newRide = "INSERT INTO Ride (rideDate, pickUpTime, pickUpLocation, driver, passengers, carName, dropOffLocation)" + "VALUES(?,?,?,?,?,?,?)";
		PreparedStatement ps = con.prepareStatement(newRide);
		ps.setString(1, offerDate);
		ps.setString(2, pickUpTime);
		ps.setString(3, pickUpLocation);
		ps.setString(4, driver);
		ps.setString(5, r2.getString("requester"));
		ps.setString(6, carName);
		ps.setString(7, dropOffLocation);
		
		ps.executeUpdate();
		
	}
		String rID = Integer.toString(r2.getInt("requestID"));
		String delrequest = ("DELETE FROM rideRequest WHERE requestID = ?");
		PreparedStatement del1 = con.prepareStatement(delrequest);

		
		del1.setString(1, rID);
		del1.executeUpdate();
		
		
		String deloffer = ("DELETE FROM rideOffers WHERE offerID = ?");
		PreparedStatement del2 = con.prepareStatement(deloffer);
		
		
		
		
		del2.setString(1, oID);
		del2.executeUpdate();
		
	}
	
	

	out.println("Offer succesfully submitted. Updated match databse.");
	

	

	%>
	        
	        
	        
	        
	        
	        
	        
	        
	        