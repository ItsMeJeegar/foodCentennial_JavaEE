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
<div class="content" style="height: 1300px;">
<div style="width: 1000px; height: 50px; float: left;">
	<h2 style="margin-left: 50px;">CHECKOUT</h2>
</div>
<div style="width: 900px; height: 170px; margin-left: 50px; float: left; line-height: 24px; border-top: 1px solid #cccccc;">

<h3>CUSTOMER INFORMATION:</h3>
<% 
if(session.getAttribute("userid")==null) {
%>
Name: &nbsp;<input type="text" style="width: 180px; font-size: 16px;">
<% 
}
else {
%>
Name: Jeegar Shah<br>
Centennial ID: 300855623
<%} %>
<div style="width: 1000px; height: 50px; float: left;"><br>
	<h3>ORDER DETAILS:</h3>
</div>

</div>
<div style="width: 1000px; height: 300px; float: left;">
	<table style="border: 1px solid #bbbbbb; color: #333333; text-align:center; background-color: #e0e0e0; width: 900px; margin-left: 50px; margin-top: 20px; border-collapse: collapse;">
		
		
		
		<tr>
			<td colspan="2" style="border-bottom: 1px solid #bbbbbb; width: 500px; padding: 10px;"><b>ITEM</b></td>
			<td style="border: 1px solid #bbbbbb; width: 100px; padding: 5px;"><b>PRICE</b></td>
			<td style="border: 1px solid #bbbbbb; width: 110px; padding: 5px;"><b>QUANTITY</b></td>
			<td style="border: 1px solid #bbbbbb; width: 160px; padding: 5px;"><b>SUBTOTAL</b></td>
		</tr>
		
		<%
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	float total = 0;
	String userId = "";
	String userType = "";
	int c = 0;
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
			<td style="border-bottom: 1px solid #bbbbbb; width: 250px; padding: 5px;">
				<img alt="" src="<%=rs.getString("itemPicture")%>" style="width: 100px; height: 100px;">
			</td>
			<td style="border-bottom: 1px solid #bbbbbb; width: 250px; padding: 5px;"><%=rs.getString("itemName")%></td>
			<td style="border: 1px solid #bbbbbb; width: 100px; padding: 5px;">
			$ <%=rs.getString("cost")%>
			</td>
			<td style="border: 1px solid #bbbbbb; width: 110px; padding: 5px;">
			<%=rs.getString("quantity")%>
			</td>
			<td style="border: 1px solid #bbbbbb; width: 160px; padding: 5px;">
			$ <%=rs.getString("total")%>
			</td>
		</tr>
		<%
		total = total + Float.parseFloat(rs.getString("total"));
		total = (float)Math.round(total * 100.0) / (float)100.0;
		} 
	}
	catch(Exception sqle) {
		
	}
		float tax = total * 0.13f;
		tax = (float)Math.round(tax * 100.0) / (float)100.0;
		%>
		
		<tr>
			<td colspan="4" style="border-bottom: 1px solid #bbbbbb; width: 250px; padding: 10px; text-align: right;">
			<b>Total</b>
			</td>
			<td style="border: 1px solid #bbbbbb; width: 160px; padding: 5px;">
			<b>$ <%=total%></b>
			</td>
		</tr>
		<tr>
			<td colspan="4" style="border-bottom: 1px solid #bbbbbb; width: 250px; padding: 10px; text-align: right;">
			<b>HST @ 13%</b>
			</td>
			<td style="border: 1px solid #bbbbbb; width: 160px; padding: 5px;">
			<b>$ <%=tax%></b>
			</td>
		</tr>
		<tr>
			<td colspan="4" style="border-bottom: 1px solid #bbbbbb; width: 250px; padding: 10px; text-align: right;">
			<b>AMOUNT PAYABLE</b>
			</td>
			<td style="border: 1px solid #bbbbbb; width: 160px; padding: 10px;">
			<%float amount = total + tax;
			amount = (float)Math.round(amount	 * 100.0) / (float)100.0;
			%>
			<b>$ <%=amount%></b>
			</td>
		</tr>
		
	</table>
	<br>
	<div style="width: 1000px; height: 60px; float: left; margin-left: 50px;">
	<h3 style="float: left; ">PAYMENT OPTIONS:</h3><br>
	
	
	</div>
	<% 
	if(session.getAttribute("userid")!=null) {
	%>
	<div style="width: 1000px; height: 200px;">
	<div style="width: 900px; height: auto; margin-left: 50px; float: left;">
	<input type="radio" name="paymethod" value="online">&nbsp;Online&nbsp; &nbsp; &nbsp;<input type="radio" name="paymethod" value="counter">&nbsp;Pay at counter
	<br><br>
	<select>
		<option>Visa ending 1111</option>
		<option>Master Card ending 2222</option>
		<option>Visa Debit ending 3333</option>
	</select>
	&nbsp;&nbsp;&nbsp;<a href="#" style="text-decoration: none; font-size: 14px;">Add Payment Method...</a>
	</div>
	</div>
	<% 
	}
	else {
		%>
		<div style="width: 1000px; margin-left: 50px;">
		<select>
		<option>Visa</option>
		<option>Master Card</option>
		<option>Visa Debit</option>
	</select><br><br>
		<input type="text" name="" placeholder="Card Number" style="width:240px; height:18px; font-size: 14px;"><br><br>
		<input type="text" name="" placeholder="Name On Card" style="width:240px; height:18px; font-size: 14px;"><br><br>
		<input type="text" name="" placeholder="Month" style="width:110px; height:18px; font-size: 14px;">&nbsp;&nbsp;&nbsp;<input type="text" name="" placeholder="Year" style="width:110px; height:18px; font-size: 14px;"><br><br>
		<input type="text" name="" placeholder="CVV" style="width:110px; height:18px; font-size: 14px;"><br><br>
		</div>
		<%
		
	}
	%>
	<form action = "OrderServlet" method="post">
	<input type = "hidden" name="total" value="<%=total%>">
	<input type = "hidden" name="tax" value="<%=tax%>">
	<input type = "hidden" name="orderAction" value="place">
	<input type="submit" class="menu-button" value="Confirm Order" style="float: right; margin-right: 50px; border: none; width: 200px; height: 50px; color: white; background-color: #333333; font-size: 20px;">
	</form>
</div>
</div>
</body>
<%@include file="footer.jsp" %>
</html>