<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Manage Account</title>
</head>
<body>
		<h1>Current Account Settings</h1>
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
				String str = "SELECT * FROM endUsers WHERE userID = \'" + entity +"\'";
				ResultSet result = stmt.executeQuery(str);
				
				int counter=0;
				String name = null;//name
				String phone = null;//phoneNumber
				String address = null;//address
				boolean forwardEmail = false;//forwardEmail
				boolean forwardText = false;//forwardText
				boolean infoVis = false; //infoVisible
				
				while (result.next()) {
					counter++;
					name = result.getString("name");
					phone = result.getString("phoneNumber");
					address = result.getString("address");
					forwardEmail = result.getBoolean("forwardToEmail");
					forwardText = result.getBoolean("forwardToTest");
					infoVis = result.getBoolean("infoVisible");
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


	<h1>Manage Account Settings</h1>
        <div align="center">
            <form action="manageAccountQuery.jsp" method="post">
            	<br/>Name (optional):<input type="text" name="name">
            	<br/>Phone Number (optional):<input type="text" name="phone">
				<br/>Address (optional):<input type ="text" name ="address">
      			<br>
				<input type="checkbox" name="forwardToEmail" value="fEmail">Forward messages to email<br>
				<input type="checkbox" name="forwardToText" value="fText">Forward messages to phone text messages<br> 
				<br>
			  	<input type="radio" name="infoVis" value="t" checked> Make info visible to other users.<br>
 				<input type="radio" name="infoVis" value="f"> Don't make info visible to other users.<br>
            
            <br/><input type="submit" value="Change Settings">
            </form>
        	<br>
        	<a href="home.jsp">Return to Dashboard</a>
        </div>

</body>
</html>