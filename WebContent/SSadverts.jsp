<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
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
<title>Advertisement Database</title>
</head>
<body>
	<h1>Advertisement Database</h1>
	
	<%
		//Create a connection string
		String url = "jdbc:mysql://example.cl8qfbhvsols.us-east-1.rds.amazonaws.com:3306/RideShare";
		//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
		Class.forName("com.mysql.jdbc.Driver");
		//Create a connection to your DB
		Connection con = DriverManager.getConnection(url, "root", "password");
		
		Statement stmt = con.createStatement();
		String str = "SELECT * FROM ads ORDER BY buyer, adName";
		ResultSet result = stmt.executeQuery(str);
		
		int counter=0;	
		out.println("<center><table>");
		while (result.next()) {
			
			if(counter==0){
				out.println("<tr>");
				out.print("<th>"+"Ad Name"+"</th>");
				out.print("<th>"+"Owner"+"</th>");
				out.print("<th>"+"Message"+"</th>");
				out.print("<th>"+"Times Displayed"+"</th>");
				out.print("</tr>");
			}
			counter++;

			out.println("<tr>");
			out.print("<td width = \"20%\">"+result.getString("adName")+"</td>");
			out.print("<td width = \"20%\">"+result.getString("buyer")+"</td>");
			out.print("<td width = \"50%\">"+result.getString("adMessage")+"</td>");
			out.print("<td width = \"10%\">"+result.getInt("timesDisplayed")+"</td>");
			out.print("</tr>");
			
		}
		out.println("</table><br>");
		
		
		if(counter==0)
			out.println("No ads found.");
		out.println("</center>");
		con.close();
	%>
	<a href="SSlogin.jsp">Return to Dashboard</a>
		

</body>
</html>