<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User Dashboard</title>
</head>
<body>


<!-- out.println(session.getAttribute("user")); -->
<h1>User Dashboard</h1>

<div align="center">

	<a href="manageAccount.jsp">Manage Account</a>
	&nbsp;
	<a href="manageCars.jsp">Manage Registered Cars</a>
	&nbsp;
	<a href="userStats.jsp">User Statistics</a>
	&nbsp;
	<a href="messages.jsp">Messages</a>
	&nbsp;
	<a href="index.jsp">Logout</a>
	
	<br><br>
	<%
		//Create a connection string
		String url = "jdbc:mysql://example.cl8qfbhvsols.us-east-1.rds.amazonaws.com:3306/RideShare";
		//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
		Class.forName("com.mysql.jdbc.Driver");
		//Create a connection to your DB
		Connection con = DriverManager.getConnection(url, "root", "password");
					
		Statement stmt = con.createStatement();
		String str = "SELECT * FROM ads ORDER BY RAND() LIMIT 1";
		ResultSet result = stmt.executeQuery(str);
		while(result.next()){
			out.print("<h3>"+result.getString("adMessage")+"</h3>");
			out.print("*advertisement*"+"<br>");

			//increment timesDisplayed
			int timesDisplayed = (int)result.getInt("timesDisplayed") + 1;
			String str2 = "UPDATE ads SET timesDisplayed = " + timesDisplayed + " WHERE adName = \'" + result.getString("adName") + "\' AND buyer = \'" + result.getString("buyer") + "\'";
			//out.print(str2);
			Statement stmt2 = con.createStatement();
			stmt2.executeUpdate(str2);
		}
		con.close();
	%>
	<br><br>
	
	
	<h1>Upcoming Rides</h1>
		<%

				//Create a connection string
				String url2 = "jdbc:mysql://example.cl8qfbhvsols.us-east-1.rds.amazonaws.com:3306/RideShare";
				//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
				Class.forName("com.mysql.jdbc.Driver");
				//Create a connection to your DB
				Connection con2 = DriverManager.getConnection(url2, "root", "password");

				Statement stmt2 = con2.createStatement();
				String entity = (String)session.getAttribute("user");
				String str2 = "SELECT * FROM Ride WHERE driver = \'" + entity +"\' OR passengers LIKE \'%" + entity +"%\'";
				ResultSet result2 = stmt2.executeQuery(str2);
				
				int counter=0;
				out.println("<center><table style=\"width:80%\">");
				while (result2.next()&&counter<15) {
					
					if(counter==0){
						out.println("<tr>");
						out.print("<td>"+"Date"+"</td>");
						out.print("<td>"+"Time"+"</td>");
						out.print("<td>"+"Driver"+"</td>");
						out.print("<td>"+"Passengers"+"</td>");
						out.print("<td>"+"Pickup Location"+"</td>");
						out.print("<td>"+"Dropoff Location"+"</td>");
						out.print("</tr>");
					}
					counter++;

					out.println("<tr>");
					out.print("<td>"+result2.getString("rideDate")+"</td>");
					out.print("<td>"+result2.getString("pickUpTime")+"</td>");
					out.print("<td>"+result2.getString("driver")+"</td>");
					out.print("<td>"+result2.getString("passengers")+"</td>");
					out.print("<td>"+result2.getString("pickUpLocation")+"</td>");
					out.print("<td>"+result2.getString("dropOffLocation")+"</td>");
					out.print("</tr>");				
					
					
				}
				out.println("</table>");
				out.println("<br><br>");
				if(counter==0)
					out.println("You have no upcoming rides.");
				out.println("</center>");
				con.close();

	%>
	
	<a href="scheduledRideRequests.jsp">See All Scheduled Requested Rides</a>
	<br>
	<a href="scheduledRideOffers.jsp">See All Scheduled Offered Rides</a>
	<br>
	<a href="rideRequests.jsp">Request a Ride</a>
	<br>
	<a href="rideOffers.jsp">Offer a Ride</a>
	<br>
	<a href="rateRides.jsp">Rate and Comment on Past Rides</a>
	
</div>



</body>
</html>