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
<%
String itemId = "1";
String itemName = "";
if(request.getParameter("itemName")==null) {
	response.sendRedirect("employee_manage_items.jsp");
}
else {

	itemName = request.getParameter("itemName").toString();
}
%>
<%@include file="employee_header.jsp" %>
<div style="width: 1000px; height: 600px; min-height: 800px; margin: auto; background-color: #222222; color: #dddddd;font-family: sans-serif;">
<form action="PictureUploadServlet" method="post" enctype="multipart/form-data">
<div style="width: 900px; height: 100px; float: left; margin-left: 50px; text-align: center; color: #eeeeee; font-size: 18px;">
<br>Update the picture for the item <%=itemName%>
</div>
<table style="padding: 10px; margin-left: 200px; border-collapse: collapse; width: 600px;">
<tr>
<td style="padding: 10px;   width: 300px; text-align: right;">Item Picture:</td>
<td style="padding: 10px;  width: 300px;"><input type="file" name="file" class="itemtext" style="width: 220px;" accept="image/x-png,image/gif,image/jpeg" /></td>
</tr>

</table>
<input type="hidden" name="itemId" value="<%=itemId%>">
<input type="submit" name="itemAction" value="Update Picture" style="margin: auto; background-color: #d4df38; border: 1px solid black; margin-top: 20px; height: 40px; width: 150px; margin-left: 	425px; font-size: 16px;">
</form>
</div>
<%@include file="employee_footer.jsp" %>
</body>
</html>