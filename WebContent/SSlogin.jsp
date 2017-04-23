<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>System Support Dashboard</title>
</head>
<body>


<h1>System Support Dashboard</h1>


            <div align="center">
	            <form action="resetPassQuery.jsp" method="post">
	            	<div style = "font-weight: bold">Reset User Password</div>
		            User ID:<input type="text" name="username"><br>
		            <input type="submit" value="Submit"><br>
	            </form>
	            <br>
	            <form action="lockoutUserQuery.jsp" method="post">
	            	<div style = "font-weight: bold">Lock Out a User</div>
		            Username:<input type="text" name="username"><br>
		            Lock Out Time Span:<select name="timespan">
						<option value="day">Day</option>
						<option value="week">Week</option>
						<option value="month">Month</option>
						<option value="semester">Semester</option>
						<option value="year">Year</option>
						<option value="forever">Forever</option>
					</select><br>
		            <input type="submit" value="Submit"><br>
	            </form>
	            <br>
	            <form action="addAdQuery.jsp" method="post">
	            	<div style = "font-weight: bold">Add an Advertisement</div>
		            Ad Name:<input type="text" name="adname"><br>
		            Ad Buyer:<input type="text" name="buyer"><br>
		            <input type="submit" value="Submit"><br>
	            </form>
	            <br>
	            <a href="SSadverts.jsp">Manage Advertisements</a><br>
	            <a href="index.jsp">Logout</a>
			</div>

</body>
</html>