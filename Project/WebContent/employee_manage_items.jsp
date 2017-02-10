<%@ page language="java" contentType="text/html; charset=US-ASCII" import="java.sql.*"
    pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/main.css">
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Manage Items</title>
</head>
<body style="background-color: #555555; margin: 0; padding: 0;">
<%@include file="employee_header.jsp" %>

<div style="width: 1000px; height: 600px; min-height: 800px; margin: auto; overflow:auto; background-color: #222222; color: #dddddd;font-family: sans-serif;">
<div style="width: 100%; height: 80px; float: left;">
<form action="employee_add_item.jsp">
<input type="submit" name="submit" value="Add Item"  style="background-color: #d4df38; border: 1px solid black; margin-left: 50px; margin-top: 20px; height: 40px; width: 150px; font-size: 16px;">
</form>
</div>
<table style="width: 900px; line-height: 28px; font-size: 20px; border: 1px solid black; margin: auto;border-collapse: collapse;">
<tr style="font-weight: bolder; border: 2px solid #dddddd">
<td style="width: 80px; padding: 10px;">Item ID</td>
<td style="width: 180px; padding: 10px;">Item Name</td>
<td style="width: 120px; padding: 10px;">Picture</td>
<td style="width: 200px; padding: 10px;">Availability</td>
<td style="width: 70px; padding: 10px;">Cost</td>
<td style="width: 75px; padding: 10px;"></td>
<td style="width: 75px; padding: 10px;"></td>
</tr>
<%

Connection conn = null;
Statement stmt = null, odstmt = null, upstmt = null;
ResultSet rs = null, od = null;
try {
	String ordersql = "select * from Item where restaurant = '"+session.getAttribute("empres").toString()+"'";
	Class.forName("com.mysql.jdbc.Driver");
	
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/COMP231","root","coinage");
	odstmt = conn.createStatement();
	stmt = conn.createStatement();
	od = odstmt.executeQuery(ordersql);
		
	while(od.next()) {
%>

<%
%>



<tr style=" border: 2px solid #dddddd">
<td style=" padding: 10px;">
<%=od.getString("itemId")%>
</td>
<td style=" padding: 10px;">
<%=od.getString("itemName")%>
</td>
<td>
<img alt="" src="<%=od.getString("itemPicture")%>" style="width:90px; width: 90px;padding: 5px;">
</td>
<td>
<form action="ItemServlet" method="post">
<select name="availability">
<%if(od.getString("availability").equals("Available")){%>
<option selected="selected" name="availability">Available</option>
<option>Not Available</option>
<%}
else{%>
<option selected="selected" name="availability">Not Available</option>
<option>Available</option>
<%}%>
</select>
<input type="hidden" name="itemId" value="<%=od.getString("itemId")%>">
<input type="submit" name="itemAction" value="Change">
</form>
</td>
<td>$ <%=od.getString("cost")%></td>
<td style=" padding: 10px;">
<form action="employee_edit_item.jsp">
<input type="hidden" name="id" value="<%=od.getString("itemId")%>">
<input type="submit" name="submit" value="Edit">
</form></td>
<td style=" padding: 10px;">
<form action="ItemServlet" method="post">
<input type="hidden" name="itemId" value="<%=od.getString("itemId")%>">
<input type="submit" name="itemAction" value="Remove">
</form>
</td>
</tr>

<%
}
	rs.close();
	od.close();
	odstmt.close();
	stmt.close();
	conn.close();	
}
catch(Exception sqle) {
	
}
%>
	
</table>

</div>

<%@include file="employee_footer.jsp" %>
</body>
</html>