<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create Result</title>
</head>
<body>
	<%
		List<String> list = new ArrayList<String>();
	



	if(request.getParameter("username").compareTo("")==0||request.getParameter("password").compareTo("")==0||request.getParameter("username").length()>20||request.getParameter("password").length()>20|| request.getParameter("conpassword").compareTo(request.getParameter("password"))!=0){
			if(request.getParameter("username").compareTo("")==0 ){
				out.print("Must provide a username to create account!\n");
			}
			else if(request.getParameter("username").length()>20){
				out.print("Username cannot exceed 20 characters in length!");
			}
			if(request.getParameter("password").compareTo("")==0){
				out.print("Must provide a password to create account!\n");
			}
			else if(request.getParameter("password").length()>20){
				out.print("Password cannot exceed 20 characters in length!");
			}
			if(request.getParameter("email").compareTo("")==0){
				out.print("Must provide a email to create account!\n");
			}
			if(request.getParameter("conpassword").compareTo(request.getParameter("password"))!=0){
				out.print("Passwords must match.\n");
			}

		}
	
		else{
			//try {

				//Create a connection string
				String url = "jdbc:mysql://example.cl8qfbhvsols.us-east-1.rds.amazonaws.com:3306/RideShare";
				//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
				Class.forName("com.mysql.jdbc.Driver");
				//Create a connection to your DB
				Connection con = DriverManager.getConnection(url, "root", "password");

				Statement stmt = con.createStatement();
				String entity = request.getParameter("username");
				String entity2 = request.getParameter("password");
				String entity3 = request.getParameter("email");
				String entity4 = request.getParameter("conpassword");
				String str = "SELECT * FROM users WHERE userID = \'" + entity +"\'";
				ResultSet result = stmt.executeQuery(str);

				int counter=0;
				while (result.next()) {
					counter++;
				}
				
				
				if(counter!=0){
					out.print("That username already exists!");
				}
				else{


					//add new account to database
					

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
	                    ps2.setBoolean(7, true);
	                }else{
	                	ps2.setBoolean(7, false);
	                }
					
					//out.println(request.getParameter("forwardToEmail"));
					
					if(request.getParameter("forwardToEmail")==null){
						ps2.setBoolean(5, false);
					}else{
						ps2.setBoolean(5, true);
					}
					
					
					if(request.getParameter("forwardToTest")==null){
						ps2.setBoolean(6, false);
					}else{
						ps2.setBoolean(6, true);
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
					out.println("<br><a href=\"index.jsp\">Return to Login page</a>");
					
				}
				
				//close the connection.
				con.close();

			//} catch (Exception e) {
				
			//out.println("An error occured.");
			//}
		}
		
	%>

</body>
</html>