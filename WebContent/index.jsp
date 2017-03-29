<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>



<html>
    <head>
        <title>RideShare Home</title>
    </head>
    <body>
        <h1>RideShare Home</h1>
        <center>
            <h2>Login Below</h2>
            <form action="loginQuery.jsp" method="post">
            <br/>Username:<input type="text" name="username">
            <br/>Password:<input type="password" name="password">
            <br/><input type="submit" value="Submit">
            </form>
            <a href="reg.jsp">Register Here</a></td>
            <a href="forgot.jsp">Forgot Password?</a>
        </center>
    </body>
</html>