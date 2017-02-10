<%@ page language="java" contentType="text/html; charset=US-ASCII" import="java.sql.*"
    pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/main.css">
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Centennial College | Food</title>
</head>
<body style="font-family: sans-serif;">
<%@include file="header.jsp" %>
<div class="content">
<div style="width: 1000px; height: 50px; float: left;">
	<h2 style="margin-left: 50px;">CART</h2>
</div>
<div style="width: 1000px; height: 50px; float: left;">
	<h3 style="margin-left: 50px; color: red; ">
	<% 
	if(request.getAttribute("cartMessage")!=null)
		out.println(request.getAttribute("cartMessage").toString());
	int c = 0;
	%>
	</h3>
</div>
<div style="width: 1000px; height: auto; min-height: 500px; float: left;">

	<% 
	int count = 0;
	if(session.getAttribute("cartCount")==null)
	{
		session.setAttribute("cartCount", 0);
		count = 0;
	}
	else {
		count = Integer.parseInt(session.getAttribute("cartCount").toString());
	}
	if(session.getAttribute("cartCount")!=null && count > 0) 
	{
	%>
	<table style="border: 1px solid #bbbbbb; color: #333333; text-align:center; background-color: #e0e0e0; width: 900px; margin-left: 50px; margin-top: 20px; border-collapse: collapse;">
		<tr>
			<td colspan="2" style="border-bottom: 1px solid #bbbbbb; width: 400px; padding: 10px;"><b>ITEM</b></td>
			<td style="border: 1px solid #bbbbbb; width: 80px; padding: 5px;"><b>PRICE</b></td>
			<td style="border: 1px solid #bbbbbb; width: 180px; padding: 5px;"><b>QUANTITY</b></td>
			<td style="border: 1px solid #bbbbbb; width: 110px; padding: 5px;"><b>SUBTOTAL</b></td>
			<td colspan="2" style="border: 1px solid #bbbbbb; width: 100px; padding: 5px;"><b></b></td>
			
		</tr>
	<%
	}		
	%>
	
		<%
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	float subTotal = 0;
	String userId = "";
	String userType = "";
	
	if(session.getAttribute("userid")==null) 
	{
		userType="guest";
		userId=session.getAttribute("guestid").toString();
	}
	else {
		userType = "member";
		userId=session.getAttribute("userid").toString();
	}
	
	try {
		String sql = "select * from cart where userId='"+userId+"' and userType = '"+userType+"'";
		Class.forName("com.mysql.jdbc.Driver");
		
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/COMP231","root","coinage");
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);
		
		while(rs.next()) {
			c++;
			%>
		
		<tr>
			<td style="border-bottom: 1px solid #bbbbbb; width: 150px; padding: 5px;">
				<img alt="no.png" src="<%=rs.getString("itemPicture")%>" style="width: 100px; height: 100px;">
			</td>
			<td style="border-bottom: 1px solid #bbbbbb; width: 250px; padding: 5px;"><%=rs.getString("itemName")%></td>
			<td style="border: 1px solid #bbbbbb; width: 80px; padding: 5px;">
			$ <%=rs.getString("cost")%>
			</td>
			
			<td style="border: 1px solid #bbbbbb; width: 180px; padding: 5px;">
			<form action="CartServlet" method="post">
				<input type="number" name="quantity" value="<%=rs.getString("quantity")%>" style="width:30px;">
			<input type="hidden" name="cost" value="<%=rs.getString("cost")%>">
			<input type="hidden" name="cartAction" value="update">
			<input type="hidden" name="cartId" value="<%=rs.getString("cartId")%>">
			<input type="submit" value="Update" class="new-button"  style="font-size: 14px;">
			</form>
			</select>
			</td>
			<td style="border: 1px solid #bbbbbb; width: 110px; padding: 5px;">
			<% 
				Float t = Float.parseFloat(rs.getString("total"));
				t = (float)Math.round(t * 100.0) / (float)100.0;
			%>
			$ <%=t%>
			</td>
			
			<td style="border: 1px solid #bbbbbb; width: 50px; padding: 5px;">
			<form action="CartServlet" method="post">
			<input type="hidden" name="cartAction" value="delete">
			<input type="hidden" name="cartId" value="<%=rs.getString("cartId")%>">
			<input type="submit" value="X" class="new-button" style="font-size: 20px;">
			</form>
			</td>
		</tr>
	
			<%
			
			subTotal = subTotal + ((float)Math.round(Float.parseFloat(rs.getString("total")) * 100.0) / (float)100.0);
			subTotal = (float)Math.round(subTotal * 100.0) / (float)100.0;
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
		
		
	<% 

	if(session.getAttribute("cartCount")!=null && count > 0) 
	{
	%>	
	<tr>
			<td colspan="4" style="border-bottom: 1px solid #bbbbbb; width: 250px; padding: 10px; text-align: right;">
			<b>TOTAL</b>
			</td>
			<td style="border: 1px solid #bbbbbb; width: 160px; padding: 5px;">
			<b>$ <%=subTotal%></b>
			</td>
			<td colspan="2" style="border: 1px solid #bbbbbb; width: 160px; padding: 5px;"></td>
		</tr>
	</table>
	<br>
	<%if(c>0) {%>
	<form action="checkout.jsp">
	
	<input type="submit" class="menu-button" value="Checkout" style="float: right; margin-right: 50px; border: none; width: 200px; height: 50px; color: white; background-color: #333333; font-size: 20px;">
	</form>
	<%} %>
	<% 
	}
	
	%>
	
</div>
</div>
</body>
<%@include file="footer.jsp" %>
</html>