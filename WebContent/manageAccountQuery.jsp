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

	<h1>New Account Settings</h1>
	<%
				//List<String> list = new ArrayList<String>();

				//Create a connection string
				String url = "jdbc:mysql://example.cl8qfbhvsols.us-east-1.rds.amazonaws.com:3306/RideShare";
				//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
				Class.forName("com.mysql.jdbc.Driver");
				//Create a connection to your DB
				Connection con = DriverManager.getConnection(url, "root", "password");

				
				String name = request.getParameter("name");//name
				String phone = request.getParameter("phone");//phoneNumber
				String address = request.getParameter("address");//address
				String forwardEmail = "";//forwardEmail
				String forwardText = "";//forwardText
				String infoVis = "";
				
				boolean fEmail = false;
				boolean fText = false;
				boolean iVis = false;
				
				
				if(request.getParameter("name")==null)
					name="";
				if(request.getParameter("phone")==null)
					phone="";
				if(request.getParameter("address")==null)
					address="";
				
				if(request.getParameter("forwardToEmail")!=null)
					fEmail = true;
				
				if(request.getParameter("forwardToText")!=null)
					fText = true;
				
				if(request.getParameter("infoVis").equals("t"))
					iVis = true;
				
				
				
					String query = "UPDATE endUsers SET name = ?, address = ?, phoneNumber = ?, forwardToEmail = ?, forwardToTest = ?,  infoVisible = ? WHERE userID = ?";
				    PreparedStatement preparedStmt = con.prepareStatement(query);
				    preparedStmt.setString(1, name);
				    preparedStmt.setString(2, address);
				    preparedStmt.setString(3, phone);
				    preparedStmt.setBoolean(4, fEmail);
				    preparedStmt.setBoolean(5, fText);
				    preparedStmt.setBoolean(6, iVis);
				    preparedStmt.setString(7, (String)session.getAttribute("user"));
				    preparedStmt.executeUpdate();
					
					
				    
				    Statement stmt = con.createStatement();
					String entity = (String)session.getAttribute("user");
					String str = "SELECT * FROM endUsers WHERE userID = \'" + entity +"\'";
					ResultSet result = stmt.executeQuery(str);
				    
				    int counter=0;					
					while (result.next()) {
						counter++;
						name = result.getString("name");
						phone = result.getString("phoneNumber");
						address = result.getString("address");
						forwardEmail = result.getString("forwardToEmail");
						forwardText = result.getString("forwardToTest");
						infoVis = result.getString("infoVisible");
					}
					if(counter==0){
						out.print("Something went wrong. Please login again.");
						response.sendRedirect("index.html");
					}
					else{
						out.println("<center>");
						out.println("Name: "+name+"<br>");
						out.println("Phone Number: "+phone+"<br>");
						out.println("Address: "+address+"<br>");
						
						out.print("Forward messages to email? ");
						if(forwardEmail.compareTo("1")==0)
							out.println("Yes"+"<br>");
						else
							out.println("No"+"<br>");

						out.print("Forward messages to phone text messages? ");
						if(forwardText.compareTo("1")==0)
							out.println("Yes"+"<br>");
						else
							out.println("No"+"<br>");

						out.print("Make information visible to other users? ");
						if(infoVis.compareTo("1")==0)
							out.println("Yes"+"<br>");
						else
							out.println("No"+"<br>");
						out.println("</center>");
						out.println();
					}
				
				//close the connection.
				con.close();

		
	%>

	<div align="center">
		<a href="home.jsp">Return to Dashboard</a>
	</div>


</body>
</html>