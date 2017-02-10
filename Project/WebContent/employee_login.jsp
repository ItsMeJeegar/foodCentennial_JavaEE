<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/main.css">
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title></title>
</head>
<%
if(session.getAttribute("empid")!=null) {
	response.sendRedirect("employee_orders.jsp");
}
%>
<body style="background-color: #555555; margin: 0; padding: 0;">
<div style="width: 100%; height: 100px; float: left; background-color: #222222; border-bottom: 2px solid #d4df38;">
<div class="hdr-inner">
			<img src="logo.svg" height="60" style="background-color: #505050; margin-top: 15px; float: left; ">
						
			<br>
			<h2 style="color: white; float: left; margin-left: 250px;">Employee Login</h2>
			</div>
</div>
<div style="color: white; width: 1000px; height: 800px; margin: auto; background-color: #222222;">
<div style="width: 100%; height: 100px; background-color: green;"></div>
<div style="width: 350px; height: 250px;  margin:auto;">
<div style="width: 100%; height: 50px;"></div>
<form action="EmployeeServlet" method="post">
<table>
<tr><td style="padding: 5px; width: 150px;">Centennial ID:</td><td style="padding: 5px;"><input type="text" name="empid" style="height: 24px; font-size: 18px;"></td></tr>
<tr><td style="padding: 5px;">Password:</td><td style="padding: 5px;"><input type="password" name="emppass" style="height: 24px; font-size: 18px;"></td></tr>
</table>
<br>
<input type="submit" name="employeeAction" value="Log In" style="background-color: #d4df38; border: 1px solid black; margin-left: 120px; height: 30px; width: 100px; font-size: 16px;">

</form>
<%if(request.getAttribute("emplogin")!=null && request.getAttribute("emplogin").equals("fail")) {%>
<script type="text/javascript">
alert("Invalid ID / Password");
</script>
<%} %>
</div>
</div>

<div style="width: 100%; height: 100px; float: left; background-color: #dddddd; border-top: 2px solid #d4df38;">

</div>



</body>
</html>