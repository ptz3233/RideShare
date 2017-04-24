<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User Statistics</title>
</head>
<body>

<h1>User Statistics</h1>
		<%


				//Create a connection string
				String url = "jdbc:mysql://example.cl8qfbhvsols.us-east-1.rds.amazonaws.com:3306/RideShare";
				//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
				Class.forName("com.mysql.jdbc.Driver");
				//Create a connection to your DB
				Connection con = DriverManager.getConnection(url, "root", "password");

				Statement stmt = con.createStatement();
				String entity = (String)session.getAttribute("user");
				String str = "SELECT * FROM endUsers WHERE userID = \'" + entity +"\'";
				ResultSet result = stmt.executeQuery(str);
				

				int counter=0;
				int rating=0;
				int ridesGiven=0;//name
				int ridesGivenM=0;//name
				int ridesGivenS=0;//name
				float cash=0;//phoneNumber
				String val="";
				
				while (result.next()) {
					counter++;
					ridesGiven = result.getInt("ridesGiven");
					ridesGivenM = result.getInt("ridesGivenPerMonth");
					ridesGivenS = result.getInt("ridesGivenPerSemester");
					cash = result.getFloat("cashEarned");
				}
				
				
				if(counter==0){
					out.print("Something went wrong. Please login again.");
					response.sendRedirect("index.html");
				}
				else{
					
					
					//second query to get rating
					Statement stmtA = con.createStatement();
					String strA = "SELECT AVG(rating) FROM userFeedback WHERE ratedUser = \'" + entity +"\'";
					ResultSet resultA = stmt.executeQuery(strA);
					
					
					
					while (resultA.next()) {
						val = resultA.getString(1);
					}
					
					out.println("<center>");
					out.print("User rating: ");
					if(val!=null)
						out.println(val+"<br>");
					else
						out.println("no ratings recieved"+"<br>");					
					
					out.println("Rides Given: "+ridesGiven+"<br>");
					out.println("    Per Month: "+ridesGivenM+"<br>");
					out.println("    Per Semester: "+ridesGivenS+"<br>");

					out.println("</center>");
					out.println();
					
					
				}
				//close the connection.
				con.close();

		
	%>


        <div align="center">
            <br>
        	<a href="leaderboard.jsp">View Leaderboard</a>
        	<br><br>
        	<a href="home.jsp">Return to Dashboard</a>
        </div>

</body>
</html>