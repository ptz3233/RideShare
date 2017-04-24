<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>New Advertisement</title>
</head>
<body>
	<%
	
		if(request.getParameter("adname").compareTo("")==0||request.getParameter("buyer").compareTo("")==0){
			if(request.getParameter("adname").compareTo("")==0){
				out.print("Must provide a name for the advertisement!\n");
			}
			if(request.getParameter("buyer").compareTo("")==0){
				out.print("Must provide the advertisement's buyer!\n");
			}			
		}
		
		else{
			//Create a connection string
			String url = "jdbc:mysql://example.cl8qfbhvsols.us-east-1.rds.amazonaws.com:3306/RideShare";
			//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
			Class.forName("com.mysql.jdbc.Driver");
			//Create a connection to your DB
			Connection con = DriverManager.getConnection(url, "root", "password");

					
			Statement stmt = con.createStatement();
			String entity = request.getParameter("adname");
			String entity2 = request.getParameter("buyer");
			String entity3 = request.getParameter("message");
			
			//Make an insert statement for the users table:
			String insert = "INSERT INTO ads(adName, buyer, adMessage, timesDisplayed) " + "VALUES (?, ?, ?, ?)";
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(insert);

			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps.setString(1, entity);
			ps.setString(2, entity2);
			ps.setString(3, entity3);
			ps.setInt(4, 0);
			//Run the query against the DB
			ps.executeUpdate();
			
			out.print("Advertisement added to database<br><a href=\"SSlogin.jsp\">Return to Dashboard</a>");
			con.close();
		}
	%>
</body>
</html>