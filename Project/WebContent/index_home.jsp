<%@ page language="java" contentType="text/html; charset=US-ASCII" import="java.sql.*"
    pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/main.css">
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Centennial College | Food</title>

</head>
<body style="">
<%@include file="header.jsp" %>

<div class="content">
<div style="width: 1000px; height: 300px; background-color: black; float: left;">
<img alt="" src="banner1.jpg" style="width: 1000px; height: 300px;">
</div>

<div style="width: 1000px; height: 50px; float: left;">
<h2 style="margin-left: 25px;">LATEST ITEMS</h2>
</div>
<div style="width: 1000px; height: auto;">
	<%
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	float subTotal = 0;
	String userId = "";
	String userType = "";
	try {
		String sql = "select * from Item order by itemId desc limit 4";
		Class.forName("com.mysql.jdbc.Driver");
		
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/COMP231","root","coinage");
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);
		
		while(rs.next()) {
			%>
			<a href="item.jsp?itemId=<%=rs.getString("itemId")%>">
			<div style="width: 250px; text-align:center; font-size: 18px; line-height: 21px; height: 300px; float: left; background-color: #eeeeee;">
			<img alt="no.png" src="<%=rs.getString("itemPicture")%>" style="background-color: #dddddd; margin-left: 6px; border: 1px solid black; margin-top: 25px;" width="200" height="200"> 
			<br>
			<v style="font-family: sans-serif;"><%=rs.getString("itemName")%></v><br>
			<b style="font-family: sans-serif;">$ <%=rs.getString("cost")%></b><br>
			<v style="font-family: sans-serif; font-size: 14px; color: green;"><%=rs.getString("availability")%></v>
			</div></a>
			<%
			
			subTotal++;
			
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

		
</div>


</div>
<%@include file="footer.jsp" %>
</body>
<%if(request.getAttribute("login")!=null && request.getAttribute("login").equals("fail")) {%>
<script type="text/javascript">
alert("Invalid ID / Password");
</script>
<%} %>
</html>