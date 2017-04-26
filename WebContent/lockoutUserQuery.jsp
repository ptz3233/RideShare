<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Locking out user</title>
</head>
<body>

<%

String user = request.getParameter("username");

Calendar now = Calendar.getInstance();

Calendar lockOutDate = Calendar.getInstance();

if(request.getParameter("timespan").equals("day")){
	
	lockOutDate.add(Calendar.DATE, 1);
	
}

if(request.getParameter("timespan").equals("week")){
	
	lockOutDate.add(Calendar.DATE, 7);
	
}

if(request.getParameter("timespan").equals("month")){
	
	lockOutDate.add(Calendar.MONTH, 1);
	
}

if(request.getParameter("timespan").equals("semester")){
	
	lockOutDate.add(Calendar.MONTH, 6);
	
}

if(request.getParameter("timespan").equals("year")){
	
	lockOutDate.add(Calendar.YEAR, 1);
	
}
if(request.getParameter("timespan").equals("forever")){
	
	lockOutDate.add(Calendar.YEAR, 1);
	
}


String url = "jdbc:mysql://example.cl8qfbhvsols.us-east-1.rds.amazonaws.com:3306/RideShare";

Class.forName("com.mysql.jdbc.Driver");

Connection con = DriverManager.getConnection(url, "root", "password");

Statement stmt = con.createStatement();

String str = "UPDATE endUsers SET lockedOutStatus=1, lockedOutTimeRemaining = ? WHERE userID = \"" + user + "\"";

PreparedStatement ps = con.prepareStatement(str);

ps.setDate(1, new java.sql.Date(lockOutDate.getTimeInMillis()));

ps.executeUpdate();

out.print("User locked out");




%>


</body>
</html>