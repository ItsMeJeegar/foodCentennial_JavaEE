<%@ page language="java" contentType="text/html; charset=US-ASCII" import="java.sql.*"
    pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<link rel="stylesheet" type="text/css" href="css/main.css">
<title>Edit Item</title>
</head>
<body>
<%@include file="employee_header.jsp" %>
<div style="width: 1000px; height: 600px; min-height: 800px; margin: auto; background-color: #222222; color: #dddddd;font-family: sans-serif;">

<%
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
String itemId = request.getParameter("id");
try {
	String sql = "select * from Item where itemId="+itemId;
	Class.forName("com.mysql.jdbc.Driver");
	
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/COMP231","root","coinage");
	stmt = conn.createStatement();
	rs = stmt.executeQuery(sql);

	while(rs.next()) {
		%>
		<form action="ItemServlet" method="post">
<div style="width: 100%; height: 50px; float: left;">
</div>
<table style="padding: 10px; margin-left: 200px; border-collapse: collapse; width: 600px;">
<tr>
<td style="padding: 10px;   width: 200px; text-align: right;">Item Name:</td>
<td style="padding: 10px;  width: 400px;"><input type="text" name="itemName" class="itemtext" value="<%=rs.getString("itemName")%>" style="width: 220px;"></td>
</tr>
<tr>
<td style="padding: 10px;    width: 200px; text-align: right;">Picture:</td>
<td style="padding: 10px;    width: 400px;">
<%
session.setAttribute("pictureItemId", rs.getString("itemId"));
%>
<a style=" color: white;" href="employee_update_picture.jsp?itemName=<%=rs.getString("itemName")%>">Change</a>
</td>
</tr>
<tr>
<td style="padding: 10px;    width: 200px; text-align: right;">Restaurant:</td>
<td style="padding: 10px;    width: 400px;"><input type="text" name="restaurant" class="itemtext" style="width: 220px;" value="<%=session.getAttribute("empres")%>" disabled></td>
</tr>
<tr>
<td style="padding: 10px;    width: 300px; text-align: right;">Category:</td>
<td style="padding: 10px;  width: 300px;">
	<select name="category" style="width: 220px;">
		<option <%if(rs.getString("category").equals("Snacks")) {%> selected="selected"<%} %>>Snacks</option>
		<option <%if(rs.getString("category").equals("Drinks")) {%> selected="selected"<%} %>>Drinks</option>
		<option <%if(rs.getString("category").equals("Salads")) {%> selected="selected"<%} %>>Snacks</option>
		<option <%if(rs.getString("category").equals("Sandwiches")) {%> selected="selected"<%} %>>Sandwiches</option>
	</select>
</td>
</tr>
<tr>
<td style="padding: 10px;   width: 300px; text-align: right;">Description:</td>
<td style="padding: 10px;  width: 300px; "><textarea name="description" rows="10" cols="35"><%=rs.getString("description")%></textarea></td>
</tr>
<tr>
<td style="padding: 10px;   width: 300px; text-align: right;">Cost:</td>
<td style="padding: 10px;  width: 300px; "><input type="text" name="cost" value="<%=rs.getString("cost")%>" class="itemtext"> $</td>
</tr>
</table>
<input type="hidden" name="itemId" value="<%=rs.getString("itemId")%>">
<input type="submit" name="itemAction" value="Update" style="margin: auto; background-color: #d4df38; border: 1px solid black; margin-top: 20px; height: 40px; width: 150px; margin-left: 	425px; font-size: 16px;">
</form>


	
		<%
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
</div>
<%@include file="employee_footer.jsp" %>
</body>
</html>