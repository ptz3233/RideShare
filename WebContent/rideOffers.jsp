<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Ride Offers</title>
</head>
<body>

<h1>Offer a ride here</h1>
        <div align="center">
            <h2>Ride offer</h2>
            <form action="offerQuery.jsp" method="post">
            <br/>Date: (Format: MM/DD/YYYY)<input type="text" name="date">
            <br/>Time: (Format: HH:MM AM/PM)<input type="text" name="time">
            <br/>Pick up location: <select name="pickUpLocation">
 	 			<option value="Cook">Cook</option>
 				 <option value="Douglass">Douglass</option>
  				<option value="College Ave.">College Ave.</option>
 				 <option value="Livingston">Livingston</option>
 				 <option value="Busch">Busch</option>
				</select>
            <br/>Drop off location<select name="dropOffLocation">
 	 			<option value="Cook">Cook</option>
 				 <option value="Douglass">Douglass</option>
  				<option value="College Ave.">College Ave.</option>
 				 <option value="Livingston">Livingston</option>
 				 <option value="Busch">Busch</option>
				</select>
            <br/>Car Name:<input type "text" name="carName">
            <br>
            <input type="checkbox" name="recurring" value="Recurring">Recurring Request?<br>
            <br/><input type="submit" value="Submit">
            </form>
        
        </div>







</body>
</html>