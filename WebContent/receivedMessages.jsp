<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!-- Author: Zachary Iuso -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style>
table{
	border-collapse: collapse;
	width: 100%;
	layout: fixed;
} 
th{
	text-align: left;
}
tr:nth-child(even) {
	background-color: #dddddd;
}
td.col{
	word-break: break-all;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Inbox</title>
</head>
<body>
	
	
	<h3>Received Messages</h3>
	<%
		//Create a connection string
		String url = "jdbc:mysql://example.cl8qfbhvsols.us-east-1.rds.amazonaws.com:3306/RideShare";
		//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
		Class.forName("com.mysql.jdbc.Driver");
		//Create a connection to your DB
		Connection con = DriverManager.getConnection(url, "root", "password");
		
		Statement stmt = con.createStatement();
		String entity = (String)session.getAttribute("user");
		String str = "SELECT * FROM messages WHERE userTo = \'" + entity +"\' ORDER BY timeSent DESC";
		ResultSet result = stmt.executeQuery(str);
		
		int counter=0;	
		out.println("<table>");
		while (result.next()) {
			
			if(counter==0){
				out.println("<tr>");
				out.print("<th>"+"From"+"</th>");
				out.print("<th>"+"Message"+"</th>");
				out.print("<th>"+"Date Sent"+"</th>");
				out.print("</tr>");
			}
			counter++;

			out.println("<tr>");
			out.print("<td width = \"20%\">"+result.getString("userFrom")+"</td>");
			out.print("<td width = \"60%\">"+result.getString("content")+"</td>");
			out.print("<td width = \"20%\">"+result.getTimestamp("timeSent")+"</td>");
			out.print("</tr>");
			
		}
		out.println("</table>");
		
		if(counter==0)
			out.println("No received messages.\n");
		con.close();
	%>
	<br><br>
	<a href="home.jsp">Return to Dashboard</a>
	&nbsp;
	<a href="sentMessages.jsp">View Outbox</a>
	&nbsp;
	<a href="sendNewMessage.jsp">Send a new message</a>
</body>
</html>