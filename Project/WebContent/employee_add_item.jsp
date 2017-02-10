<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/main.css">
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Add Item</title>
</head>
<body>
<%@include file="employee_header.jsp" %>
<div style="width: 1000px; height: 600px; min-height: 800px; margin: auto; background-color: #222222; color: #dddddd;font-family: sans-serif;">
<form action="ItemServlet" method="post">
<div style="width: 100%; height: 50px; float: left;">
</div>
<table style="padding: 10px; margin-left: 200px; border-collapse: collapse; width: 600px;">
<tr>
<td style="padding: 10px;   width: 200px; text-align: right;">Item Name:</td>
<td style="padding: 10px;  width: 400px;"><input type="text" name="itemName" class="itemtext" style="width: 220px;"></td>
</tr>
<tr>
<td style="padding: 10px;    width: 200px; text-align: right;">Restaurant:</td>
<td style="padding: 10px;    width: 400px;"><input type="text" name="restaurant" class="itemtext" style="width: 220px;" value="<%=session.getAttribute("empres")%>" disabled></td>
</tr>
<tr>
<td style="padding: 10px;    width: 300px; text-align: right;">Category:</td>
<td style="padding: 10px;  width: 300px;">
	<select name="category" style="width: 220px;">
		<option>Snacks</option>
		<option>Drinks</option>
		<option>Sandwiches</option>
		<option>Salads</option>
	</select>
</td>
</tr>
<tr>
<td style="padding: 10px;   width: 300px; text-align: right;">Description:</td>
<td style="padding: 10px;  width: 300px; "><textarea name="description" rows="10" cols="35"></textarea></td>
</tr>
<tr>
<td style="padding: 10px;   width: 300px; text-align: right;">Cost:</td>
<td style="padding: 10px;  width: 300px; "><input type="text" name="cost" class="itemtext"> $</td>
</tr>
<tr>
<td style="padding: 10px;   width: 300px; text-align: right;">Available:</td>
<td style="padding: 10px;  width: 300px; "><input type="checkbox" name="availability" checked="checked"></td>
</tr>
</table>
<input type="submit" name="itemAction" value="Add" style="margin: auto; background-color: #d4df38; border: 1px solid black; margin-top: 20px; height: 40px; width: 150px; margin-left: 	425px; font-size: 16px;">
</form>
</div>
<%@include file="employee_footer.jsp" %>
</body>
</html>