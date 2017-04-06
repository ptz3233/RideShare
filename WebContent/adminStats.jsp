<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Statistics</title>
</head>
<body>


		<h1>Statistics</h1>

            
            <div align="center">
	            <form action="adminStatsQuery.jsp" method="post">
		            User ID (optional):<input type="text" name="username"><br>
		            Origin (optional):<input type="text" name="origin"><br>
		            Destination (optional):<input type="text" name="dest"><br>
		            Time of Day (optional):<input type="text" name="time"><br>
		            Time Span:
		            <select name="timespan">
						<option value="day">past day</option>
						<option value="month">past month</option>
						<option value="semester">past semester</option>
						<option value="year">past year</option>
					</select><br>
		            Sort By:
		            <select name="sortType">
						<option value="date">Date</option>
						<option value="username">User ID</option>
						<option value="origin">Origin</option>
						<option value="dest">Destination</option>
					</select><br>
		            <input type="submit" value="Submit"><br>
	            </form>
	            <a href="adminlogin.jsp">Cancel</a>
			</div>



</body>
</html>