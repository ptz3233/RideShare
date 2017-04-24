<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Leaderboard</title>
</head>
<body>
		<h1>Top 100 Users</h1>
		<%
				//List<String> list = new ArrayList<String>();

				//Create a connection string
				String url = "jdbc:mysql://example.cl8qfbhvsols.us-east-1.rds.amazonaws.com:3306/RideShare";
				//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
				Class.forName("com.mysql.jdbc.Driver");
				//Create a connection to your DB
				Connection con = DriverManager.getConnection(url, "root", "password");

				Statement stmt = con.createStatement();
				String entity = (String)session.getAttribute("user");
				String str = "SELECT AVG(rating), ratedUser FROM userFeedback GROUP BY ratedUser ORDER BY AVG(rating) DESC";
				ResultSet result = stmt.executeQuery(str);
				
				int counter=0;				
				out.println("<center><table style=\"width:60%\">");
				while (result.next()&&counter<101) {
					
					if(counter==0){
						out.println("<tr>");
						out.print("<td>"+"Rank"+"</td>");
						out.print("<td>"+"Username"+"</td>");
						out.print("<td>"+"Rating"+"</td>");
						out.print("</tr>");
					}
					counter++;

					out.println("<tr>");
					out.print("<td>"+counter+"</td>");
					out.print("<td>"+result.getString(2)+"</td>");
					out.print("<td>"+result.getInt(1)+"</td>");
					out.print("</tr>");
					
				}
				out.println("</table>");
				if(counter==0)
					out.println("No one has been rated yet. <a href=\"rateRides.jsp\">Maybe you can be the first?</a>");
				out.println("</center>");
				con.close();

	%>

        <div align="center">
            <br>
        	<br>
        	<a href="home.jsp">Return to Dashboard</a>
        </div>

</body>
</html>