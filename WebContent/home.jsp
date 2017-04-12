<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
	[insert some kind of advertisement here]
	<br><br>
	
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