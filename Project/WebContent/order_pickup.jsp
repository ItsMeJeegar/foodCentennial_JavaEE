<%@ page language="java" contentType="text/html; charset=US-ASCII" import="java.sql.*"
    pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<link rel="stylesheet" type="text/css" href="css/main.css">
<title>Order Pickup</title>
</head>
<body style="background-color: #555555; margin: 0; padding: 0;">
<%@include file="employee_header.jsp" %>

<div style="width: 1000px; height: 600px; min-height: 800px; margin: auto; background-color: #dddddd; color: black;font-family: sans-serif;">
<div style="width: 100%; height: 50px; float: left;">
</div>
<table style="width: 900px; line-height: 28px; font-size: 20px; border: 1px solid black; margin: auto;border-collapse: collapse;">
<tr style="font-weight: bolder; border: 3px solid black">
<td style="width: 200px; padding: 10px;">Order Number</td>
<td style="width: 500px; padding: 10px;">Details</td>
<td style="width: 200px; padding: 10px;">Pickup</td>
</tr>
<%

Connection conn = null;
Statement stmt = null, odstmt = null, upstmt = null;
ResultSet rs = null, od = null;
try {
	String ordersql = "select distinct orderNumber from OrderDetail where restaurant = '"+session.getAttribute("empres").toString()+"' and orderStatus='Ready!' limit 8";
	Class.forName("com.mysql.jdbc.Driver");
	
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/COMP231","root","coinage");
	odstmt = conn.createStatement();
	stmt = conn.createStatement();
	od = odstmt.executeQuery(ordersql);
		
	while(od.next()) {
%>

<%
%>



<tr style=" border: 3px solid black">
<td style=" padding: 10px;">
<%=od.getString("orderNumber")%>
</td>
<td style=" padding: 10px;">
<%
String sql = "select * from OrderDetail where orderNumber = '"+od.getString("orderNumber")+"' and restaurant = '"+session.getAttribute("empres").toString()+"'";
rs = stmt.executeQuery(sql);
while(rs.next()) {
%>
<%=rs.getString("quantity")%> <%=rs.getString("itemName")%><br>
<%
}
%>
</td>
<td style=" padding: 10px;">
<form action="OrderServlet" method="post" style="width: 150px; float: left;">
<input type="submit" name="submit" value="Picked up" style="border: 1px solid black; width: 100%; height:30px; font-size: 16px; background-color: #4adb97;">
<input type="hidden" name="restaurant" value="<%=session.getAttribute("empres").toString()%>">
<input type="hidden" name="ordernumber" value="<%=od.getString("orderNumber")%>">
<input type="hidden" name="orderAction" value="pickupStatus">
</form>
<form action="OrderServlet" method="post" style="width: 30px; float: left;">
<!-- <input type="submit" name="submit" value="X" style="border: 1px solid black; width: 100%; height:30px; font-size: 20px; background-color: #f45642;">
 --><input type="hidden" name="restaurant" value="<%=session.getAttribute("empres").toString()%>">
<input type="hidden" name="ordernumber" value="<%=od.getString("orderNumber")%>">
<input type="hidden" name="orderAction" value="cancelStatus">
</form>
</td>

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
	</tr>
</table>

</div>
<%@include file="footer.jsp" %>



</body>
</html>