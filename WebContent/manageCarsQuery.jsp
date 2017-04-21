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

				
				boolean properAddName=true;
				boolean properAddCap=true;
				boolean existing=false;
				int capp=0;
				String capa="";
				if(request.getParameter("carName")==null||request.getParameter("carName").compareTo("")==0)
					properAddName=false;
				try {
			        capp=Integer.parseInt(request.getParameter("cap"));
			        capa=Integer.toString(capp);
			    }
			    catch( Exception e ) {
			        properAddCap=false;
			    }
				
				Statement stmtA = con.createStatement();
				String entityA = (String)session.getAttribute("user");
				String strA = "SELECT * FROM car WHERE ownedBy = \'" + entityA +"\' AND carName = \'" + request.getParameter("carName") +"\'";
				ResultSet resultA = stmtA.executeQuery(strA);
				
				int counterA=0;
				while (resultA.next()) {
					counterA++;
				}
				if(counterA>0){
					existing=true;
				}
				
				
				
				if(properAddName&&properAddCap&&!existing){
					String insert = "INSERT INTO car(carName, capacity, ownedBy) " + "VALUES (?, ?, ?)";
					//Create a Prepared SQL statement allowing you to introduce the parameters of the query
					PreparedStatement ps = con.prepareStatement(insert);

					//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
					ps.setString(1, request.getParameter("carName"));
					ps.setInt(2, capp);
					ps.setString(3, (String)session.getAttribute("user"));
					//Run the query against the DB
					ps.executeUpdate();
				}
				else{
					out.print("<p style=\"color:red;\">Error in submission form: ");
					if(!properAddName)
						out.print("<br>Must provide a name for the car!");
					else if(existing)
						out.print("<br>That car name is already in use!");
					if(!properAddCap)
						out.print("<br>Must provide the car's passenger capacity as an integer value! ");
					out.print("</p><br><br>");
				}
				
						
				
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
		<br><br>
        <div align="center">
            <a href="manageCars.jsp">Add Another Car</a><br><br>
        	<a href="home.jsp">Return to Dashboard</a>
        </div>

</body>
</html>