<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Message</title>
</head>
<body>
	<%
	
		if(request.getParameter("userTo").compareTo("")==0)
			out.print("Must provide a message recipient!\n");
		else if (request.getParameter("content").length() > 1023)
			out.print("Message exceeds the maximum length!\n");
	
		//Create a connection string
		String url = "jdbc:mysql://example.cl8qfbhvsols.us-east-1.rds.amazonaws.com:3306/RideShare";
		//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
		Class.forName("com.mysql.jdbc.Driver");
		//Create a connection to your DB
		Connection con = DriverManager.getConnection(url, "root", "password");
	
		Statement stmt = con.createStatement();
		String entity = request.getParameter("userTo");
		String str = "SELECT * FROM users WHERE userID = \'" + entity +"\'";
		ResultSet result = stmt.executeQuery(str);
		
		if (!result.next())
			out.print("That recipient does not exist!\n");
		
		else{
								
			String userTo = request.getParameter("userTo");
			String content = request.getParameter("content");
			String userFrom = (String)session.getAttribute("user");

	        java.text.SimpleDateFormat df = new java.text.SimpleDateFormat("MM/dd/yyyy HH:mm:ss");
	        java.util.Date now = new java.util.Date();
	        String timeSent = df.format(now);
			
			//Make an insert statement for the users table:
			String insert = "INSERT INTO messages(userFrom, userTo, content, timeSent) " + "VALUES (?, ?, ?, ?)";
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(insert);

			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps.setString(1, userFrom);
			ps.setString(2, userTo);
			ps.setString(3, content);
			ps.setTimestamp(4, new java.sql.Timestamp(Calendar.getInstance().getTime().getTime()));
			//Run the query against the DB
			ps.executeUpdate();
			
			out.print("Message sent.");
			con.close();
		}
	%>
	<br>
	<a href="sendNewMessage.jsp">Back</a>
	<br>
	<a href="home.jsp">Dashboard</a>
	<br>
	<a href="messages.jsp">Messages</a>
</body>
</html>