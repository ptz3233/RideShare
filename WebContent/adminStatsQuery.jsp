<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Statistics Query Result</title>
</head>
<body>
		<h1>Query Results:</h1>
		<%
				//List<String> list = new ArrayList<String>();

				//Create a connection string
				String url = "jdbc:mysql://example.cl8qfbhvsols.us-east-1.rds.amazonaws.com:3306/RideShare";
				//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
				Class.forName("com.mysql.jdbc.Driver");
				//Create a connection to your DB
				Connection con = DriverManager.getConnection(url, "root", "password");

						
				boolean first = true;				
				String user = request.getParameter("username");
				String origin = request.getParameter("origin");
				String dest = request.getParameter("dest");
				String time = request.getParameter("time");
				String timespan = request.getParameter("timespan");
				String sortType = request.getParameter("sortType");
				
				if(user==null)
					user="";
				if(origin==null)
					origin="";
				if(dest==null)
					dest="";
				if(time==null)
					time="";

				//timespan to curtail results
				
				
						
				Statement stmt = con.createStatement();
				String str = "SELECT * FROM pastRides ";
				if(user!=null&&user.compareTo("")!=0 || origin!=null&&origin.compareTo("")!=0 || dest!=null&&dest.compareTo("")!=0 || time!=null&&time.compareTo("")!=0){
					
					str+="WHERE ";
							
					if(user!=null&&user.compareTo("")!=0){
						str += "(driver = \'"+user+"\' OR passengers = \'"+user+"\') ";
						first=false;
					}
					
					
					if(origin!=null&&origin.compareTo("")!=0){
						if(first)
							first=false;
						else
							str+="AND ";
						str += "pickUpLocation = \'"+origin+"\' ";
					}
					
					
					if(dest!=null&&dest.compareTo("")!=0){
						if(first)
							first=false;
						else
							str+="AND ";
						str += "dropOffLocation = \'"+dest+"\' ";
					}
					
					
					if(time!=null&&time.compareTo("")!=0){
						if(first)
							first=false;
						else
							str+="AND ";
						str += "pickupTime = \'"+time+"\' ";
					}
				}
				str += "ORDER BY "+sortType;
				//System.out.println(str);
				ResultSet result = stmt.executeQuery(str);	

				
				int counter=0;
				out.println("<center><table style=\"width:80%\">");
				while (result.next()&&counter<50) {
					
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
					out.println("No Results");
				if(counter==50)
					out.println(">50 results found; please narrow your search.");
				out.println("</center>");
				con.close();

	%>

        <div align="center">
            <br>
        	<br>
        	<a href="adminStats.jsp">Run another query</a><br>
        	<br>
        	<a href="adminlogin.jsp">Return to Dashboard</a>
        </div>

</body>
</html>