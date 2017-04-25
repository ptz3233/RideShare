<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Manage Account Results</title>
</head>
<body>
<h1>Result:</h1>

<%

				//check if fields are null/incorrect
				//check if name exists in chart
				//insert query
	

				//Create a connection string
				String url = "jdbc:mysql://example.cl8qfbhvsols.us-east-1.rds.amazonaws.com:3306/RideShare";
				//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
				Class.forName("com.mysql.jdbc.Driver");
				//Create a connection to your DB
				Connection con = DriverManager.getConnection(url, "root", "password");

	
				boolean properAddName=true;
				boolean properAddRate=true;
				boolean properRate=true;
				boolean existingName=true;
				boolean notYou=true;
				int rating=0;
				String rateStr="";
				
				if(request.getParameter("use")==null||request.getParameter("use").compareTo("")==0)
					properAddName=false;
				else if(request.getParameter("use").compareTo((String)session.getAttribute("user"))==0)
					notYou=false;
				
				try {
			        rating=Integer.parseInt(request.getParameter("rate"));
			        rateStr=Integer.toString(rating);
			    }
			    catch( Exception e ) {
			        properAddRate=false;
			    }
				if(rating<1||rating>5){
					properRate=false;
				}
				

				Statement stmtA = con.createStatement();
				String entityA = request.getParameter("use");
				String strA = "SELECT * FROM pastRides WHERE driver = \'" + entityA +"\' OR passengers = \'%" + entityA +"%\'";
				ResultSet resultA = stmtA.executeQuery(strA);
				
				int counterA=0;
				while (resultA.next()) {
					counterA++;
				}
				if(counterA>0){
					existingName=false;
				}
				
				
				
				if(properAddName && properAddRate && properRate && existingName && notYou){
					String insert = "INSERT INTO userFeedback(ratingUser, ratedUser, rating, feedbackComment) " + "VALUES (?, ?, ?, ?)";
					//Create a Prepared SQL statement allowing you to introduce the parameters of the query
					PreparedStatement ps = con.prepareStatement(insert);

					//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
					ps.setString(1, (String)session.getAttribute("user"));
					ps.setString(2, request.getParameter("use"));
					ps.setInt(3, rating);
					ps.setString(4, request.getParameter("com"));
					ps.executeUpdate();
					
					out.print("<center><p>");
					out.print("<br>Rating and Comment successfully submitted!!");
					out.print("</p></center><br><br>");
					
				}
				else{
					out.print("<center><p style=\"color:red;\">Error in submission form: ");
					if(!properAddName)
						out.print("<br>You must provide the name of a user you want to rate!");
					else if(!notYou)
						out.print("<br>You cannot rate yourself!");
					else if(!existingName)
						out.print("<br>You have not participated in a ride with that user!");
					if(!properAddRate||!properRate)
						out.print("<br>Rating must be an integer between 1 and 5!");
					out.print("</p></center><br><br>");
				}

				con.close();

	%>

	<br><br>
        <div align="center">
            <a href="rateRides.jsp">Rate Another Ride</a><br><br>
        	<a href="home.jsp">Return to Dashboard</a>
        </div>


</body>
</html>