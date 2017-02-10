<%@ page language="java" contentType="text/html; charset=US-ASCII" import="java.sql.*"
    pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/main.css">
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Centennial College | Food</title>
</head>
<body>
<%@include file="header.jsp" %>
<div class = "content" style="widt: auto;">

<%

int itemId = 2;
if(request.getParameter("itemId")!=null) {
	itemId = Integer.parseInt(request.getParameter("itemId"));
}
%>
<%
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	float subTotal = 0;
	String userId = "";
	String userType = "";
	try {
		String sql = "select * from Item where itemId = "+itemId;
		Class.forName("com.mysql.jdbc.Driver");
		
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/COMP231","root","coinage");
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);
		
		while(rs.next()) {
			%>
			
			
			
			<div style="width:1000px; height: 400px; float: left; margin-top: 0px; background-color: #dddddd;">
		<div style="width: 300px; height: 400px; float: left; float: left;">
			<div style="width: 300px; height: 300px; float: left; float: left;">
				<img alt="no.png" src="<%=rs.getString("itemPicture")%>" style="background-color: white; width: 250px; height: 250px; border: 1px solid black; margin: 25px;">
			</div>
			<div style="width: 300px; height: 100px; float: left; float: left;">
			<% 
			if(rs.getString("availability").equals("Available")) {
			%>
			<form action="CartServlet" method="post">
			<input type="hidden" name="itemId" value="<%=itemId%>">
			<input type="hidden" name="cartAction" value="insert">
			<input type="submit" class="new-button" value="Add to cart" style="width: 180px; font-size: 20px; height: 50px; margin-left: 25px; margin-top: 25px;">
			<select name="quantity" style="width: 50px; height: 50px; margin-bottom: 25px; margin-left: 15px;">
				<option value="1">1</option>
				<option value="2">2</option>
				<option value="3">3</option>
				<option value="4">4</option>
				<option value="5">5</option>
			</select>
			</form>
			<% 
			}
			else if(rs.getString("availability").equals("Not Available")) {
			%>
			
 			<%
			}
			%>
			
			</div>
		</div>
		<div style="width: 700px; height: 400px; float: left; float: left; ">
			<div style="width: 660px; height: 110px; float: left; padding-left: 20px; float: left; margin-top: 25px; border-bottom: 1px solid black;">
			<x style="font-size: 24px; font-weight: bolder; line-height: 30px; "><%=rs.getString("itemName")%></x><br>
			<x style="font-size: 14px; line-height: 16px;"><%=rs.getString("restaurant")%></x><br><br>
			<x style="font-size: 16px; line-height: 26px;">Price: <strong>$ <%=rs.getString("cost")%></strong></x><br>
			
			<% 
			if(rs.getString("availability").equals("Available")) {
			%>
			
			<x style="font-size: 16px; font-weight: bold; color: green;  line-height: 16px;"><%=rs.getString("availability")%></x>
			
			<% 
			}
			else if(rs.getString("availability").equals("Not Available")) {
			%>
			
 
			
				<x style="font-size: 16px; font-weight: bold; color: red;  line-height: 16px;"><%=rs.getString("availability")%></x>
			<%
			}
			%>
			
			</div>
			<div style="width: 660px; height: 250px;padding: 20px; float: left; float: left;">
			<%=rs.getString("description")%>
			</div>
			</div>
		</div>
			<%
			
			subTotal++;
			
		}
		rs.close();
		stmt.close();
		conn.close();
	} 
	catch (Exception e) 
	{
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	%>
	<%
	if(subTotal==0) {
		%>
		<div style="width:100%; height:50px; margin-top: 50px; font-size: 20px; text-align: center;">There are no items in your cart.
		<br>View all the items <a href="fooditems.jsp" style="text-decoration: none;">here</a>.</div>
		<%
	}
	
	%>
	
	
	
		
	</div>
</div>
<%@include file="footer.jsp" %>
</body>
</html>