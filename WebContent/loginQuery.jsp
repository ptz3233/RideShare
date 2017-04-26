<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login Result</title>
</head>
<body>
	<%
		List<String> list = new ArrayList<String>();

		if(request.getParameter("username").compareTo("")==0||request.getParameter("password").compareTo("")==0){
			if(request.getParameter("username").compareTo("")==0){
				out.print("Must provide a username to login!\n");
			}
			if(request.getParameter("password").compareTo("")==0){
				out.print("Must provide a password to login!\n");
			}			
		}
	
		else{
			

				//Create a connection string
				String url = "jdbc:mysql://example.cl8qfbhvsols.us-east-1.rds.amazonaws.com:3306/RideShare";
				//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
				Class.forName("com.mysql.jdbc.Driver");
				//Create a connection to your DB
				Connection con = DriverManager.getConnection(url, "root", "password");

				Statement stmt = con.createStatement();
				String entity = request.getParameter("username");
				String entity2 = request.getParameter("password");
				String str = "SELECT * FROM users WHERE userID = \'" + entity +"\'";
				ResultSet result = stmt.executeQuery(str);
				//out.println(str);
				int counter=0;
				String retrievedPass = null;
				String userStatus = null;
				while (result.next()) {
					counter++;
					retrievedPass = result.getString("password");
					userStatus = result.getString("type");
				}
				
				
				if(counter==0){
					out.print("That username does not exist!");
					response.sendRedirect("loginFail.html");
				}
				
				else if(entity2.compareTo(retrievedPass)!=0){
					out.print("Wrong password.");
					return;
				}
				else{
					session.setAttribute("user", request.getParameter("username"));
				
				
				//System.out.print(userStatus);
				
				if(userStatus.compareTo("endUser")==0){
					String finduser = "SELECT * from endUsers WHERE userID = \"" + request.getParameter("username") + "\"";
					//System.out.println(finduser);
					Statement stmt2 = con.createStatement();
					ResultSet rs2 = stmt2.executeQuery(finduser);
					
					rs2.next();
					
					if(rs2.getBoolean("lockedOutStatus")==true){
						java.sql.Date lockdate = rs2.getDate("lockedOutTimeRemaining");
						
						Calendar now = Calendar.getInstance();
						Calendar lock = Calendar.getInstance();
						
						lock.setTime(lockdate);
						
						if(now.after(lock)){
							String unlock = "UPDATE endUsers SET lockedOutStatus=0 WHERE userID = \"" + request.getParameter("username") + "\"";
							Statement stmt3 = con.createStatement();
							stmt3.executeUpdate(unlock);
							
							
							response.sendRedirect("home.jsp");
							
						}else{
							out.print("You are locked out");
						}
						
						
						
					}else{
					
					
					
					
					response.sendRedirect("home.jsp");
					}
				}else if(userStatus.compareTo("admin")==0){
					response.sendRedirect("adminlogin.html");
				}else if(userStatus.compareTo("systemSupport")==0){
					response.sendRedirect("SSlogin.jsp");
				}
				}
				//close the connection.
				con.close();

			
		}
		
	%>

</body>
</html>