<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User Ratings and Comments</title>
</head>
<body>
		<h1>User Ratings and Comments</h1>
		<%
				//List<String> list = new ArrayList<String>();

				//Create a connection string
				String url = "jdbc:mysql://example.cl8qfbhvsols.us-east-1.rds.amazonaws.com:3306/RideShare";
				//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
				Class.forName("com.mysql.jdbc.Driver");
				//Create a connection to your DB
				Connection con = DriverManager.getConnection(url, "root", "password");

						
				Statement stmtA = con.createStatement();
				String strA = "SELECT AVG(rating) FROM userFeedback where ratedUser = \'" + request.getParameter("user") +"\'";
				ResultSet resultA = stmtA.executeQuery(strA);	
				
				while (resultA.next()) {
					int avg = resultA.getInt(1);
					out.print("<br>Average Rating for user "+request.getParameter("user")+" is "+avg+"<br><br><br>");
					
				}
						
				
				Statement stmt = con.createStatement();
				String entity = (String)session.getAttribute("user");
				String str = "SELECT * FROM userFeedback where ratedUser = \'" + request.getParameter("user") +"\'";
				ResultSet result = stmt.executeQuery(str);
				
				int counter=0;				
				out.println("<center><table style=\"width:80%\">");
				while (result.next()&&counter<101) {
					
					if(counter==0){
						out.println("<tr>");
						out.print("<td>"+"Rating User"+"</td>");
						out.print("<td>"+"Rating"+"</td>");
						out.print("<td>"+"Comment"+"</td>");
						out.print("</tr>");
					}
					counter++;

					out.println("<tr>");
					out.print("<td>"+result.getString("ratingUser")+"</td>");
					out.print("<td>"+result.getInt("rating")+"</td>");
					out.print("<td>"+result.getString("feedbackComment")+"</td>");
					out.print("</tr>");
					
				}
				out.println("</table>");
				if(counter==0)
					out.println("No one has rated this user yet.");
				out.println("</center>");
				con.close();

	%>

        <div align="center">
            <br>
        	<br><a href="rateRides.jsp">Rate a Ride from this User</a><br><br>
        	<a href="home.jsp">Return to Dashboard</a>
        </div>

</body>
</html>