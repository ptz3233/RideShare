<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Rate and Comment on Past Rides</title>
</head>
<body>


<h1>Past Rides</h1>
		<%

				//Create a connection string
				String url = "jdbc:mysql://example.cl8qfbhvsols.us-east-1.rds.amazonaws.com:3306/RideShare";
				//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
				Class.forName("com.mysql.jdbc.Driver");
				//Create a connection to your DB
				Connection con = DriverManager.getConnection(url, "root", "password");

				Statement stmt = con.createStatement();
				String entity = (String)session.getAttribute("user");
				String str = "SELECT * FROM pastRides WHERE driver = \'" + entity +"\' OR passengers LIKE \'%" + entity +"%\'";
				ResultSet result = stmt.executeQuery(str);
				
				int counter=0;
				out.println("<center><table style=\"width:80%\">");
				while (result.next()&&counter<15) {
					
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
					out.print("<td>"+result.getString("rideDate")+"</td>");
					out.print("<td>"+result.getString("pickUpTime")+"</td>");
					out.print("<td>"+result.getString("driver")+"</td>");
					out.print("<td>"+result.getString("passengers")+"</td>");
					out.print("<td>"+result.getString("pickUpLocation")+"</td>");
					out.print("<td>"+result.getString("dropOffLocation")+"</td>");
					out.print("</tr>");				
					
					
				}
				out.println("</table>");
				if(counter==0)
					out.println("You have not participated in any rides yet!");
				out.println("</center>");
				con.close();

	%>

	<h1>See Ratings and Comments for a User (including yourself)</h1>
        <div align="center">
            <form action="userRatings.jsp" method="post">
            	<br/>User (see Usernames from above chart):<input type="text" name="user">
            <br/><input type="submit" value="See Ratings and Comments">
            </form>
        	<br>
        	<a href="home.jsp">Return to Dashboard</a>
        </div>


	<h1>Rate and Comment on a Past Ride</h1>
        <div align="center">
            <form action="rateRidesQuery.jsp" method="post">
            	<br/>User (see Usernames from above chart):<input type="text" name="use">
            	<br/>Rating (from 1 to 5 (lowest to highest)):<input type="text" name="rate">
            	<br/>Comments (optional):<input type="text" name="com">
      			<br>            
            <br/><input type="submit" value="Add New Comment">
            </form>
        	<br>
        	<a href="home.jsp">Return to Dashboard</a>
        </div>


</body>
</html>