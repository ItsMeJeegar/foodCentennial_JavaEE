<%@ page language="java" contentType="text/html; charset=US-ASCII" import="java.sql.*"
    pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">

<title>Employee | Food</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body style="background-color: #555555; margin: 0; padding: 0;">
<%@include file="employee_header.jsp" %>

<div style="width: 1000px; height: 600px; min-height: 800px; margin: auto; background-color: #222222;font-family: monospace;">
<div style="width: 100%; height: 50px; background-color: #222222; float: left;"></div>

<%

Connection conn = null;
Statement stmt = null, odstmt = null, upstmt = null;
ResultSet rs = null, od = null;
try {
	String ordersql = "select distinct orderNumber from OrderDetail where restaurant = '"+session.getAttribute("empres").toString()+"' and orderStatus!='Ready!' and orderStatus!='Cancelled' limit 8";
	Class.forName("com.mysql.jdbc.Driver");
	
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/COMP231","root","coinage");
	odstmt = conn.createStatement();
	stmt = conn.createStatement();
	upstmt = conn.createStatement();
	od = odstmt.executeQuery(ordersql);
		
	while(od.next()) {
%>

<%
%>
<div style="width: 238px; height: 300px; background-color: #222222; float: left; color: #dddddd; font-size: 18px; font-weight: bold;padding: 5px; border: 1px solid #dddddd;">
<div style="width: 238px; height: 40px; font-size: 24px; line-height: 38px; float: left;  border-bottom: 2px solid #dddddd;">OD: <%=od.getString("orderNumber")%></div>
<div style="width: 238px; height: 220px; float: left;">

<%
String sql = "select * from OrderDetail where orderNumber = '"+od.getString("orderNumber")+"' and restaurant = '"+session.getAttribute("empres").toString()+"'";
rs = stmt.executeQuery(sql);
while(rs.next()) {
%>
<%=rs.getString("quantity")%> x <%=rs.getString("itemName")%><br>
<%
upstmt.executeUpdate("update OrderDetail set orderStatus = 'Preparing' where orderDetailId="+rs.getString("orderDetailId"));
}
%>

</div>
<div style="width: 238px; height: 30px; float: left;">
<form action="OrderServlet" method="post" style="width: 190px; float: left;">
<input type="submit" name="submit" value="Done" style="border: 1px solid black; width: 100%; height:30px; font-size: 20px; font-family: monospace; background-color: #4adb97;">
<input type="hidden" name="restaurant" value="<%=session.getAttribute("empres").toString()%>">
<input type="hidden" name="ordernumber" value="<%=od.getString("orderNumber")%>">
<input type="hidden" name="orderAction" value="updateStatus">
</form>
<form action="OrderServlet" method="post" style="width: 30px; float: left;">
<input type="submit" name="submit" value="X" style="border: 1px solid black; width: 100%; height:30px; font-size: 20px; font-family: monospace; background-color: #f45642;">
<input type="hidden" name="restaurant" value="<%=session.getAttribute("empres").toString()%>">
<input type="hidden" name="ordernumber" value="<%=od.getString("orderNumber")%>">
<input type="hidden" name="orderAction" value="cancelStatus">
</form>
</div>
</div>

<%
}
	
rs.close();
stmt.close();
conn.close();
}
catch(Exception sqle) {
	
}
%>


</div>
<%@include file="employee_footer.jsp" %>



</body>
</html>