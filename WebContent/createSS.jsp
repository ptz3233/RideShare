<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create a System Support Account</title>
</head>
<body>

		<h1>Create a System Support Account</h1>

            
            <div align="center">
	            <form action="createSSQuery.jsp" method="post">
		            User ID:<input type="text" name="username"><br>
		            RU email:<input type="text" name="email"><br>
		            Password:<input type="password" name="password"><br>
		            Confirm Password:<input type="password" name="passwordC"><br>
		            <input type="submit" value="Submit"><br>
	            </form>
	            <a href="adminlogin.jsp">Cancel</a>
			</div>


</body>
</html>