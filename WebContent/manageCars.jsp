<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Manage Registered Cars</title>
</head>
<body>
		<h1>Registered Cars</h1>
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
				String str = "SELECT * FROM car WHERE ownedBy = \'" + entity +"\'";
				ResultSet result = stmt.executeQuery(str);
				
				int counter=0;				
				out.println("<center><table style=\"width:50%\">");
				while (result.next()) {
					
					if(counter==0){
						out.println("<tr>");
						out.print("<td>"+"Car Name"+"</td>");
						out.print("<td>"+"Passenger Capacity"+"</td>");
						out.print("</tr>");
					}
					counter++;

					out.println("<tr>");
					out.print("<td>"+result.getString("carName")+"</td>");
					out.print("<td>"+result.getInt("capacity")+"</td>");
					out.print("</tr>");
					
				}
				out.println("</table>");
				if(counter==0)
					out.println("No cars found. Register one below!");
				out.println("</center>");
				con.close();

	%>


	<h1>Register a Car</h1>
        <div align="center">
            <form action="manageCarsQuery.jsp" method="post">
            	<br/>Car Name:<input type="text" name="carName">
            	<br/>Passenger Capacity:<input type="text" name="cap">
      			<br>            
            <br/><input type="submit" value="Add New Car">
            </form>
        	<br>
        	<a href="home.jsp">Return to Dashboard</a>
        </div>

</body>
</html>