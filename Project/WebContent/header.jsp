<%@ page language="java" contentType="text/html; charset=US-ASCII" import="java.sql.*"
    pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<div class="hdr-outer">
		<div class="hdr-inner">
			<img src="logo.svg" height="60" style="background-color: #303030; margin-top: 15px; ">
			<img src="fiftieth-anniversary.png" height="54" style="margin-top: 17px; ">
			<img src="mainlogo.png" height="50" style="margin-left: 20px; margin-bottom:4px;">
			<div style="width: 300px; height: 40px; margin-top: 25px; background-color: #9ba50e; float:right;">
				<input type="text" style="height: 38px; width:245px; background-color: #9ba50e; border: none; outline: none; color:white; font-family: sans-serif; margin-left: 10px; font-size: 20px; float:left;">
				<div style="background-color: red; width: 40px; height: 40px; float:left;">
					<button style="width:40px; height:40px; border:none; outline:none; background-color: #9ba50e;">
					<img src="search.png" height="30" width="30" style="margin-top:5px">
					</button>
				</div>
			</div>
			
		</div>
		<div style="width: 1000px; height: 50px; margin: auto;">
		<%
		if(session.getAttribute("userid")==null) 
		{
			%>
			<form action="UserServlet" method="post">
			<div style="width:280px; height:50px; float:left;">
			
		<input type="text" name="loginid" placeholder="User ID" style="height: 30px; width: 250px; margin-top: 7px; font-size: 18px;">
	</div>
	<div style="width:280px; height:50px; float:left;">
		<input type="password" name="loginpass" placeholder="Password" style="height: 30px; width: 250px; margin-top: 7px; font-size: 18px;">
	</div>
	<div style="width:140px; height:50px; float:left;">
		<input type="submit" class="ui-button" style="width:140px; height:36px; margin-top:7px; background-color:black; color:white; font-size:18px; border:none;" name="btn"  value="Login">
		<input type="hidden" name="userAction" value="Login">
	</div>
	</form>
			<%
		}
		else {
			%>
		<div style="width:280px; height:50px; float:left;">
		
	</div>
	<div style="width:280px; height:50px; float:left;">
		
	</div>
	<div style="width:140px; height:50px; float:left;">
	<form action="UserServlet" method="post">
		<input class="ui-button" style="width:140px; height:36px; margin-top:7px; background-color:black; color:white; font-size:18px; border:none;" name="btn" type="submit" value="Logout">
		<input type="hidden" name="userAction" value="Logout">
	</form>
	</div>		
			
			<%
			
		}
		
	
		%>
		
		
		
		
	
	<div style="width:300px; height:50px; float:left; line-height:52px; text-align: center; font-size:20px; font-weight:bold;">
		<% 
		
		
		Connection hconn = null;
		Statement hstmt = null;
		ResultSet hrs = null;

		String huserId = "";
		String huserType = "";
		int hcartCount = 0;
		if (session.getAttribute("guestid")==null)
		{
			session.setAttribute("guestid", "16");
		}
		if(session.getAttribute("userid")==null) 
		{
			session.setAttribute("guestid", "16");
			huserType="guest";
			huserId=session.getAttribute("guestid").toString();
		}
		else {
			huserType = "member";
			huserId=session.getAttribute("userid").toString();
		}
		
		try {
			String sql = "select count(*) from cart where userId='"+huserId+"' and userType = '"+huserType+"'";
			Class.forName("com.mysql.jdbc.Driver");
			
			hconn = DriverManager.getConnection("jdbc:mysql://localhost:3306/COMP231","root","coinage");
			hstmt = hconn.createStatement();
			hrs = hstmt.executeQuery(sql);
			
			while(hrs.next()) {
				hcartCount = Integer.parseInt(hrs.getString(1));
			}
			
			hrs.close();
			hstmt.close();
			hconn.close();
		}
		catch(Exception e) {
			
		}
		
		
		
		
		session.setAttribute("cartCount", hcartCount);
		if(session.getAttribute("userid")==null && session.getAttribute("guestid")==null)
		{	
			session.setAttribute("guestid", "16");
			%>
			Hello, Guest!
			<%
		} 
		else if(session.getAttribute("userid")==null) 
		{
			%>
			Hello, Guest!
			<%
		}
		else {
			out.println("Hello, "+session.getAttribute("username"));
		}
		%>
	
			
		
	</div>
	
	</div>
	</div>
	</div>
	
	</div>
	<div class="menu-outer">
		<div class="menu-inner">
			<a href="index_home.jsp">
				<div class="menu-button" style="width: 168px; border-right: 1px solid #aaaaaa; ">
					<v class="menu-title">Home</v>
				</div>
			</a>
			
			<a href="fooditems.jsp">
				<div class="menu-button" style="width: 168px; border-right: 1px solid #aaaaaa; ">
					<v class="menu-title">Food</v>
				</div>
			</a>
			
			<a href="restaurants.jsp">
				<div class="menu-button" style="width: 168px; border-right: 1px solid #aaaaaa; ">
					<v class="menu-title">Restaurants</v>
				</div>
			</a>
			
			<a href="orders.jsp">
				<div class="menu-button" style="width: 168px; border-right: 1px solid #aaaaaa; ">
					<v class="menu-title">Orders</v>
				</div>
			</a>
			
			<a href="#">
				<div class="menu-button" style="width: 166px; border-right: 1px solid #aaaaaa; ">
					<v class="menu-title">About</v>
				</div>
			</a>
			
			<a href="cart.jsp">
				<div class="menu-button" style="width: 154px;">
					<v class="menu-title" style="width: 100px; height: 50px; float:left;">Cart</v>
					<div class="cart-number"><%=hcartCount%></div>
				</div>
			</a>
		</div>
		
	</div>
	