<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/main.css">
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Centennial College | Food</title>
</head>
<body>
<%if(session.getAttribute("placedorder")==null) { response.sendRedirect("index_home.jsp");}
if(session.getAttribute("cartCount")!=null)
{
	session.setAttribute("cartCount",0);
}
%> 
<%@include file="header.jsp" %>
<div class="content" style=" text-align: center; height: 800px;">

<h2 style="line-height: 50px;">Your order has been placed successfully! <br>
<%if(session.getAttribute("placedorder")!=null) { %> 
Your Order Number is <%=session.getAttribute("placedorder").toString()%>
<%
session.removeAttribute("placedorder");
} %><br></h2>

<% if(session.getAttribute("userid")==null) {%>
	<h3>Please keep the order number for your reference. <br>You can track your order <a href="orders.jsp">here</a>.</h3>
<%
}
else {
%>
<h3>Track your order <a href="orders.jsp">here</a>.</h3>
<%} %>
</div>
<%@include file="footer.jsp" %>
</body>
</html>