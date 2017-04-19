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
				boolean forwardEmail = request.getParameter("forwardToEmail");//forwardEmail
				boolean forwardText = request.getParameter("forwardToText");//forwardText
				boolean infoVis = request.getParameter("infoVis");
				
				Statement stmt = con.createStatement();
				String entity = (String)session.getAttribute("user");
				String str = "SELECT * FROM endUsers WHERE userID = \'" + entity +"\'";
				ResultSet result = stmt.executeQuery(str);
				
				int counter=0;
				while (result.next()) {
					counter++;
				}
				
				
				if(counter==0){
					out.print("Something went wrong. Please login again.");
					response.sendRedirect("index.html");
				}
				else{
					
					
					/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
					
					
					//add new account to database
					/*

					//Make an insert statement for the users table:
					String insert = "INSERT INTO users(userID, password, ruEmail,type) " + "VALUES (?, ?, ?, ?)";
					//Create a Prepared SQL statement allowing you to introduce the parameters of the query
					PreparedStatement ps = con.prepareStatement(insert);

					//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
					ps.setString(1, request.getParameter("username"));
					ps.setString(2, request.getParameter("password"));
					ps.setString(3, request.getParameter("email"));
					ps.setString(4, "endUser");
					//Run the query against the DB
					ps.executeUpdate();
					
					
					
					String insert2 = "INSERT INTO endUsers (userID, name, address, phoneNumber, forwardToEmail, forwardtoTest, infoVisible)" + "VALUES (?,?,?,?,?,?,?)";
					
					PreparedStatement ps2 = con.prepareStatement(insert2);
					ps2.setString(1, request.getParameter("username"));
					ps2.setString(2, request.getParameter("name"));
					ps2.setString(3, request.getParameter("address"));
					ps2.setString(4, request.getParameter("phone"));
					
					if(request.getParameter("infoVis").equals("t")) {
	                    ps2.setString(5, "1");
	                }else{
	                	ps2.setString(5, "0");
	                }
					
					out.println(request.getParameter("forwardToEmail"));
					
					if(request.getParameter("forwardToEmail")!="fEmail"){
						ps2.setString(6, "1");
					}else{
						ps2.setString(6, "0");
					}
					
					
					if(request.getParameter("forwardToTest")!="fText"){
						ps2.setString(7, "1");
					}else{
						ps2.setString(7, "0");
					}
					
					ps2.executeUpdate();
					//execute query again to check if the addition was successful
					result = stmt.executeQuery(str);
					counter=0;
					//String retrievedPass = "";
					while (result.next()) {
						counter++;
					}
					
					if(counter!=0){
						out.print("Account creation successful.");
					}
					else{
						out.print("Account creation failed?!");
					}
					
					*/
					/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
					
					
					out.println("<center>");
					out.println("Name: "+name+"<br>");
					out.println("Phone Number: "+phone+"<br>");
					out.println("Address: "+address+"<br>");
					
					out.print("Forward messages to email? ");
					if(forwardEmail)
						out.println("Yes"+"<br>");
					else
						out.println("No"+"<br>");

					out.print("Forward messages to phone text messages? ");
					if(forwardText)
						out.println("Yes"+"<br>");
					else
						out.println("No"+"<br>");

					out.print("Make information visible to other users? ");
					if(infoVis)
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